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
     Check ShiftBytesCount :
     ****************************************************************************************** -->
  <xsl:template name="ShiftBytesCount">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ShiftBytesCount.xsl: template ShiftBytesCount starts')"/></logmsg>

    <xsl:for-each select = "ddt:Requests/ddt:Request/ddt:Received/ddt:ShiftBytesCount">
      <xsl:choose>

        <xsl:when test= "../../ddt:Sent/ddt:SentBytes = '1902FF'">
          <!-- allowed -->
        </xsl:when>
        <xsl:when test= "../../ddt:Sent/ddt:SentBytes = '17FF00'">
          <!-- allowed -->
        </xsl:when>
        <xsl:when test= "../../ddt:Sent[starts-with(ddt:SentBytes,'190A')]
                or ../../ddt:Sent[starts-with(ddt:SentBytes,'190B')]
                or ../../ddt:Sent[starts-with(ddt:SentBytes,'190C')]
                or ../../ddt:Sent[starts-with(ddt:SentBytes,'190D')]
                or ../../ddt:Sent[starts-with(ddt:SentBytes,'190E')]
                or ../../ddt:Sent[starts-with(ddt:SentBytes,'190F')]
                or ../../ddt:Sent[starts-with(ddt:SentBytes,'1913')]
                or ../../ddt:Sent[starts-with(ddt:SentBytes,'1914')]
                or ../../ddt:Sent[starts-with(ddt:SentBytes,'1915')]
                ">
          <!-- 19xx where xx =  0A 0B 0C 0D 0E 0F 13 14 15 allowed  for UDS-->
        </xsl:when>


        <xsl:otherwise>
          <xsl:call-template name="warning">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_WAR_ShiftByteCount</xsl:with-param>
            <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b><br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string(../../ddt:Sent/ddt:SentBytes),32)" /></pre>
            </xsl:with-param>
            <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoShiftByteCount" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="../ddt:ShiftBytesCount" /></b>
            </xsl:with-param>
            <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ShiftBytesCount.xsl: template ShiftBytesCount ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
