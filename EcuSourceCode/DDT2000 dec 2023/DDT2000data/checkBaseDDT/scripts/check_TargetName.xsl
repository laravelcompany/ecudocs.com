<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions">

  <xsl:template name="TargetName">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_TargetName.xsl: template TargetName starts')" /></logmsg>

    <xsl:variable name="ecuName" select="string(//ddt:Target/@Name)" />
    <xsl:variable name="invalidChar" select="local:checkTargetName($ecuName)" />

    <xsl:if test="$invalidChar !=''">
      <!-- ************************************ -->
      <!-- Error DE200 : DDT2000_ERR_TargetName -->
      <!-- ************************************ -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_TargetName</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desEcuName"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>: <b><xsl:value-of select="$ecuName" /></b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidCharacter"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>: -&gt;<b><xsl:value-of select="$invalidChar" /></b>&lt;-
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValidCharacter"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>: <b><xsl:value-of select="local:getTargetNameValidChars($language)" /></b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_TargetName.xsl: template TargetName ends')" /></logmsg>
  </xsl:template>
</xsl:stylesheet>