<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:ddt="http://www-diag.renault.com/2002/ECU"
	xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions"
  >
  <xsl:template name="ExternalFiles">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ExtFiles.xsl: template ExternalFiles starts')"/></logmsg>
    
    <!--  *****************************
          ** GENERIC ADDRESSING FILE **
          ***************************** -->
    <xsl:if test="$mGenAddFileName = 'Not Found'">
      <xsl:call-template name="error">
        <!-- ************************************* -->
        <!-- Error DE201 : DDT200_ERR_MissingFiles -->
        <!-- ************************************* -->
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT200_ERR_MissingFiles</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/GenericAddressingFile"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoFile"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotExists"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionSynchronize"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <!--  *******************
          ** PROJECTS FILE **
          ******************* -->
    <xsl:if test="$mProjectsFileName = 'Not Found'">
      <xsl:call-template name="error">
        <!-- ************************************* -->
        <!-- Error DE201 : DDT200_ERR_MissingFiles -->
        <!-- ************************************* -->
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT200_ERR_MissingFiles</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/ProjectFile"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoFile"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotExists"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionSynchronize"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
          
    <!--  ****************
          ** UNITS FILE **
          **************** -->
    <xsl:choose>
      <xsl:when test="$mUnitFileName = 'Not Found'">
        <xsl:call-template name="error">
          <!-- ************************************* -->
          <!-- Error DE201 : DDT200_ERR_MissingFiles -->
          <!-- ************************************* -->
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT200_ERR_MissingFiles</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/UnitsFile"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoFile"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotExists"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionSynchronize"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$mUnitFileName != $mUnitFileNameOfficial">
          <!-- *********************************** -->
          <!-- Warning AW006 ALLIANCE_WAR_BackupFileUsed -->
          <!-- *********************************** -->
          <xsl:call-template name="warning">
            <xsl:with-param name="type">ALLIANCE</xsl:with-param>
            <xsl:with-param name="chapter">ALLIANCE_WAR_BackupFileUsed</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/UnitsFile" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoUnitsFileUsed" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="$mUnitFileName"/></b>
              <br/>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoUnitsFileToUse" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="$mUnitFileNameOfficial"/></b>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionSynchronize"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ExtFiles.xsl: template ExternalFiles ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>