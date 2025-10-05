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

  <!-- ***************************************** -->
  <!-- Specification   36-00-013/B & 36-00-011/D -->
  <!-- ***************************************** -->
  <xsl:template name="ReadDTCInformation_ReportExtendedData_Mileage">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportExtendedData_Mileage.xsl: template ReadDTCInformation_ReportExtendedData_Mileage starts')"/></logmsg>
  
    <xsl:choose>
      <xsl:when test="ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportExtendedData.Mileage']">
        <xsl:apply-templates select="ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportExtendedData.Mileage']" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="ddt:Requests/ddt:Request/ddt:Sent/ddt:SentBytes = '190600000080'">
            <xsl:for-each select="ddt:Requests/ddt:Request/ddt:Sent/ddt:SentBytes[.='190600000080']">
              <xsl:variable name="mSentBytes" select="../ddt:SentBytes"></xsl:variable>
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang">
                      <xsl:value-of select="$language"></xsl:value-of>
                    </xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> :
									<b><xsl:value-of select="../../@Name"></xsl:value-of></b><br /><xsl:call-template name="getLocalizedText"><xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param><xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" /><xsl:with-param name="defaultText">*non trouvé*</xsl:with-param></xsl:call-template> : <b><xsl:value-of select="$mSentBytes"></xsl:value-of></b><br /></xsl:with-param>
                <xsl:with-param name="info">
                  <b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang">
                        <xsl:value-of select="$language"></xsl:value-of>
                      </xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidNameRequest"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang">
                      <xsl:value-of select="$language"></xsl:value-of>
                    </xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br />
                  <b>ReadDTCInformation.ReportExtendedData.Mileage</b>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang">
                    <xsl:value-of select="$language"></xsl:value-of>
                  </xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>ReadDTCInformation.ReportExtendedData.Mileage</b></xsl:with-param>
              <xsl:with-param name="info">
                <b>ReadDTCInformation.ReportExtendedData.Mileage</b>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang">
                    <xsl:value-of select="$language"></xsl:value-of>
                  </xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <br />
                <b>ReadDTCInformation.ReportExtendedData.Mileage</b>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang">
                    <xsl:value-of select="$language"></xsl:value-of>
                  </xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMandatory" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang">
                    <xsl:value-of select="$language"></xsl:value-of>
                  </xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCopyRequestFromGenericDataBase" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportExtendedData_Mileage.xsl: template ReadDTCInformation_ReportExtendedData_Mileage ends')"/></logmsg>
  </xsl:template>
  
  
  <!-- ***************************************************************
     Check the request ReadDTCInformation.ReportExtendedData.Mileage
     *************************************************************** -->
  <xsl:template match="ddt:Request[@Name = 'ReadDTCInformation.ReportExtendedData.Mileage']">
    <xsl:if test="ddt:Sent/ddt:SentBytes != '190600000080'">
      <!-- Error DE100 : DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportExtendedData.Mileage</b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="ddt:Sent/ddt:SentBytes" /></b>
          <br />
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
          </xsl:call-template> :  <b>190600000080</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="ddt:Received[@MinBytes != '6'] and ddt:Received[@MinBytes != '10']">
      <!-- Error DE100 : DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportExtendedData.Mileage</b>
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
          </xsl:call-template> : <b>6 </b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template><b> 10</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>


    <xsl:if test="ddt:Received/ddt:ShiftBytesCount">
      <!-- Error DE100 : DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportExtendedData.Mileage</b>
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
          Shift Bytes Count = <b>0</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    
    <!-- ************************************************************************************************
	 Check all the datas of the request ReadDTCInformation.ReportExtendedData.Mileage ($190600000080)
	 ************************************************************************************************ -->
    <!-- Longueur de la réponse = 10 octets donc la réponse positive avec le mileage est obligatoire
	     L'ecu ne supporte pas la réponse minimale possible = 6 octets -->
    <xsl:if test="ddt:Received[@MinBytes = '10'] and not (ddt:Received/ddt:DataItem[@Name = 'DTCExtendedData.Mileage'])">
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>: ReadDTCInformation.ReportExtendedData.Mileage
        </xsl:with-param>
        <xsl:with-param name="info">
          <b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMileageRequest" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          </b>
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
    
    <!-- **********
	     Sent Data
	     ********* -->
    <!-- **************************************************************
	     Check the data : DTCMaskRecord
	     ************************************************************** -->
    <!-- Error DE104 : DTT2000_ERR_190680_DTCMaskRecord -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DTT2000_ERR_190680_DTCMaskRecord</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData.Mileage</xsl:with-param>
      <xsl:with-param name="dataName">DTCMaskRecord</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 3 bytes BCD/HEXA</xsl:with-param>
      <xsl:with-param name="startByte">3</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">3</xsl:with-param>
      <xsl:with-param name="ascii">0</xsl:with-param>
    </xsl:call-template>
    <!-- *************
	     Received Data
	     ************* -->
    <!-- **************************
	     Check the data : DTCRecord
	     ************************** -->
    <!-- Error DE105 : DDT2000_ERR_190680_DTCRecord -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_190680_DTCRecord</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData.Mileage</xsl:with-param>
      <xsl:with-param name="dataName">DTCRecord</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 3 bytes BCD/HEXA</xsl:with-param>
      <xsl:with-param name="startByte">3</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">3</xsl:with-param>
      <xsl:with-param name="ascii">0</xsl:with-param>
    </xsl:call-template>
    <!-- ****************************
	     Check the data : StatusOfDTC
	     **************************** -->
    <!-- Error DE106 : DDT2000_ERR_190680_StatusOfDTC -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_190680_StatusOfDTC</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData.Mileage</xsl:with-param>
      <xsl:with-param name="dataName">StatusOfDTC</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">6</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
    <!-- ********************************************
	     Check the data : DTCExtendedDataRecordNumber
	     ******************************************** -->
    <!-- Error DE107 : DDT2000_ERR_190680_DTCExtendedDataRecordNumber -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_190680_DTCExtendedDataRecordNumber</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData.Mileage</xsl:with-param>
      <xsl:with-param name="dataName">DTCExtendedDataRecordNumber</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
    <!-- ****************************************
	     Check the data : DTCExtendedData.Mileage
	     **************************************** -->
    <!-- Error DE108 : DDT2000_ERR_190680_DTCExtendedData_Mileage -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_190680_DTCExtendedData_Mileage</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData.Mileage</xsl:with-param>
      <xsl:with-param name="dataName">DTCExtendedData.Mileage</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 24 bits unsigned (km)</xsl:with-param>
      <xsl:with-param name="startByte">8</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">24</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>