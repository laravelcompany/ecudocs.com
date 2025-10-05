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

  <!-- **************************************** -->
  <!-- Specification   36-00-013/B & 36-00-11/D -->
  <!-- **************************************** -->
  <xsl:template name="ReadDTCInformation_ReportExtendedData">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportExtendedData.xsl: template ReadDTCInformation_ReportExtendedData starts')"/></logmsg>
  
    <xsl:choose>
      <xsl:when test="ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportExtendedData']">
        <xsl:apply-templates select="ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportExtendedData']" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="ddt:Requests/ddt:Request/ddt:Sent/ddt:SentBytes = '1906000000FF'">
            <xsl:for-each select="ddt:Requests/ddt:Request/ddt:Sent/ddt:SentBytes[.='1906000000FF']">
              <xsl:variable name="mSentBytes" select="../ddt:SentBytes"></xsl:variable>
              <!-- Error DE091 : DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b>
                  <br />
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="$mSentBytes" /></b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidNameRequest" />
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
                  <b>ReadDTCInformation.ReportExtendedData</b>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <!-- Error DE080 : DDT2000_ERR_ReadDTCInformationReportExtendedData -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedData</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>ReadDTCInformation.ReportExtendedData</b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText"><xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <br />
                <b>ReadDTCInformation.ReportExtendedData</b>
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
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCopyRequestFromGenericDataBase" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_ReadDTCInformation_ReportExtendedData.xsl: template ReadDTCInformation_ReportExtendedData ends')"/></logmsg>
  </xsl:template>

  <!-- ****************************************************** -->
  <!-- Check the request ReadDTCInformation.ReportExtendedData-->
  <!-- ****************************************************** -->
  <xsl:template match="ddt:Request[@Name = 'ReadDTCInformation.ReportExtendedData']">
    <xsl:if test="ddt:Sent/ddt:SentBytes != '1906000000FF'">
      <!-- Error DE080 : DDT2000_ERR_ReadDTCInformationReportExtendedData -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedData</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportExtendedData</b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : 
          <b><xsl:value-of select="ddt:Sent/ddt:SentBytes" /></b><br />
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
          </xsl:call-template> :  <b>1906000000FF</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="ddt:Received[@MinBytes != '6'] and ddt:Received[@MinBytes != '10']">
      <!-- Error DE080 : DDT2000_ERR_ReadDTCInformationReportExtendedData -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedData</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportExtendedData</b>
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
          </xsl:call-template> : <b>6</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="ddt:Received/ddt:ShiftBytesCount">
      <!-- Error DE080 : DDT2000_ERR_ReadDTCInformationReportExtendedData -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_ReadDTCInformationReportExtendedData</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>ReadDTCInformation.ReportExtendedData</b>
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
          </xsl:call-template>Shift Bytes Count = <b>0</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>



    <!-- *************************************************************************
     Check all the datas of the request: ReadDTCInformation.ReportExtendedData
     ************************************************************************* -->
    <!-- *********
	     Sent Data
	     ********* -->
    <!-- Error DE084 : DDT2000_ERR_1906FF_DTCMaskRecord -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1906FF_DTCMaskRecord</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData</xsl:with-param>
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
    <!-- Error DE085 : DDT2000_ERR_1906FF_DTCRecord -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1906FF_DTCRecord</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData</xsl:with-param>
      <xsl:with-param name="dataName">DTCRecord</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 3 bytes BCD/HEXA</xsl:with-param>
      <xsl:with-param name="startByte">3</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">3</xsl:with-param>
      <xsl:with-param name="ascii">0</xsl:with-param>
    </xsl:call-template>
    
    <!-- Error DE086 : DDT2000_ERR_1906FF_StatusOfDTC -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1906FF_StatusOfDTC</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData</xsl:with-param>
      <xsl:with-param name="dataName">StatusOfDTC</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">6</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
    
    <!-- Error DE087 : DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData</xsl:with-param>
      <xsl:with-param name="dataName">DTCExtendedDataRecordNumber</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">7</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
    
    <!-- Error DE088 : DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData</xsl:with-param>
      <xsl:with-param name="dataName">DTCExtendedData.AgingCounter</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">8</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
    
    <!-- Error DE089 : DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData</xsl:with-param>
      <xsl:with-param name="dataName">DTCExtendedData.DTCOccurrenceCounter</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">8</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
    
    <!-- Error DE090 : DDT2000_ERR_1906FF_DTCExtendedData_Mileage -->
    <xsl:call-template name="checkDataItemNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_1906FF_DTCExtendedData_Mileage</xsl:with-param>
      <xsl:with-param name="reqName">ReadDTCInformation.ReportExtendedData</xsl:with-param>
      <xsl:with-param name="dataName">DTCExtendedData.Mileage</xsl:with-param>
      <xsl:with-param name="msgMissing">Numeric 24 bits unsigned (km)</xsl:with-param>
      <xsl:with-param name="startByte">8</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">24</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>