package it.regioneveneto.mygov.payment.mypivot.domain.po;
// Generated Nov 15, 2017 2:45:28 PM by Hibernate Tools 4.0.1.Final

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
 * Accertamento generated by hbm2java
 */
@Entity
@Table(name = "mygov_accertamento")
public class Accertamento implements java.io.Serializable {

	private Long id;
	private EnteTipoDovuto enteTipoDovuto;
	private Utente utente;
	private AnagraficaStato anagraficaStato;
	private String deNomeAccertamento;
	private Date dtCreazione;
	private Date dtUltimaModifica;
	private boolean printed;

	public Accertamento() {
	}

	public Accertamento(EnteTipoDovuto enteTipoDovuto, Utente utente, AnagraficaStato anagraficaStato,
			String deNomeAccertamento, Date dtCreazione, Date dtUltimaModifica, boolean printed) {
		this.enteTipoDovuto = enteTipoDovuto;
		this.utente = utente;
		this.anagraficaStato = anagraficaStato;
		this.deNomeAccertamento = deNomeAccertamento;
		this.dtCreazione = dtCreazione;
		this.dtUltimaModifica = dtUltimaModifica;
		this.printed = printed;
	}

	@SequenceGenerator(name = "generator", allocationSize=1, sequenceName = "mygov_accertamento_mygov_accertamento_id_seq")
	@Id
	@GeneratedValue(strategy = SEQUENCE, generator = "generator")

	@Column(name = "mygov_accertamento_id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mygov_ente_tipo_dovuto_id", nullable = false)
	public EnteTipoDovuto getEnteTipoDovuto() {
		return this.enteTipoDovuto;
	}

	public void setEnteTipoDovuto(EnteTipoDovuto enteTipoDovuto) {
		this.enteTipoDovuto = enteTipoDovuto;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mygov_utente_id", nullable = false)
	public Utente getUtente() {
		return this.utente;
	}

	public void setUtente(Utente utente) {
		this.utente = utente;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mygov_anagrafica_stato_id", nullable = false)
	public AnagraficaStato getAnagraficaStato() {
		return this.anagraficaStato;
	}

	public void setAnagraficaStato(AnagraficaStato anagraficaStato) {
		this.anagraficaStato = anagraficaStato;
	}

	@Column(name = "de_nome_accertamento", nullable = false)
	public String getDeNomeAccertamento() {
		return this.deNomeAccertamento;
	}

	public void setDeNomeAccertamento(String deNomeAccertamento) {
		this.deNomeAccertamento = deNomeAccertamento;
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

	@Column(name = "printed", nullable = false)
	public boolean isPrinted() {
		return this.printed;
	}

	public void setPrinted(boolean printed) {
		this.printed = printed;
	}

}