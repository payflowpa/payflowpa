/*
 * Created on Apr 9, 2009
 */
package it.nch.eb.xsqlcmd.dbtrpos.dao;

import it.nch.eb.common.utils.resource.ResourcesUtil;
import it.nch.eb.xsqlcmd.dbtrpos.error.DBError;
import it.nch.eb.xsqlcmd.dbtrpos.error.DbErrorsHolderException;
import it.nch.eb.xsqlcmd.dbtrpos.error.XmlErrorsUtils;
import it.nch.eb.xsqlcmd.dbtrpos.model.PendenzeModel;
import it.nch.eb.xsqlcmd.dbtrpos.operations.DBErrorsHandler;
import it.nch.eb.xsqlcmd.utils.PendenzeUtils;

import java.sql.Connection;

import org.slf4j.Logger;

import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author BastiaP, gdefacci
 */
public class PendenzeModelOrchestrator implements PendenzeModelValidator {
	
	private static final Logger log = ResourcesUtil.createLogger(PendenzeModelOrchestrator.class);
	
	private final SqlMapClient sqlMapClient;
	
	/** validate, the model, eventually altering its content */
	private final PendenzeModelValidator  validator;
	/** do something with the model (usually put it inside the db) */
	private final PendenzeModelEffect dao;

	private final DBErrorsHandler errorsHandler;

	private final String name;

	public PendenzeModelOrchestrator(
			String name,
			SqlMapClient sqlMapClient,
//			@Nullable
			PendenzeModelValidator validator,
			PendenzeModelEffect dao, 
			DBErrorsHandler errorsHandler) {
		
		if (dao==null) throw new NullPointerException("dao");
		if (sqlMapClient==null) throw new NullPointerException("sqlMapClient");
		this.name = name;
		this.sqlMapClient = sqlMapClient;
		this.validator = validator;
		this.dao = dao;
		this.errorsHandler = errorsHandler;
	}
	
	public DBError[] processErrors(DBError[] errs, PendenzeModel pendenza, SqlMapClient session) {
		try {
			errorsHandler.onError(errs, pendenza);
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return concat(errs, createDBError(e, pendenza));
		}
	}
	
	public DBError createDBError(Exception e, PendenzeModel pendenza) {
		log.error(PendenzeUtils.pendenzaDescId( pendenza ) + " caused error", e);
		return new DBError("db.exception", pendenza, e, createErrorDescription(e));
	}

	private final XmlErrorsUtils xh = XmlErrorsUtils.instance;
	
	private String createErrorDescription(Exception e) {
//		FIXME: 2900 is hardwritten, move elsewhere
		String msg = (e.getMessage() == null ? e.toString() : e.getMessage());
		if (msg.length() > 2900) msg = msg.substring(0, 2900);
		return xh.describeError(xh.xmlWrap("exception", msg));
	}


	
	
	public DBError[] validate(PendenzeModel model, SqlMapClient session) {
		if (validator==null) return null;
		else {
			try {
				return validator.apply(model);
			} catch (Exception e) {
				return extractErrorrs(model, e);
			}
		}
	}
	
	public DBError[] writeDB(PendenzeModel pendenza, SqlMapClient session) {
		try {
			dao.apply(pendenza);
			return null;
		} catch (Exception e) {
			return extractErrorrs(pendenza, e);
		}
	}

	private DBError[] extractErrorrs(PendenzeModel pendenza, Exception e) {
		return (e instanceof DbErrorsHolderException) ? 
				((DbErrorsHolderException)e).getErrors() : 
				new DBError[] { createDBError(e, pendenza) };
	}
	
	final static int maxNestedException = 10;
	public DbErrorsHolderException getDbErrorsHolderException(Throwable ex) {
		Throwable curr = ex;
		int i = 0;
		while (curr != null && i < maxNestedException) {
			if (curr instanceof DbErrorsHolderException) {
				return (DbErrorsHolderException) curr;
			} else {
				curr = ex.getCause();
				i++;
			}
		}
		return null;
	}
	
	public DBError[] transactionally(PendenzeModel model, PendenzeModelValidator validator, 
			final DBErrorsHandler errorHandler) {
		try {
			DBError[] res;
			boolean errorHappened;
			try {
				sqlMapClient.startTransaction(Connection.TRANSACTION_READ_COMMITTED);
				res = validator.apply(model);
				sqlMapClient.getCurrentConnection().commit();
				sqlMapClient.commitTransaction();
				errorHappened = false;
			} catch (DbErrorsHolderException e) {
				printLogErr(e);
				errorHappened = true;
				res = e.getErrors();
			} catch (Exception e) {
				printLogErr(e);
				errorHappened = true;
				res = extractErrorrs(model, e);
			} finally {
				sqlMapClient.endTransaction();
			}
			if (errorHandler!=null && errorHappened && res.length == 1) {
				final DBError[] errsAux = res;
				transactionally(model, new PendenzeModelValidator() {

					public DBError[] apply(PendenzeModel pendenza) {
						errorHandler.onError(errsAux, pendenza);
						return null;					}
					
				}, null);
			}
			return res;
		} catch (Exception e) {
			return new DBError[] { createDBError(e, null) };
		}
	}
	
	public synchronized DBError[] apply(PendenzeModel model) {
		final DBError[] errors = validate(model, sqlMapClient);
		log.debug("starting Pendenza(IdPendenzaEnte=" + model.getIdPendenzaEnte() + ")");
		log.debug("Inserting Pendenza, modalita =" + model.isHidden() + ")");
		if (errors==null || errors.length==0) {
			return transactionally(model, new PendenzeModelValidator() {

				public DBError[] apply(PendenzeModel pendenza) {
					DBError[] ierrors = writeDB(pendenza, sqlMapClient);
					if (ierrors!=null && ierrors.length > 0) throw new DbErrorsHolderException(ierrors);
					ierrors = processErrors(null, pendenza, sqlMapClient);
					if (ierrors!=null && ierrors.length > 0) throw new DbErrorsHolderException(ierrors);
					log.debug("sucessfully processed Pendenza(IdPendenzaEnte,trbEnte,IdEnte=" +  PendenzeUtils.pendenzaDescId(pendenza) + ")");
					return null;
				}
				
			}, errorsHandler);
		} else {
			StringBuffer sb = new StringBuffer();
			for (int i=0; i<errors.length; i++) {
				sb.append("error : ");
				sb.append(errors[i].toString());
				sb.append("\n");
			}
			log.debug("errors while performing validation on Pendenza(IdPendenzaEnte,trbEnte,IdEnte=" + PendenzeUtils.pendenzaDescId(model) + ") errors \n" + sb);
//			session = newIBatisSession();
			transactionally(model, new PendenzeModelValidator() {

				public DBError[] apply(PendenzeModel pendenza) {
					errorsHandler.onError(errors, pendenza);
					return null;
				}
				
			}, null);
			return errors;
		}
	}
	
	private static DBError[] concat(DBError[] errs, DBError othr) {
		if (errs==null || errs.length==0) {
			if (othr!=null) return new DBError[] {othr};
			else return new DBError[0];
		} else {
			if (othr!=null) {
				DBError[] res = new DBError[errs.length + 1];
				System.arraycopy(errs, 0, res, 0, errs.length);
				res[errs.length] = othr;
				return res;
			} else {
				return errs;
			}
		}
	}
	
	private void printLogErr(Exception e) {
		String exceptionMessage = null;
		if (e instanceof DbErrorsHolderException) {
			DBError[] dberrs = ((DbErrorsHolderException)e).getErrors();
			exceptionMessage = "";
			for (int i = 0; i < dberrs.length; i++) {
				DBError error = dberrs[i];
				exceptionMessage += (error.toString() + "\n");
			}
		} else {
			exceptionMessage = e.getMessage();
		}
		log.error("error " + exceptionMessage);
	}

	public String toString() {
	    String FQClassName = getClass().getName();
	    
	    int firstChar;
	    firstChar = FQClassName.lastIndexOf ('.') + 1;
	    if ( firstChar > 0 ) {
	      FQClassName = FQClassName.substring ( firstChar );
	      }
	    return FQClassName + ":"  + this.name;
	}

}
