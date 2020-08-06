package it.regioneveneto.mygov.payment.mypivot.domain.po;
// Generated Nov 15, 2017 2:45:28 PM by Hibernate Tools 4.0.1.Final

import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.SEQUENCE;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * AccertamentoDettaglio generated by hbm2java
 */
@Entity
@Table(name = "mygov_accertamento_dettaglio")
public class AccertamentoDettaglio implements java.io.Serializable {

	private Long id;
	private Accertamento accertamento;
	private Utente utente;
	private String codIpaEnte;
	private String codTipoDovuto;
	private String codIud;
	private String codIuv;
	private String codUfficio;
	private String codCapitolo;
	private String codAccertamento;
	private BigDecimal numImporto;
	private boolean flgImportoInserito;
	private Date dtUltimaModifica;
	private Date dtDataInserimento;

	public AccertamentoDettaglio() {
	}

	public AccertamentoDettaglio(Accertamento accertamento, Utente utente, String codIpaEnte, String codTipoDovuto,
			String codIud, String codIuv, String codUfficio, String codCapitolo, String codAccertamento,
			BigDecimal numImporto, boolean flgImportoInserito, Date dtUltimaModifica, Date dtDataInserimento) {
		this.accertamento = accertamento;
		this.utente = utente;
		this.codIpaEnte = codIpaEnte;
		this.codTipoDovuto = codTipoDovuto;
		this.codIud = codIud;
		this.codIuv = codIuv;
		this.codUfficio = codUfficio;
		this.codCapitolo = codCapitolo;
		this.codAccertamento = codAccertamento;
		this.numImporto = numImporto;
		this.flgImportoInserito = flgImportoInserito;
		this.dtUltimaModifica = dtUltimaModifica;
		this.dtDataInserimento = dtDataInserimento;
	}

	@SequenceGenerator(name = "generator", allocationSize=1, sequenceName = "mygov_accertamento_dettaglio_mygov_accertamento_dett_id_seq")
	@Id
	@GeneratedValue(strategy = SEQUENCE, generator = "generator")

	@Column(name = "mygov_accertamento_dettaglio_id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mygov_accertamento_id", nullable = false)
	public Accertamento getAccertamento() {
		return this.accertamento;
	}

	public void setAccertamento(Accertamento accertamento) {
		this.accertamento = accertamento;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mygov_utente_id", nullable = false)
	public Utente getUtente() {
		return this.utente;
	}

	public void setUtente(Utente utente) {
		this.utente = utente;
	}

	@Column(name = "cod_ipa_ente", nullable = false, length = 35)
	public String getCodIpaEnte() {
		return this.codIpaEnte;
	}

	public void setCodIpaEnte(String codIpaEnte) {
		this.codIpaEnte = codIpaEnte;
	}

	@Column(name = "cod_tipo_dovuto", nullable = false, length = 64)
	public String getCodTipoDovuto() {
		return this.codTipoDovuto;
	}

	public void setCodTipoDovuto(String codTipoDovuto) {
		this.codTipoDovuto = codTipoDovuto;
	}

	@Column(name = "cod_iud", nullable = false, length = 35)
	public String getCodIud() {
		return this.codIud;
	}

	public void setCodIud(String codIud) {
		this.codIud = codIud;
	}

	@Column(name = "cod_iuv", nullable = false, length = 35)
	public String getCodIuv() {
		return this.codIuv;
	}

	public void setCodIuv(String codIuv) {
		this.codIuv = codIuv;
	}

	@Column(name = "cod_ufficio", nullable = false, length = 64)
	public String getCodUfficio() {
		return this.codUfficio;
	}

	public void setCodUfficio(String codUfficio) {
		this.codUfficio = codUfficio;
	}

	@Column(name = "cod_capitolo", nullable = false, length = 64)
	public String getCodCapitolo() {
		return this.codCapitolo;
	}

	public void setCodCapitolo(String codCapitolo) {
		this.codCapitolo = codCapitolo;
	}

	@Column(name = "cod_accertamento", nullable = false, length = 64)
	public String getCodAccertamento() {
		return this.codAccertamento;
	}

	public void setCodAccertamento(String codAccertamento) {
		this.codAccertamento = codAccertamento;
	}

	@Column(name = "num_importo", nullable = false, precision = 17)
	public BigDecimal getNumImporto() {
		return this.numImporto;
	}

	public void setNumImporto(BigDecimal numImporto) {
		this.numImporto = numImporto;
	}

	@Column(name = "flg_importo_inserito", nullable = false)
	public boolean isFlgImportoInserito() {
		return this.flgImportoInserito;
	}

	public void setFlgImportoInserito(boolean flgImportoInserito) {
		this.flgImportoInserito = flgImportoInserito;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "dt_ultima_modifica", nullable = false, length = 29)
	public Date getDtUltimaModifica() {
		return this.dtUltimaModifica;
	}

	public void setDtUltimaModifica(Date dtUltimaModifica) {
		this.dtUltimaModifica = dtUltimaModifica;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "dt_data_inserimento", nullable = false, length = 29)
	public Date getDtDataInserimento() {
		return this.dtDataInserimento;
	}

	public void setDtDataInserimento(Date dtDataInserimento) {
		this.dtDataInserimento = dtDataInserimento;
	}

}