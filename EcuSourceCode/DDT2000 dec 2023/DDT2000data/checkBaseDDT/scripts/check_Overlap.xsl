<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:ddt="http://www-diag.renault.com/2002/ECU"
xmlns:ds="http://www-diag.renault.com/2002/screens"
xmlns:local="#local-functions"
>
  <!-- Remarque : 
      2 templates définis dans ce fichier :
        + Overlap_Request : 
            - Vérification qu'aucune donnée de la trame d'émission ne se chevauchent
            - Inclusion interdit : aucun bit ne doit être commun entre 2 données
        + Overlap_Response : 
            - Vérification qu'aucune donnée de la trame de reception ne se chevauchent
            - Inclusion autorisée : Une donnée A peut être incluse dans donnée B, cas tous les bits de A appartiennent également à B
  -->


  <!-- ********************************** -->
  <!-- ********************************** -->
  <!-- **** TEMPLATE Overlap_Request **** -->
  <!-- ********************************** -->
  <!-- ********************************** -->
	<xsl:template name="Overlap_Request">
		<xsl:param name="serviceName" />
    <xsl:param name="isMaintainabilityReport"/>
		<xsl:param name="currentFrame" />
		<xsl:param name="currentDataItem" />
    
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Overlap.xsl: template Overlap_Request starts')"/></logmsg>

		<xsl:variable name = "currentStartBitPosition">
			<xsl:call-template name="GetStartBitPosition">
				<xsl:with-param name="dataItem" select="$currentDataItem" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name = "currentStopBitPosition">
			<xsl:call-template name="GetStopBitPosition">
				<xsl:with-param name="dataItem" select="$currentDataItem" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:for-each select="$currentFrame/ddt:DataItem">
			<!-- On ne compare pas le DataItem avec lui même -->
			<xsl:if test="@Name != $currentDataItem/@Name">
				<xsl:variable name = "checkedStartBitPosition">
					<xsl:call-template name="GetStartBitPosition">
						<xsl:with-param name="dataItem" select="." />
					</xsl:call-template>
				</xsl:variable>
				<!-- erreur si checkedStartBitPosition est inclus entre currentStartBitPosition et currentStopBitPosition  - l'inclusion (Donnée contenue dans une autre) est interdit -->
				<xsl:if test="($currentStartBitPosition &lt;= $checkedStartBitPosition) and ($checkedStartBitPosition &lt;= $currentStopBitPosition)">
          <!-- ***************************************** -->
          <!-- Error AE011 : ALLIANCE_ERR_RequestOverlap -->
          <!-- ***************************************** -->
					<xsl:call-template name="error">
						<xsl:with-param name="type">ALLIANCE</xsl:with-param>
						<xsl:with-param name="chapter">ALLIANCE_ERR_RequestOverlap</xsl:with-param>
						<xsl:with-param name="description">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							: <b><xsl:value-of select="$serviceName" /></b>
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoOverlap"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							:<br/>
							+ <b><xsl:value-of select="$currentDataItem/@Name" /></b><br/>
							+ <b><xsl:value-of select="@Name" /></b>
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							:<br/>
							+ First byte<br/>
							+ Bit Offset<br/>
							+
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataLength" />
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				

          <xsl:if test="$isMaintainabilityReport = 'true'">
            <!-- **************************************** -->
            <!-- Error ME023 : DAIMLER_ERR_RequestOverlap -->
            <!-- **************************************** -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DAIMLER</xsl:with-param>
              <xsl:with-param name="chapter">DAIMLER_ERR_RequestOverlap</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b><xsl:value-of select="$serviceName" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoOverlap"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                :<br/>
                + <b><xsl:value-of select="$currentDataItem/@Name" /></b><br/>
                + <b><xsl:value-of select="@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                :<br/>
                + First byte<br/>
                + Bit Offset<br/>
                +
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataLength" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
			</xsl:if>
		</xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Overlap.xsl: template Overlap_Request ends')"/></logmsg>        
	</xsl:template>

  <!-- *********************************** -->
  <!-- *********************************** -->
  <!-- **** TEMPLATE Overlap_Response **** -->
  <!-- *********************************** -->
  <!-- *********************************** -->
  <xsl:template name="Overlap_Response">
		<xsl:param name="serviceName" />
    <xsl:param name="isMaintainabilityReport"/>
		<xsl:param name="currentFrame" />
		<xsl:param name="currentDataItem" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Overlap.xsl: template Overlap_Response starts')"/></logmsg>

		<xsl:variable name = "currentStartBitPosition">
			<xsl:call-template name="GetStartBitPosition">
				<xsl:with-param name="dataItem" select="$currentDataItem" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name = "currentStopBitPosition">
			<xsl:call-template name="GetStopBitPosition">
				<xsl:with-param name="dataItem" select="$currentDataItem" />
			</xsl:call-template>
		</xsl:variable>


    <xsl:for-each select="$currentFrame/ddt:DataItem">
      <xsl:if test="@Name != $currentDataItem/@Name">

        <!-- Get tested DataItem StartBit position -->
        <xsl:variable name="checkedStartBitPosition">
					<xsl:call-template name="GetStartBitPosition">
						<xsl:with-param name="dataItem" select="." />
					</xsl:call-template>
        </xsl:variable>
        
        <!-- Get tested DataItem StopBit position -->
        <xsl:variable name="checkedStopBitPosition">
          <xsl:call-template name="GetStopBitPosition">
            <xsl:with-param name="dataItem" select="." />
          </xsl:call-template>
        </xsl:variable>

        <!-- Compare checked DataItem position with current DataItem - inclusion (data inside another) allowed -->
        <xsl:if test="($currentStartBitPosition &lt;= $checkedStartBitPosition) and ($checkedStartBitPosition &lt;= $currentStopBitPosition) and ($checkedStopBitPosition &gt;= $currentStopBitPosition)">
          <xsl:if test="$isMaintainabilityReport = 'true'">
            <!-- **************************************** -->
            <!-- Error ME024 : DAIMLER_ERR_ResponseOverlap -->
            <!-- **************************************** -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DAIMLER</xsl:with-param>
              <xsl:with-param name="chapter">DAIMLER_ERR_ResponseOverlap</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b><xsl:value-of select="$serviceName" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoOverlap"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                :<br/>
                + <b><xsl:value-of select="$currentDataItem/@Name" /></b><br/>
                + <b><xsl:value-of select="@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                :<br/>
                + First byte<br/>
                + Bit Offset<br/>
                +
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataLength" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Overlap.xsl: template Overlap_Response ends')"/></logmsg>        
  </xsl:template>
</xsl:stylesheet>