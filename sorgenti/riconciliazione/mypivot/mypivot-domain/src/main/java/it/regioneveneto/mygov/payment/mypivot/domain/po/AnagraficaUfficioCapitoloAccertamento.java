package it.regioneveneto.mygov.payment.mypivot.domain.po;
// Generated Nov 15, 2017 3:08:30 PM by Hibernate Tools 4.0.1.Final

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
 * AnagraficaUfficioCapitoloAccertamento generated by hbm2java
 */
@Entity
@Table(name = "mygov_anagrafica_uff_cap_acc")
public class AnagraficaUfficioCapitoloAccertamento implements java.io.Serializable {

	private Long id;
	private Ente ente;
	private String codTipoDovuto;
	private String codUfficio;
	private String deUfficio;
	private boolean flgAttivo;
	private String codCapitolo;
	private String deCapitolo;
	private String deAnnoEsercizio;
	private String codAccertamento;
	private String deAccertamento;
	private Date dtCreazione;
	private Date dtUltimaModifica;

	public AnagraficaUfficioCapitoloAccertamento() {
	}

	public AnagraficaUfficioCapitoloAccertamento(Ente ente, String codUfficio, String deUfficio, boolean flgAttivo,
			String codCapitolo, String deCapitolo, String deAnnoEsercizio, String codAccertamento,
			String deAccertamento, Date dtCreazione, Date dtUltimaModifica) {
		this.ente = ente;
		this.codUfficio = codUfficio;
		this.deUfficio = deUfficio;
		this.flgAttivo = flgAttivo;
		this.codCapitolo = codCapitolo;
		this.deCapitolo = deCapitolo;
		this.deAnnoEsercizio = deAnnoEsercizio;
		this.codAccertamento = codAccertamento;
		this.deAccertamento = deAccertamento;
		this.dtCreazione = dtCreazione;
		this.dtUltimaModifica = dtUltimaModifica;
	}

	public AnagraficaUfficioCapitoloAccertamento(Ente ente, String codTipoDovuto, String codUfficio, String deUfficio,
			boolean flgAttivo, String codCapitolo, String deCapitolo, String deAnnoEsercizio, String codAccertamento,
			String deAccertamento, Date dtCreazione, Date dtUltimaModifica) {
		this.ente = ente;
		this.codTipoDovuto = codTipoDovuto;
		this.codUfficio = codUfficio;
		this.deUfficio = deUfficio;
		this.flgAttivo = flgAttivo;
		this.codCapitolo = codCapitolo;
		this.deCapitolo = deCapitolo;
		this.deAnnoEsercizio = deAnnoEsercizio;
		this.codAccertamento = codAccertamento;
		this.deAccertamento = deAccertamento;
		this.dtCreazione = dtCreazione;
		this.dtUltimaModifica = dtUltimaModifica;
	}

	@SequenceGenerator(name = "generator", allocationSize=1, sequenceName = "mygov_anag_uff_cap_acc_mygov_anag_uff_cap_acc_id_seq")
	@Id
	@GeneratedValue(strategy = SEQUENCE, generator = "generator")

	@Column(name = "mygov_anagrafica_uff_cap_acc_id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mygov_ente_id", nullable = false)
	public Ente getEnte() {
		return this.ente;
	}

	public void setEnte(Ente ente) {
		this.ente = ente;
	}

	@Column(name = "cod_tipo_dovuto", length = 64)
	public String getCodTipoDovuto() {
		return this.codTipoDovuto;
	}

	public void setCodTipoDovuto(String codTipoDovuto) {
		this.codTipoDovuto = codTipoDovuto;
	}

	@Column(name = "cod_ufficio", nullable = false, length = 64)
	public String getCodUfficio() {
		return this.codUfficio;
	}

	public void setCodUfficio(String codUfficio) {
		this.codUfficio = codUfficio;
	}

	@Column(name = "de_ufficio", nullable = false, length = 512)
	public String getDeUfficio() {
		return this.deUfficio;
	}

	public void setDeUfficio(String deUfficio) {
		this.deUfficio = deUfficio;
	}

	@Column(name = "flg_attivo", nullable = false)
	public boolean isFlgAttivo() {
		return this.flgAttivo;
	}

	public void setFlgAttivo(boolean flgAttivo) {
		this.flgAttivo = flgAttivo;
	}

	@Column(name = "cod_capitolo", nullable = false, length = 64)
	public String getCodCapitolo() {
		return this.codCapitolo;
	}

	public void setCodCapitolo(String codCapitolo) {
		this.codCapitolo = codCapitolo;
	}

	@Column(name = "de_capitolo", nullable = false, length = 512)
	public String getDeCapitolo() {
		return this.deCapitolo;
	}

	public void setDeCapitolo(String deCapitolo) {
		this.deCapitolo = deCapitolo;
	}

	@Column(name = "de_anno_esercizio", nullable = false, length = 4)
	public String getDeAnnoEsercizio() {
		return this.deAnnoEsercizio;
	}

	public void setDeAnnoEsercizio(String deAnnoEsercizio) {
		this.deAnnoEsercizio = deAnnoEsercizio;
	}

	@Column(name = "cod_accertamento", nullable = false, length = 64)
	public String getCodAccertamento() {
		return this.codAccertamento;
	}

	public void setCodAccertamento(String codAccertamento) {
		this.codAccertamento = codAccertamento;
	}

	@Column(name = "de_accertamento", nullable = false, length = 512)
	public String getDeAccertamento() {
		return this.deAccertamento;
	}

	public void setDeAccertamento(String deAccertamento) {
		this.deAccertamento = deAccertamento;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "dt_creazione", nullable = false, length = 29)
	public Date getDtCreazione() {
		return this.dtCreazione;
	}

	public void setDtCreazione(Date dtCreazione) {
		this.dtCreazione = dtCreazione;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "dt_ultima_modifica", nullable = false, length = 29)
	public Date getDtUltimaModifica() {
		return this.dtUltimaModifica;
	}

	public void setDtUltimaModifica(Date dtUltimaModifica) {
		this.dtUltimaModifica = dtUltimaModifica;
	}

}