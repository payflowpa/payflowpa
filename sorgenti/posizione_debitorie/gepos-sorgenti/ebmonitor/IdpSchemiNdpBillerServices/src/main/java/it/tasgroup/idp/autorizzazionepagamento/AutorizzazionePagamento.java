package it.tasgroup.idp.autorizzazionepagamento;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.bind.annotation.XmlSeeAlso;

/**
 * This class was generated by Apache CXF 2.7.11
 * 2018-11-13T13:16:48.010+01:00
 * Generated source version: 2.7.11
 * 
 */
@WebService(targetNamespace = "http://idp.tasgroup.it/AutorizzazionePagamento/", name = "AutorizzazionePagamento")
@XmlSeeAlso({ObjectFactory.class})
@SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
public interface AutorizzazionePagamento {

    @WebResult(name = "AttivaPagamentoResponse", targetNamespace = "http://idp.tasgroup.it/AutorizzazionePagamento/", partName = "parameters")
    @WebMethod(operationName = "AttivaPagamento", action = "http://idp.tasgroup.it/NdpServices/AttivaPagamento")
    public AttivaPagamentoResponseType attivaPagamento(
        @WebParam(partName = "parameters", name = "AttivaPagamentoRequest", targetNamespace = "http://idp.tasgroup.it/AutorizzazionePagamento/")
        AttivaPagamentoRequestType parameters
    );

    @WebResult(name = "VerificaPagamentoResponse", targetNamespace = "http://idp.tasgroup.it/AutorizzazionePagamento/", partName = "parameters")
    @WebMethod(operationName = "VerificaPagamento", action = "http://idp.tasgroup.it/NdpServices/VerificaPagamento")
    public VerificaPagamentoResponseType verificaPagamento(
        @WebParam(partName = "parameters", name = "VerificaPagamentoRequest", targetNamespace = "http://idp.tasgroup.it/AutorizzazionePagamento/")
        RequestBase parameters
    );
}
