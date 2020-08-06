/*
 * XML Type:  stAutenticazioneSoggetto
 * Namespace: http://www.digitpa.gov.it/schemas/2011/Pagamenti/
 * Java type: it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto
 *
 * Automatically generated - do not modify.
 */
package it.gov.digitpa.schemas.x2011.pagamenti;


/**
 * An XML stAutenticazioneSoggetto(@http://www.digitpa.gov.it/schemas/2011/Pagamenti/).
 *
 * This is an atomic type that is a restriction of it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto.
 */
public interface StAutenticazioneSoggetto extends org.apache.xmlbeans.XmlString
{
    public static final org.apache.xmlbeans.SchemaType type = (org.apache.xmlbeans.SchemaType)
        org.apache.xmlbeans.XmlBeans.typeSystemForClassLoader(StAutenticazioneSoggetto.class.getClassLoader(), "schemaorg_apache_xmlbeans.system.s41F9FA6057C7193A26B79565BC14C042").resolveHandle("stautenticazionesoggetto6503type");
    
    org.apache.xmlbeans.StringEnumAbstractBase enumValue();
    void set(org.apache.xmlbeans.StringEnumAbstractBase e);
    
    static final Enum CNS = Enum.forString("CNS");
    static final Enum USR = Enum.forString("USR");
    static final Enum OTH = Enum.forString("OTH");
    static final Enum N_A = Enum.forString("N/A");
    
    static final int INT_CNS = Enum.INT_CNS;
    static final int INT_USR = Enum.INT_USR;
    static final int INT_OTH = Enum.INT_OTH;
    static final int INT_N_A = Enum.INT_N_A;
    
    /**
     * Enumeration value class for it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto.
     * These enum values can be used as follows:
     * <pre>
     * enum.toString(); // returns the string value of the enum
     * enum.intValue(); // returns an int value, useful for switches
     * // e.g., case Enum.INT_CNS
     * Enum.forString(s); // returns the enum value for a string
     * Enum.forInt(i); // returns the enum value for an int
     * </pre>
     * Enumeration objects are immutable singleton objects that
     * can be compared using == object equality. They have no
     * public constructor. See the constants defined within this
     * class for all the valid values.
     */
    static final class Enum extends org.apache.xmlbeans.StringEnumAbstractBase
    {
        /**
         * Returns the enum value for a string, or null if none.
         */
        public static Enum forString(java.lang.String s)
            { return (Enum)table.forString(s); }
        /**
         * Returns the enum value corresponding to an int, or null if none.
         */
        public static Enum forInt(int i)
            { return (Enum)table.forInt(i); }
        
        private Enum(java.lang.String s, int i)
            { super(s, i); }
        
        static final int INT_CNS = 1;
        static final int INT_USR = 2;
        static final int INT_OTH = 3;
        static final int INT_N_A = 4;
        
        public static final org.apache.xmlbeans.StringEnumAbstractBase.Table table =
            new org.apache.xmlbeans.StringEnumAbstractBase.Table
        (
            new Enum[]
            {
                new Enum("CNS", INT_CNS),
                new Enum("USR", INT_USR),
                new Enum("OTH", INT_OTH),
                new Enum("N/A", INT_N_A),
            }
        );
        private static final long serialVersionUID = 1L;
        private java.lang.Object readResolve() { return forInt(intValue()); } 
    }
    
    /**
     * A factory class with static methods for creating instances
     * of this type.
     */
    
    public static final class Factory
    {
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto newValue(java.lang.Object obj) {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) type.newValue( obj ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto newInstance() {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().newInstance( type, null ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto newInstance(org.apache.xmlbeans.XmlOptions options) {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().newInstance( type, options ); }
        
        /** @param xmlAsString the string value to parse */
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.lang.String xmlAsString) throws org.apache.xmlbeans.XmlException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( xmlAsString, type, null ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.lang.String xmlAsString, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( xmlAsString, type, options ); }
        
        /** @param file the file from which to load an xml document */
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.io.File file) throws org.apache.xmlbeans.XmlException, java.io.IOException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( file, type, null ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.io.File file, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException, java.io.IOException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( file, type, options ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.net.URL u) throws org.apache.xmlbeans.XmlException, java.io.IOException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( u, type, null ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.net.URL u, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException, java.io.IOException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( u, type, options ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.io.InputStream is) throws org.apache.xmlbeans.XmlException, java.io.IOException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( is, type, null ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.io.InputStream is, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException, java.io.IOException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( is, type, options ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.io.Reader r) throws org.apache.xmlbeans.XmlException, java.io.IOException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( r, type, null ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(java.io.Reader r, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException, java.io.IOException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( r, type, options ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(javax.xml.stream.XMLStreamReader sr) throws org.apache.xmlbeans.XmlException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( sr, type, null ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(javax.xml.stream.XMLStreamReader sr, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( sr, type, options ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(org.w3c.dom.Node node) throws org.apache.xmlbeans.XmlException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( node, type, null ); }
        
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(org.w3c.dom.Node node, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( node, type, options ); }
        
        /** @deprecated {@link org.apache.xmlbeans.xml.stream.XMLInputStream} */
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(org.apache.xmlbeans.xml.stream.XMLInputStream xis) throws org.apache.xmlbeans.XmlException, org.apache.xmlbeans.xml.stream.XMLStreamException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( xis, type, null ); }
        
        /** @deprecated {@link org.apache.xmlbeans.xml.stream.XMLInputStream} */
        public static it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto parse(org.apache.xmlbeans.xml.stream.XMLInputStream xis, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException, org.apache.xmlbeans.xml.stream.XMLStreamException {
          return (it.gov.digitpa.schemas.x2011.pagamenti.StAutenticazioneSoggetto) org.apache.xmlbeans.XmlBeans.getContextTypeLoader().parse( xis, type, options ); }
        
        /** @deprecated {@link org.apache.xmlbeans.xml.stream.XMLInputStream} */
        public static org.apache.xmlbeans.xml.stream.XMLInputStream newValidatingXMLInputStream(org.apache.xmlbeans.xml.stream.XMLInputStream xis) throws org.apache.xmlbeans.XmlException, org.apache.xmlbeans.xml.stream.XMLStreamException {
          return org.apache.xmlbeans.XmlBeans.getContextTypeLoader().newValidatingXMLInputStream( xis, type, null ); }
        
        /** @deprecated {@link org.apache.xmlbeans.xml.stream.XMLInputStream} */
        public static org.apache.xmlbeans.xml.stream.XMLInputStream newValidatingXMLInputStream(org.apache.xmlbeans.xml.stream.XMLInputStream xis, org.apache.xmlbeans.XmlOptions options) throws org.apache.xmlbeans.XmlException, org.apache.xmlbeans.xml.stream.XMLStreamException {
          return org.apache.xmlbeans.XmlBeans.getContextTypeLoader().newValidatingXMLInputStream( xis, type, options ); }
        
        private Factory() { } // No instance of this class allowed
    }
}
