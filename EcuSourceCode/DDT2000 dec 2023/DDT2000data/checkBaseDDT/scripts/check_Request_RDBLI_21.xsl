<?xml version="1.0" encoding="windows-1252"?>
<!--
    [XSL-XSLT] This stylesheet automatically updated from an IE5-compatible XSL stylesheet to XSLT.
    The following problems which need manual attention may exist in this stylesheet:
    -->
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:ddt="http://www-diag.renault.com/2002/ECU"
	xmlns:ds="http://www-diag.renault.com/2002/screens">

<xsl:template match="ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,2) = '21']">

	<xsl:if test="../ddt:ManuelSend">
		<xsl:call-template name="error">
			<xsl:with-param name="description">Request : <xsl:value-of select="../@Name" /> ($<xsl:value-of select="ddt:SentBytes" />)</xsl:with-param>
			<xsl:with-param name="info">"Manual Send" in 21... requests</xsl:with-param>
			<xsl:with-param name="action">Suppress "Manuel Send"</xsl:with-param>
		</xsl:call-template>
	</xsl:if>

	<xsl:if test="ddt:DataItem">
		<xsl:call-template name="error">
			<xsl:with-param name="description">Request : <xsl:value-of select="../@Name" /> ($<xsl:value-of select="ddt:SentBytes" />)</xsl:with-param>
			<xsl:with-param name="info">Sent parameters shoud be empty  in 21... requests
				DataItem :
				<xsl:for-each select="ddt:DataItem">
					(<xsl:value-of select="@Name" />)
				</xsl:for-each>
			</xsl:with-param>
			<xsl:with-param name="action">suppress sent parameters in 21... requests</xsl:with-param>
		</xsl:call-template>
	</xsl:if>


</xsl:template>


</xsl:stylesheet>
