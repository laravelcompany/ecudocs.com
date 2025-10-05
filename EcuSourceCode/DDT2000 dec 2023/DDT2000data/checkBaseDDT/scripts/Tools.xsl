<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:ddt="http://www-diag.renault.com/2002/ECU"
xmlns:ds="http://www-diag.renault.com/2002/screens"
xmlns:local="#local-functions">

	<xsl:template name="toHex">
		<!--
		* *******************************************************
		* Template for decimal to hexadecimal display
		* based on source located at
		* http://www.dpawson.co.uk/xsl/sect2/N5121.html#d6079e181
		*
		* *******************************************************
		* Call sample:
		* <xsl:call-template name="toHex">
		*  	<xsl:with-param name="number" ><xsl:value-of select="." /></xsl:with-param>
		*  	<xsl:with-param name="digits" >3</xsl:with-param>
		*  	<xsl:with-param name="prefix" ></xsl:with-param>
		*  	<xsl:with-param name="suffix" > H</xsl:with-param>
		*  	<xsl:with-param name="padchar">0</xsl:with-param>
		* </xsl:call-template>
		*
		* *******************************************************
		* Default parameters:
		*    prefix : 0x
		*    suffix : (empty)
		*    digits : 4         (to disable padding, set digits to 0)
		*    padchar: 0
		*
		* *******************************************************
		-->
		<xsl:param name="number" >0</xsl:param>
		<xsl:param name="prefix" >0x</xsl:param>
		<xsl:param name="suffix" ></xsl:param>
		<xsl:param name="digits" >4</xsl:param>
		<xsl:param name="padchar">0</xsl:param>
		<!-- *******************************************************-->

		<xsl:param name="digitCounter">0</xsl:param>
		<xsl:variable name="varDigitCounter">
			<xsl:value-of select="$digitCounter + 1" />
		</xsl:variable>

		<xsl:variable name="low">
			<xsl:value-of select="$number mod 16" />
		</xsl:variable>

		<xsl:variable name="high">
			<xsl:value-of select="floor($number div 16)" />
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$high &gt; 0">
				<xsl:call-template name="toHex">
					<xsl:with-param name="number">
						<xsl:value-of select="$high" />
					</xsl:with-param>
					<xsl:with-param name="digits" ><xsl:value-of select="$digits" /></xsl:with-param>
					<xsl:with-param name="prefix" ><xsl:value-of select="$prefix" /></xsl:with-param>
					<xsl:with-param name="padchar"><xsl:value-of select="$padchar" /></xsl:with-param>
					<xsl:with-param name="digitCounter"><xsl:value-of select="$varDigitCounter" /></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="digitTemp"><xsl:value-of select="number($digits)-number($varDigitCounter)" /></xsl:variable>
				<xsl:value-of select="$prefix" />
				<xsl:if test="$digitTemp &gt; 0"><xsl:value-of select="$padchar" /></xsl:if>
				<xsl:if test="$digitTemp &gt; 1"><xsl:value-of select="$padchar" /></xsl:if>
				<xsl:if test="$digitTemp &gt; 2"><xsl:value-of select="$padchar" /></xsl:if>
				<xsl:if test="$digitTemp &gt; 3"><xsl:value-of select="$padchar" /></xsl:if>
				<xsl:if test="$digitTemp &gt; 4"><xsl:value-of select="$padchar" /></xsl:if>
				<xsl:if test="$digitTemp &gt; 5"><xsl:value-of select="$padchar" /></xsl:if>
				<xsl:if test="$digitTemp &gt; 6"><xsl:value-of select="$padchar" /></xsl:if>
				<xsl:if test="$digitTemp &gt; 7"><xsl:value-of select="$padchar" /></xsl:if>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="$low &lt; 10">
				<xsl:value-of select="$low" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="temp">
					<xsl:value-of select="$low - 10" />
				</xsl:variable>
				<xsl:value-of select="translate($temp, '012345', 'ABCDEF')" />
			</xsl:otherwise>
		</xsl:choose>

		<xsl:value-of select="$suffix" />
	</xsl:template>

	<xsl:template name="GetDataBitLength">
		<xsl:param name="data" />
		<xsl:choose>
			<xsl:when test="$data/ddt:Bytes/@count">
				<xsl:value-of select="$data/ddt:Bytes/@count*8" />
			</xsl:when>
			<xsl:when test="$data/ddt:Bits/@count">
				<xsl:value-of select="$data/ddt:Bits/@count" />
			</xsl:when>
			<xsl:otherwise>8</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="GetBitOffset">
		<xsl:param name="dataItem" />
		<xsl:choose>
			<xsl:when test="$dataItem/@BitOffset">
				<xsl:value-of select="$dataItem/@BitOffset" />
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="GetStartBitPosition">
		<xsl:param name="dataItem" />
		<xsl:variable name="bitOffset">
			<xsl:call-template name="GetBitOffset">
				<xsl:with-param name="dataItem" select="." />
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="8 * ($dataItem/@FirstByte - 1) + $bitOffset + 1" />
	</xsl:template>

	<xsl:template name="GetStopBitPosition">
		<xsl:param name="dataItem" />
		<xsl:variable name="startBitPosition">
			<xsl:call-template name="GetStartBitPosition">
				<xsl:with-param name="dataItem" select="." />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="dataBitLength">
			<xsl:call-template name="GetDataBitLength">
				<xsl:with-param name="data" select="key('allDatas',@Name)" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:value-of select="$startBitPosition + $dataBitLength - 1" />
	</xsl:template>

  <xsl:template name="GetDataFormat">
    <xsl:param name="data" />
    <xsl:choose>
      <xsl:when test="$data/ddt:Bits/ddt:List">
        <xsl:text>NumericList</xsl:text>
      </xsl:when>
      <xsl:when test="$data/ddt:Bits/ddt:Scaled">
        <xsl:text>Numeric</xsl:text>
      </xsl:when>
      <xsl:when test="$data/ddt:Bytes/@ascii='1'">
        <xsl:text>ASCII</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>ByteField</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="GetDataItemFormat">
    <xsl:param name="dataItem" />
    <xsl:call-template name="GetDataFormat">
      <xsl:with-param name="data" select="key('allDatas',@Name)" />
    </xsl:call-template>
  </xsl:template>

	<!-- ****************  -->
	<!-- Template Message  -->
	<!-- ****************  -->
	<xsl:template name="message">
		<xsl:param name="description" />
		<xsl:param name="info" />
		<xsl:param name="action" />

		<message>
			<name><xsl:copy-of select="$description" /></name>
			<info><xsl:copy-of select="$info" /></info>
			<xsl:if test="$action != ''">
				<action  xml:lang="fr"><xsl:copy-of select="$action" /></action>
			</xsl:if>
		</message>
	</xsl:template>

	<!-- ****************  -->
	<!-- Template Warning  -->
	<!-- ****************  -->
	<xsl:template name="warning">
		<xsl:param name="type" />
		<xsl:param name="chapter" />
		<xsl:param name="description" />
		<xsl:param name="info" />
		<xsl:param name="action" />

		<warning>
			<xsl:if test="$type!= ''">
				<xsl:attribute name="type"><xsl:value-of select="$type" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$chapter!= ''">
				<xsl:attribute name="chapter"><xsl:value-of select="$chapter" /></xsl:attribute>
			</xsl:if>
			<name><xsl:copy-of select="$description" /></name>
			<info><xsl:copy-of select="$info" /></info>
			<action><xsl:copy-of select="$action" /></action>
		</warning>
	</xsl:template>

	<!-- **************  -->
	<!-- Template Error  -->
	<!-- **************  -->
	<xsl:template name="error">
		<xsl:param name="type" />
		<xsl:param name="chapter" />
		<xsl:param name="description" />
		<xsl:param name="info" />
		<xsl:param name="action" />

		<error>
			<xsl:if test="$type!= ''">
				<xsl:attribute name="type"><xsl:value-of select="$type" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$chapter!= ''">
				<xsl:attribute name="chapter"><xsl:value-of select="$chapter" /></xsl:attribute>
			</xsl:if>
			<name><xsl:copy-of select="$description" /></name>
			<info><xsl:copy-of select="$info" /></info>
			<action><xsl:copy-of select="$action" /></action>
		</error>
	</xsl:template>

	<!-- *********************** -->
	<!-- Template multi language -->
	<!-- *********************** -->
	<xsl:template name="getLocalizedText">
		<xsl:param name="lang" />
		<xsl:param name="aNode" />
		<xsl:param name="defaultText" />

		<xsl:choose>
			<xsl:when test="$aNode[@xml:lang=$lang]">
				<xsl:copy-of select="$aNode[@xml:lang=$lang]"></xsl:copy-of>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$aNode[not(@xml:lang)]">
						<xsl:copy-of select="$aNode[not(@xml:lang)]"></xsl:copy-of>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$defaultText"></xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

  <xsl:template name="Counter">
    <xsl:param name="Value"/>
    <xsl:value-of select="$Value"/>
  </xsl:template>


</xsl:stylesheet>