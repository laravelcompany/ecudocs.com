<?xml version="1.0" encoding="windows-1252"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:ddt="http://www-diag.renault.com/2002/ECU"
	xmlns:ds="http://www-diag.renault.com/2002/screens"
	xmlns:local="#local-functions">



<!-- ******************************************************************************************
     Check Data Numerical if DividedBy 0 :
     ****************************************************************************************** -->
  <xsl:template name="DataNumericalDividedBy0">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DataNumericalDividedBy0.xsl: template DataNumericalDividedBy0 starts')"/></logmsg>

    <!-- ************
         Check DivideBy != 0
         ************ -->
    <xsl:for-each select="ddt:Datas/ddt:Data/ddt:Bits/ddt:Scaled[local:LowerSpaceRemove(string(@DivideBy)) = '0']">
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_DataNumericalDividedBy0</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
            <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b> <br/>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDividedBy0"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDividedBy0"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>
    <!-- ************
         Check DivideBy != xE+yy
         ************ -->
    <xsl:for-each select="ddt:Datas/ddt:Data/ddt:Bits/ddt:Scaled[contains(local:LowerSpaceRemove(string(@DivideBy)),'e+')]">
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_DataNumericalDividedBy0</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
            <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b> <br/>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDividedBy0"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDividedBy0"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DataNumericalDividedBy0.xsl: template DataNumericalDividedBy0 ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
