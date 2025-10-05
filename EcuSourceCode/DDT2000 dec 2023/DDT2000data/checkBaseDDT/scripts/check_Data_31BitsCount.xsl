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
  xmlns:local="#local-functions">

  <!-- **************************************************
       Check Data Bits count > 16 and != 24 and != 32 bits
      *************************************************** -->
  <xsl:template name="Data_31BitsCount">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName,'check_Data_31BitsCount.xsl: template Data_31BitsCount starts')" /></logmsg>
    
    <xsl:for-each select="ddt:Datas/ddt:Data/ddt:Bits[(@count &gt;'16')and (@count != '24')and (@count != '32')]">
      <xsl:call-template name="warning">
        <xsl:with-param name="type">CPDD</xsl:with-param>
        <xsl:with-param name="chapter">CPDD_WAR_Data_31BitsCount</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
            <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="../@Name" /></b> <br/>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> =   <b><xsl:value-of select="@count" /></b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit2" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName,'check_Data_31BitsCount.xsl: template Data_31BitsCount ends')" /></logmsg>
  </xsl:template>

</xsl:stylesheet>
