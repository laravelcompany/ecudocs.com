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

<!-- ******************************************************************************************
     Check used Data in multiple request and unused data

       Remarque : Utilisation de la fonction count() pour différencier les éléments traités
     ****************************************************************************************** -->
  <xsl:template name="DataInMultipleRequestOrUnused">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Data_InMultipleRequest_Or_Unused.xsl: template DataInMultipleRequestOrUnused starts')"/></logmsg>

    <!-- boucle n°1 -->
    <xsl:for-each select = "ddt:Datas/ddt:Data">

      <!-- Définition des variables -->
      <xsl:variable name="mDataName" select="@Name"></xsl:variable>
      <xsl:variable name="mMnemonic" select="ddt:Mnemonic"></xsl:variable>
      <xsl:variable name="mCounterSent" select="count(key('allSentDataItem',$mDataName))"></xsl:variable>
      <xsl:variable name="mCounterReceived" select="count(key('allReceivedDataItem',$mDataName))"></xsl:variable>
      <xsl:variable name="mCounter" select="$mCounterSent + $mCounterReceived"></xsl:variable>

      <xsl:choose>
        <xsl:when test="$mCounter = 1">
          <!-- Donnée utilisée 1 fois, pas de problème -->
        </xsl:when>

        <xsl:when test="$mCounter&gt;1">
          <xsl:call-template name="warning">
            <xsl:with-param name="type">CPDD</xsl:with-param>
            <xsl:with-param name="chapter">CPDD_WAR_DataUsedInMultipleRequest</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mDataName" /></b> <br/>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desUsedData"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mCounter" /></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/time"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :
              <ul>
                <!-- boucle n°2 -->
                <xsl:if test="$mCounterReceived&gt;0">
                  <ul>
                    <xsl:for-each select="key('allReceivedDataItem',$mDataName)">
                      <li><b><xsl:value-of select="../../@Name" /></b><br/>
                          <pre>
                            <xsl:call-template name="getLocalizedText">
                              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                            </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string(../../ddt:Sent/ddt:SentBytes),32)" />
                          </pre>
                      </li>
                    </xsl:for-each>
                  </ul>
                </xsl:if>

                <xsl:if test="$mCounterSent&gt;0">
                  <ul>
                    <xsl:for-each select="key('allSentDataItem',$mDataName)">
                      <li><b><xsl:value-of select="../../@Name" /></b><br/>
                          <pre>
                            <xsl:call-template name="getLocalizedText">
                              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                            </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string(../../ddt:Sent/ddt:SentBytes),32)" />
                          </pre>
                      </li>
                    </xsl:for-each>
                  </ul>
                </xsl:if>
              </ul>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>

        <xsl:otherwise>
          <xsl:call-template name="warning">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_WAR_DataUnused</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mDataName" /></b><br/>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoUnusedData"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUnusedData"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Data_InMultipleRequest_Or_Unused.xsl: template DataInMultipleRequestOrUnused ends')"/></logmsg>
  </xsl:template>

</xsl:stylesheet>
