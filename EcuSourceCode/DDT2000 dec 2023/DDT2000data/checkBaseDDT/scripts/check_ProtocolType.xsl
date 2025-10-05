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
  xmlns:local="#local-functions"
  >

<!-- ******************************************************************************************
     Check protocol
     ****************************************************************************************** -->
  <xsl:template name="ProtocolType">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ProtocolType.xsl: template ProtocolType starts')"/></logmsg>

    <xsl:choose>
  <!-- ******************************* -->
  <!-- Detection du type de protocol K -->
  <!-- ******************************* -->
      <xsl:when test="ddt:K and not(ddt:CAN) and not(ddt:IP)">
        <xsl:choose>
          <!-- ISO8 -->
          <xsl:when test="ddt:K/ddt:ISO8">
            <xsl:call-template name="message">
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info"><b>ISO8</b><br/>
                KW1 : <xsl:value-of select="ddt:K/ddt:ISO8/ddt:KW1/@Value" /><br/>
                KW2 : <xsl:value-of select="ddt:K/ddt:ISO8/ddt:KW2/@Value" />  Timeout: <xsl:value-of select="ddt:K/ddt:ISO8/ddt:KW2/@Timeout" /><br/>
                FirstRequest Delay: <xsl:value-of select="ddt:K/ddt:ISO8/ddt:FirstRequest/@Delay" /><br/>
                InterByte Delay: <xsl:value-of select="ddt:K/ddt:InterByte/@Delay" /><br/>
                RequestToReply Timeout: <xsl:value-of select="ddt:K/ddt:RequestToReply/@Timeout" /><br/>
                TesterPresent Delay: <xsl:value-of select="ddt:K/ddt:TesterPresent/@Delay" /><br/>
                OnError Delay: <xsl:value-of select="ddt:K/ddt:OnError/@Delay" />
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>

          <!-- Diag on K -->
          <xsl:when test="ddt:K/ddt:KWP">
            <xsl:choose>
              <!-- KWP2000 FastInit MultiPoint-->
              <xsl:when test="ddt:K/ddt:KWP[ddt:FastInit and @Multipoint='1']">
                <xsl:call-template name="message">
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info"><b>KWP2000 FastInit MultiPoint</b><br/>
                    KW1 : <xsl:value-of select="ddt:K/ddt:KWP/ddt:FastInit/ddt:KW1/@Value" /><br/>
                    KW2 : <xsl:value-of select="ddt:K/ddt:KWP/ddt:FastInit/ddt:KW2/@Value" /><br/>
                    InterByte Delay: <xsl:value-of select="ddt:K/ddt:InterByte/@Delay" /><br/>
                    RequestToReply Timeout: <xsl:value-of select="ddt:K/ddt:RequestToReply/@Timeout" /><br/>
                    TesterPresent Delay: <xsl:value-of select="ddt:K/ddt:TesterPresent/@Delay" /><br/>
                    OnError Delay: <xsl:value-of select="ddt:K/ddt:OnError/@Delay" />
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>

              <!-- KWP2000 FastInit MonoPoint -->
              <xsl:when test="ddt:K/ddt:KWP[ddt:FastInit]">
                <xsl:call-template name="message">
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info"><b>KWP2000 FastInit MonoPoint</b><br/>
                    KW1 : <xsl:value-of select="ddt:K/ddt:KWP/ddt:FastInit/ddt:KW1/@Value" /><br/>
                    KW2 : <xsl:value-of select="ddt:K/ddt:KWP/ddt:FastInit/ddt:KW2/@Value" /><br/>
                    InterByte Delay: <xsl:value-of select="ddt:K/ddt:InterByte/@Delay" /><br/>
                    RequestToReply Timeout: <xsl:value-of select="ddt:K/ddt:RequestToReply/@Timeout" /><br/>
                    TesterPresent Delay: <xsl:value-of select="ddt:K/ddt:TesterPresent/@Delay" /><br/>
                    OnError Delay: <xsl:value-of select="ddt:K/ddt:OnError/@Delay" />
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>

              <!-- KWP2000 Init 5 Baud Type I and II -->
              <xsl:when test="ddt:K/ddt:KWP[not(ddt:FastInit) and @Multipoint='1']">
                <xsl:call-template name="message">
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info"><b>KWP2000 Init 5 Baud Type I and II</b><br/>
                    KW1 : <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:KW1/@Value" /><br/>
                    KW2 : <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:KW2/@Value" />  Timeout: <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:L/ddt:KW2/@Timeout" /><br/>
                    FirstRequest Delay: <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:FirstRequest/@Delay" /><br/>
                    KW2 Delay: <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:FirstRequest/@Delay" /><br/>
                    InterByte Delay: <xsl:value-of select="ddt:K/ddt:InterByte/@Delay" /><br/>
                    RequestToReply Timeout: <xsl:value-of select="ddt:K/ddt:RequestToReply/@Timeout" /><br/>
                    TesterPresent Delay: <xsl:value-of select="ddt:K/ddt:TesterPresent/@Delay" /><br/>
                    OnError Delay: <xsl:value-of select="ddt:K/ddt:OnError/@Delay" />
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>

              <!-- KWP2000 Init 5 Bauds Type I -->
              <xsl:when test="ddt:K/ddt:KWP[not(ddt:FastInit)]">
                <xsl:call-template name="message">
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info"><b>KWP2000 Init 5 Baud Type I</b><br/>
                    KW1 : <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:KW1/@Value" /><br/>
                    KW2 : <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:KW2/@Value" />  Timeout: <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:KW2/@Timeout" /><br/>
                    FirstRequest Delay: <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:FirstRequest/@Delay" /><br/>
                    KW2 Delay: <xsl:value-of select="ddt:K/ddt:KWP/ddt:ISO8/ddt:FirstRequest/@Delay" /><br/>
                    InterByte Delay: <xsl:value-of select="ddt:K/ddt:InterByte/@Delay" /><br/>
                    RequestToReply Timeout: <xsl:value-of select="ddt:K/ddt:RequestToReply/@Timeout" /><br/>
                    TesterPresent Delay: <xsl:value-of select="ddt:K/ddt:TesterPresent/@Delay" /><br/>
                    OnError Delay: <xsl:value-of select="ddt:K/ddt:OnError/@Delay" />
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>

              <!-- **Unknown Protocol** -->
              <xsl:otherwise>
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DDT2000</xsl:with-param>
                  <xsl:with-param name="chapter">DDT2000_ERR_ProtocolType</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unknown"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUnknownProtocol"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <!-- **Unknown Protocol** -->
          <xsl:otherwise>
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_ProtocolType</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info">
                <b>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unknown"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUnknownProtocol"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

  <!-- ********************************* -->
  <!-- Detection du type de protocol CAN -->
  <!-- ********************************* -->
      <xsl:when test="ddt:CAN and not(ddt:K) and not(ddt:IP)">
        <xsl:choose>
          <!-- DiagOnCAN -->
          <xsl:when test="ddt:CAN/ddt:SendId">
            <xsl:call-template name="message">
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info"><b>DiagOnCAN</b>
                <table style="border-collapse:collapse">
                  <tr>
                    <td><b>XID</b>(SendId)</td>
                    <td><xsl:value-of select="ddt:CAN/ddt:SendId/ddt:CANId/@Value" />
                      (<xsl:call-template name="toHex">
                        <xsl:with-param name="number"><xsl:value-of select="ddt:CAN/ddt:SendId/ddt:CANId/@Value" /></xsl:with-param>
                        <xsl:with-param name="digits">3</xsl:with-param>
                        <xsl:with-param name="prefix">$</xsl:with-param>
                      </xsl:call-template>)
                    </td>
                  </tr>
                  <tr>
                    <td><b>RID</b>(ReceiveID)</td>
                    <td><xsl:value-of select="ddt:CAN/ddt:ReceiveId/ddt:CANId/@Value" />
                      (<xsl:call-template name="toHex">
                        <xsl:with-param name="number"><xsl:value-of select="ddt:CAN/ddt:ReceiveId/ddt:CANId/@Value" /></xsl:with-param>
                        <xsl:with-param name="digits">3</xsl:with-param>
                        <xsl:with-param name="prefix">$</xsl:with-param>
                      </xsl:call-template>)
                    </td>
                  </tr>
                </table>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>

          <!-- CAN Messaging -->
          <xsl:otherwise>
            <xsl:call-template name="message">
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info">
                <b>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoCanMessaging"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </b>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

  <!-- ********************************** -->
  <!-- Detection du type de protocol DoIp -->
  <!-- ********************************** -->
      <xsl:when test="ddt:IP and not(ddt:K) and not(ddt:CAN)">
        <xsl:choose>
          <!-- DigOnIP -->
          <xsl:when test="ddt:IP/ddt:IPAddress and ddt:IP/ddt:MACAddress">
            <xsl:call-template name="message">
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info"><b>DiagOnIP</b>
                <table style="border-collapse:collapse">
                  <tr>
                    <td><b>IPAddress</b></td>
                    <td><xsl:value-of select="ddt:IP/ddt:IPAddress" /></td>
                  </tr>
                  <tr>
                    <td><b>MACAddress</b></td>
                    <td><xsl:value-of select="ddt:IP/ddt:MACAddress" /></td>
                  </tr>
                </table>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>

          <!-- **Unknown Protocol** -->
          <xsl:otherwise>
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_ProtocolType</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info">
                <b>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unknown"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUnknownProtocol"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <!-- **Unknown Protocol** -->
      <xsl:otherwise>
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_ProtocolType</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desProtocolType"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unknown"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </b>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUnknownProtocol"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ProtocolType.xsl: template ProtocolType ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
