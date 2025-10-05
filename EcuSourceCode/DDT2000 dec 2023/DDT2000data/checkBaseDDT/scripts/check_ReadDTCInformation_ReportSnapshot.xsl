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


<!-- ******* -->
<!-- Include -->
<!-- ******* -->
<!--<xsl:include href="check_DataItem.xsl" />-->


<!-- ***************************************************************** -->
<!-- On cherche la requête nommée : ReadDTCInformation.ReportSnapshot  -->
<!-- car c'est sous ce nom que la page failure traite les snapshots    -->
<!-- ***************************************************************** -->
  <xsl:template name="ReadDTCInformation_ReportSnapshot">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportSnapshot.xsl: template ReadDTCInformation_ReportSnapshot starts')"/></logmsg>

    <xsl:choose>
      <xsl:when test= "ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportSnapshot']">
        <xsl:apply-templates select="ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportSnapshot']" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test= "ddt:Requests/ddt:Request/ddt:Sent/ddt:SentBytes = '1904000000FF'">
            <xsl:for-each select="ddt:Requests/ddt:Request/ddt:Sent/ddt:SentBytes[.='1904000000FF']">
              <xsl:variable name="mSentBytes" select="../ddt:SentBytes"></xsl:variable>
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DDT2000</xsl:with-param>
                  <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> :
                    <b><xsl:value-of select="../../@Name"></xsl:value-of></b>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b><xsl:value-of select="$mSentBytes"></xsl:value-of></b><br/>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidNameRequest"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template><br/>
                    <b>ReadDTCInformation.ReportSnapshot</b>
                  </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="warning">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_WAR_ReadDTCInformationReportSnapshot</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>ReadDTCInformation.ReportSnapshot</b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/noSupportSnapshot"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">?</xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportSnapshot.xsl: template ReadDTCInformation_ReportSnapshot ends')"/></logmsg>
  </xsl:template>


<!-- ************************************************** -->
<!-- Check the request ReadDTCInformation.ReportSnapshot-->
<!-- ************************************************** -->
<xsl:template match="ddt:Request[@Name = 'ReadDTCInformation.ReportSnapshot']">
	<xsl:choose>
		<xsl:when test="ddt:Sent/ddt:SentBytes != '1904000000FF'">

			<xsl:call-template name="error">
				<xsl:with-param name="type">DDT2000</xsl:with-param>
				<xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportSnapshot</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b>ReadDTCInformation.ReportSnapshot</b>
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><xsl:value-of select="ddt:Sent/ddt:SentBytes" /></b><br/>
					<b>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
					</b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b>1904000000FF</b>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>

	<xsl:choose>
		<xsl:when test="ddt:Received[@MinBytes != '6']" >
			<xsl:call-template name="error">
				<xsl:with-param name="type">DDT2000</xsl:with-param>
				<xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportSnapshot</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b>ReadDTCInformation.ReportSnapshot</b>
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="ddt:Received/@MinBytes" /></b><br/>
					    <b>
					    <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
						</b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b>6</b>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>

	<xsl:choose>
		<xsl:when test="ddt:Received/ddt:ShiftBytesCount">
			<xsl:call-template name="error">
				<xsl:with-param name="type">DDT2000</xsl:with-param>
				<xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportSnapshot</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b>ReadDTCInformation.ReportSnapshot</b>
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoShiftByteCount" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> = <b><xsl:value-of select="ddt:Received/ddt:ShiftBytesCount" /></b><br/>
					    <b><xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template></b><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoPageFailure" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
					Shift Bytes Count = <b>0</b>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>

<!-- ********************************************************************** -->
<!-- Controler chaque data  de la requête ReadDTCInformation.ReportSnapshot -->
<!-- ********************************************************************** -->

	<!-- ****************** -->
	<!-- Donnée en émission -->
	<!-- ****************** -->
  <!-- Error DE124 : DDT2000_ERR_1904_DTCMaskRecord -->
	<xsl:call-template name="checkDataItemNoNumeric">
		<xsl:with-param name="type">DDT2000</xsl:with-param>
		<xsl:with-param name="chapter">DDT2000_ERR_1904_DTCMaskRecord</xsl:with-param>
		<xsl:with-param name="reqName">ReadDTCInformation.ReportSnapshot</xsl:with-param>
		<xsl:with-param name="dataName">DTCMaskRecord</xsl:with-param>
		<xsl:with-param name="msgMissing">No Numeric 3 bytes BCD/HEXA</xsl:with-param>
		<xsl:with-param name="startByte">3</xsl:with-param>
		<xsl:with-param name="offsetBit">0</xsl:with-param>
		<xsl:with-param name="numberBytes">3</xsl:with-param>
		<xsl:with-param name="ascii">0</xsl:with-param>
	</xsl:call-template>

	<!-- ******************** -->
	<!-- Données en réception -->
	<!-- ******************** -->
  <!-- Error DE125 : DDT2000_ERR_1904_DTCRecord -->
	<xsl:call-template name="checkDataItemNoNumeric">
		<xsl:with-param name="type">DDT2000</xsl:with-param>
		<xsl:with-param name="chapter">DDT2000_ERR_1904_DTCRecord</xsl:with-param>
		<xsl:with-param name="reqName">ReadDTCInformation.ReportSnapshot</xsl:with-param>
		<xsl:with-param name="dataName">DTCRecord</xsl:with-param>
		<xsl:with-param name="msgMissing">No Numeric 3 bytes BCD/HEXA</xsl:with-param>
		<xsl:with-param name="startByte">3</xsl:with-param>
		<xsl:with-param name="offsetBit">0</xsl:with-param>
		<xsl:with-param name="numberBytes">3</xsl:with-param>
		<xsl:with-param name="ascii">0</xsl:with-param>
	</xsl:call-template>

  <!-- Error DE126 : DDT2000_ERR_1904_StatusOfDTC -->
	<xsl:call-template name="checkDataItemNumeric">
		<xsl:with-param name="type">DDT2000</xsl:with-param>
		<xsl:with-param name="chapter">DDT2000_ERR_1904_StatusOfDTC</xsl:with-param>
		<xsl:with-param name="reqName">ReadDTCInformation.ReportSnapshot</xsl:with-param>
		<xsl:with-param name="dataName">StatusOfDTC</xsl:with-param>
		<xsl:with-param name="msgMissing">Numeric 8 bits unsigned</xsl:with-param>
		<xsl:with-param name="startByte">6</xsl:with-param>
		<xsl:with-param name="offsetBit">0</xsl:with-param>
		<xsl:with-param name="numbersBits">8</xsl:with-param>
		<xsl:with-param name="signed">0</xsl:with-param>
	</xsl:call-template>

</xsl:template>


</xsl:stylesheet>
