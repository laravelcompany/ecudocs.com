<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:ddt="http://www-diag.renault.com/2002/ECU"
xmlns:ds="http://www-diag.renault.com/2002/screens"
xmlns:local="#local-functions"
>

  <xsl:template name="ByteBoundary">
    <xsl:param name="dataItem"/>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ByteBoundary.xsl: template ByteBoundary starts')"/></logmsg>
    <xsl:variable name="mDataName" select="$dataItem/@Name"/>
    <xsl:variable name="mData" select="key('allDatas', @Name)"/>
    <xsl:variable name="mBitOffset">
      <xsl:choose>
        <xsl:when test="$dataItem/@BitOffset"><xsl:value-of select="$dataItem/@BitOffset"/></xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$mData/ddt:Bytes">
        <xsl:if test="$mBitOffset != 0">
          <!-- ************************************************************************************* -->
          <!-- Error ME022 : DAIMLER_ERR_ByteBoundary (Donnée non numérique avec un bit offset != 0) -->
          <!-- ************************************************************************************* -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">DAIMLER</xsl:with-param>
            <xsl:with-param name="chapter">DAIMLER_ERR_ByteBoundary</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="$dataItem/../../@Name"/></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="$mData/@Name"/></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidBitOffset"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <br/>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="$mBitOffset"/></b>
              <br/>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b>0</b>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>

          <!-- ************************************************************************************** -->
          <!-- Error AE017 : ALLIANCE_ERR_ByteBoundary (Donnée non numérique avec un bit offset != 0) -->
          <!-- ************************************************************************************* -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">ALLIANCE</xsl:with-param>
            <xsl:with-param name="chapter">ALLIANCE_ERR_ByteBoundary</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="$dataItem/../../@Name"/></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="$mData/@Name"/></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidBitOffset"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <br/>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="$mBitOffset"/></b>
              <br/>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b>0</b>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="mBitCount">
          <xsl:choose>
            <xsl:when test="$mData/ddt:Bits/@count"><xsl:value-of select="$mData/ddt:Bits/@count"/></xsl:when>
            <xsl:otherwise>8</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$mBitCount &lt; 8">
            <xsl:if test="($mBitCount + $mBitOffset) &gt; 8">
              <!-- ******************************************************************************************************************* -->
              <!-- Error ME022 : DAIMLER_ERR_ByteBoundary (Donnée numérique ou liste numérique de taille < 8 positionnée sur 2 octets) -->
              <!-- ******************************************************************************************************************* -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_ByteBoundary</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$dataItem/../../@Name"/></b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$mData/@Name"/></b>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoByteBoundary2Bytes"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionByteBoundary2Bytes"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:when>
          <xsl:when test="($mBitCount = 8) or ($mBitCount = 16) or ($mBitCount = 24) or ($mBitCount = 32)">
            <xsl:if test="$mBitOffset != 0">
              <!-- ******************************************************************************************************************************** -->
              <!-- Error ME022 : DAIMLER_ERR_ByteBoundary (Donnée numérique ou liste numérique de taille 8, 16,24 ou 32 et avec un bit offset != 0) -->
              <!-- ******************************************************************************************************************************** -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_ByteBoundary</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$dataItem/../../@Name"/></b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$mData/@Name"/></b>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidBitOffset"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$mBitOffset"/></b>
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b>0</b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <!-- ******************************************************************************************************** -->
            <!-- Error ME022 : DAIMLER_ERR_ByteBoundary (nombre de bit de la donné numérique ou liste numérique invalide) -->
            <!-- ******************************************************************************************************** -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DAIMLER</xsl:with-param>
              <xsl:with-param name="chapter">DAIMLER_ERR_ByteBoundary</xsl:with-param>
              <xsl:with-param name="description">

                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="$dataItem/../../@Name"/></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="$mData/@Name"/></b>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidLenght"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="$mBitCount"/></b>
                <br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b>8 - 16 - 24 - 32</b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ByteBoundary.xsl: template ByteBoundary ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>