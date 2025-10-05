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
	xmlns:ga="DiagnosticAddressingSchema.xml"
	xmlns:local="#local-functions">

  <xsl:template name="GenericAdressing">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_GenericAdressing.xsl: template GenericAdressing starts')"/></logmsg>

    <xsl:if test="$mGenAddFileName!='Not Found'">
      <xsl:choose>
        <xsl:when test="ddt:CAN">
          <xsl:variable name="mFunctionName"><xsl:value-of select ="ddt:Function/@Name"></xsl:value-of></xsl:variable>
          <xsl:variable name="mFunctionAddress"><xsl:value-of select ="ddt:Function/@Address"></xsl:value-of></xsl:variable>
          <xsl:variable name="mFunctionSendId"><xsl:value-of select ="ddt:CAN/ddt:SendId/ddt:CANId/@Value"></xsl:value-of></xsl:variable>
          <xsl:variable name="mFunctionReceiveId"><xsl:value-of select ="ddt:CAN/ddt:ReceiveId/ddt:CANId/@Value"></xsl:value-of></xsl:variable>

          <xsl:choose>
            <xsl:when test="(
                    document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress]/ga:XId[.=$mFunctionSendId] and
                    document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress]/ga:RId[.=$mFunctionReceiveId]
                    )or(
                    (document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress]/ga:XId + 2147483648) = $mFunctionSendId and
                    (document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress]/ga:RId + 2147483648) = $mFunctionReceiveId
                    ) and (
                    document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress and @Name=$mFunctionName]
                    )
                    ">
                    <!-- ************************************************ -->
                    <!-- base cohérente avec le fichier GenericAddressing -->
                    <!-- ************************************************ -->
            </xsl:when>
            <xsl:otherwise>
              <!-- ******************************************* -->
              <!-- Error DE171 : DDT2000_ERR_GenericAddressing -->
              <!-- ******************************************* -->
              <!-- base incohérente avec le fichier GenericAddressing -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_GenericAddressing</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/AddressingChecking"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <table style="border-collapse:collapse">
                    <tr>
                      <th style="background-color:white;color:black;"></th>
                      <th style="background-color:white;color:black;">DataBase</th>
                      <th style="background-color:white;color:black;">GenericAddressing</th>
                    </tr>
                    <tr>
                      <td><b>Name</b></td>
                      <td><xsl:value-of select="$mFunctionName" /></td>
                      <td><xsl:value-of select="document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress]/@Name" /></td>
                    </tr>
                    <tr>
                      <td><b>Address</b></td>
                      <td><xsl:value-of select="$mFunctionAddress" /></td>
                      <td><xsl:value-of select="document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress]/@Address" /></td>
                    </tr>
                    <tr>
                      <td><b>XID</b></td>
                      <td><xsl:value-of select="$mFunctionSendId" /></td>
                      <td><xsl:value-of select="(document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress]/ga:XId + 2147483648)" /></td>
                    </tr>
                    <tr>
                      <td><b>RID</b></td>
                      <td><xsl:value-of select="$mFunctionReceiveId" /></td>
                      <td><xsl:value-of select="(document($mGenAddFileName)/ga:Functions/ga:Function[@Address=$mFunctionAddress]/ga:RId + 2147483648)" /></td>
                    </tr>
                  </table>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddressingChecking"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_GenericAdressing.xsl: template GenericAdressing ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
