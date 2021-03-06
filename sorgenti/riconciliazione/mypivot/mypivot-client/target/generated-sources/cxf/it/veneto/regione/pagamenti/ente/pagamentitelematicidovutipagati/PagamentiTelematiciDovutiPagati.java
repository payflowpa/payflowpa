package it.veneto.regione.pagamenti.ente.pagamentitelematicidovutipagati;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.Action;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

/**
 * This class was generated by Apache CXF 2.7.18
 * 2020-05-18T11:22:55.921+02:00
 * Generated source version: 2.7.18
 * 
 */
@WebService(targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/PagamentiTelematiciDovutiPagati", name = "PagamentiTelematiciDovutiPagati")
@XmlSeeAlso({it.veneto.regione.pagamenti.ente.ppthead.ObjectFactory.class, it.veneto.regione.pagamenti.ente.ObjectFactory.class, it.veneto.regione.schemas._2012.pagamenti.ente.ObjectFactory.class})
public interface PagamentiTelematiciDovutiPagati {

    @WebMethod(action = "paaSILChiediPagati")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediPagatiRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediPagatiRisposta")
    @RequestWrapper(localName = "paaSILChiediPagati", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", className = "it.veneto.regione.pagamenti.ente.PaaSILChiediPagati")
    @ResponseWrapper(localName = "paaSILChiediPagatiRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", className = "it.veneto.regione.pagamenti.ente.PaaSILChiediPagatiRisposta")
    public void paaSILChiediPagati(
        @WebParam(name = "codIpaEnte", targetNamespace = "")
        java.lang.String codIpaEnte,
        @WebParam(name = "password", targetNamespace = "")
        java.lang.String password,
        @WebParam(name = "idSession", targetNamespace = "")
        java.lang.String idSession,
        @WebParam(mode = WebParam.Mode.OUT, name = "fault", targetNamespace = "")
        javax.xml.ws.Holder<it.veneto.regione.pagamenti.ente.FaultBean> fault,
        @WebParam(mode = WebParam.Mode.OUT, name = "pagati", targetNamespace = "")
        javax.xml.ws.Holder<javax.activation.DataHandler> pagati
    );

    @WebMethod(action = "paaSILImportaDovuto")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILImportaDovutoRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILImportaDovutoRisposta")
    @SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
    @WebResult(name = "paaSILImportaDovutoRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", partName = "bodyrisposta")
    public it.veneto.regione.pagamenti.ente.PaaSILImportaDovutoRisposta paaSILImportaDovuto(
        @WebParam(partName = "bodyrichiesta", name = "paaSILImportaDovuto", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/")
        it.veneto.regione.pagamenti.ente.PaaSILImportaDovuto bodyrichiesta,
        @WebParam(partName = "header", name = "intestazionePPT", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/ppthead", header = true)
        it.veneto.regione.pagamenti.ente.ppthead.IntestazionePPT header
    );

    @WebMethod(action = "paaSILChiediAvvisiPendenti")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediAvvisiPendentiRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediAvvisiPendentiRisposta")
    @RequestWrapper(localName = "paaSILChiediAvvisiPendenti", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", className = "it.veneto.regione.pagamenti.ente.PaaSILChiediAvvisiPendenti")
    @ResponseWrapper(localName = "paaSILChiediAvvisiPendentiRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", className = "it.veneto.regione.pagamenti.ente.PaaSILChiediAvvisiPendentiRisposta")
    public void paaSILChiediAvvisiPendenti(
        @WebParam(name = "password", targetNamespace = "")
        java.lang.String password,
        @WebParam(name = "codIpaEnte", targetNamespace = "")
        java.lang.String codIpaEnte,
        @WebParam(name = "dateFrom", targetNamespace = "")
        javax.xml.datatype.XMLGregorianCalendar dateFrom,
        @WebParam(name = "dateTo", targetNamespace = "")
        javax.xml.datatype.XMLGregorianCalendar dateTo,
        @WebParam(mode = WebParam.Mode.OUT, name = "fault", targetNamespace = "")
        javax.xml.ws.Holder<it.veneto.regione.pagamenti.ente.FaultBean> fault,
        @WebParam(mode = WebParam.Mode.OUT, name = "paaSILAvvisoPendente", targetNamespace = "")
        javax.xml.ws.Holder<java.util.List<it.veneto.regione.pagamenti.ente.PaaSILAvvisoPendente>> paaSILAvvisoPendente
    );

    @WebMethod(action = "paaSILAutorizzaImportFlusso")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILAutorizzaImportFlussoRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILAutorizzaImportFlussoRisposta")
    @SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
    @WebResult(name = "paaSILAutorizzaImportFlussoRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", partName = "bodyrisposta")
    public it.veneto.regione.pagamenti.ente.PaaSILAutorizzaImportFlussoRisposta paaSILAutorizzaImportFlusso(
        @WebParam(partName = "bodyrichiesta", name = "paaSILAutorizzaImportFlusso", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/")
        it.veneto.regione.pagamenti.ente.PaaSILAutorizzaImportFlusso bodyrichiesta,
        @WebParam(partName = "header", name = "intestazionePPT", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/ppthead", header = true)
        it.veneto.regione.pagamenti.ente.ppthead.IntestazionePPT header
    );

    @WebMethod(action = "paaSILChiediPagatiConRicevuta")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediPagatiConRicevutaRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediPagatiConRicevutaRisposta")
    @RequestWrapper(localName = "paaSILChiediPagatiConRicevuta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", className = "it.veneto.regione.pagamenti.ente.PaaSILChiediPagatiConRicevuta")
    @ResponseWrapper(localName = "paaSILChiediPagatiConRicevutaRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", className = "it.veneto.regione.pagamenti.ente.PaaSILChiediPagatiConRicevutaRisposta")
    public void paaSILChiediPagatiConRicevuta(
        @WebParam(name = "codIpaEnte", targetNamespace = "")
        java.lang.String codIpaEnte,
        @WebParam(name = "password", targetNamespace = "")
        java.lang.String password,
        @WebParam(name = "idSession", targetNamespace = "")
        java.lang.String idSession,
        @WebParam(mode = WebParam.Mode.OUT, name = "fault", targetNamespace = "")
        javax.xml.ws.Holder<it.veneto.regione.pagamenti.ente.FaultBean> fault,
        @WebParam(mode = WebParam.Mode.OUT, name = "pagati", targetNamespace = "")
        javax.xml.ws.Holder<javax.activation.DataHandler> pagati,
        @WebParam(mode = WebParam.Mode.OUT, name = "tipoFirma", targetNamespace = "")
        javax.xml.ws.Holder<java.lang.String> tipoFirma,
        @WebParam(mode = WebParam.Mode.OUT, name = "rt", targetNamespace = "")
        javax.xml.ws.Holder<javax.activation.DataHandler> rt
    );

    @WebMethod(action = "paaSILPrenotaExportFlussoIncrementaleConRicevuta")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILPrenotaExportFlussoIncrementaleConRicevutaRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILPrenotaExportFlussoIncrementaleConRicevutaRisposta")
    @SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
    @WebResult(name = "paaSILPrenotaExportFlussoIncrementaleConRicevutaRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", partName = "bodyrisposta")
    public it.veneto.regione.pagamenti.ente.PaaSILPrenotaExportFlussoIncrementaleConRicevutaRisposta paaSILPrenotaExportFlussoIncrementaleConRicevuta(
        @WebParam(partName = "bodyrichiesta", name = "paaSILPrenotaExportFlussoIncrementaleConRicevuta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/")
        it.veneto.regione.pagamenti.ente.PaaSILPrenotaExportFlussoIncrementaleConRicevuta bodyrichiesta,
        @WebParam(partName = "header", name = "intestazionePPT", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/ppthead", header = true)
        it.veneto.regione.pagamenti.ente.ppthead.IntestazionePPT header
    );

    @WebMethod(action = "paaSILVerificaAvviso")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILVerificaAvvisoRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILVerificaAvvisoRisposta")
    @SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
    @WebResult(name = "paaSILVerificaAvvisoRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", partName = "bodyrisposta")
    public it.veneto.regione.pagamenti.ente.PaaSILVerificaAvvisoRisposta paaSILVerificaAvviso(
        @WebParam(partName = "bodyrichiesta", name = "paaSILVerificaAvviso", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/")
        it.veneto.regione.pagamenti.ente.PaaSILVerificaAvviso bodyrichiesta,
        @WebParam(partName = "header", name = "intestazionePPT", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/ppthead", header = true)
        it.veneto.regione.pagamenti.ente.ppthead.IntestazionePPT header
    );

    @WebMethod(action = "paaSILChiediStatoImportFlusso")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediStatoImportFlussoRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediStatoImportFlussoRisposta")
    @SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
    @WebResult(name = "paaSILChiediStatoImportFlussoRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", partName = "bodyrisposta")
    public it.veneto.regione.pagamenti.ente.PaaSILChiediStatoImportFlussoRisposta paaSILChiediStatoImportFlusso(
        @WebParam(partName = "bodyrichiesta", name = "paaSILChiediStatoImportFlusso", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/")
        it.veneto.regione.pagamenti.ente.PaaSILChiediStatoImportFlusso bodyrichiesta,
        @WebParam(partName = "header", name = "intestazionePPT", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/ppthead", header = true)
        it.veneto.regione.pagamenti.ente.ppthead.IntestazionePPT header
    );

    @WebMethod(action = "paaSILPrenotaExportFlusso")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILPrenotaExportFlussoRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILPrenotaExportFlussoRisposta")
    @SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
    @WebResult(name = "paaSILPrenotaExportFlussoRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", partName = "bodyrisposta")
    public it.veneto.regione.pagamenti.ente.PaaSILPrenotaExportFlussoRisposta paaSILPrenotaExportFlusso(
        @WebParam(partName = "bodyrichiesta", name = "paaSILPrenotaExportFlusso", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/")
        it.veneto.regione.pagamenti.ente.PaaSILPrenotaExportFlusso bodyrichiesta,
        @WebParam(partName = "header", name = "intestazionePPT", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/ppthead", header = true)
        it.veneto.regione.pagamenti.ente.ppthead.IntestazionePPT header
    );

    @WebMethod(action = "paaSILInviaDovuti")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILInviaDovutiRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILInviaDovutiRisposta")
    @SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
    @WebResult(name = "paaSILInviaDovutiRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", partName = "bodyrisposta")
    public it.veneto.regione.pagamenti.ente.PaaSILInviaDovutiRisposta paaSILInviaDovuti(
        @WebParam(partName = "bodyrichiesta", name = "paaSILInviaDovuti", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/")
        it.veneto.regione.pagamenti.ente.PaaSILInviaDovuti bodyrichiesta,
        @WebParam(partName = "header", name = "intestazionePPT", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/ppthead", header = true)
        it.veneto.regione.pagamenti.ente.ppthead.IntestazionePPT header
    );

    @WebMethod(action = "paaSILChiediStatoExportFlusso")
    @Action(input = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediStatoExportFlussoRichiesta", output = "http://www.regione.veneto.it/pagamenti/ente/PPT/paaSILChiediStatoExportFlussoRisposta")
    @SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
    @WebResult(name = "paaSILChiediStatoExportFlussoRisposta", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/", partName = "bodyrisposta")
    public it.veneto.regione.pagamenti.ente.PaaSILChiediStatoExportFlussoRisposta paaSILChiediStatoExportFlusso(
        @WebParam(partName = "bodyrichiesta", name = "paaSILChiediStatoExportFlusso", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/")
        it.veneto.regione.pagamenti.ente.PaaSILChiediStatoExportFlusso bodyrichiesta,
        @WebParam(partName = "header", name = "intestazionePPT", targetNamespace = "http://www.regione.veneto.it/pagamenti/ente/ppthead", header = true)
        it.veneto.regione.pagamenti.ente.ppthead.IntestazionePPT header
    );
}
