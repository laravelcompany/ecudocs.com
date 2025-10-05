<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions">

  <xsl:template name="check_Projects">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Projects.xsl: template check_Projects starts')" /></logmsg>

    <xsl:if test="$mProjectsFileName != 'Not Found'">
      <xsl:for-each select="Projects/*">
        <xsl:variable name="code" select="name(.)" />
        <xsl:if test="not(document($mProjectsFileName)/projects/Manufacturer/project[@code=$code])">
          <!-- ***************************************** -->
          <!-- Error DE199 : DDT2000_ERR_ProjectNotExist -->
          <!-- ***************************************** -->
          <!-- Vehicle project not exist on project.xml file -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_ERR_ProjectNotExist</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desVehicleProject"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              : <b><xsl:value-of select="$code" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desVehicleProject"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="action">
              <ul>
                <li>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionSynchronize"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </li>
                <li>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionFail"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>:
                  <ul>
                    <li>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRemoveProject"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </li>
                    <li>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCloseOpen"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </li>
                    <li>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionSelectProject"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </li>
                    <li>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUpdateProject"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </li>
                  </ul>
                </li>
              </ul>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Projects.xsl: template check_Projects ends')" /></logmsg>
  </xsl:template>
</xsl:stylesheet>