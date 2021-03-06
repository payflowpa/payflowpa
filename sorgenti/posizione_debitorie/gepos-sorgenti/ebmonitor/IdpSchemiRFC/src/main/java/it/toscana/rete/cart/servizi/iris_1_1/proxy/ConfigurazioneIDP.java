package it.toscana.rete.cart.servizi.iris_1_1.proxy;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.bind.annotation.XmlSeeAlso;

/**
 * This class was generated by Apache CXF 2.7.11
 * 2020-02-10T11:37:29.060+01:00
 * Generated source version: 2.7.11
 * 
 */
@WebService(targetNamespace = "http://www.cart.rete.toscana.it/servizi/iris_1_1/proxy", name = "ConfigurazioneIDP")
@XmlSeeAlso({it.toscana.rete.cart.servizi.iris_1_1.idpheader.ObjectFactory.class, ObjectFactory.class, it.toscana.rete.cart.servizi.iris_1_1.idpconfigurazione.ObjectFactory.class, it.toscana.rete.cart.servizi.iris_1_1.idpesito.ObjectFactory.class, it.toscana.rete.cart.servizi.iris_1_1.idpinclude.ObjectFactory.class})
@SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
public interface ConfigurazioneIDP {

    @WebMethod(operationName = "IdpConfigurazioneEnte", action = "IdpConfigurazioneEnte")
    @WebResult(name = "IdpConfigurazioneEnte.Esito", targetNamespace = "http://www.cart.rete.toscana.it/servizi/iris_1_1/proxy", partName = "IdpConfigurazioneEnte.Esito")
    public IdpConfigurazioneEnteEsito idpConfigurazioneEnte(
        @WebParam(partName = "IdpConfigurazioneEnte", name = "IdpConfigurazioneEnte", targetNamespace = "http://www.cart.rete.toscana.it/servizi/iris_1_1/proxy")
        IdpConfigurazioneEnte idpConfigurazioneEnte
    );

    @WebMethod(operationName = "IdpConfigurazioneTributi", action = "IdpConfigurazioneTributi")
    @WebResult(name = "IdpConfigurazioneTributi.Esito", targetNamespace = "http://www.cart.rete.toscana.it/servizi/iris_1_1/proxy", partName = "IdpConfigurazioneTribut.Esito")
    public IdpConfigurazioneTributiEsito idpConfigurazioneTributi(
        @WebParam(partName = "IdpConfigurazioneTributi", name = "IdpConfigurazioneTributi", targetNamespace = "http://www.cart.rete.toscana.it/servizi/iris_1_1/proxy")
        IdpConfigurazioneTributi idpConfigurazioneTributi
    );
}
