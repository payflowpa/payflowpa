package it.regioneveneto.mygov.payment.mypivot.domain.po;
// Generated Nov 15, 2017 2:45:36 PM by Hibernate Tools 4.0.1.Final

import java.util.Date;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * RendicontazioneSubset generated by hbm2java
 */
@Entity
@Table(name = "mygov_import_export_rendicontazione_tesoreria")
public class RendicontazioneSubset implements java.io.Serializable {

	private RendicontazioneSubsetId id;
	private String singoloImportoCommissioneCaricoPa;
	private String bilancio;
	private String dataOraFlussoRendicontazione;
	private String identificativoUnivocoRegolamento;
	private Date dtDataRegolamento;
	private String deDataRegolamento;
	private String importoTotalePagamenti;
	private String deAnnoBolletta;
	private String codBolletta;
	private String codIdDominio;
	private Date dtRicezione;
	private String deDataRicezione;
	private String deAnnoDocumento;
	private String codDocumento;
	private String deAnnoProvvisorio;
	private String codProvvisorio;
	private String classificazioneCompletezza;
	private Date dtDataUltimoAggiornamento;
	private String deDataUltimoAggiornamento;
	private Integer indiceDatiSingoloPagamento;
	private String codIufKey;

	public RendicontazioneSubset() {
	}

	public RendicontazioneSubset(RendicontazioneSubsetId id) {
		this.id = id;
	}

	public RendicontazioneSubset(RendicontazioneSubsetId id, String singoloImportoCommissioneCaricoPa, String bilancio,
			String dataOraFlussoRendicontazione, String identificativoUnivocoRegolamento, Date dtDataRegolamento,
			String deDataRegolamento, String importoTotalePagamenti, String deAnnoBolletta, String codBolletta,
			String codIdDominio, Date dtRicezione, String deDataRicezione, String deAnnoDocumento, String codDocumento,
			String deAnnoProvvisorio, String codProvvisorio, String classificazioneCompletezza,
			Date dtDataUltimoAggiornamento, String deDataUltimoAggiornamento, Integer indiceDatiSingoloPagamento,
			String codIufKey) {
		this.id = id;
		this.singoloImportoCommissioneCaricoPa = singoloImportoCommissioneCaricoPa;
		this.bilancio = bilancio;
		this.dataOraFlussoRendicontazione = dataOraFlussoRendicontazione;
		this.identificativoUnivocoRegolamento = identificativoUnivocoRegolamento;
		this.dtDataRegolamento = dtDataRegolamento;
		this.deDataRegolamento = deDataRegolamento;
		this.importoTotalePagamenti = importoTotalePagamenti;
		this.deAnnoBolletta = deAnnoBolletta;
		this.codBolletta = codBolletta;
		this.codIdDominio = codIdDominio;
		this.dtRicezione = dtRicezione;
		this.deDataRicezione = deDataRicezione;
		this.deAnnoDocumento = deAnnoDocumento;
		this.codDocumento = codDocumento;
		this.deAnnoProvvisorio = deAnnoProvvisorio;
		this.codProvvisorio = codProvvisorio;
		this.classificazioneCompletezza = classificazioneCompletezza;
		this.dtDataUltimoAggiornamento = dtDataUltimoAggiornamento;
		this.deDataUltimoAggiornamento = deDataUltimoAggiornamento;
		this.indiceDatiSingoloPagamento = indiceDatiSingoloPagamento;
		this.codIufKey = codIufKey;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "codiceIpaEnte", column = @Column(name = "codice_ipa_ente", length = 80)),
			@AttributeOverride(name = "identificativoFlussoRendicontazione", column = @Column(name = "identificativo_flusso_rendicontazione", length = 35)) })
	public RendicontazioneSubsetId getId() {
		return this.id;
	}

	public void setId(RendicontazioneSubsetId id) {
		this.id = id;
	}

	@Column(name = "singolo_importo_commissione_carico_pa", length = 15)
	public String getSingoloImportoCommissioneCaricoPa() {
		return this.singoloImportoCommissioneCaricoPa;
	}

	public void setSingoloImportoCommissioneCaricoPa(String singoloImportoCommissioneCaricoPa) {
		this.singoloImportoCommissioneCaricoPa = singoloImportoCommissioneCaricoPa;
	}

	@Column(name = "bilancio", length = 4096)
	public String getBilancio() {
		return this.bilancio;
	}

	public void setBilancio(String bilancio) {
		this.bilancio = bilancio;
	}

	@Column(name = "data_ora_flusso_rendicontazione", length = 19)
	public String getDataOraFlussoRendicontazione() {
		return this.dataOraFlussoRendicontazione;
	}

	public void setDataOraFlussoRendicontazione(String dataOraFlussoRendicontazione) {
		this.dataOraFlussoRendicontazione = dataOraFlussoRendicontazione;
	}

	@Column(name = "identificativo_univoco_regolamento", length = 35)
	public String getIdentificativoUnivocoRegolamento() {
		return this.identificativoUnivocoRegolamento;
	}

	public void setIdentificativoUnivocoRegolamento(String identificativoUnivocoRegolamento) {
		this.identificativoUnivocoRegolamento = identificativoUnivocoRegolamento;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "dt_data_regolamento", length = 13)
	public Date getDtDataRegolamento() {
		return this.dtDataRegolamento;
	}

	public void setDtDataRegolamento(Date dtDataRegolamento) {
		this.dtDataRegolamento = dtDataRegolamento;
	}

	@Column(name = "de_data_regolamento")
	public String getDeDataRegolamento() {
		return this.deDataRegolamento;
	}

	public void setDeDataRegolamento(String deDataRegolamento) {
		this.deDataRegolamento = deDataRegolamento;
	}

	@Column(name = "importo_totale_pagamenti", length = 21)
	public String getImportoTotalePagamenti() {
		return this.importoTotalePagamenti;
	}

	public void setImportoTotalePagamenti(String importoTotalePagamenti) {
		this.importoTotalePagamenti = importoTotalePagamenti;
	}

	@Column(name = "de_anno_bolletta", length = 4)
	public String getDeAnnoBolletta() {
		return this.deAnnoBolletta;
	}

	public void setDeAnnoBolletta(String deAnnoBolletta) {
		this.deAnnoBolletta = deAnnoBolletta;
	}

	@Column(name = "cod_bolletta", length = 7)
	public String getCodBolletta() {
		return this.codBolletta;
	}

	public void setCodBolletta(String codBolletta) {
		this.codBolletta = codBolletta;
	}

	@Column(name = "cod_id_dominio", length = 7)
	public String getCodIdDominio() {
		return this.codIdDominio;
	}

	public void setCodIdDominio(String codIdDominio) {
		this.codIdDominio = codIdDominio;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "dt_ricezione", length = 29)
	public Date getDtRicezione() {
		return this.dtRicezione;
	}

	public void setDtRicezione(Date dtRicezione) {
		this.dtRicezione = dtRicezione;
	}

	@Column(name = "de_data_ricezione", length = 10)
	public String getDeDataRicezione() {
		return this.deDataRicezione;
	}

	public void setDeDataRicezione(String deDataRicezione) {
		this.deDataRicezione = deDataRicezione;
	}

	@Column(name = "de_anno_documento", length = 4)
	public String getDeAnnoDocumento() {
		return this.deAnnoDocumento;
	}

	public void setDeAnnoDocumento(String deAnnoDocumento) {
		this.deAnnoDocumento = deAnnoDocumento;
	}

	@Column(name = "cod_documento", length = 7)
	public String getCodDocumento() {
		return this.codDocumento;
	}

	public void setCodDocumento(String codDocumento) {
		this.codDocumento = codDocumento;
	}

	@Column(name = "de_anno_provvisorio", length = 4)
	public String getDeAnnoProvvisorio() {
		return this.deAnnoProvvisorio;
	}

	public void setDeAnnoProvvisorio(String deAnnoProvvisorio) {
		this.deAnnoProvvisorio = deAnnoProvvisorio;
	}

	@Column(name = "cod_provvisorio", length = 6)
	public String getCodProvvisorio() {
		return this.codProvvisorio;
	}

	public void setCodProvvisorio(String codProvvisorio) {
		this.codProvvisorio = codProvvisorio;
	}

	@Column(name = "classificazione_completezza", length = 20)
	public String getClassificazioneCompletezza() {
		return this.classificazioneCompletezza;
	}

	public void setClassificazioneCompletezza(String classificazioneCompletezza) {
		this.classificazioneCompletezza = classificazioneCompletezza;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "dt_data_ultimo_aggiornamento", length = 13)
	public Date getDtDataUltimoAggiornamento() {
		return this.dtDataUltimoAggiornamento;
	}

	public void setDtDataUltimoAggiornamento(Date dtDataUltimoAggiornamento) {
		this.dtDataUltimoAggiornamento = dtDataUltimoAggiornamento;
	}

	@Column(name = "de_data_ultimo_aggiornamento", length = 10)
	public String getDeDataUltimoAggiornamento() {
		return this.deDataUltimoAggiornamento;
	}

	public void setDeDataUltimoAggiornamento(String deDataUltimoAggiornamento) {
		this.deDataUltimoAggiornamento = deDataUltimoAggiornamento;
	}

	@Column(name = "indice_dati_singolo_pagamento")
	public Integer getIndiceDatiSingoloPagamento() {
		return this.indiceDatiSingoloPagamento;
	}

	public void setIndiceDatiSingoloPagamento(Integer indiceDatiSingoloPagamento) {
		this.indiceDatiSingoloPagamento = indiceDatiSingoloPagamento;
	}

	@Column(name = "cod_iuf_key", length = 35)
	public String getCodIufKey() {
		return this.codIufKey;
	}

	public void setCodIufKey(String codIufKey) {
		this.codIufKey = codIufKey;
	}

}
