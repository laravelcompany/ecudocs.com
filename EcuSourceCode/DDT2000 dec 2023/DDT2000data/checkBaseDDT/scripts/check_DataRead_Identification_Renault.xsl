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



  <!-- ***************************** -->
  <!-- Specification   36-00-013/B -->
  <!-- ***************************** -->
  <xsl:template name="DataRead.Identification.Renault">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DataRead_Identification_Renault.xsl: template DataRead.Identification.Renault starts')"/></logmsg>

    <xsl:choose>
      <xsl:when test= "ddt:Requests/ddt:Request[@Name = 'DataRead.Identification.RenaultR1']">
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desRenaultIdent"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info"><b>R1</b></xsl:with-param>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test= "ddt:Requests/ddt:Request[@Name = 'DataRead.Identification.RenaultR2']">
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desRenaultIdent"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info"><b>R2 (5 Digits)</b></xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates select="ddt:Requests/ddt:Request[@Name = 'DataRead.Identification.RenaultR2']" />
      </xsl:when>

      <xsl:when test= "ddt:Requests/ddt:Request[@Name = 'DataRead.Identification.RenaultR3']">
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desRenaultIdent"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info"><b>R3</b></xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desRenaultIdent"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/unknown"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </b>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="error">
          <xsl:with-param name="type">CPDD</xsl:with-param>
          <xsl:with-param name="chapter">CPDD_ERR_IdentificationRequestName</xsl:with-param>
          <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b>DataRead.Identification.RenaultR[x]</b>
          </xsl:with-param>
          <xsl:with-param name="info"><b>DataRead.Identification.RenaultR1 ou RenaultR2 ou RenaultR3 : </b>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b>DataRead.Identification.RenaultR1 ou RenaultR2 ou RenaultR3</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
  <!-- =============================================================== -->
  <!-- la spécification 36-00-013/B supporte ou non le format 5 digits -->
  <!-- =============================================================== -->
  <!--
      <xsl:otherwise>
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
          <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <b>DataRead.Identification.RenaultR2</b>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template><br/>
            <b>DataRead.Identification.RenaultR2</b>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
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
  -->
    </xsl:choose>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DataRead_Identification_Renault.xsl: template DataRead.Identification.Renault ends')"/></logmsg>
  </xsl:template>

  <!-- ****************************************************** -->
  <!-- Check the request DataRead.Identification.RenaultR2    -->
  <!-- ****************************************************** -->
  <xsl:template match="/xml/ddt:Target/ddt:Requests/ddt:Request[@Name = 'DataRead.Identification.RenaultR2']">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DataRead_Identification_Renault.xsl: template match with request name DataRead.Identification.RenaultR2 starts')"/></logmsg>
    <xsl:if test="ddt:Sent/ddt:SentBytes != '2180'">
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b>
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
          </xsl:call-template> :  <b>2180</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="ddt:Received[@MinBytes != '26']" >
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b>
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
          </xsl:call-template> : <b>26</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="ddt:Received/ddt:ShiftBytesCount">
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoShiftByteCount" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> = <b><xsl:value-of select="ddt:Received/ddt:ShiftBytesCount" /></b><br/>
          <b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          </b><br/>
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
    </xsl:if>
  <!-- *********************************************************************
       Check all the datas of the request: DataRead.Identification.RenaultR2
       ***********************************************************************-->

    <!-- **************
         Received Datas
         ************** -->
    <!-- ******************************************
         Check the data : PartNumber.LowerPart
         ****************************************** -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">PartNumber.LowerPart</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 5 bytes ASCII</xsl:with-param>
      <xsl:with-param name="startByte">3</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">5</xsl:with-param>
      <xsl:with-param name="ascii">1</xsl:with-param>
    </xsl:call-template>

    <!-- **************************************************
         Check the data : DiagnosticIdentificationCode
         ************************************************** -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">DiagnosticIdentificationCode</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 1 bytes BCD/HEXA</xsl:with-param>
      <xsl:with-param name="startByte">8</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">1</xsl:with-param>
      <xsl:with-param name="ascii">0</xsl:with-param>
    </xsl:call-template>
    <!-- ****************************************
         Check the data : SupplierNumber.ITG
         **************************************** -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">SupplierNumber.ITG</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 3 bytes ASCII</xsl:with-param>
      <xsl:with-param name="startByte">9</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">3</xsl:with-param>
      <xsl:with-param name="ascii">1</xsl:with-param>
    </xsl:call-template>

    <!-- **********************************************
         Check the data : HardwareNumber.LowerPart
         ********************************************** -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">HardwareNumber.LowerPart</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 5 bytes ASCII</xsl:with-param>
      <xsl:with-param name="startByte">12</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">5</xsl:with-param>
      <xsl:with-param name="ascii">1</xsl:with-param>
    </xsl:call-template>

    <!-- ************************************
         Check the data : SoftwareNumber
         ************************************ -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">SoftwareNumber</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 2 bytes BCD/HEXA</xsl:with-param>
      <xsl:with-param name="startByte">17</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">2</xsl:with-param>
      <xsl:with-param name="ascii">0</xsl:with-param>
    </xsl:call-template>

    <!-- ***********************************
         Check the data : EditionNumber
         *********************************** -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">EditionNumber</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 2 bytes BCD/HEXA</xsl:with-param>
      <xsl:with-param name="startByte">19</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">2</xsl:with-param>
      <xsl:with-param name="ascii">0</xsl:with-param>
    </xsl:call-template>

    <!-- ***************************************
         Check the data : CalibrationNumber
         *************************************** -->
    <xsl:call-template name="checkDataItemNoNumeric">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">CalibrationNumber</xsl:with-param>
      <xsl:with-param name="msgMissing">No Numeric 2 bytes BCD/HEXA</xsl:with-param>
      <xsl:with-param name="startByte">21</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numberBytes">2</xsl:with-param>
      <xsl:with-param name="ascii">0</xsl:with-param>
    </xsl:call-template>

    <!-- **********************************************
         Check the data : PartNumber.BasicPartList
         ********************************************** -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">PartNumber.BasicPartList</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">23</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- **************************************************
         Check the data : HardwareNumber.BasicPartList
         ************************************************** -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">HardwareNumber.BasicPartList</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">24</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- **************************************************
         Check the data : ApprovalNumber.BasicPartList
         ************************************************** -->
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">ApprovalNumber.BasicPartList</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">25</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- ****************************************************
         Check the data : ManufacturerIdentificationCode
         **************************************************** --> 
    <xsl:call-template name="checkDataItemNumericList">
      <xsl:with-param name="type">DDT2000</xsl:with-param>
      <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
      <xsl:with-param name="reqName">DataRead.Identification.RenaultR2</xsl:with-param>
      <xsl:with-param name="dataName">ManufacturerIdentificationCode</xsl:with-param>
      <xsl:with-param name="msgMissing">List Numeric 8 bits unsigned</xsl:with-param>
      <xsl:with-param name="startByte">26</xsl:with-param>
      <xsl:with-param name="offsetBit">0</xsl:with-param>
      <xsl:with-param name="numbersBits">8</xsl:with-param>
      <xsl:with-param name="signed">0</xsl:with-param>
    </xsl:call-template>

    <!-- ***************************************************************************
      Contrôler la longueur (Max 5 caractères) des libellés des listes suivantes :
          ApprovalNumber.BasicPartList
          HardwareNumber.BasicPartList
          PartNumber.BasicPartList
         **************************************************************************** -->
    <xsl:for-each select = "//ddt:Target/ddt:Datas/ddt:Data[@Name='ApprovalNumber.BasicPartList']/ddt:Bits/ddt:List/ddt:Item">
      <xsl:choose>
        <xsl:when test= "string-length(@Text)&gt;5">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_BadLengthBasicPartList</xsl:with-param>
              <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b><br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>ApprovalNumber.BasicPartList</b>
              </xsl:with-param>
              <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemtext"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <br/>
                <b><xsl:value-of select="@Text" /></b> <br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b><xsl:value-of select="string-length(@Text)" /></b>
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
                </xsl:call-template> : <br/>
                <b>5</b>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
      </xsl:choose>
    </xsl:for-each>

    <xsl:for-each select = "//ddt:Target/ddt:Datas/ddt:Data[@Name='HardwareNumber.BasicPartList']/ddt:Bits/ddt:List/ddt:Item">
      <xsl:choose>
        <xsl:when test= "string-length(@Text)&gt;5">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_BadLengthBasicPartList</xsl:with-param>
              <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b><br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>HardwareNumber.BasicPartList</b>
              </xsl:with-param>
              <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemtext"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <br/>
                <b><xsl:value-of select="@Text" /></b> <br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b><xsl:value-of select="string-length(@Text)" /></b>
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
                </xsl:call-template> : <br/>
                <b>5</b>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
      </xsl:choose>
    </xsl:for-each>

    <xsl:for-each select = "//ddt:Target/ddt:Datas/ddt:Data[@Name='PartNumber.BasicPartList']/ddt:Bits/ddt:List/ddt:Item">
      <xsl:choose>
        <xsl:when test= "string-length(@Text)&gt;5">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_BadLengthBasicPartList</xsl:with-param>
              <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b><br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>PartNumber.BasicPartList</b>
              </xsl:with-param>
              <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemtext"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <br/>
                <b><xsl:value-of select="@Text" /></b> <br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b><xsl:value-of select="string-length(@Text)" /></b>
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
                </xsl:call-template> : <br/>
                <b>5</b>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
      </xsl:choose>
    </xsl:for-each>
    <!-- ***************************************************************************
      Contrôler que Les données suivantes doivent contenir une liste de valeurs :
          HardwareNumber.BasicPartList
          PartNumber.BasicPartList
         **************************************************************************** -->
    <xsl:for-each select = "//ddt:Target/ddt:Datas/ddt:Data[@Name='HardwareNumber.BasicPartList']">
      <xsl:choose>
        <xsl:when test= "not(count(//ddt:Target/ddt:Datas/ddt:Data[@Name='HardwareNumber.BasicPartList']/ddt:Bits/ddt:List/ddt:Item)&gt;0)">
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>HardwareNumber.BasicPartList</b>
              </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b>HardwareNumber.BasicPartList</b><br/>
              <b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemEmpty" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              </b>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddListItems" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template><br/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>

    <xsl:for-each select = "//ddt:Target/ddt:Datas/ddt:Data[@Name='PartNumber.BasicPartList']">
      <xsl:choose>
        <xsl:when test= "not(count(//ddt:Target/ddt:Datas/ddt:Data[@Name='PartNumber.BasicPartList']/ddt:Bits/ddt:List/ddt:Item)&gt;0)">
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>DataRead.Identification.RenaultR2</b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> :  <b>PartNumber.BasicPartList</b>
              </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b>PartNumber.BasicPartList</b><br/>
              <b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemEmpty" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              </b>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddListItems" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template><br/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DataRead_Identification_Renault.xsl: template match with request name DataRead.Identification.RenaultR2] ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
