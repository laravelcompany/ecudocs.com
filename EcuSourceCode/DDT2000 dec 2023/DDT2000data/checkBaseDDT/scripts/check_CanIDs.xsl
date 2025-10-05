<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions">

  <xsl:template name="CanIDs">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_CanIDs.xsl: template CanIDs starts')" /></logmsg>

      <xsl:variable name="sentId" select="ddt:CAN/ddt:SendId/ddt:CANId/@Value" />
      <xsl:variable name="receiveId" select="ddt:CAN/ddt:ReceiveId/ddt:CANId/@Value" />

      <xsl:variable name="sentExt">
        <xsl:choose>
          <xsl:when test="ddt:CAN/ddt:SendId/ddt:CANId/@Extended">
            <xsl:value-of select="ddt:CAN/ddt:SendId/ddt:CANId/@Extended" />
          </xsl:when>
          <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="txtSentExt">
        <xsl:choose>
          <xsl:when test="$sentExt = 0">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/upperNo" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/upperYes" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="receiveExt">
        <xsl:choose>
          <xsl:when test="ddt:CAN/ddt:ReceiveId/ddt:CANId/@Extended">
            <xsl:value-of select="ddt:CAN/ddt:ReceiveId/ddt:CANId/@Extended" />
          </xsl:when>
          <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="txtReceiveExt">
        <xsl:choose>
          <xsl:when test="$receiveExt = 0">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/upperNo" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/upperYes" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>


      <xsl:if test="($sentId &gt; 2047) and ($sentExt = 0)">
        <!-- ******************************************** -->
        <!-- Error DE197 : DDT2000_ERR_CanIdInconsistency -->
        <!-- ******************************************** -->
        <!-- SendId value > $7FF but  not Extended -->
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_CanIdInconsistency</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desSendCanId" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>: $<b><xsl:value-of select="local:ToHex(string($sentId),8)" /></b> Extended : <b><xsl:value-of select="$txtSentExt"/></b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInconsistencyCanId" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionInconsistencyCanId" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="($receiveId &gt; 2047) and ($receiveExt = 0)">
        <!-- ******************************************** -->
        <!-- Error DE197 : DDT2000_ERR_CanIdInconsistency -->
        <!-- ******************************************** -->
        <!-- ReceiveId value > $7FF but not Extended -->
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_CanIdInconsistency</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desReceiveCanId" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>: $<b><xsl:value-of select="local:ToHex(string($receiveId),8)" /></b> Extended : <b><xsl:value-of select="$txtReceiveExt"/></b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInconsistencyCanId" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionInconsistencyCanId" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$sentExt != $receiveExt">
        <!-- ******************************************** -->
        <!-- Error DE197 : DDT2000_ERR_CanIdInconsistency -->
        <!-- ******************************************** -->
        <!-- Sending and receiving CAN ID have not same Extended value -->
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_CanIdInconsistency</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desSendCanId" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>: $<b><xsl:value-of select="local:ToHex(string($sentId),8)" /></b> Extended : <b><xsl:value-of select="$txtSentExt"/></b>
            <br />
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desReceiveCanId" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>: $<b><xsl:value-of select="local:ToHex(string($receiveId),8)" /></b> Extended : <b><xsl:value-of select="$txtReceiveExt"/></b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInconsistencyCanIds" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionInconsistencyCanIds" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_CanIDs.xsl: template CanIDs ends')" /></logmsg>
  </xsl:template>
</xsl:stylesheet>