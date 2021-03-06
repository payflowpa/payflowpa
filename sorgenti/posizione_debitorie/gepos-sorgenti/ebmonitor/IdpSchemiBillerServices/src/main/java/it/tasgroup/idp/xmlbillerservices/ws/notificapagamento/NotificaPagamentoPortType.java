package it.tasgroup.idp.xmlbillerservices.ws.notificapagamento;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.bind.annotation.XmlSeeAlso;

/**
 * This class was generated by Apache CXF 2.7.11
 * 2016-03-16T16:07:01.799+01:00
 * Generated source version: 2.7.11
 * 
 */
@WebService(targetNamespace = "http://idp.tasgroup.it/xmlbillerservices/ws/NotificaPagamento/", name = "NotificaPagamentoPortType")
@XmlSeeAlso({it.tasgroup.idp.xmlbillerservices.header.ObjectFactory.class, it.tasgroup.idp.xmlbillerservices.informativapagamento.ObjectFactory.class, it.tasgroup.idp.xmlbillerservices.common.ObjectFactory.class, ObjectFactory.class})
@SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
public interface NotificaPagamentoPortType {

    @WebResult(name = "NotificaPagamentoResponse", targetNamespace = "http://idp.tasgroup.it/xmlbillerservices/ws/NotificaPagamento/", partName = "response")
    @WebMethod(operationName = "NotificaPagamento", action = "http://idp.tasgroup.it/xmlbillerservices/ws/NotificaPagamento/NotificaPagamento")
    public NotificaPagamentoResponse notificaPagamento(
        @WebParam(partName = "request", name = "NotificaPagamento", targetNamespace = "http://idp.tasgroup.it/xmlbillerservices/ws/NotificaPagamento/")
        NotificaPagamento request
    );
}
