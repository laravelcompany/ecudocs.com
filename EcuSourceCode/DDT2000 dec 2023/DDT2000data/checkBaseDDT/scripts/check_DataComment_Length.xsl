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

<!-- ******************************************************************************************
     Check Data Comment length
     ****************************************************************************************** -->
  <xsl:template match="ddt:Datas/ddt:Data/ddt:Comment">
    <xsl:variable name="comment" select="."></xsl:variable>

    <xsl:if test="string-length(.)&gt;100"> <!-- 100 characters -->
      <xsl:call-template name="warning">
        <xsl:with-param name="type">CPDD</xsl:with-param>
        <xsl:with-param name="chapter">CPDD_WAR_DataComment</xsl:with-param>
        <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b><xsl:value-of select="../@Name" /></b>
        </xsl:with-param>
        <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoComment"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            <!--</xsl:call-template> :  <b><xsl:value-of select="." /></b><br/>-->
            </xsl:call-template> : <pre><b><xsl:value-of select="local:WriteMultiLineEx(string($comment),32)" /></b></pre><br/>
                <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b><xsl:value-of select="string-length(.)" /></b>
                <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAuthorizedLength"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>255</b>
                <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
