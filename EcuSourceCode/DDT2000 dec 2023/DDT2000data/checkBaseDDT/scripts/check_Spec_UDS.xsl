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


<!-- ************************************ -->
<!-- Contrôles Specifications UDS-->
<!-- ************************************ -->
  <xsl:template name="check_Spec_UDS">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Spec_UDS.xsl: template check_Spec_UDS starts')"/></logmsg>
    <!-- -existence de $14XXXXXX ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,2) = '14'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_ClearDiagnosticInformation</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>ClearDiagnosticInformation($14XXXXXX)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->
      <!-- ************************ -->
      <!-- Contrôles des requêtes : -->
      <!--				$1902FF			      -->
      <!--				$1904000000FF	    -->
      <!--				$190600000080	    -->
      <!--				$1906000000FF	    -->
      <!-- ****************************** -->
      <xsl:call-template name="ReadDTCInformation_UDS" />

    <!-- -existence de $1901XX ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,4) = '1901'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_1901</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>ReadDTCInformation.ReportNumberOfDTCByStatusMask($1901XX)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->
    <!-- -existence de $1902XX ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,4) = '1902'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_1902</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>ReadDTCInformation.ReportDTC($1902XX)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->
    <!-- -existence de $1903XX ?
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,4) = '1903'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_1903</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>ReadDTCInformation.ReportDTCSnapshotIdentification($1903XX)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    ************************************************************************************************** -->
    <!-- -existence de $190AXX ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,4) = '190A'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_190A</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>ReadDTCInformation.ReportSupportedDTC($190AXX)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->


    <!-- -existence de $21 ou $3B ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[starts-with(ddt:SentBytes,'21') or starts-with(ddt:SentBytes,'3B')])&gt;=1">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_ForbiddenRequests</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> $21 / $3B
          </xsl:with-param>
          <xsl:with-param name="info">UDS :
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoForbiddenRequests"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDelete"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    <!-- -existence de $22F187 ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F187'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F187</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>DataRead.vehicleManufacturerSparePartNumber($22F187)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->
    <!-- -existence de $22F188 ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F188'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F188</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>DataRead.vehicleManufacturerECUSoftwareNumber($22F188)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->
    <!-- -existence de $22F18A ?-->
      <xsl:choose>
        <xsl:when test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F18A'])&lt;=0">
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F18A</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>DataRead.systemSupplierIdentifier($22F18A)</b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
        <xsl:otherwise>
          <xsl:variable name="mDataItemName" select="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F18A']/../ddt:Received/ddt:DataItem/@Name"></xsl:variable>
          <xsl:variable name="mDataItemLength" select="//ddt:Target/ddt:Datas/ddt:Data[@Name = $mDataItemName]/ddt:Bytes/@count"></xsl:variable>
          <xsl:variable name="mRequestName" select="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F18A']/../@Name"></xsl:variable>
          <xsl:for-each select="//ddt:Target/ddt:AutoIdents/ddt:AutoIdent">
          <xsl:variable name="mAutoidentAttributeLength" select="string-length(@Supplier)"></xsl:variable>
            <xsl:if test="not($mAutoidentAttributeLength = $mDataItemLength)">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_UDS_Autoident</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <xsl:value-of select="$mRequestName" /> ($22F18A)<br/>
                  <xsl:value-of select="$mDataItemName" />
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="$mDataItemLength" />
                </xsl:with-param>
                <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/supplier"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="@Supplier" />,
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="$mAutoidentAttributeLength" />
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
              </xsl:if>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    <!-- ************************************************************************************************** -->
    <!-- -existence de $22F18C ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F18C'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F18C</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>DataRead.ECUSerialNumber($22F18C)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->
    <!-- -existence de $22F190 ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F190'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F190</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>DataRead.VIN($22F190)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->
    <!-- -existence de $22F191 ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F191'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F191</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>DataRead.vehicleManufacturerECUHardwareNumber($22F191)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->
    <!-- -existence de $22F194 ?-->
      <xsl:choose>
        <xsl:when test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F194'])&lt;=0">
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F194</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>DataRead.systemSupplierECUSoftwareNumber($22F194)</b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
        <xsl:otherwise>
          <xsl:variable name="mDataItemName" select="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F194']/../ddt:Received/ddt:DataItem/@Name"></xsl:variable>
          <xsl:variable name="mDataItemLength" select="//ddt:Target/ddt:Datas/ddt:Data[@Name = $mDataItemName]/ddt:Bytes/@count"></xsl:variable>
          <xsl:variable name="mRequestName" select="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F194']/../@Name"></xsl:variable>
          <xsl:for-each select="//ddt:Target/ddt:AutoIdents/ddt:AutoIdent">
          <xsl:variable name="mAutoidentAttributeLength" select="string-length(@Soft)"></xsl:variable>
            <xsl:if test="not($mAutoidentAttributeLength = $mDataItemLength)">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_UDS_Autoident</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <xsl:value-of select="$mRequestName" /> ($22F194)<br/>
                  <xsl:value-of select="$mDataItemName" />
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="$mDataItemLength" />
                </xsl:with-param>
                <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/soft"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="@Soft" />,
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="$mAutoidentAttributeLength" />
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    <!-- ************************************************************************************************** -->
    <!-- -existence de $22F195 ?-->
      <xsl:choose>
        <xsl:when test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F195'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F195</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>DataRead.systemSupplierECUSoftwareVersionNumber($22F195)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
        <xsl:otherwise>
          <xsl:variable name="mDataItemName" select="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F195']/../ddt:Received/ddt:DataItem/@Name"></xsl:variable>
          <xsl:variable name="mDataItemLength" select="//ddt:Target/ddt:Datas/ddt:Data[@Name = $mDataItemName]/ddt:Bytes/@count"></xsl:variable>
          <xsl:variable name="mRequestName" select="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F195']/../@Name"></xsl:variable>
          <xsl:for-each select="//ddt:Target/ddt:AutoIdents/ddt:AutoIdent">
          <xsl:variable name="mAutoidentAttributeLength" select="string-length(@Version)"></xsl:variable>
            <xsl:if test="not($mAutoidentAttributeLength = $mDataItemLength)">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_UDS_Autoident</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <xsl:value-of select="$mRequestName" /> ($22F195)<br/>
                  <xsl:value-of select="$mDataItemName" />
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="$mDataItemLength" />
                </xsl:with-param>
                <xsl:with-param name="info">
                  Version : <xsl:value-of select="@Version" />,
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="$mAutoidentAttributeLength" />
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    <!-- ************************************************************************************************** -->
    <!-- -existence de $22F1A0 ?-->
      <xsl:choose>
         <xsl:when test="count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F1A0'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F1A0</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>DataRead.diagnosticVersion($22F1A0)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
        <xsl:otherwise>
          <xsl:variable name="mDataItemName" select="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F1A0']/../ddt:Received/ddt:DataItem/@Name"></xsl:variable>
          <xsl:variable name="mDataItemLength" select="//ddt:Target/ddt:Datas/ddt:Data[@Name = $mDataItemName]/ddt:Bytes/@count"></xsl:variable>
          <xsl:variable name="mRequestName" select="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '22F1A0']/../@Name"></xsl:variable>
          <xsl:for-each select="//ddt:Target/ddt:AutoIdents/ddt:AutoIdent">
          <xsl:variable name="mAutoidentAttributeLength" select="string-length(@DiagVersion)"></xsl:variable>
            <xsl:if test="not($mAutoidentAttributeLength &lt;= ($mDataItemLength*3))">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_UDS_Autoident</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <xsl:value-of select="$mRequestName" /> ($22F1A0)<br/>
                  <xsl:value-of select="$mDataItemName" />
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="$mDataItemLength" />
                </xsl:with-param>
                <xsl:with-param name="info">
                  Diag Version : <xsl:value-of select="@DiagVersion" />,
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <xsl:value-of select="$mAutoidentAttributeLength" />
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUsedDataInRequestAsAutoIdent"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    <!-- ************************************************************************************************** -->
    <!-- -existence de $10XX ?-->
      <xsl:if test="count(ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,2) = '10'])&lt;=0">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UDS_StartDiagnosticSession</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>StartDiagnosticSession($10XX)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
    <!-- ************************************************************************************************** -->

    <xsl:for-each select="ddt:Requests/ddt:Request">

      <xsl:variable name="mRequestName" select="@Name"></xsl:variable>
      <xsl:variable name="mRequestSentBytes" select="ddt:Sent/ddt:SentBytes"></xsl:variable>
      <xsl:variable name="mRequestReceivedMinBytes" select="ddt:Received/@MinBytes"></xsl:variable>

      <!-- ************************************ -->
      <!-- -$22F187: vehicleManufacturerSparePartNumber / ASCII / Fix. 10 Bytes-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F187'">
        <xsl:if test="not($mRequestName = 'DataRead.vehicleManufacturerSparePartNumber') or
              not($mRequestReceivedMinBytes = '13') or
              not(ddt:Received/ddt:DataItem[@Name = 'vehicleManufacturerSparePartNumber']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'vehicleManufacturerSparePartNumber']/ddt:Bytes[@ascii='1'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F187</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F187</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>

      <!-- ************************************ -->
      <!-- -$22F188: vehicleManufacturerECUSoftwareNumber / ASCII / Fix. 10 Bytes-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F188'">
        <xsl:if test="not($mRequestName = 'DataRead.vehicleManufacturerECUSoftwareNumber') or
              not($mRequestReceivedMinBytes = '13') or
              not(ddt:Received/ddt:DataItem[@Name = 'vehicleManufacturerECUSoftwareNumber']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'vehicleManufacturerECUSoftwareNumber']/ddt:Bytes[@ascii='1'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F188</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F188</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>

      <!-- ************************************ -->
      <!-- $22F18A: systemSupplierIdentifier / UTF-8 / Max. 64 Bytes-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F18A'">
        <xsl:if test="not($mRequestName = 'DataRead.systemSupplierIdentifier') or
              not($mRequestReceivedMinBytes &lt;= 67) or
              not(ddt:Received/ddt:DataItem[@Name = 'systemSupplierIdentifier']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'systemSupplierIdentifier']/ddt:Bytes[@ascii='1'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F18A</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F18A</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>

      <!-- ************************************ -->
      <!-- $22F18C: ECUSerialNumber / ASCII / Fix. 20 Bytes-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F18C'">
        <xsl:if test="not($mRequestName = 'DataRead.ECUSerialNumber') or
              not($mRequestReceivedMinBytes = 23) or
              not(ddt:Received/ddt:DataItem[@Name = 'ECUSerialNumber']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'ECUSerialNumber']/ddt:Bytes[@ascii='1'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F18C</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F18C</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>

      <!-- ************************************ -->
      <!-- -$22F190: VIN / ASCII / Fix. 17 Bytes-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F190'">
        <xsl:if test="not($mRequestName = 'DataRead.VIN') or
              not($mRequestReceivedMinBytes = 20) or
              not(ddt:Received/ddt:DataItem[@Name = 'VIN']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'VIN']/ddt:Bytes[@ascii='1'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F190</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F190</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>

      <!-- ************************************ -->
      <!-- $22F191: vehicleManufacturerECUHardwareNumber / ASCII / Fix. 10 Bytes-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F191'">
        <xsl:if test="not($mRequestName = 'DataRead.vehicleManufacturerECUHardwareNumber') or
              not($mRequestReceivedMinBytes = 13) or
              not(ddt:Received/ddt:DataItem[@Name = 'vehicleManufacturerECUHardwareNumber']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'vehicleManufacturerECUHardwareNumber']/ddt:Bytes[@ascii='1'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F191</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F191</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>

      <!-- ************************************ -->
      <!--$22F194: systemSupplierECUSoftwareNumber / UTF-8 / Max. 32 Bytes-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F194'">
        <xsl:if test="not($mRequestName = 'DataRead.systemSupplierECUSoftwareNumber') or
              not($mRequestReceivedMinBytes &lt;= 35) or
              not(ddt:Received/ddt:DataItem[@Name = 'systemSupplierECUSoftwareNumber']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'systemSupplierECUSoftwareNumber']/ddt:Bytes[@ascii='1'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F194</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F194</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>

      <!-- ************************************ -->
      <!---$22F195: systemSupplierECUSoftwareVersionNumber / UTF-8 / Max. 32 Bytes-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F195'">
        <xsl:if test="not($mRequestName = 'DataRead.systemSupplierECUSoftwareVersionNumber') or
              not($mRequestReceivedMinBytes &lt;= 35) or
              not(ddt:Received/ddt:DataItem[@Name = 'systemSupplierECUSoftwareVersionNumber']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'systemSupplierECUSoftwareVersionNumber']/ddt:Bytes[@ascii='1'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F195</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F195</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>
    
      <!-- ************************************ -->
      <!---$22F1A0: Alliance specific: VDIAG / HEX / Fix. 1 Byte-->
      <!-- ************************************ -->
      <xsl:if test="$mRequestSentBytes = '22F1A0'">
        <xsl:if test="not($mRequestName = 'DataRead.diagnosticVersion') or
              not($mRequestReceivedMinBytes = 4) or
              not(ddt:Received/ddt:DataItem[@Name = 'diagnosticVersion']) or
              not(//ddt:Target/ddt:Datas/ddt:Data[@Name = 'diagnosticVersion'])
              ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_22F1A0</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>$22F1A0</b><br/>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckDID"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
      </xsl:if>

      <!-- ************************************ -->
      <!---$10XX: StartDiagnosticSession-->
      <!-- ************************************ -->
      <xsl:if test="substring($mRequestSentBytes,1,2) = '10'">
        <xsl:if test="not(starts-with($mRequestName,'StartDiagnosticSession')) or
            not(string-length($mRequestSentBytes) div 2 = 2)
            ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_StartDiagnosticSession</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="string-length($mRequestSentBytes) div 2" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/mustToBegin"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>StartDiagnosticSession</b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> = <b>2</b>
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
      </xsl:if>

      <!-- ************************************ -->
      <!---$14XXXXXX: ClearDiagnosticInformation-->
      <!-- ************************************ -->
      <xsl:if test="substring($mRequestSentBytes,1,2) = '14'">
        <xsl:if test="not(starts-with($mRequestName,'ClearDiagnosticInformation')) or
            not(string-length($mRequestSentBytes) div 2 = 4)
            ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_ClearDiagnosticInformation</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="string-length($mRequestSentBytes) div 2" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/mustToBegin"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>ClearDiagnosticInformation</b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> = <b>4</b>
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
      </xsl:if>

      <!-- ************************************ -->
      <!---$1901XX: ReadDTCInformation.ReportNumberOfDTCByStatusMask-->
      <!-- ************************************ -->
      <xsl:if test="substring($mRequestSentBytes,1,4) = '1901'">
        <xsl:if test="not(starts-with($mRequestName,'ReadDTCInformation.ReportNumberOfDTCByStatusMask')) or
            not(string-length($mRequestSentBytes) div 2 = 3)
            ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_1901</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="string-length($mRequestSentBytes)div 2" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/mustToBegin"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>ReadDTCInformation.ReportNumberOfDTCByStatusMask</b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> = <b>3</b>
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
      </xsl:if>

      <!-- ************************************ -->
      <!---$1902XX: ReadDTCInformation.ReportDTC-->
      <!-- ************************************ -->
      <xsl:if test="substring($mRequestSentBytes,1,4) = '1902'">
        <xsl:if test="not(starts-with($mRequestName,'ReadDTCInformation.ReportDTC')) or
            not(string-length($mRequestSentBytes) div 2 = 3)
            ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_1902</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="string-length($mRequestSentBytes) div 2" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/mustToBegin"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>ReadDTCInformation.ReportDTC</b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> = <b>3</b>
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
      </xsl:if>

      <!-- ************************************ -->
      <!---$1903XX: ReadDTCInformation.ReportDTCSnapshotIdentification-->
      <!-- ************************************ -->
      <xsl:if test="substring($mRequestSentBytes,1,4) = '1903'">
        <xsl:if test="not(starts-with($mRequestName,'ReadDTCInformation.ReportDTCSnapshotIdentification'))">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_1903</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/mustToBegin"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>ReadDTCInformation.ReportDTCSnapshotIdentification</b><br/>
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
      </xsl:if>

      <!-- ************************************ -->
      <!---$190AXX: ReadDTCInformation.ReportSupportedDTC-->
      <!-- ************************************ -->
      <xsl:if test="substring($mRequestSentBytes,1,4) = '190A'">
        <xsl:if test="not(starts-with($mRequestName,'ReadDTCInformation.ReportSupportedDTC'))">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_UDS_190A</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/mustToBegin"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b>ReadDTCInformation.ReportSupportedDTC</b><br/>
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
      </xsl:if>

      <!-- ************************************ -->
      <!---$31: RoutineControl-->
      <!-- ************************************ -->
<!--
      <xsl:if test="substring($mRequestSentBytes,1,2) = '31'">
        <xsl:choose>
          <xsl:when test="$mSpecidication='UDS'">
            <xsl:variable name="mRID" select="substring($mRequestSentBytes, 5, 4)"/>
          </xsl:when>
          <xsl:otherwise>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
-->
      <!-- ************************************ -->
      <!---$2F: OutputControl-->
      <!-- ************************************ -->
      <xsl:if test="substring($mRequestSentBytes,1,2) = '2F'">
        <!-- -pour tous les DID déclarés dans la liste des DID 2F, les services 22 de ces DID existent ?-->
        <xsl:variable name="mDid1" select="substring($mRequestSentBytes,3,2)"></xsl:variable>
        <xsl:variable name="mDid2" select="substring($mRequestSentBytes,5,2)"></xsl:variable>
        <xsl:variable name="mDidReadRequest" select="concat(concat('22',$mDid1),$mDid2)"></xsl:variable>
        
        <xsl:if test="not($mDidReadRequest = '220000') and count(//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,6) = $mDidReadRequest])&lt;=0">
          <xsl:call-template name="warning">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_WAR_UDS_MissingReadDID</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <xsl:value-of select="$mRequestSentBytes" />
            </xsl:with-param>
            <xsl:with-param name="info">DID $<xsl:value-of select="$mDidReadRequest" />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
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
        <!-- -fin test DIDs -->
        <!-- - test des OutputPermanentControlList -->
        <xsl:choose>
          <xsl:when test="starts-with($mRequestName,'OutputControl.Start') or starts-with($mRequestName,'OutputControl.Stop')
              ">
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName and ddt:DossierMaintenabilite] and (not(count(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName  and ddt:DossierMaintenabilite]/ddt:Sent/ddt:DataItem[@Name='OutputPermanentControlList' and @FirstByte = '2' ])&gt;=1)	or
              not(count(//ddt:Target/ddt:Datas/ddt:Data[@Name='OutputPermanentControlList']/ddt:Bits[@count='16']/ddt:List/ddt:Item)&gt; 0))
              ">
               
              <xsl:variable name="mError">
                <xsl:choose>
                  <xsl:when test="not(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName  and ddt:DossierMaintenabilite]/ddt:Sent/ddt:DataItem[@Name='OutputPermanentControlList']) or
                          not(//ddt:Target/ddt:Datas/ddt:Data[@Name='OutputPermanentControlList'])
                          ">
                    <b>(OutputPermanentControlList)</b> :<xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    (OutputPermanentControlList)
                    <xsl:if test="not(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName and ddt:DossierMaintenabilite]/ddt:Sent/ddt:DataItem[@Name='OutputPermanentControlList' and @FirstByte = '2' ])">
                       - <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> != 2
                    </xsl:if>
                    <xsl:if test="not(//ddt:Target/ddt:Datas/ddt:Data[@Name='OutputPermanentControlList']/ddt:Bits[@count='16'])">
                       - <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> != 2<br/>
                    </xsl:if>
                    <xsl:if test="not(count(//ddt:Target/ddt:Datas/ddt:Data[@Name='OutputPermanentControlList']/ddt:Bits/ddt:List/ddt:Item)&gt; 0)">
                       - <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddListItems" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> <xsl:value-of select="$mError" />
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDataInRequest"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
            <xsl:if test="//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName and ddt:DossierMaintenabilite] and (not(count(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName and ddt:DossierMaintenabilite]/ddt:Sent/ddt:DataItem[@Name='OutputControlCommand' and @FirstByte = '4' ])&gt;=1)	or
              not(count(//ddt:Target/ddt:Datas/ddt:Data[@Name='OutputControlCommand']/ddt:Bits/ddt:List/ddt:Item)&gt;=2))
              ">
              <xsl:variable name="mError">
                <xsl:choose>
                  <xsl:when test="not(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName and ddt:DossierMaintenabilite]/ddt:Sent/ddt:DataItem[@Name='OutputControlCommand']) or
                          not(//ddt:Target/ddt:Datas/ddt:Data[@Name='OutputControlCommand'])
                          ">
                    <b>(OutputControlCommand)</b> :<xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    (OutputControlCommand)
                    <xsl:if test="not(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName and ddt:DossierMaintenabilite]/ddt:Sent/ddt:DataItem[@Name='OutputControlCommand' and @FirstByte = '4' ])">
                       - <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> != 4
                    </xsl:if>
                    <xsl:if test="not(count(//ddt:Target/ddt:Datas/ddt:Data[@Name='OutputControlCommand']/ddt:Bits/ddt:List/ddt:Item)&gt;=2)">
                       - <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddListItems" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_UDS_OutputControl_OutputControlCommand</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> <xsl:value-of select="$mError" />
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDataInRequest"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Spec_UDS.xsl: template check_Spec_UDS ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
