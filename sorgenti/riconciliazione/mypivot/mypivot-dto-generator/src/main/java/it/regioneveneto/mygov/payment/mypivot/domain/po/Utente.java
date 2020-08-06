package it.regioneveneto.mygov.payment.mypivot.domain.po;
// Generated Nov 15, 2017 2:45:28 PM by Hibernate Tools 4.0.1.Final

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.SEQUENCE;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;

/**
 * Utente generated by hbm2java
 */
@Entity
@Table(name = "mygov_utente")
public class Utente implements java.io.Serializable {

	private Long id;
	private int version;
	private String codFedUserId;
	private String codCodiceFiscaleUtente;
	private String deEmailAddress;
	private String deFirstname;
	private String deLastname;
	private Date dtUltimoLogin;

	public Utente() {
	}

	public Utente(String codFedUserId, String codCodiceFiscaleUtente, String deEmailAddress, Date dtUltimoLogin) {
		this.codFedUserId = codFedUserId;
		this.codCodiceFiscaleUtente = codCodiceFiscaleUtente;
		this.deEmailAddress = deEmailAddress;
		this.dtUltimoLogin = dtUltimoLogin;
	}

	public Utente(String codFedUserId, String codCodiceFiscaleUtente, String deEmailAddress, String deFirstname,
			String deLastname, Date dtUltimoLogin) {
		this.codFedUserId = codFedUserId;
		this.codCodiceFiscaleUtente = codCodiceFiscaleUtente;
		this.deEmailAddress = deEmailAddress;
		this.deFirstname = deFirstname;
		this.deLastname = deLastname;
		this.dtUltimoLogin = dtUltimoLogin;
	}

	@SequenceGenerator(name = "generator", allocationSize=1, sequenceName = "mygov_utente_mygov_utente_id_seq")
	@Id
	@GeneratedValue(strategy = SEQUENCE, generator = "generator")

	@Column(name = "mygov_utente_id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Version
	@Column(name = "version", nullable = false)
	public int getVersion() {
		return this.version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	@Column(name = "cod_fed_user_id", nullable = false, length = 128)
	public String getCodFedUserId() {
		return this.codFedUserId;
	}

	public void setCodFedUserId(String codFedUserId) {
		this.codFedUserId = codFedUserId;
	}

	@Column(name = "cod_codice_fiscale_utente", nullable = false, length = 16)
	public String getCodCodiceFiscaleUtente() {
		return this.codCodiceFiscaleUtente;
	}

	public void setCodCodiceFiscaleUtente(String codCodiceFiscaleUtente) {
		this.codCodiceFiscaleUtente = codCodiceFiscaleUtente;
	}

	@Column(name = "de_email_address", nullable = false, length = 256)
	public String getDeEmailAddress() {
		return this.deEmailAddress;
	}

	public void setDeEmailAddress(String deEmailAddress) {
		this.deEmailAddress = deEmailAddress;
	}

	@Column(name = "de_firstname", length = 64)
	public String getDeFirstname() {
		return this.deFirstname;
	}

	public void setDeFirstname(String deFirstname) {
		this.deFirstname = deFirstname;
	}

	@Column(name = "de_lastname", length = 64)
	public String getDeLastname() {
		return this.deLastname;
	}

	public void setDeLastname(String deLastname) {
		this.deLastname = deLastname;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "dt_ultimo_login", nullable = false, length = 29)
	public Date getDtUltimoLogin() {
		return this.dtUltimoLogin;
	}

	public void setDtUltimoLogin(Date dtUltimoLogin) {
		this.dtUltimoLogin = dtUltimoLogin;
	}

}