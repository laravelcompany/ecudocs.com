<?xml version="1.0" encoding="Windows-1252"?>
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
  

  <!-- ***************************** -->
  <!-- Specification   36-00-013/A -->
  <!-- ***************************** -->
  <xsl:template name="ReadDTC_SpecA">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportDTC.xsl: template ReadDTC_SpecA starts')"/></logmsg>
  
    <!-- Présence de la requête ReportDTC ($17FF)-->
    <!--
      <xsl:call-template name="message">
        <xsl:with-param name="description">Specification</xsl:with-param>
        <xsl:with-param name="info">36-00-013/A</xsl:with-param>
      </xsl:call-template>
    -->
    <h99>ReadDTC_SpecA</h99>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportDTC.xsl: template ReadDTC_SpecA ends')"/></logmsg>
  </xsl:template>


  <!-- ************************* -->
  <!-- Specification 36-00-013/B -->
  <!-- ************************* -->
  <xsl:template name="ReadDTCInformation_BC">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportDTC.xsl: template ReadDTCInformation_BC starts')"/></logmsg>
  
    <xsl:apply-templates select="//ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportDTC']" />

    <xsl:call-template name="ReadDTCInformation_ReportSnapshot" />
    <xsl:call-template name="ReadDTCInformation_ReportExtendedData" />
    <xsl:call-template name="ReadDTCInformation_ReportExtendedData_Mileage" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportDTC.xsl: template ReadDTCInformation_BC ends')"/></logmsg>
  </xsl:template>

  <!-- ************************** -->
  <!-- Specification 36-00-011/D  -->
  <!-- ************************** -->
  <xsl:template name="ReadDTCInformation_UDS">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportDTC.xsl: template ReadDTCInformation_UDS starts')"/></logmsg>
  
    <xsl:apply-templates select="//ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportDTC']" />

    <xsl:call-template name="ReadDTCInformation_ReportSnapshot" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportDTC.xsl: template ReadDTCInformation_UDS ends')"/></logmsg>
  </xsl:template>


  <!-- ******************************************************** -->
  <!-- Contrôler la requête ReadDTCInformation.ReportDTC ($1902FF) -->
  <!-- ******************************************************** -->
  <xsl:template match="ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportDTC']">

    <!-- ******************************************************************************** -->
    <!-- Conformité des paramètres de la requête ReadDTCInformation.ReportDTC ($1902FF)   -->
    <!-- ******************************************************************************** -->
    <xsl:if test="substring(ddt:Sent/ddt:SentBytes,1,4) != '1902'">
      <!-- Error DE050 : DDT2000_ERR_ReadDTCInformationReportDTC -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportDTC</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportDTC</b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="ddt:Sent/ddt:SentBytes" /></b><br />
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
          </xsl:call-template>
          <br />
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>1902xx</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>


    <!-- ******************************** -->
    <!-- Conformité longueur MinBytes = 3 -->
    <!-- ******************************** -->
    <xsl:if test="ddt:Received[@MinBytes != '3']">
      <!-- Error DE050 : DDT2000_ERR_ReadDTCInformationReportDTC -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportDTC</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportDTC</b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b><xsl:value-of select="ddt:Received/@MinBytes" /></b><br />
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
          </xsl:call-template>
          <br />
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b>3</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <!-- ****************************** -->
    <!-- Conformité ShiftBytesCount = 4 -->
    <!-- ****************************** -->
    <xsl:if test="ddt:Received[ddt:ShiftBytesCount != '4']">
      <!-- DE050 DDT2000_ERR_ReadDTCInformationReportDTC -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportDTC</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportDTC</b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoShiftByteCount" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> = <b><xsl:value-of select="ddt:Received/ddt:ShiftBytesCount" /></b><br />
          <b>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </b>
          <br />
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
          </xsl:call-template>
          <br />
          Shift Bytes Count = <b>4</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    
    <!-- **********************************************
	 Règle : DE146
     Conformité type de panne et id associé soit :
     ********************************************** -->
    <xsl:if test="//ddt:Target/ddt:Failures[(@Name !='Pannes DTC' and  @Name != 'DTC Failures' ) or (@Id !='3')] and      //ddt:Target/ddt:Failures[(@Name !='Ne contient pas de pannes' and  @Name != 'No failures' ) or (@Id !='0')] and      //ddt:Target/ddt:Failures[(@Name !='Flags de pannes' and  @Name != 'Failures Flags' ) or (@Id !='1')] and      //ddt:Target/ddt:Failures[(@Name !='10 pannes DTC dans les trames APV' and  @Name != '10 DTC failures read with After sales Frames' ) or (@Id !='2')]">
      <!-- Error DE146 : DDT2000_ERR_BreakDownType -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_BreakDownType</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportDTC</b></xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBadBreakdown" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <br />
          <b><xsl:value-of select="//ddt:Target/ddt:Failures/@Name" /> (Id=<xsl:value-of select="//ddt:Target/ddt:Failures/@Id" />)</b>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <br />
            <ul>
              <li><b>Ne contient pas de pannes / No failures - Id=0</b></li>
              <li><b>Flags de pannes / Failures Flags - Id=1</b></li>
              <li><b>10 pannes DTC dans les trames APV / 10 DTC failures read with After sales Frames - Id=2</b></li>
              <li><b>Pannes DTC / DTC Failures - Id=3</b></li>
            </ul>
          </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <!-- *********************************************** -->
    <!-- Controler la présence des données en reception  -->
    <!-- *********************************************** -->
    <!-- Déjà réaliser ci-dessous dans les templates :	checkDataItemNumeric
													checkDataItemNumericList
													checkDataItemNoNumeric
-->
    <!-- ************************************************************************** -->
    <!-- Controler chaque data  de la requête ReadDTCInformation.ReportDTC ($1902FF)-->
    <!-- ************************************************************************** -->
    <!-- Error DE054 : DDT2000_ERR_1902_DTCStatusAvailabilityMask -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatusAvailabilityMask</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatusAvailabilityMask</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">3</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- Error DE055 : DDT2000_ERR_1902_DTCDeviceIdentifier -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCDeviceIdentifier</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCDeviceIdentifier</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 16 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">4</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">16</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- Error DE056 : DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCDeviceAndFailureTypeOBD</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 16 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">4</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">16</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- Error DE057 : DDT2000_ERR_1902_DTCFailureType_Category -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCFailureType_Category</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCFailureType.Category</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 4 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">6</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">4</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- Error DE058 : DDT2000_ERR_1902_DTCFailureType -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCFailureType</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCFailureType</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">6</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- Error DE059 : DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCFailureType.ManufacturerOrSupplier</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 4 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">6</xsl:with-param>
      <xsl:with-param name="offsetBit">4</xsl:with-param>
      <xsl:with-param name="numbersBits">4</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- Error DE060 : DDT2000_ERR_1902_StatusOfDTC -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_StatusOfDTC</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">StatusOfDTC</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- DE061  DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatus.warningIndicatorRequested</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 1 bit unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">1</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- DE062 DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatus.testNotCompletedThisMonitoringCycle</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 1 bit unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">1</xsl:with-param>
      <xsl:with-param name="numbersBits">1</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- DE063 DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatus.testFailedSinceLastClear</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 1 bit unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">2</xsl:with-param>
      <xsl:with-param name="numbersBits">1</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- DE064 DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatus.testNotCompletedSinceLastClear</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 1 bit unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">3</xsl:with-param>
      <xsl:with-param name="numbersBits">1</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- DE065 DDT2000_ERR_1902_DTCStatus_confirmedDTC -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatus_confirmedDTC</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatus.confirmedDTC</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 1 bit unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">4</xsl:with-param>
      <xsl:with-param name="numbersBits">1</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- DE066 DDT2000_ERR_1902_DTCStatus_pendingDTC -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatus_pendingDTC</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatus.pendingDTC</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 1 bit unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">5</xsl:with-param>
      <xsl:with-param name="numbersBits">1</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- DE067 DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatus.testFailedThisMonitoringCycle</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 1 bit unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">6</xsl:with-param>
      <xsl:with-param name="numbersBits">1</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- DE068 DDT2000_ERR_1902_DTCStatus_testFailed -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1902_DTCStatus_testFailed</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportDTC </xsl:with-param>
      <xsl:with-param name="dataName">DTCStatus.testFailed</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 1 bit unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">7</xsl:with-param>
      <xsl:with-param name="numbersBits">1</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
    <!-- ******************************************************* -->
    <!-- Contrôler la requête  ReadDTCInformation.ReportSnapshot -->
    <!-- ******************************************************* -->
    <!-- déjà testé voir règle DW008 -->

  </xsl:template>
</xsl:stylesheet>