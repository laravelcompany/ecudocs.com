<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions">
  
  <xsl:template name="check_ForbiddenCharacters">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ForbiddenCharacters.xsl: template check_ForbiddenCharacters starts')"/></logmsg>    
    <!-- **************************************** -->
    <!-- ** CONTROLE DES CARACTERES DE LA BASE ** -->
    <!-- **************************************** -->
    <!-- Vérification que tous les caractères de la base sont inclus dans la page de code 1252. -->
    <!-- Dans le cas où un caractère interdit existe dans la base, le programe 'DDT_ForbiddenCharacters.exe'
              génère le fichier 'C:\DDT2000data\checkBaseDDT\ForbiddenCharacters.
         Ainsi, si le fichier existe, on doit le traiter pour remonter l'erreur dans le rapport, sinon, il n'y a rien à faire
    -->

    <!-- Vérification de l'existance du fichier -->
    <xsl:variable name="mForbiddenCharsFile">
      <xsl:choose>
        <xsl:when test="local:FileExists('C:\DDT2000data\checkBaseDDT\ForbiddenCharacters.xml')">
          <xsl:text>C:\DDT2000data\checkBaseDDT\ForbiddenCharacters.xml</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>NOT-EXIST</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Exploitation du fichier (s'il existe) -->
    <xsl:if test="$mForbiddenCharsFile != 'NOT-EXIST'">
      <!-- ******************************************* -->
      <!-- Error DE202 : DDT200_ERR_ForbiddenCharacter -->
      <!-- ******************************************* -->
      <xsl:for-each select="document($mForbiddenCharsFile)/FORBIDDEN-CHARACTERS/FORBIDDEN-CHARACTER">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT200_ERR_ForbiddenCharacter</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desForbiddenChar"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLineNumber"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            <xsl:value-of select="LINE"/>
            <br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoPositionNumber"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            <xsl:value-of select="POSITION"/>
            <br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoCharacter"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            [<xsl:value-of select="CHARACTER"/>]
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionForbiddenChar"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>
  
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ForbiddenCharacters.xsl: template check_ForbiddenCharacters starts')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>  
