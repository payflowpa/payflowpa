package it.gov.spcoop.nodopagamentispc.servizi.pagamentitelematiciccp;

import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceFeature;
import javax.xml.ws.Service;

/**
 * This class was generated by Apache CXF 2.7.11
 * 2018-12-17T16:55:25.319+01:00
 * Generated source version: 2.7.11
 * 
 */
@WebServiceClient(name = "PagamentiTelematiciCCPservice", 
                  wsdlLocation = "classpath:PaPerNodo.wsdl",
                  targetNamespace = "http://NodoPagamentiSPC.spcoop.gov.it/servizi/PagamentiTelematiciCCP") 
public class PagamentiTelematiciCCPservice extends Service {

    public final static URL WSDL_LOCATION;

    public final static QName SERVICE = new QName("http://NodoPagamentiSPC.spcoop.gov.it/servizi/PagamentiTelematiciCCP", "PagamentiTelematiciCCPservice");
    public final static QName PPTPort = new QName("http://NodoPagamentiSPC.spcoop.gov.it/servizi/PagamentiTelematiciCCP", "PPTPort");
    static {
        URL url = PagamentiTelematiciCCPservice.class.getClassLoader().getResource("PaPerNodo.wsdl");
        if (url == null) {
            java.util.logging.Logger.getLogger(PagamentiTelematiciCCPservice.class.getName())
                .log(java.util.logging.Level.INFO, 
                     "Can not initialize the default wsdl from {0}", "classpath:PaPerNodo.wsdl");
        }       
        WSDL_LOCATION = url;   
    }

    public PagamentiTelematiciCCPservice(URL wsdlLocation) {
        super(wsdlLocation, SERVICE);
    }

    public PagamentiTelematiciCCPservice(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public PagamentiTelematiciCCPservice() {
        super(WSDL_LOCATION, SERVICE);
    }
    

    /**
     *
     * @return
     *     returns PagamentiTelematiciCCP
     */
    @WebEndpoint(name = "PPTPort")
    public PagamentiTelematiciCCP getPPTPort() {
        return super.getPort(PPTPort, PagamentiTelematiciCCP.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns PagamentiTelematiciCCP
     */
    @WebEndpoint(name = "PPTPort")
    public PagamentiTelematiciCCP getPPTPort(WebServiceFeature... features) {
        return super.getPort(PPTPort, PagamentiTelematiciCCP.class, features);
    }

}