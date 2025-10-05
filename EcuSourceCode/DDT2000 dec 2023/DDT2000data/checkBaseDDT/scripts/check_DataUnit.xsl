<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:ddt="http://www-diag.renault.com/2002/ECU"
	xmlns:ds="http://www-diag.renault.com/2002/screens"
	xmlns:ga="DiagnosticAddressingSchema.xml"
	xmlns:local="#local-functions">


	<xsl:template match="ddt:Datas/ddt:Data/ddt:Bits/ddt:Scaled">
    <xsl:variable name="mDataUnit" select="@Unit" />
    <xsl:if test="string-length($mDataUnit) &gt; 0 and not(document($mUnitFileName)/units/unit[symbol = $mDataUnit])">
      <!-- ****************************** -->
      <!-- Warning DW193 DDT2000_WAR_DataUnit -->
      <!-- ****************************** -->
      <xsl:call-template name="warning">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_WAR_DataUnit</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          : <b><xsl:value-of select="../../@Name" /></b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unit"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          : <b><xsl:value-of select="@Unit" /></b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unitNotDefine"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          version <b><xsl:value-of select="$mUnitVersion" /></b>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
      <!-- *********************************** -->
      <!-- Error AE015 : ALLIANCE_ERR_DataUnit -->
      <!-- *********************************** -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">ALLIANCE</xsl:with-param>
        <xsl:with-param name="chapter">ALLIANCE_ERR_DataUnit</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          : <b><xsl:value-of select="../../@Name" /></b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unit"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          : <b><xsl:value-of select="@Unit" /></b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unitNotDefine"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          version <b><xsl:value-of select="$mUnitVersion" /></b>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
	</xsl:template>

</xsl:stylesheet>