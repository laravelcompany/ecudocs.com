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


<!-- *******************************************************************************************************************
*******************************************************************************************************************
			Check request
				@Name	length
						invalid char
				<SentBytes>	pair
							DDT2000 limits
							CPDD limits
				<MinBytes>	DDT2000 limits
							CPDD limits
				<ReplyBytes>	DDT2000 limits
							CPDD limits
*******************************************************************************************************************
******************************************************************************************************************* -->
	<xsl:template name="Request">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Request.xsl: template Request starts')"/></logmsg>

		<!-- *********************************************************************************
		Existence de la requête ClearDiagnosticInformation.Manual
		Si la requête existe alors effacement des pannes impossible avec la page Failure
		********************************************************************************* -->
		<xsl:if test="ddt:Requests/ddt:Request[@Name = 'ClearDiagnosticInformation.Manual']">
			<xsl:call-template name="warning">
				<xsl:with-param name="type">DDT2000</xsl:with-param>
				<xsl:with-param name="chapter">DDT2000_WAR_ClearDiagnosticInformationManual</xsl:with-param>
				<xsl:with-param name="description">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b>ClearDiagnosticInformation.Manual</b><br/>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string(ddt:Requests/ddt:Request[@Name = 'ClearDiagnosticInformation.Manual']/ddt:Sent/ddt:SentBytes),32)" /></pre><br/>
				</xsl:with-param>
				<xsl:with-param name="info">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/info2PageFailure"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="action">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!-- *********************************************************************************
		Existence des requêtes $21AD et $22FDC5 qui engendrent
		un risque d'erreur lors de la lecture des codes injecteur (IMA)
		********************************************************************************* -->
		<xsl:if test="ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '21AD'] and ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22FDC5']">
			<xsl:call-template name="warning">
				<xsl:with-param name="type">DDT2000</xsl:with-param>
				<xsl:with-param name="chapter">DDT2000_WAR_InjectorCode</xsl:with-param>
				<xsl:with-param name="description">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b>$21AD</b> / <b>$22FDC5</b>
				</xsl:with-param>
				<xsl:with-param name="info">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInjectorCode"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="action">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionInjectorCode"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:for-each select="ddt:Requests/ddt:Request">
			<!-- ***************************
			Déclarations des variables
			*************************** -->
			<xsl:variable name="mRequestName" select="@Name"></xsl:variable>
			<xsl:variable name="mRequestNameNormalize" select="local:NormalizeName(string($mRequestName))"></xsl:variable>

      <xsl:variable name="mIsMaintainabilityReport">
        <xsl:choose>
          <xsl:when test="ddt:DossierMaintenabilite">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

			<xsl:variable name="mRequestSentBytes" select="ddt:Sent/ddt:SentBytes"></xsl:variable>
			<xsl:variable name="mSend0" select="substring($mRequestSentBytes,1,2)"></xsl:variable>
			<xsl:variable name="mSend1" select="substring($mRequestSentBytes,3,2)"></xsl:variable>
			<xsl:variable name="mSend2" select="substring($mRequestSentBytes,5,2)"></xsl:variable>

			<xsl:variable name="mRequestReceivedMinBytes" select="ddt:Received/@MinBytes"></xsl:variable>
			<xsl:variable name="mRequestReplyBytes" select="ddt:Received/ddt:ReplyBytes"></xsl:variable>
			<xsl:variable name="mReply0" select="substring($mRequestReplyBytes,1,2)"></xsl:variable>
			<xsl:variable name="mReply1" select="substring($mRequestReplyBytes,3,2)"></xsl:variable>
			<xsl:variable name="mReply2" select="substring($mRequestReplyBytes,5,2)"></xsl:variable>

			<xsl:variable name="mCheckInvalidCharRequestDataName" select="local:CheckInvalidCharRequestDataName(string($mRequestName))"></xsl:variable>
			<xsl:variable name="mMinRequestSentBytes">1</xsl:variable><!-- 1 octet-->
			<xsl:variable name="mMaxRequestSentBytesDDT2000">
				<xsl:choose>
					<!-- Attention ce sont des octets -->
					<xsl:when test="substring($mRequestSentBytes,1,2) = '21'">2</xsl:when>
					<xsl:when test="//ddt:Target/ddt:K">255</xsl:when><!-- 255 octets -->
					<xsl:when test="//ddt:Target/ddt:CAN">4095</xsl:when><!-- 4095 octets-->
          <xsl:when test="//ddt:Target/ddt:IP">4095</xsl:when><!-- 4095 octets-->
					<xsl:otherwise>255</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="mMinMinBytes">1</xsl:variable><!-- 1 -->
			<xsl:variable name="mMaxMinBytesDDT2000">
				<xsl:choose>
					<!-- Attention ce sont des octets -->
					<xsl:when test="//ddt:Target/ddt:K">255</xsl:when><!-- 255 octets -->
					<xsl:when test="//ddt:Target/ddt:CAN">4095</xsl:when><!-- 4095 octets-->
					<xsl:when test="//ddt:Target/ddt:IP">4095</xsl:when><!-- 4095 octets-->
					<xsl:otherwise>255</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:choose>
				<!-- Check empty SID -->
				<xsl:when test="string-length($mRequestSentBytes) = 0">
          <!-- ****************************************** -->
          <!-- Error AE001 : ALLIANCE_ERR_RequestErrorSID -->
          <!-- ****************************************** -->
					<xsl:call-template name="error">
						<xsl:with-param name="type">ALLIANCE</xsl:with-param>
						<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorSID</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b><xsl:value-of select="$mRequestName" /></b>
						</xsl:with-param>
						<xsl:with-param name="info">
							Template
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofRequest"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							:
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>

          <!-- ***************************************** -->
          <!-- Error ME018 : DAIMLER_ERR_RequestErrorSID -->
          <!-- ***************************************** -->
          <xsl:if test="ddt:DossierMaintenabilite">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DAIMLER</xsl:with-param>
              <xsl:with-param name="chapter">DAIMLER_ERR_RequestErrorSID</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b><xsl:value-of select="$mRequestName" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                Template
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                :
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:when>

				<!-- Check allowed SID for KWP2000 -->
				<xsl:when test="$mSpecification = 'KWP2000'
						and not($mSend0 = '01')
						and not($mSend0 = '02')
						and not($mSend0 = '03')
						and not($mSend0 = '04')
						and not($mSend0 = '05')
						and not($mSend0 = '06')
						and not($mSend0 = '07')
						and not($mSend0 = '08')
						and not($mSend0 = '09')
						and not($mSend0 = '0A')
						and not($mSend0 = '10')
						and not($mSend0 = '11')
						and not($mSend0 = '12')
						and not($mSend0 = '14')
						and not($mSend0 = '17')
						and not($mSend0 = '21')
						and not($mSend0 = '23')
						and not($mSend0 = '27')
						and not($mSend0 = '2C')
						and not($mSend0 = '30')
						and not($mSend0 = '31')
						and not($mSend0 = '32')
						and not($mSend0 = '34')
						and not($mSend0 = '35')
						and not($mSend0 = '3B')
						and not($mSend0 = '3D')
						and not($mSend0 = '3E')
						and not($mSend0 = '81')
						and not($mSend0 = '82')">
          <!-- ****************************************** -->
          <!-- Error AE001 : ALLIANCE_ERR_RequestErrorSID -->
          <!-- ****************************************** -->
					<xsl:call-template name="error">
						<xsl:with-param name="type">ALLIANCE</xsl:with-param>
						<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorSID</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b><xsl:value-of select="$mRequestName" /></b>
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotAllowedForProtocol"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b>$<xsl:value-of select="$mSend0" /></b>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAllianceSentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>

          <!-- ***************************************** -->
          <!-- Error ME018 : DAIMLER_ERR_RequestErrorSID -->
          <!-- ***************************************** -->
          <xsl:if test="ddt:DossierMaintenabilite">
            <xsl:call-template name="error">
              <xsl:with-param name="type">ALLIANCE</xsl:with-param>
              <xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorSID</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b><xsl:value-of select="$mRequestName" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotAllowedForProtocol"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b>$<xsl:value-of select="$mSend0" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAllianceSentBytes"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:when>

				<!-- Check allowed SID for SPEC A -->
				<xsl:when test="$mSpecification = 'DiagOnCan'
						and not($mSend0 = '01')
						and not($mSend0 = '02')
						and not($mSend0 = '03')
						and not($mSend0 = '04')
						and not($mSend0 = '05')
						and not($mSend0 = '06')
						and not($mSend0 = '07')
						and not($mSend0 = '08')
						and not($mSend0 = '09')
						and not($mSend0 = '0A')
						and not($mSend0 = '10')
						and not($mSend0 = '11')
						and not($mSend0 = '12')
						and not($mSend0 = '14')
						and not($mSend0 = '17')
						and not($mSend0 = '21')
						and not($mSend0 = '22')
						and not($mSend0 = '23')
						and not($mSend0 = '27')
						and not($mSend0 = '28')
						and not($mSend0 = '29')
						and not($mSend0 = '2C')
						and not($mSend0 = '30')
						and not($mSend0 = '31')
						and not($mSend0 = '32')
						and not($mSend0 = '34')
						and not($mSend0 = '35')
						and not($mSend0 = '3B')
						and not($mSend0 = '3D')
						and not($mSend0 = '3E')
						and not($mSend0 = '85')">
          <!-- ****************************************** -->
          <!-- Error AE001 : ALLIANCE_ERR_RequestErrorSID -->
          <!-- ****************************************** -->
					<xsl:call-template name="error">
						<xsl:with-param name="type">ALLIANCE</xsl:with-param>
						<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorSID</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b><xsl:value-of select="$mRequestName" /></b>
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotAllowedForProtocol"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b>$<xsl:value-of select="$mSend0" /></b>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAllianceSentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>

          <!-- ***************************************** -->
          <!-- Error ME018 : DAIMLER_ERR_RequestErrorSID -->
          <!-- ***************************************** -->
          <xsl:if test="ddt:DossierMaintenabilite">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DAIMLER</xsl:with-param>
              <xsl:with-param name="chapter">DAIMLER_ERR_RequestErrorSID</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b><xsl:value-of select="$mRequestName" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotAllowedForProtocol"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b>$<xsl:value-of select="$mSend0" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAllianceSentBytes"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:when>

				<!-- Check allowed SID for SPEC B/C -->
				<xsl:when test="$mSpecification = 'Spec B/C'
						and not($mSend0 = '01')
						and not($mSend0 = '02')
						and not($mSend0 = '03')
						and not($mSend0 = '04')
						and not($mSend0 = '05')
						and not($mSend0 = '06')
						and not($mSend0 = '07')
						and not($mSend0 = '08')
						and not($mSend0 = '09')
						and not($mSend0 = '0A')
						and not($mSend0 = '10')
						and not($mSend0 = '11')
						and not($mSend0 = '14')
						and not($mSend0 = '19')
						and not($mSend0 = '21')
						and not($mSend0 = '22')
						and not($mSend0 = '23')
						and not($mSend0 = '24')
						and not($mSend0 = '27')
						and not($mSend0 = '28')
						and not($mSend0 = '2C')
						and not($mSend0 = '2E')
						and not($mSend0 = '30')
						and not($mSend0 = '31')
						and not($mSend0 = '32')
						and not($mSend0 = '34')
						and not($mSend0 = '35')
						and not($mSend0 = '36')
						and not($mSend0 = '37')
						and not($mSend0 = '3B')
						and not($mSend0 = '3D')
						and not($mSend0 = '3E')">
          <!-- ****************************************** -->
          <!-- Error AE001 : ALLIANCE_ERR_RequestErrorSID -->
          <!-- ****************************************** -->
					<xsl:call-template name="error">
						<xsl:with-param name="type">ALLIANCE</xsl:with-param>
						<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorSID</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b><xsl:value-of select="$mRequestName" /></b>
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotAllowedForProtocol"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b>$<xsl:value-of select="$mSend0" /></b>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAllianceSentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>

          <!-- ***************************************** -->
          <!-- Error ME018 : DAIMLER_ERR_RequestErrorSID -->
          <!-- ***************************************** -->
          <xsl:if test="ddt:DossierMaintenabilite">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DAIMLER</xsl:with-param>
              <xsl:with-param name="chapter">DAIMLER_ERR_RequestErrorSID</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b><xsl:value-of select="$mRequestName" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotAllowedForProtocol"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b>$<xsl:value-of select="$mSend0" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAllianceSentBytes"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:when>

				<!-- Check allowed SID for SPEC UDS -->
				<xsl:when test="$mSpecification = 'UDS'
						and not($mSend0 = '01')
						and not($mSend0 = '02')
						and not($mSend0 = '03')
						and not($mSend0 = '04')
						and not($mSend0 = '05')
						and not($mSend0 = '06')
						and not($mSend0 = '07')
						and not($mSend0 = '08')
						and not($mSend0 = '09')
						and not($mSend0 = '0A')
						and not($mSend0 = '10')
						and not($mSend0 = '11')
						and not($mSend0 = '14')
						and not($mSend0 = '19')
						and not($mSend0 = '22')
						and not($mSend0 = '23')
						and not($mSend0 = '27')
						and not($mSend0 = '28')
						and not($mSend0 = '2C')
						and not($mSend0 = '2E')
						and not($mSend0 = '2F')
						and not($mSend0 = '31')
						and not($mSend0 = '34')
						and not($mSend0 = '35')
						and not($mSend0 = '36')
						and not($mSend0 = '37')
						and not($mSend0 = '3D')
						and not($mSend0 = '3E')">
          <!-- ****************************************** -->
          <!-- Error AE001 : ALLIANCE_ERR_RequestErrorSID -->
          <!-- ****************************************** -->
					<xsl:call-template name="error">
						<xsl:with-param name="type">ALLIANCE</xsl:with-param>
						<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorSID</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b><xsl:value-of select="$mRequestName" /></b>
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotAllowedForProtocol"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b>$<xsl:value-of select="$mSend0" /></b>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAllianceSentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>

          <!-- ***************************************** -->
          <!-- Error ME018 : DAIMLER_ERR_RequestErrorSID -->
          <!-- ***************************************** -->
          <xsl:if test="ddt:DossierMaintenabilite">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DAIMLER</xsl:with-param>
              <xsl:with-param name="chapter">DAIMLER_ERR_RequestErrorSID</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b><xsl:value-of select="$mRequestName" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotAllowedForProtocol"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b>$<xsl:value-of select="$mSend0" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAllianceSentBytes"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
				</xsl:when>
			</xsl:choose>

			<!-- ******************************************* -->
			<!-- Error AE002 : ALLIANCE_ERR_ResponseErrorSID -->
			<!-- ******************************************* -->
			<xsl:if test="string-length($mRequestSentBytes) &gt; 0">
				<xsl:choose>
					<xsl:when test="string-length($mRequestReplyBytes) = 0">
						<xsl:call-template name="error">
							<xsl:with-param name="type">ALLIANCE</xsl:with-param>
							<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorSID</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								Template
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								:
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="mExpectedResponseSID" select="local:ToHex(local:ToDec($mSend0)+64,2)" />
						<xsl:if test="$mReply0 != $mExpectedResponseSID">
							<xsl:call-template name="error">
								<xsl:with-param name="type">ALLIANCE</xsl:with-param>
								<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorSID</xsl:with-param>
								<xsl:with-param name="description">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><xsl:value-of select="$mRequestName" /></b>
								</xsl:with-param>
								<xsl:with-param name="info">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									:<br/>
									<b>
										<xsl:call-template name="getLocalizedText">
											<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
											<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
											<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
										</xsl:call-template>
									</b> $<b><xsl:value-of select="$mReply0" /></b>
								</xsl:with-param>
								<xsl:with-param name="action">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									<br/>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: $<b><xsl:value-of select="$mExpectedResponseSID" /></b>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:otherwise>
				</xsl:choose>
			</xsl:if>

			<!-- ******************************* -->
			<!--  VERIFICATION DES REQUETES DID  -->
			<!-- ******************************* -->
			<!--  AE003 AE004 AE007 AE008 AE011  -->
			<xsl:if test="$mSend0 = '22' or $mSend0 = '2E' or $mSend0 = '2F'">
				<xsl:choose>
					<!-- ****************************************** -->
					<!-- Error AE003 : ALLIANCE_ERR_RequestErrorDID -->
					<!-- ****************************************** -->
					<!-- if there is less than 6 characters (3 bytes) in SentBytes template, DID value is missing -->
					<xsl:when test="string-length($mRequestSentBytes) &lt; 6">
						<xsl:call-template name="error">
							<xsl:with-param name="type">ALLIANCE</xsl:with-param>
							<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorDID</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofRequest"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								:
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<!-- ******************************************* -->
					<!-- Error AE004 : ALLIANCE_ERR_ResponseErrorDID -->
					<!-- ******************************************* -->
					<!-- if there is less than 6 characters (3 bytes) in ReplyBytes template, DID value is missing -->
					<xsl:when test="string-length($mRequestReplyBytes) &lt; 6">
						<xsl:call-template name="error">
							<xsl:with-param name="type">ALLIANCE</xsl:with-param>
							<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorDID</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								:
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
								<xsl:with-param name="action">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
								</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<!-- check if the DID value of response is the same as request -->
					<xsl:when test="($mSend1 != $mReply1) and ($mSend2 != $mReply2)">
						<xsl:call-template name="error">
							<xsl:with-param name="type">ALLIANCE</xsl:with-param>
							<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorDID</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								:<br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: $<b><xsl:value-of select="$mReply1" /><xsl:value-of select="$mReply2" /></b>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: $<b><xsl:value-of select="$mSend1" /><xsl:value-of select="$mSend2" /></b>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<xsl:otherwise>
						<!-- Test request (Sent) -->
						<xsl:for-each select="ddt:Sent/ddt:DataItem">
							<xsl:variable name="mDataBitLength">
								<xsl:call-template name="GetDataBitLength">
									<xsl:with-param name="data" select="key('allDatas',@Name)" />
								</xsl:call-template>
							</xsl:variable>

							<xsl:variable name="mBitOffset">
								<xsl:call-template name="GetBitOffset">
									<xsl:with-param name="dataItem" select="." />
								</xsl:call-template>
							</xsl:variable>

							<!-- ************************************************** -->
							<!-- Error AE007 : ALLIANCE_ERR_RequestErrorDataItemDID -->
							<!-- ************************************************** -->
							<xsl:choose>
								<xsl:when test="@FirstByte = 2">
									<xsl:if test="($mBitOffset != 0) or (($mDataBitLength != 8) and ($mDataBitLength != 16))">
										<xsl:call-template name="error">
											<xsl:with-param name="type">ALLIANCE</xsl:with-param>
											<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorDataItemDID</xsl:with-param>
											<xsl:with-param name="description">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												: <b><xsl:value-of select="$mRequestName" /></b>
											</xsl:with-param>
											<xsl:with-param name="info">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												: <b><xsl:value-of select="@Name" /></b><br/>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidDataSizePos" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param name="action">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												 /
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template><br/>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> :<br/>
												+ Bit Offset : <b>0</b><br/>
												+
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/firstByte"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = 2 ==>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = <b>8</b> / <b>16</b> bits<br/>
												+
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/firstByte"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = 3 ==>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = <b>8</b> bits
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:when>
								<xsl:when test="@FirstByte = 3">
									<xsl:if test="($mBitOffset != 0) or ($mDataBitLength != 8)">
										<xsl:call-template name="error">
											<xsl:with-param name="type">ALLIANCE</xsl:with-param>
											<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorDataItemDID</xsl:with-param>
											<xsl:with-param name="description">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												: <b><xsl:value-of select="$mRequestName" /></b>
											</xsl:with-param>
											<xsl:with-param name="info">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												: <b><xsl:value-of select="@Name" /></b><br/>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidDataSizePos" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param name="action">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												 /
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template><br/>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> :<br/>
												+ Bit Offset : <b>0</b><br/>
												+
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/firstByte"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = 2 ==>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = <b>8</b> / <b>16</b> bits<br/>
												+
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/firstByte"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = 3 ==>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = <b>8</b> bits
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:when>
							</xsl:choose>
              
              <!-- Check ByteBoundary and overlap on sending DataItem only for $2E or $2F services -->
              <xsl:if test="$mSend0 = '2E' or $mSend0 = '2F'">
                <!-- *************************************** -->
                <!-- Error ME022 : DAIMLER_ERR_ByteBoundary  -->
                <!-- Error AE017 : ALLIANCE_ERR_ByteBoundary -->
                <!-- *************************************** -->
                <xsl:call-template name="ByteBoundary">
                  <xsl:with-param name="dataItem" select="."/>
                </xsl:call-template>
              
                <!-- ***************************************** -->
                <!-- Error ME023 : DAIMLER_ERR_RequestOverlap  -->
                <!-- Error AE011 : ALLIANCE_ERR_RequestOverlap -->
                <!-- ***************************************** -->
                <!-- Check overlap, except for generic outputcontrol because it has overlap dataItem -->
                <xsl:if test="('outputcontrol' != local:LowerSpaceRemove(string($mRequestName)))
                              and ('outputcontrol.start' != local:LowerSpaceRemove(string($mRequestName)))
                              and ('outputcontrol.stop' != local:LowerSpaceRemove(string($mRequestName)))">
                  <xsl:call-template name="Overlap_Request">
                    <xsl:with-param name="serviceName" select="$mRequestName" />
                    <xsl:with-param name="isMaintainabilityReport" select="$mIsMaintainabilityReport"/>
                    <xsl:with-param name="currentFrame" select=".." />
                    <xsl:with-param name="currentDataItem" select="." />
                  </xsl:call-template>
                </xsl:if>
              </xsl:if>
						</xsl:for-each>

						<!-- Test response (Received) -->
						<xsl:for-each select="ddt:Received/ddt:DataItem">
							<xsl:variable name="mDataBitLength">
								<xsl:call-template name="GetDataBitLength">
									<xsl:with-param name="data" select="key('allDatas',@Name)" />
								</xsl:call-template>
							</xsl:variable>

							<xsl:variable name="mBitOffset">
								<xsl:call-template name="GetBitOffset">
									<xsl:with-param name="dataItem" select="." />
								</xsl:call-template>
							</xsl:variable>

							<!-- *************************************************** -->
							<!-- Error AE008 : ALLIANCE_ERR_ResponseErrorDataItemDID -->
							<!-- *************************************************** -->
							<xsl:choose>
								<xsl:when test="@FirstByte = 2">
									<xsl:if test="($mBitOffset != 0) or (($mDataBitLength != 8) and ($mDataBitLength != 16))">
										<xsl:call-template name="error">
											<xsl:with-param name="type">ALLIANCE</xsl:with-param>
											<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorDataItemDID</xsl:with-param>
											<xsl:with-param name="description">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												: <b><xsl:value-of select="$mRequestName" /></b>
											</xsl:with-param>
											<xsl:with-param name="info">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												: <b><xsl:value-of select="@Name" /></b><br/>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidDataSizePos" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param name="action">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												 /
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template><br/>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> :<br/>
												+ Bit Offset : <b>0</b><br/>
												+
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/firstByte"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = 2 ==>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = <b>8</b> / <b>16</b> bits<br/>
												+
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/firstByte"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = 3 ==>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = <b>8</b> bits
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:when>
								<xsl:when test="@FirstByte = 3">
									<xsl:if test="($mBitOffset != 0) or ($mDataBitLength != 8)">
										<xsl:call-template name="error">
											<xsl:with-param name="type">ALLIANCE</xsl:with-param>
											<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorDataItemDID</xsl:with-param>
											<xsl:with-param name="description">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												: <b><xsl:value-of select="$mRequestName" /></b>
											</xsl:with-param>
											<xsl:with-param name="info">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												: <b><xsl:value-of select="@Name" /></b><br/>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidDataSizePos" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param name="action">
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template>
												 /
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template><br/>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> :<br/>
												+ Bit Offset : <b>0</b><br/>
												+
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/firstByte"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = 2 ==>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = <b>8</b> / <b>16</b> bits<br/>
												+
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/firstByte"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = 3 ==>
												<xsl:call-template name="getLocalizedText">
													<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
													<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
													<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
												</xsl:call-template> = <b>8</b> bits
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:when>
							</xsl:choose>
              
              <!-- ***************************************** -->
              <!-- Error ME024 : DAIMLER_ERR_ResponseOverlap -->
              <!-- ***************************************** -->
              <!-- Check overlap on received DataItem only for $22 service -->
              <xsl:if test="$mSend0 = '22'">
                <xsl:call-template name="Overlap_Response">
                  <xsl:with-param name="serviceName" select="$mRequestName" />
                  <xsl:with-param name="isMaintainabilityReport" select="$mIsMaintainabilityReport"/>
                  <xsl:with-param name="currentFrame" select=".." />
                  <xsl:with-param name="currentDataItem" select="." />
                </xsl:call-template>
              </xsl:if>
            </xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>

			<!-- ******************************* -->
			<!--  VERIFICATION DES REQUETES LID  -->
			<!-- ******************************* -->
			<!--  AE005 AE006 AE009 AE010 AE011  -->
			<xsl:if test="$mSend0 = '21' or $mSend0 = '3B' or $mSend0 = '30'">
				<xsl:choose>
					<!-- ****************************************** -->
					<!-- Error AE005 : ALLIANCE_ERR_RequestErrorLID -->
					<!-- ****************************************** -->
					<!-- if there is less than 4 characters (2 bytes) in SentBytes template, LID value is missing -->
					<xsl:when test="string-length($mRequestSentBytes) &lt; 4">
						<xsl:call-template name="error">
							<xsl:with-param name="type">ALLIANCE</xsl:with-param>
							<xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorLID</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofRequest"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								:
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
								<xsl:with-param name="action">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
								</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<!-- ******************************************* -->
					<!-- Error AE006 : ALLIANCE_ERR_ResponseErrorLID -->
					<!-- ******************************************* -->
					<!-- if there is less than 4 characters (2 bytes) in ReplyBytes template, LID value is missing -->
					<xsl:when test="string-length($mRequestReplyBytes) &lt; 4">
						<xsl:call-template name="error">
							<xsl:with-param name="type">ALLIANCE</xsl:with-param>
							<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorLID</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								:
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
								<xsl:with-param name="action">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
								</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<!-- check if the LID value of response is the same as request -->
					<xsl:when test="($mSend1 != $mReply1)">
						<xsl:call-template name="error">
							<xsl:with-param name="type">ALLIANCE</xsl:with-param>
							<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorLID</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								:<br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: $<b><xsl:value-of select="$mReply1" /></b>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								: $<b><xsl:value-of select="$mSend1" /></b>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>

					<xsl:otherwise>
						<!-- Test request (Sent) -->
						<xsl:for-each select="ddt:Sent/ddt:DataItem">
							<xsl:variable name="mDataBitLength">
								<xsl:call-template name="GetDataBitLength">
									<xsl:with-param name="data" select="key('allDatas',@Name)" />
								</xsl:call-template>
							</xsl:variable>

							<xsl:variable name="mBitOffset">
								<xsl:call-template name="GetBitOffset">
									<xsl:with-param name="dataItem" select="." />
								</xsl:call-template>
							</xsl:variable>

							<!-- ************************************************** -->
							<!-- Error AE009 : ALLIANCE_ERR_RequestErrorDataItemLID -->
							<!-- ************************************************** -->
							<xsl:choose>
                <xsl:when test="@FirstByte = 2">
                  <xsl:if test="($mBitOffset != 0) or ($mDataBitLength != 8)">
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">ALLIANCE</xsl:with-param>
                      <xsl:with-param name="chapter">ALLIANCE_ERR_RequestErrorDataItemLID</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        : <b><xsl:value-of select="$mRequestName" /></b>
                      </xsl:with-param>
                      <xsl:with-param name="info">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        : <b><xsl:value-of select="@Name" /></b><br/>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidDataSizePos" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                         /
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template><br/>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> :<br/>
                        + Bit Offset : <b>0</b><br/>
                        +
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> : <b>8</b> bits
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
              </xsl:choose>

              <!-- Check ByteBoundary and overlap on sending DataItem only for $3B or $30 services -->
              <xsl:if test="$mSend0 = '3B' or $mSend0 = '30'">
                <!-- *************************************** -->
                <!-- Error ME022 : DAIMLER_ERR_ByteBoundary  -->
                <!-- Error AE017 : ALLIANCE_ERR_ByteBoundary -->
                <!-- *************************************** -->
                <xsl:call-template name="ByteBoundary">
                  <xsl:with-param name="dataItem" select="."/>
                </xsl:call-template>

                <!-- ***************************************** -->
                <!-- Error ME023 : DAIMLER_ERR_RequestOverlap  -->
                <!-- Error AE011 : ALLIANCE_ERR_RequestOverlap -->
                <!-- ***************************************** -->
                <!-- Check overlap, except for generic outputcontrol because it has overlap dataItem -->
                <xsl:if test="('outputcontrol' != local:LowerSpaceRemove(string($mRequestName)))
                              and ('outputcontrol.start' != local:LowerSpaceRemove(string($mRequestName)))
                              and ('outputcontrol.status' != local:LowerSpaceRemove(string($mRequestName)))
                              and ('outputcontrol.stop' != local:LowerSpaceRemove(string($mRequestName)))">
                  <xsl:call-template name="Overlap_Request">
                    <xsl:with-param name="serviceName" select="$mRequestName" />
                    <xsl:with-param name="isMaintainabilityReport" select="$mIsMaintainabilityReport"/>
                    <xsl:with-param name="currentFrame" select=".." />
                    <xsl:with-param name="currentDataItem" select="." />
                  </xsl:call-template>
                </xsl:if>
              </xsl:if>
						</xsl:for-each>

						<!-- Test response (Received) -->
						<xsl:for-each select="ddt:Received/ddt:DataItem">
							<xsl:variable name="mDataBitLength">
								<xsl:call-template name="GetDataBitLength">
									<xsl:with-param name="data" select="key('allDatas',@Name)" />
								</xsl:call-template>
							</xsl:variable>

							<xsl:variable name="mBitOffset">
								<xsl:call-template name="GetBitOffset">
									<xsl:with-param name="dataItem" select="." />
								</xsl:call-template>
							</xsl:variable>

							<!-- *************************************************** -->
							<!-- Error AE010 : ALLIANCE_ERR_ResponseErrorDataItemLID -->
							<!-- *************************************************** -->
							<xsl:if test="@FirstByte = 2">
								<xsl:if test="($mBitOffset != 0) or ($mDataBitLength != 8)">
									<xsl:call-template name="error">
										<xsl:with-param name="type">ALLIANCE</xsl:with-param>
										<xsl:with-param name="chapter">ALLIANCE_ERR_ResponseErrorDataItemLID</xsl:with-param>
										<xsl:with-param name="description">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
											: <b><xsl:value-of select="$mRequestName" /></b>
										</xsl:with-param>
										<xsl:with-param name="info">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
											: <b><xsl:value-of select="@Name" /></b><br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidDataSizePos" />
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
										</xsl:with-param>
										<xsl:with-param name="action">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
											 /
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template><br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> :<br/>
											+ Bit Offset : <b>0</b><br/>
											+
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <b>8</b> bits
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
							</xsl:if>

              <!-- ***************************************** -->
              <!-- Error ME024 : DAIMLER_ERR_ResponseOverlap -->
              <!-- ***************************************** -->
              <!-- Check overlap on received DataItem only for $21 service -->
              <xsl:if test="$mSend0 = '21'">
                <xsl:call-template name="Overlap_Response">
                    <xsl:with-param name="serviceName" select="$mRequestName" />
                    <xsl:with-param name="isMaintainabilityReport" select="$mIsMaintainabilityReport"/>
                    <xsl:with-param name="currentFrame" select=".." />
                    <xsl:with-param name="currentDataItem" select="." />
                </xsl:call-template>
              </xsl:if>              
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>

			<!-- ******************************************************************************** -->
			<!--  VERIFICATION DE LA TAILLE DU TEMPLATE DE REPONSE VS NOMBRE OCTET POUR $3B, $2E  -->
			<!-- ******************************************************************************** -->
			<xsl:if test="($mSend0 = '2E') or ($mSend0 = '3B')">
				<xsl:variable name="mTemplateByteLength" select ="(string-length(ddt:Received/ddt:ReplyBytes)) div 2" />
				<xsl:variable name="mMinByteLength" select="ddt:Received/@MinBytes" />

				<!-- On vérifie que la taille du template est au moins égal au nombre d'octet attendu (ddt:Request/ddt:Received/@MinBytes) -->
				<xsl:if test="$mTemplateByteLength &lt; $mMinByteLength">
					<xsl:choose>
						<!-- Si le service est DossierMaintenabilite et APV, erreur, sinon warning -->
						<xsl:when test="(ddt:DossierMaintenabilite and not(ddt:DenyAccess/ddt:AfterSales))">
							<!-- ************************************ -->
							<!-- Error CE151 : CPDD_ERR_ReplyMinBytes -->
							<!-- ************************************ -->
							<xsl:call-template name="error">
								<xsl:with-param name="type">CPDD</xsl:with-param>
								<xsl:with-param name="chapter">CPDD_ERR_ReplyMinBytes</xsl:with-param>
								<xsl:with-param name="description">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><xsl:value-of select="$mRequestName" /></b>
									<br/>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></b>
								</xsl:with-param>
								<xsl:with-param name="info">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMinBytes"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									<br/>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidLength"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									:<br/>
									Template :
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><xsl:value-of select="$mTemplateByteLength" /></b>
									<br/>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDdtMinBytes"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/expected"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><xsl:value-of select="$mMinByteLength" /></b>
								</xsl:with-param>
								<xsl:with-param name="action">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<!-- ************************************ -->
							<!-- Warning CW024 CPDD_WAR_ReplyMinBytes -->
							<!-- ************************************ -->
							<xsl:call-template name="warning">
								<xsl:with-param name="type">CPDD</xsl:with-param>
								<xsl:with-param name="chapter">CPDD_WAR_ReplyMinBytes</xsl:with-param>
								<xsl:with-param name="description">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><xsl:value-of select="$mRequestName" /></b>
									<br/>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></b>
								</xsl:with-param>
								<xsl:with-param name="info">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMinBytes"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									<br/>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidLength"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									:<br/>
									Template :
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><xsl:value-of select="$mTemplateByteLength" /></b>
									<br/>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDdtMinBytes"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/expected"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
									: <b><xsl:value-of select="$mMinByteLength" /></b>
								</xsl:with-param>
								<xsl:with-param name="action">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:if>


			<!-- ******************
			RequestName length
			****************** -->
			<!-- debug : la clé allRequestNameNormalized ne fonctionne pas ???
			<h99>*coz*mRequestName:<xsl:value-of select="$mRequestName"></xsl:value-of></h99>
			<h99>*coz*mRequestNameNormalize:<xsl:value-of select="$mRequestNameNormalize"></xsl:value-of></h99>
			<h99>*coz*mRequestNameNormalize2:<xsl:value-of select="local:NormalizeName(string($mRequestName))"></xsl:value-of></h99>
			<h99>============</h99>
			-->
			<xsl:if test="string-length($mRequestNameNormalize)&gt;255"><!--255 caractères-->
				<!-- ************************************** -->
				<!-- Warning AW003 ALLIANCE_WAR_RequestName -->
				<!-- ************************************** -->
				<xsl:call-template name="warning">
					<xsl:with-param name="type">ALLIANCE</xsl:with-param>
					<xsl:with-param name="chapter">ALLIANCE_WAR_RequestName</xsl:with-param>
					<xsl:with-param name="description">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <xsl:value-of select="string-length($mRequestName)" />
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="info">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNormalizedName"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestNameNormalize" /></b><br/>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="string-length($mRequestNameNormalize)" /></b>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="action">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAuthorizedLength"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b>255</b><br/>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- ********************************** -->
				<!-- Error CE030 : CPDD_ERR_RequestName -->
				<!-- ********************************** -->
				<xsl:if test="ddt:DossierMaintenabilite">
					<xsl:call-template name="error">
						<xsl:with-param name="type">CPDD</xsl:with-param>
						<xsl:with-param name="chapter">CPDD_ERR_RequestName</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <xsl:value-of select="string-length($mRequestName)" />
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNormalizedName"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestNameNormalize" /></b><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="string-length($mRequestNameNormalize)" /></b>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAuthorizedLength"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b>255</b><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>

			<!-- ***********************************
			Invalid char ';' or CrLf in the RequestName
			*********************************** -->
			<xsl:choose>
				<xsl:when test="$mCheckInvalidCharRequestDataName = ';' or $mCheckInvalidCharRequestDataName = ' '">
					<xsl:call-template name="error">
					<xsl:with-param name="type">DDT2000</xsl:with-param>
					<xsl:with-param name="chapter">DDT2000_ERR_RequestNameInvalidChar</xsl:with-param>
					<xsl:with-param name="description">
					<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b>
					</xsl:with-param>
					<xsl:with-param name="info">
					<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidCharacter"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
					<b>-&gt;<xsl:value-of select="$mCheckInvalidCharRequestDataName" />&lt;-</b>
					</xsl:with-param>
					<xsl:with-param name="action">
					<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDeleteReplace"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>  <b>-&gt;<xsl:value-of select="$mCheckInvalidCharRequestDataName" />&lt;-</b>
					</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="contains($mRequestName, '&#10;')"> <!-- character Carriage return/Line feed (CrLf) -->
					<xsl:call-template name="error">
						<xsl:with-param name="type">DDT2000</xsl:with-param>
						<xsl:with-param name="chapter">DDT2000_ERR_RequestNameInvalidChar</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b>
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidCharacter"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><br/>
							<b>-&gt; CrLf &lt;-</b>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDeleteReplace"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>  <b>-&gt; CrLf &lt;-</b>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<!-- ***********************************
					Other Invalid char in the RequestName
					*********************************** -->
					<xsl:if test="$mCheckInvalidCharRequestDataName != ''">
						<xsl:call-template name="warning">
							<xsl:with-param name="type">DDT2000</xsl:with-param>
							<xsl:with-param name="chapter">DDT2000_WAR_RequestNameInvalidChar</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidCharacter"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><br/>
								<b>-&gt;<xsl:value-of select="$mCheckInvalidCharRequestDataName" />&lt;-</b>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desFirstCharValid"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><br/>
								<b><xsl:value-of select="local:getValidChars($language, 1)" /></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desOtherCharValid"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><br/>
								<b><xsl:value-of select="local:getValidChars($language, 0)" /></b>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="warning">
							<xsl:with-param name="type">DAIMLER</xsl:with-param>
							<xsl:with-param name="chapter">DAIMLER_WAR_RequestNameInvalidChar</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidCharacter"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><br/>
								<b>-&gt;<xsl:value-of select="$mCheckInvalidCharRequestDataName" />&lt;-</b>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desFirstCharValid"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><br/>
								<b><xsl:value-of select="local:getValidChars($language, 1)" /></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desOtherCharValid"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><br/>
								<b><xsl:value-of select="local:getValidChars($language, 0)" /></b>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>

			<!-- *******************************************************************************************************************
			*******************************************************************************************************************
								Check request/SentBytes
			*******************************************************************************************************************
			******************************************************************************************************************* -->
			<xsl:if test="(string-length($mRequestSentBytes) mod 2) != 0">
				<xsl:call-template name="error">
					<xsl:with-param name="type">DDT2000</xsl:with-param>
					<xsl:with-param name="chapter">DDT2000_ERR_RequestSentBytes</xsl:with-param>
					<xsl:with-param name="description">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b>
					</xsl:with-param>
					<xsl:with-param name="info">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>SentBytes: $<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></b><br/>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="string-length($mRequestSentBytes) div 2" /></b><br/>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/notEvenValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="action">
						<!--The length of the sent bytes must be an even value-->
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- **************************************************************************************************************
			SentBytes except DTT2000 limits
			Attention :
			mMinRequestSentBytes			: limite inférieure en octets
			mMaxRequestSentBytesDDT2000	: limite supérieure en octets
			mRequestSentBytes = octets émis (ex:2180)
			string-length($mRequestSentBytes) = nombre de caractères émis (ex si 2180 alors 4 caractères)
			string-length($mRequestSentBytes) div 2 = nombre d'octets émis (ex si 2180 alors 4 caractères donc 2 octets)
			*************************************************************************************************************** -->
			<xsl:if test="((string-length($mRequestSentBytes) div 2)&lt; $mMinRequestSentBytes) or ((string-length($mRequestSentBytes) div 2)&gt; $mMaxRequestSentBytesDDT2000)">
				<xsl:call-template name="error">
					<xsl:with-param name="type">DDT2000</xsl:with-param>
					<xsl:with-param name="chapter">DDT2000_ERR_RequestSentBytes</xsl:with-param>
					<xsl:with-param name="description">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b>
					</xsl:with-param>
					<xsl:with-param name="info">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></b><br/>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/numberOf"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <xsl:value-of select="string-length($mRequestSentBytes)" /><br/>
						<b>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <xsl:value-of select="string-length($mRequestSentBytes) div 2" />
						</b>
					</xsl:with-param>
					<xsl:with-param name="action">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <br/>
						<b>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b>[<xsl:value-of select="$mMinRequestSentBytes" />,<xsl:value-of select="$mMaxRequestSentBytesDDT2000" />]</b>
						</b>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- *******************************************************************************************************************
			*******************************************************************************************************************
							Check request/Received/@MinBytes
			*******************************************************************************************************************
			******************************************************************************************************************* -->

			<!-- **********************************************************************************
			MinBytes except DDT2000 limits
			mMinMinBytes				: limite inférieure en octets
			mMaxMinBytesDDT2000		: limite supérieure en octets
			mRequestReceivedMinBytes = Longueur minimum de la réponse à recevoir en octets
			********************************************************************************** -->
			<xsl:if test="($mRequestReceivedMinBytes&lt; $mMinMinBytes) or ($mRequestReceivedMinBytes&gt; $mMaxMinBytesDDT2000)">
				<xsl:call-template name="error">
					<xsl:with-param name="type">DDT2000</xsl:with-param>
					<xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedMinBytes</xsl:with-param>
					<xsl:with-param name="description">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></b><br/>
					</xsl:with-param>
					<xsl:with-param name="info">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/minBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestReceivedMinBytes" /></b><br/>
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
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <br/>
						<b>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/minBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : [<xsl:value-of select="$mMinMinBytes" />,<xsl:value-of select="$mMaxMinBytesDDT2000" />]
						</b>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- *******************************************************************************************************************
			*******************************************************************************************************************
							Check request/Received/ReplyBytes
			*******************************************************************************************************************
			******************************************************************************************************************* -->
			<xsl:if test="ddt:Received/ddt:ReplyBytes">
				<xsl:variable name="mMinRequestReceivedReplyBytes">1</xsl:variable><!-- 1 -->
				<xsl:variable name="mMaxRequestReceivedReplyBytesDDT2000">
					<xsl:choose>
						<!-- Attention ce sont des octets -->
						<xsl:when test="//ddt:Target/ddt:K">255</xsl:when><!-- 255 octets -->
						<xsl:when test="//ddt:Target/ddt:CAN">4095</xsl:when><!-- 4095 octets-->
						<xsl:when test="//ddt:Target/ddt:IP">4095</xsl:when><!-- 4095 octets-->
						<xsl:otherwise>255</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<!-- *************************************************************************************************************
				ReplyBytes except DDT2000 limits
				mMinRequestReceivedReplyBytes				: Limite inférieure en octets
				mMaxRequestReceivedReplyBytesDDT2000		: Limite supérieure en octets
				mRequestReplyBytes 				: Template de réponse
				************************************************************************************************************* -->
				<xsl:if test="((string-length($mRequestReplyBytes) div 2)&lt; $mMinRequestReceivedReplyBytes) or ((string-length($mRequestReplyBytes) div 2)&gt; $mMaxRequestReceivedReplyBytesDDT2000)">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DDT2000</xsl:with-param>
						<xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedReplyBytes</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></b>
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReplyBytes),32)" /></pre></b><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> :<b><xsl:value-of select="string-length($mRequestReplyBytes) div 2" /></b>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <br/>
							<b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : [<xsl:value-of select="$mMinRequestReceivedReplyBytes" />,<xsl:value-of select="$mMaxRequestReceivedReplyBytesDDT2000" />]
							</b>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<!-- *******************************************
				Coherence between SendBytes and ReplyBytes
				******************************************* -->
				<xsl:variable name="mExpectedReplyBytes" select="string(local:CheckTemplate(string($mRequestSentBytes),string($mRequestReplyBytes)))"></xsl:variable>
				<xsl:if test="$mExpectedReplyBytes != ''">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DDT2000</xsl:with-param>
						<xsl:with-param name="chapter">DDT2000_ERR_RequestCoherenceSendBytesReplyBytes</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <br/>
							<b><xsl:value-of select="$mRequestName" /></b><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> :  <pre><b>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></b></pre>
						</xsl:with-param>
						<xsl:with-param name="info">
							Template
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReplyBytes),32)" /></pre></b><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoCoherence"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="action">
							Template
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/mustToBegin"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b>$<xsl:value-of select="$mExpectedReplyBytes" /></b>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>

			<!-- *******************************************
			Vérifier que le template réponse des requêtes est documenté
			******************************************* -->
			<xsl:if test="string-length($mRequestReplyBytes) = 0">
				<xsl:choose>
					<!-- Need to test SentByte to be able to compute ReplyBytes first byte value -->
					<xsl:when test="string-length($mRequestSentBytes) &gt; 0">
						<xsl:call-template name="warning">
							<xsl:with-param name="type">DDT2000</xsl:with-param>
							<xsl:with-param name="chapter">DDT2000_WAR_RequestTemplateMissing</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <br/>
								<b><xsl:value-of select="$mRequestName" /></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> :  <pre><b>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></b></pre>
							</xsl:with-param>
							<xsl:with-param name="info">
								Template
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="action">
								Template
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/mustToBegin"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b>$<xsl:value-of select="local:ToHex(local:ToDec(substring($mRequestSentBytes,1,2))+64,2)" /></b>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="warning">
							<xsl:with-param name="type">DDT2000</xsl:with-param>
							<xsl:with-param name="chapter">DDT2000_WAR_RequestTemplateMissing</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <br/>
								<b><xsl:value-of select="$mRequestName" /></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="info">
								Template
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/ofRequest"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionResponse"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Request.xsl: template Request ends')"/></logmsg>
	</xsl:template>
</xsl:stylesheet>
