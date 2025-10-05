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
  
  <msxsl:script language="VBScript" implements-prefix = "local">
    <![CDATA[
    function ToDec(t)
    ToDec = clng("&h" & t )
    end function]]>
  </msxsl:script>

  <xsl:template name="AddressFunction">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName,'check_AddressFunction.xsl: template AddressFunction starts')"/></logmsg>
    <xsl:choose>
      <xsl:when test="(ddt:Function/@Address &lt;1) or (ddt:Function/@Address &gt;254)"> <!-- valeur décimale dans le fichier xml -->
        <!-- ***************************************** -->
        <!-- Error DE170 : DDT2000_ERR_AddressFunction -->
        <!-- ***************************************** -->
        <!-- Check Address for CPDD :  1 <= Address < 255 (decimal values) -->
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_AddressFunction</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desFunctionAddress" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>: <b><xsl:value-of select="ddt:Function/@Address" /></b>
            (
              <xsl:call-template name="toHex">
                <xsl:with-param name="number"><xsl:value-of select="ddt:Function/@Address" /></xsl:with-param>
                <xsl:with-param name="digits">2</xsl:with-param>
                <xsl:with-param name="prefix">$</xsl:with-param>
              </xsl:call-template>
            )
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAllowedFunctionAddress" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>: <b>[1 , 254]</b>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckFunctionAddress" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="(ddt:Function/@Type = 'CGW') and (not(ddt:Function/@Address = 210 or ddt:Function/@Address = 212 or ddt:Function/@Address = 235))">
        <!-- ******************************************** -->
        <!-- Error DE196 : DDT2000_ERR_FunctionAddressCGW -->
        <!-- ******************************************** -->
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_FunctionAddressCGW</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desFunctionAddress" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>: <b><xsl:value-of select="ddt:Function/@Address" /></b>
            (
              <xsl:call-template name="toHex">
                <xsl:with-param name="number"><xsl:value-of select="ddt:Function/@Address" /></xsl:with-param>
                <xsl:with-param name="digits">2</xsl:with-param>
                <xsl:with-param name="prefix">$</xsl:with-param>
              </xsl:call-template>
            )
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>$D2</b> (210)
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template><b>$D4</b> (212)
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckFunctionAddress" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            <br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            <br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckCGW" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    
    <logmsg><xsl:value-of select="local:AddMessage($logFileName,'check_AddressFunction.xsl: template AddressFunction ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
