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
     Check Bytes Count
     ****************************************************************************************** -->
<xsl:template match="ddt:Datas/ddt:Data/ddt:Bytes">

	<xsl:variable name="mBytesCount" select="@count"></xsl:variable>

	<xsl:if test="//ddt:Target/ddt:K">
	<!-- **********************
		 Check Bytes Count on K
 		*********************** -->
		<xsl:if test="$mBytesCount&lt;1 or $mBytesCount&gt;255 or floor($mBytesCount) != $mBytesCount">
			<xsl:call-template name="error">
				<xsl:with-param name="type">DDT2000</xsl:with-param>
				<xsl:with-param name="chapter">DDT2000_ERR_DataBytesCount</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><xsl:value-of select="../@Name" /></b>
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">Donnée*</xsl:with-param>
					</xsl:call-template> : <b><xsl:value-of select="$mBytesCount" /></b><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="action">
					DiagOnK :
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> (Integer) : [1,255]
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>

	<xsl:if test="//ddt:Target/ddt:CAN or //ddt:Target/ddt:IP">
	<!-- ************************
		 Check Bytes Count on CAN
 		************************* -->
		<xsl:if test="$mBytesCount&lt;1 or $mBytesCount&gt;4095 or floor($mBytesCount) != $mBytesCount">
			<xsl:call-template name="error">
				<xsl:with-param name="type">DDT2000</xsl:with-param>
				<xsl:with-param name="chapter">DDT2000_ERR_DataBytesCount</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><xsl:value-of select="../@Name" /></b>
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">Donnée*</xsl:with-param>
					</xsl:call-template> : <b><xsl:value-of select="$mBytesCount" /></b><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="action">
          DiagOnCAN / DoIP:
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> (Integer) : <b>[1,4095] </b>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>

<!-- ******************************************************************************************
     Check Bytes ASCII value
     ****************************************************************************************** -->
	<xsl:if test="@ascii">
		<xsl:variable name="mBytesAscii" select="@ascii"></xsl:variable>

		<xsl:if test="$mBytesAscii!= 1">
			<xsl:call-template name="warning">
				<xsl:with-param name="type">CPDD</xsl:with-param>
				<xsl:with-param name="chapter">CPDD_WAR_DataBytesAscii</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="../@Name" /></b><br/>
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIndicatorAscii1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> = <b><xsl:value-of select="$mBytesAscii" /></b><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIndicatorAscii2"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionIndicatorAscii"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>


</xsl:template>

</xsl:stylesheet>
