<?xml version="1.0" encoding="windows-1252"?>
<!--
    [XSL-XSLT] This stylesheet automatically updated from an IE5-compatible XSL stylesheet to XSLT.
    The following problems which need manual attention may exist in this stylesheet:
    -->
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:ddt="http://www-diag.renault.com/2002/ECU"
	xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions"
  >



  <xsl:template name="TesterPresent.WithResponse">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_TesterPresent_WithResponse.xsl: template TesterPresent.WithResponse starts')"/></logmsg>
  
  <!-- ***************************** -->
  <!-- Specification   36-00-013/B -->
  <!-- ***************************** -->
      <xsl:if test= "not(ddt:Requests/ddt:Request[@Name = 'TesterPresent.WithResponse'])">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_TesterPresent</xsl:with-param>
          <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b>TesterPresent.WithResponse</b>
          </xsl:with-param>
          <xsl:with-param name="info"><b>TesterPresent.WithResponse : </b>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b>TesterPresent.WithResponse</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_TesterPresent_WithResponse.xsl: template TesterPresent.WithResponse ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
