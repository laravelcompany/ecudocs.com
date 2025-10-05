<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:ddt="http://www-diag.renault.com/2002/ECU"
xmlns:ds="http://www-diag.renault.com/2002/screens"
xmlns:local="#local-functions">

  <!-- ******************************************** -->
  <!-- Contrôles Specifiques à Daimler et Alliance  -->
  <!-- ******************************************** -->
  <xsl:template name="check_DaimlerAlliance">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template check_DaimlerAlliance starts')"/></logmsg>    

    <!-- ****************** -->
    <!-- Check <AutoIdents> -->
    <!-- ****************** -->
    <xsl:choose>
      <xsl:when test="not(count(//ddt:Target/ddt:AutoIdents/ddt:AutoIdent)&gt;0)">
        <!-- ****************************************** -->
        <!-- Error ME004 : DAIMLER_ERR_MissingAutoIdent -->
        <!-- ****************************************** -->
        <xsl:call-template name="error">
          <xsl:with-param name="type">DAIMLER</xsl:with-param>
          <xsl:with-param name="chapter">DAIMLER_ERR_MissingAutoIdent</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/autoident" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionMissingAutoident" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="//ddt:Target/ddt:AutoIdents/ddt:AutoIdent">
          <xsl:if test="@Supplier='000' or @Soft='0000'">
            <!-- **************************************** -->
            <!-- Error ME005 : DAIMLER_ERR_WrongAutoIdent -->
            <!-- **************************************** -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DAIMLER</xsl:with-param>
              <xsl:with-param name="chapter">DAIMLER_ERR_WrongAutoIdent</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/autoident" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>: Supplier = <b><xsl:value-of select="@Supplier" /></b>, Soft = <b><xsl:value-of select="@Soft" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionWrongAutoident" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>

    <!-- *************************************************************** -->
    <!-- Check Daimler identification request is defined for spec A & BC -->
    <!-- *************************************************************** -->
    <xsl:if test="($mSpecification = 'DiagOnCanA') or ($mSpecification = 'DiagOnCanBC')">
      <xsl:if test="count(ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent[ddt:SentBytes = '21EF']) &lt;= 0">
        <!-- ************************************** -->
        <!-- Error ME008 : DAIMLER_ERR_IdentRequest -->
        <!-- ************************************** -->
        <xsl:call-template name="error">
          <xsl:with-param name="type">DAIMLER</xsl:with-param>
          <xsl:with-param name="chapter">DAIMLER_ERR_IdentRequest</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>DAIMLER Identification ($21EF)</b>
          </xsl:with-param>
          <xsl:with-param name="info">
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
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>

    <!-- ************************************************************ -->
    <!-- Check Daimler identification request is defined for spec UDS -->
    <!-- ************************************************************ -->
    <xsl:if test="$mSpecification = 'UDS'">
      <xsl:variable name="mRequestF111" select="ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and @Name='DataRead.VehicleManufacturerECUHardwareNumber_DAI']/ddt:Sent[ddt:SentBytes = '22F111']" />
      <xsl:variable name="mRequestF121" select="ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and @Name='DataRead.VehicleManufacturerECUSoftwareNumber_DAI']/ddt:Sent[ddt:SentBytes = '22F121']" />

      <!-- *********************************** -->
      <!-- Error ME019 : DAIMLER_ERR_IdentF111 -->
      <!-- *********************************** -->
      <xsl:choose>
        <xsl:when test="string($mRequestF111) = ''">
          <!-- Missing request -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">DAIMLER</xsl:with-param>
            <xsl:with-param name="chapter">DAIMLER_ERR_IdentF111</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>DataRead.VehicleManufacturerECUHardwareNumber_DAI</b> ($22F111)
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMaintenabilityRepportUnckecked" />
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
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="mHardwareNb" select="$mRequestF111/../ddt:Received/ddt:DataItem[@Name='VehicleManufacturerECUHardwareNumber_DAI']" />
          <xsl:choose>
            <!-- Missing data -->
            <xsl:when test="string($mHardwareNb/@Name) = ''">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_IdentF111</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>DataRead.VehicleManufacturerECUHardwareNumber_DAI</b> ($22F111)
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template><b> VehicleManufacturerECUSoftwareNumber_DAI</b>
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
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <!-- Check for position, format and length -->
            <xsl:otherwise>
              <xsl:variable name="mData" select="key('allDatas',$mHardwareNb/@Name)" />
              <xsl:variable name="mBitOffset">
                <xsl:call-template name="GetBitOffset">
                  <xsl:with-param name="dataItem" select="$mHardwareNb" />
                </xsl:call-template>
              </xsl:variable>
              <xsl:variable name="mFormat">
                <xsl:call-template name="GetDataFormat">
                  <xsl:with-param name="data" select="$mData" />
                </xsl:call-template>
              </xsl:variable>
              <xsl:variable name="mBitLength">
                <xsl:call-template name="GetDataBitLength">
                  <xsl:with-param name="data" select="$mData" />
                </xsl:call-template>
              </xsl:variable>
              <!-- Invalid data position -->
              <xsl:if test="$mBitOffset != 0 or $mHardwareNb/@FirstByte != 4">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_IdentF111</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>DataRead.VehicleManufacturerECUHardwareNumber_DAI</b> ($22F111)
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>VehicleManufacturerECUHardwareNumber_DAI</b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidDataSizePos" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br />
                  FirstByte : <b><xsl:value-of select="$mHardwareNb/@FirstByte" /></b>
                  <br />
                  BitOffset : <b><xsl:value-of select="$mBitOffset" /></b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br />
                  FirstByte : <b>4</b>
                  <br />
                  BitOffset : <b>0</b>
                </xsl:with-param>
              </xsl:call-template>
              </xsl:if>
              <!-- Invalide length -->
              <xsl:if test="$mBitLength !=80">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_IdentF111</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>DataRead.VehicleManufacturerECUHardwareNumber_DAI</b> ($22F111)
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>VehicleManufacturerECUHardwareNumber_DAI</b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataLength" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="$mBitLength" /></b> bits
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>80</b> bits
                </xsl:with-param>
              </xsl:call-template>
              </xsl:if>
              <!-- Invalid format -->
              <xsl:if test="$mFormat !='ASCII'">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_IdentF111</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>DataRead.VehicleManufacturerECUHardwareNumber_DAI</b> ($22F111)
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>VehicleManufacturerECUHardwareNumber_DAI</b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBadFormat" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="$mFormat" /></b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>ASCII</b>
                </xsl:with-param>
              </xsl:call-template>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>

      <!-- *********************************** -->
      <!-- Error ME020 : DAIMLER_ERR_IdentF121 -->
      <!-- *********************************** -->
      <xsl:choose>
        <xsl:when test="string($mRequestF121) = ''">
          <!-- Missing request -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">DAIMLER</xsl:with-param>
            <xsl:with-param name="chapter">DAIMLER_ERR_IdentF121</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>DataRead.VehicleManufacturerECUSoftwareNumber_DAI</b> ($22F121)
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMaintenabilityRepportUnckecked" />
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
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="mSoftwareNb" select="$mRequestF121/../ddt:Received/ddt:DataItem[@Name='VehicleManufacturerECUSoftwareNumber_DAI']" />
          <xsl:choose>
            <!-- Missing data -->
            <xsl:when test="string($mSoftwareNb/@Name) = ''">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_IdentF121</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>DataRead.VehicleManufacturerECUSoftwareNumber_DAI</b> ($22F121)
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template><b> VehicleManufacturerECUSoftwareNumber_DAI</b>
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
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <!-- Check for position, format and length -->
            <xsl:otherwise>
              <xsl:variable name="mData" select="key('allDatas',$mSoftwareNb/@Name)" />
              <xsl:variable name="mBitOffset">
                <xsl:call-template name="GetBitOffset">
                  <xsl:with-param name="dataItem" select="$mSoftwareNb" />
                </xsl:call-template>
              </xsl:variable>
              <xsl:variable name="mFormat">
                <xsl:call-template name="GetDataFormat">
                  <xsl:with-param name="data" select="$mData" />
                </xsl:call-template>
              </xsl:variable>
              <xsl:variable name="mBitLength">
                <xsl:call-template name="GetDataBitLength">
                  <xsl:with-param name="data" select="$mData" />
                </xsl:call-template>
              </xsl:variable>
              <!-- Invalid data position -->
              <xsl:if test="$mBitOffset != 0 or $mSoftwareNb/@FirstByte != 4">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_IdentF121</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>DataRead.VehicleManufacturerECUSoftwareNumber_DAI</b> ($22F121)
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>VehicleManufacturerECUSoftwareNumber_DAI</b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidDataSizePos" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br />
                  FirstByte : <b><xsl:value-of select="$mSoftwareNb/@FirstByte" /></b>
                  <br />
                  BitOffset : <b><xsl:value-of select="$mBitOffset" /></b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br />
                  FirstByte : <b>4</b>
                  <br />
                  BitOffset : <b>0</b>
                </xsl:with-param>
              </xsl:call-template>
              </xsl:if>
              <!-- Invalide length -->
              <xsl:if test="$mBitLength !=160">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_IdentF121</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>DataRead.VehicleManufacturerECUSoftwareNumber_DAI</b> ($22F121)
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>VehicleManufacturerECUSoftwareNumber_DAI</b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataLength" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="$mBitLength" /></b> bits
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>160</b> bits
                </xsl:with-param>
              </xsl:call-template>
              </xsl:if>
              <!-- Invalid format -->
              <xsl:if test="$mFormat !='ASCII'">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_IdentF121</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>DataRead.VehicleManufacturerECUSoftwareNumber_DAI</b> ($22F121)
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>VehicleManufacturerECUSoftwareNumber_DAI</b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBadFormat" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="$mFormat" /></b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>ASCII</b>
                </xsl:with-param>
              </xsl:call-template>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <!-- *********************************** -->
    <!-- Check generic OutputControl request -->
    <!-- *********************************** -->
    <!-- STEP 1 : check if generic request exist -->
    <xsl:variable name="mOutputControlGenericRequest2F">
      <xsl:choose>
        <xsl:when test="$mSpecification = 'UDS'">
          <xsl:value-of select="count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and @Name = 'OutputControl']/ddt:Sent[starts-with(ddt:SentBytes,'2F')])" />
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="mOutputControlGenericRequest30">
      <xsl:choose>
        <xsl:when test="$mSpecification != 'UDS'">
          <xsl:value-of select="count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and local:LowerSpaceRemove(string(@Name)) = 'outputcontrol']/ddt:Sent[starts-with(ddt:SentBytes,'30')])" />
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- STEP 2 : check generic request existence & conformity -->
    <!--     Algorithm :
          if Spec UDS
            if generic request $2F 'OutputControl' exist
              if data 'OutputPermanentControlList' is not define on byte 2 on generic request 'OutputControl'
                == > Error ME013 DAIMLER_ERR_OutputControl_GenericRequest (wrong OutputControl definition)
              else
                foreach DID define on data 'OutputPermanentControlList' without a reading request $22
                  == > Error ME015 DAIMLER_ERR_OutputPermanentControlList_Request
                endforeach
              endif
            else (generic request $2F 'OutputControl' do not exist)
              if exist at least a $2F request
                == > Error ME013 DAIMLER_ERR_OutputControl_GenericRequest (missing request 'OutputControl')
              endif
            endif
          else (not Spec UDS)
            if generic request $30 exist
              if neither datas 'OutputPermanentControlList' nor 'OutputTemporaryControlList' are define on byte 2 on generic request 'OutputControl'
                == > Error ME013 DAIMLER_ERR_OutputControl_GenericRequest (wrong OutputControl definition)
              endif
            else (generic request $30 'OutputControl' do not exist)
              if exist at least a $30 request
                == > Error ME013 DAIMLER_ERR_OutputControl_GenericRequest (missing request 'OutputControl')
            endif
          endif
    -->
    <xsl:choose>
      <xsl:when test="$mSpecification = 'UDS'">
        <xsl:choose>
          <xsl:when test="$mOutputControlGenericRequest2F &gt; 0">
            <!-- Generic Output Control request $2F exist, looking for OutputPermanentControlList data -->
            <xsl:choose>
              <xsl:when test = "count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and @Name = 'OutputControl']/ddt:Sent/ddt:DataItem[local:LowerSpaceRemove(string(@Name))='outputpermanentcontrollist' and @FirstByte = '2']) = 0">
                <!-- *********************************************************************************************** -->
                <!-- Error ME013 : DAIMLER_ERR_OutputControl_GenericRequest (missing OutputPermanentControlList data)-->
                <!-- *********************************************************************************************** -->
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DAIMLER</xsl:with-param>
                  <xsl:with-param name="chapter">DAIMLER_ERR_OutputControl_GenericRequest</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/genericRequest" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b> OutputControl $2F</b>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b> OutputPermanentControlList</b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddGenericRequestOutputControl" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <!-- Generic OutputControl request exist with OutputPermanentControlList data                        -->
                <!--  == > Check each DID define on OutputPermanentControlList data have its own reading request $22 -->
                <xsl:for-each select="//ddt:Target/ddt:Datas/ddt:Data[local:LowerSpaceRemove(string(@Name)) = 'outputpermanentcontrollist']/ddt:Bits/ddt:List/ddt:Item">
                  <xsl:variable name="mRequestReadDid" select="concat('22',local:ToHex(string(@Value),4))"></xsl:variable>
                  <xsl:if test="not(//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[starts-with(ddt:SentBytes,$mRequestReadDid)])">
                    <!-- ************************************************************ -->
                    <!-- Error ME015 : DAIMLER_ERR_OutputPermanentControlList_Request -->
                    <!-- ************************************************************ -->
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DAIMLER</xsl:with-param>
                      <xsl:with-param name="chapter">DAIMLER_ERR_OutputPermanentControlList_Request</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> $<xsl:value-of select="$mRequestReadDid" />
                      </xsl:with-param>
                      <xsl:with-param name="info">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddOutputPermanentControlListRequest" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <!-- Generic Output Control request $2F do not exist, looking for other $2F requests -->
            <xsl:if test="count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent[starts-with(ddt:SentBytes,'2F')]) &gt;= 1">
              <!-- **************************************************************************** -->
              <!-- Error ME013 : DAIMLER_ERR_OutputControl_GenericRequest (missing generic $2F) -->
              <!-- **************************************************************************** -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_OutputControl_GenericRequest</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/genericRequest" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> OutputControl $2F
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddGenericRequestOutputControl" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$mOutputControlGenericRequest30 &gt; 0">
            <!-- Generic Output Control request $30 exist, looking for OutputPermanentControlList and OutputTemporaryControlList datas -->
            <xsl:if test="  (count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and local:LowerSpaceRemove(string(@Name)) = 'outputcontrol']/ddt:Sent/ddt:DataItem[local:LowerSpaceRemove(string(@Name))='outputpermanentcontrollist' and @FirstByte = '2']) = 0)
                    and
                    (count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and local:LowerSpaceRemove(string(@Name)) = 'outputcontrol']/ddt:Sent/ddt:DataItem[local:LowerSpaceRemove(string(@Name))='outputtemporarycontrollist' and @FirstByte = '2' ]) = 0)">
              <!-- ****************************************************************************************************************************** -->
              <!-- Error ME013 : DAIMLER_ERR_OutputControl_GenericRequest (missing OutputPermanentControlList and OutputTemporaryControlList data)-->
              <!-- ****************************************************************************************************************************** -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_OutputControl_GenericRequest</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/genericRequest" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b> OutputControl $30</b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b> OutputPermanentControlList</b>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/and" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b>OutputTemporaryControlList</b>
                  <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAreMissing" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidPosition" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddGenericRequestOutputControl" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <!-- Generic Output Control request $30 do not exist, looking for other $30 requests -->
            <xsl:if test="count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent[starts-with(ddt:SentBytes,'30')]) &gt;= 1">
              <!-- **************************************************************************** -->
              <!-- Error ME013 : DAIMLER_ERR_OutputControl_GenericRequest (missing generic $30) -->
              <!-- **************************************************************************** -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DAIMLER</xsl:with-param>
                <xsl:with-param name="chapter">DAIMLER_ERR_OutputControl_GenericRequest</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/genericRequest" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b> OutputControl $30</b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddGenericRequestOutputControl" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>

    <!-- ************** -->
    <!-- Check Requests -->
    <!-- ************** -->
    <xsl:for-each select="ddt:Requests/ddt:Request">
      <xsl:variable name="mRequestName" select="@Name" />
      <!-- Request information -->
      <xsl:variable name="mRequestSentBytes" select="ddt:Sent/ddt:SentBytes" />
      <xsl:variable name="mSend0" select="substring($mRequestSentBytes,1,2)" />
      <xsl:variable name="mSend1" select="substring($mRequestSentBytes,3,2)" />
      <xsl:variable name="mSend2" select="substring($mRequestSentBytes,5,2)" />
      <xsl:variable name="mSend3" select="substring($mRequestSentBytes,7,2)" />
      <xsl:variable name="mRequesteByteNumber" select="string-length($mRequestSentBytes) div 2" />
      <!-- Response information -->
      <xsl:variable name="mRequestReceivedReplyBytes" select="ddt:Received/ddt:ReplyBytes" />
      <xsl:variable name="mRequestMinBytes" select="ddt:Received/@MinBytes" />
      <xsl:variable name="mReply0" select="substring($mRequestReceivedReplyBytes,1,2)" />
      <xsl:variable name="mReply1" select="substring($mRequestReceivedReplyBytes,3,2)" />
      <xsl:variable name="mReply2" select="substring($mRequestReceivedReplyBytes,5,2)" />
      <xsl:variable name="mReply3" select="substring($mRequestReceivedReplyBytes,7,2)" />
      <xsl:variable name="mResponseByteNumber" select="string-length($mRequestReceivedReplyBytes) div 2" />

      <!-- ************************************* -->
      <!-- Error ME017 : DAIMLER_ERR_RequestName -->
      <!-- ************************************* -->
      <!-- Check <Request> attribute Name value has a length less or equal than 127 characters -->
      <xsl:if test="ddt:DossierMaintenabilite and string-length($mRequestName)&gt;127">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DAIMLER</xsl:with-param>
          <xsl:with-param name="chapter">DAIMLER_ERR_RequestName</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <xsl:value-of select="string-length($mRequestName)" />
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNormalizedName" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="string-length($mRequestName)" /></b>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAuthorizedLength" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>127</b><br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="not ($mSend0 = '')">
        <!-- Sending SID exist -->

        <!-- ***************************** -->
        <!-- Error ME001 : DAIMLER_ERR_SID -->
        <!-- ***************************** -->
        <!-- Check received SID value is the transmit SID + $40 -->
        <xsl:if test="ddt:DossierMaintenabilite and $mReply0 != local:ToHex(local:ToDec($mSend0)+64,2)">
          <xsl:call-template name="error">
            <xsl:with-param name="type">DAIMLER</xsl:with-param>
            <xsl:with-param name="chapter">DAIMLER_ERR_SID</xsl:with-param>
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
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)" /></pre></b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template><b> n°1 </b>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>:
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template><b> n°1 </b>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> = <b>$<xsl:value-of select="local:ToHex(local:ToDec($mSend0)+64,2)" /></b>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>

        <!-- ********************* -->
        <!-- CHECK SERVICES FORMAT -->
        <!-- ********************* -->
        <xsl:choose>
          <!-- =============================================================== -->
          <!-- SERVICE $10 : StartDiagnosticSession / DiagnosticSessionControl -->
          <!-- =============================================================== -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '10'">
            <xsl:choose>
              <!-- Diagnostic session type value missing on sending bytes -->
              <xsl:when test="$mSend1 = ''">
                <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                  <xsl:with-param name="Request" select="." />
                  <xsl:with-param name="ByteNumber" select="2" />
                </xsl:call-template>
              </xsl:when>
              <!-- Reply diagnostic session type value byte differt from sending one -->
              <xsl:when test="$mReply1 != $mSend1">
                <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                  <xsl:with-param name="Request" select="." />
                  <xsl:with-param name="ByteNumber" select="2" />
                  <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                </xsl:call-template>
              </xsl:when>
              <!-- If UDS ECU, need to check existing DataItem to verify size, else (no UDs or no DataItem), response is 2 bytes length -->
              <xsl:when test="$mSpecification = 'UDS' and ddt:Received/ddt:DataItem">
                <xsl:if test="$mResponseByteNumber &lt; 2">
                  <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$mRequestMinBytes != '2'">
                  <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedMinByte" select="2" />
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="$mResponseByteNumber != 2">
                  <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <!-- ====================== -->
          <!-- SERVICE $11 : ECUReset -->
          <!-- ====================== -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '11'">
            <xsl:choose>
              <!-- Reset type value missing on sending bytes -->
              <xsl:when test="$mSend1 =''">
                <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                  <xsl:with-param name="Request" select="." />
                  <xsl:with-param name="ByteNumber" select="2" />
                </xsl:call-template>
              </xsl:when>
              <!-- on ECU UDS or DiagOnCan spec BC, reply reset type should be the same as sending one -->
              <xsl:when test= "($mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC') and ($mSend1 != $mReply1)">
                <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                  <xsl:with-param name="Request" select="." />
                  <xsl:with-param name="ByteNumber" select="2" />
                  <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                </xsl:call-template>
              </xsl:when>
              <!-- on ECU UDS or DiagOnCan spec BC, if reset type is 0x04 enableRapidPowerShutDown, response is 3 bytes length -->
              <xsl:when test="($mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC') and ($mReply1='04')">
                <xsl:if test="$mRequestMinBytes != '3'">
                  <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedMinByte" select="3" />
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="$mResponseByteNumber != 3">
                  <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <!-- if ECU is UDS or BC with a reset type differt from 0x04 or ECU is not UDS or BC then response is 2 bytes length -->
                <xsl:if test="$mRequestMinBytes != '2'">
                  <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedMinByte" select="2" />
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="$mResponseByteNumber != 2">
                  <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <!-- ================================= -->
          <!-- SERVICE $12 : ReadFreezeFrameData -->
          <!-- ================================= -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '12'">
            <!-- Service $12 do not exist for ECU on DiagOnCan BC or UDS -->
            <xsl:if test="not($mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC')">
              <xsl:choose>
                <!-- FreezeFrameNumber value missing on sending bytes -->
                <xsl:when test="$mSend1 =''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply FreezeFrameNumber value byte differt from sending one -->
                <xsl:when test="$mReply1 != $mSend1">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                    <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                  </xsl:call-template>
                </xsl:when>
                <!-- If exist DataItem, response should be at least greater than 1 byte -->
                <xsl:when test="ddt:Received/ddt:DataItem">
                  <xsl:if test="$mResponseByteNumber &lt; 2">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Without DataItem, response is 2 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '2'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 2">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- ======================================== -->
          <!-- SERVICE $14 : ClearDiagnosticInformation -->
          <!-- ======================================== -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '14'">
            <xsl:choose>
              <!-- Service $14 response do not have same structure for UDS on DiagOnCan BC/UDS vs KWP2000 or DiagOnCanSpec A -->
              <xsl:when test="$mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC'">
                <!-- Only 1 byte Received -->
                <xsl:if test="$mRequestMinBytes != '1'">
                  <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedMinByte" select="1" />
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="$mResponseByteNumber != 1">
                  <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedRxByteNumber" select="1" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <!-- KWP2000 or DiagOnCanSpec A -->
                <xsl:choose>
                  <!-- Incomplete GroupOfDTC value -->
                  <xsl:when test="$mSend1 = ''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="'2/3'" />
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="$mSend2 = ''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="3" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- Received GroupOfDTC difert from sending one -->
                  <xsl:when test="($mSend1 != $mReply1) or ($mSend2 != $mReply2)">
                    <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="'2/3'" />
                      <xsl:with-param name="ExpectedByteValue" select="concat($mSend1,$mSend2)" />
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- Response is 3 bytes lenght (Reply byte && Min byte) -->
                    <xsl:if test="$mRequestMinBytes != '3'">
                      <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedMinByte" select="3" />
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$mResponseByteNumber != 3">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <!-- ================================================ -->
          <!-- SERVICE $17 : ReadStatusOfDiagnosticTroubleCodes -->
          <!-- ================================================ -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '17'">
            <!-- Service $17 do not exist for ECU on DiagOnCan BC or UDS -->
            <xsl:if test="not ($mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC')">
              <xsl:choose>
                <!-- If exist DataItem, response should be at least greater than 1 byte -->
                <xsl:when test="ddt:Received/ddt:DataItem">
                  <xsl:if test="$mResponseByteNumber &lt; 1">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="1" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Without DataItem, response is 1 byte lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '1'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="1" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 1">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="1" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- ================================ -->
          <!-- SERVICE $19 : ReadDTCInformation -->
          <!-- ================================ -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '19'">
            <!-- Service $19 exist only for ECU on DiagOnCan BC or UDS -->
            <xsl:if test="$mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC'">
              <xsl:choose>
                <!-- Sub-function value missing on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply sub-function value byte differt from sending one -->
                <xsl:when test="$mReply1 != $mSend1">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                    <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                  </xsl:call-template>
                </xsl:when>
                <!-- If exist DataItem, response should be at least greater than 2 bytes -->
                <xsl:when test="ddt:Received/ddt:DataItem">
                  <xsl:if test="$mResponseByteNumber &lt; 2">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Without DataItem, response is 2 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '2'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 2">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- ======================================= -->
          <!-- SERVICE $21 : ReadDataByLocalIdentifier -->
          <!-- ======================================= -->
          <xsl:when test="$mSend0 = '21'">
            <!-- Service $21 do not exist for ECU on UDS -->
            <xsl:if test="$mSpecification != 'UDS'">
              <xsl:if test="$mRequesteByteNumber &gt; 2">
                <!-- ********************************* -->
                <!-- AE016 ALLIANCE_ERR_RequestTooLong -->
                <!-- ********************************* -->
                <!-- Frame size -->
                <xsl:call-template name="error">
                  <xsl:with-param name="type">ALLIANCE</xsl:with-param>
                  <xsl:with-param name="chapter">ALLIANCE_ERR_RequestTooLong</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <br/>
                    <b><xsl:value-of select="$mRequestName"/></b>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotExpectedSentBytes" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mRequestSentBytes"/></b>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedFormat" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mSend0"/><xsl:value-of select="$mSend1"/></b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectRequestFrame" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:if>
              <xsl:for-each select="ddt:Sent/ddt:DataItem">
                <xsl:variable name="stopBitPosition">
                  <xsl:call-template name="GetStopBitPosition">
                    <xsl:with-param name="dataItem" select="." />
                  </xsl:call-template>
                </xsl:variable>
                <xsl:if test="$stopBitPosition &gt; 16">
                  <!-- ********************************* -->
                  <!-- AE016 ALLIANCE_ERR_RequestTooLong -->
                  <!-- ********************************* -->
                  <!-- DataItem position -->
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">ALLIANCE</xsl:with-param>
                    <xsl:with-param name="chapter">ALLIANCE_ERR_RequestTooLong</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <br/>
                      <b><xsl:value-of select="$mRequestName"/></b>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="./@Name"/></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsOutside" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataStopBitPositionValue" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$stopBitPosition"/></b>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMaxAllowedStopBitPosition" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>16</b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectRequestDataItem" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>
              </xsl:for-each>
            
              <xsl:if test="ddt:DossierMaintenabilite">
                <xsl:choose>
                  <!-- LID value missing on sending bytes -->
                  <xsl:when test="$mSend1 = ''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- Reply LID value byte differt from sending one -->
                  <xsl:when test="$mReply1 != $mSend1">
                    <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="2" />
                      <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- Check Daimler identification request $21EF -->
                  <xsl:when test="$mSend1 = 'EF' and not (ddt:Received/ddt:DataItem[@FirstByte = '3'] and ddt:Received/ddt:DataItem[@FirstByte = '13'])">
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DAIMLER</xsl:with-param>
                      <xsl:with-param name="chapter">DAIMLER_ERR_IdentRequest</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> : <b>DAIMLER Identification ($21EF)</b>
                      </xsl:with-param>
                      <xsl:with-param name="info">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> : <b>Hardware and/or Software number </b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionWrongDaimlerIdent" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                  <!-- If exist DataItem, response should be at least greater than 2 bytes -->
                  <xsl:when test="ddt:Received/ddt:DataItem">
                    <xsl:if test="$mResponseByteNumber &lt; 2">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- Without DataItem, response is 2 bytes lenght (Reply byte && Min byte) -->
                    <xsl:if test="$mRequestMinBytes != '2'">
                      <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedMinByte" select="2" />
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$mResponseByteNumber != 2">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </xsl:if>
          </xsl:when>

          <!-- ======================================= -->
          <!-- SERVICE $22 : ReadDataByIdentifier -->
          <!-- ======================================= -->
          <xsl:when test="$mSend0 = '22'">
            <!-- Service $22 only for ECU DiagOnCAN spec B/C or UDS -->
            <xsl:if test="$mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC'">
              <xsl:if test="$mRequesteByteNumber &gt; 3">
                <!-- ********************************* -->
                <!-- AE016 ALLIANCE_ERR_RequestTooLong -->
                <!-- ********************************* -->
                <!-- Frame size -->
                <xsl:call-template name="error">
                  <xsl:with-param name="type">ALLIANCE</xsl:with-param>
                  <xsl:with-param name="chapter">ALLIANCE_ERR_RequestTooLong</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <br/>
                    <b><xsl:value-of select="$mRequestName"/></b>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotExpectedSentBytes" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mRequestSentBytes"/></b>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedFormat" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mSend0"/><xsl:value-of select="$mSend1"/><xsl:value-of select="$mSend2"/></b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectRequestFrame" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:if>
              <xsl:for-each select="ddt:Sent/ddt:DataItem">
                <xsl:variable name="stopBitPosition">
                  <xsl:call-template name="GetStopBitPosition">
                    <xsl:with-param name="dataItem" select="." />
                  </xsl:call-template>
                </xsl:variable>
                <xsl:if test="$stopBitPosition &gt; 24">
                  <!-- ********************************* -->
                  <!-- AE016 ALLIANCE_ERR_RequestTooLong -->
                  <!-- ********************************* -->
                  <!-- DataItem position -->
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">ALLIANCE</xsl:with-param>
                    <xsl:with-param name="chapter">ALLIANCE_ERR_RequestTooLong</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <br/>
                      <b><xsl:value-of select="$mRequestName"/></b>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="./@Name"/></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsOutside" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataStopBitPositionValue" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$stopBitPosition"/></b>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMaxAllowedStopBitPosition" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>24</b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectRequestDataItem" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>
              </xsl:for-each>

              <xsl:if test="ddt:DossierMaintenabilite">
                <xsl:choose>
                  <!-- DID value missing or incomplete on sending bytes -->
                  <xsl:when test="$mSend1 = ''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="'2/3'" />
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="$mSend2 = ''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="'3'" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- Reply DID differt from sending one -->
                  <xsl:when test="($mSend1 != $mReply1) or ($mSend2 != $mReply2)">
                    <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="'2/3'" />
                      <xsl:with-param name="ExpectedByteValue" select="concat($mSend1,$mSend2)" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- If exist DataItem, response should be at least greater than 3 byte -->
                  <xsl:when test="ddt:Received/ddt:DataItem">
                    <xsl:if test="$mResponseByteNumber &lt; 3">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- Without DataItem, response is 3 byte lenght (Reply byte && Min byte) -->
                    <xsl:if test="$mRequestMinBytes != '3'">
                      <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedMinByte" select="3" />
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$mResponseByteNumber != 3">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </xsl:if>
          </xsl:when>

          <!-- ========================================= -->
          <!-- SERVICE $24 : ReadScalingDataByIdentifier -->
          <!-- ========================================= -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '24'">
            <!-- Service $24 only for ECU DiagOnCAN spec B/C or UDS -->
            <xsl:if test="$mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC'">
              <xsl:choose>
                <!-- DID value missing or incomplete on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2/3'" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$mSend2 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'3'" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply DID differt from sending one -->
                <xsl:when test="($mSend1 != $mReply1) or ($mSend2 != $mReply2)">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2/3'" />
                    <xsl:with-param name="ExpectedByteValue" select="concat($mSend1,$mSend2)" />
                  </xsl:call-template>
                </xsl:when>
              <!-- If exist DataItem, response should be at least greater than 3 byte -->
              <xsl:when test="ddt:Received/ddt:DataItem">
                <xsl:if test="$mResponseByteNumber &lt; 3">
                  <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:when>
                <xsl:otherwise>
                  <!-- Without DataItem, response is 3 byte lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '3'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 3">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- ============================ -->
          <!-- SERVICE $27 : SecurityAccess -->
          <!-- ============================ -->
          <!-- Service manage by daimler convertor. -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '27'">
            <!-- ***************************************** -->
            <!-- Error ME018 : DAIMLER_ERR_RequestErrorSID -->
            <!-- ***************************************** -->
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
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoSID" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoManageByConverter" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                : <b>$<xsl:value-of select="$mSend0" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRemoveMaintenabilityReport" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>

          <!-- ================================== -->
          <!-- SERVICE $28 : CommunicationControl -->
          <!-- ================================== -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '28'">
            <!-- Service $28 only for ECU DiagOnCAN spec B/C or UDS -->
            <xsl:if test="$mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC'">
              <xsl:choose>
                <!-- ControlType value missing on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2'" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply ControlType differt from sending one -->
                <xsl:when test="$mSend1 != $mReply1">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2'" />
                    <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Response is 3 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '3'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 3">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- ================================================= -->
          <!-- SERVICE $30 : InputOutputControlByLocalIdentifier -->
          <!-- ================================================= -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '30'">
            <!-- Service $30 do not exist for ECU on UDS -->
            <xsl:if test="$mSpecification != 'UDS'">
              <xsl:choose>
                <!-- LID value missing on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply LID value byte differt from sending one -->
                <xsl:when test="$mReply1 != $mSend1">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                    <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                  </xsl:call-template>
                </xsl:when>
                <!-- If exist DataItem, response should be at least greater than 3 bytes -->
                <xsl:when test="ddt:Received/ddt:DataItem">
                  <xsl:if test="$mResponseByteNumber &lt; 3">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Without DataItem, response is 3 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '3'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 3">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>

              <!-- Check a LID define in specific IO request is defined on generic IO request outputcontrol list datas -->
              <xsl:if test="$mOutputControlGenericRequest30 &gt; 0">
                <!-- if no generic Io service, nothing to do because of ME013 -->
                <xsl:if test="(local:LowerSpaceRemove(string($mRequestName)) != 'outputcontrol')  and ($mSend1 != '00')">
                  <!-- check only specific request with LID <> 00 -->
                  <xsl:if test="  (count(//ddt:Target/ddt:Datas/ddt:Data[local:LowerSpaceRemove(string(@Name))='outputpermanentcontrollist']/ddt:Bits/ddt:List/ddt:Item[@Value = local:ToDec($mSend1)]) = 0)
                          and
                          (count(//ddt:Target/ddt:Datas/ddt:Data[local:LowerSpaceRemove(string(@Name))='outputtemporarycontrollist']/ddt:Bits/ddt:List/ddt:Item[@Value = local:ToDec($mSend1)]) = 0)">
                    <!-- LID define on current specific request $30LID is not define neither on OutputPermanentControlList nor OutputTemporaryControlList datas -->
                    <!-- ***************************************************** -->
                    <!-- Error ME014 : DAIMLER_ERR_OutputControlList_MissingID -->
                    <!-- ***************************************************** -->
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DAIMLER</xsl:with-param>
                      <xsl:with-param name="chapter">DAIMLER_ERR_OutputControlList_MissingID</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> : <xsl:value-of select="$mRequestName" /> $<xsl:value-of select="$mRequestSentBytes" />
                      </xsl:with-param>
                      <xsl:with-param name="info">LID: <b><xsl:value-of select="$mSend1" /></b>,
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoOutputControlMissingID" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> : OutputPermanentControlList / OutputTemporaryControlList
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddOutputControlID" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:if>
              </xsl:if>
            </xsl:if>
          </xsl:when>

          <!-- ============================================ -->
          <!-- SERVICE $2F : InputOutputControlByIdentifier -->
          <!-- ============================================ -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '2F'">
            <xsl:if test="$mSpecification = 'UDS'">
              <xsl:choose>
                <!-- DID and/or command value missing on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2/3/4'" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$mSend2 =''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'3/4'" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$mSend3 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'4'" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply DID and/or command value byte differt from sending one -->
                <xsl:when test="$mSend1 != $mReply1 or $mSend2 != $mReply2 or $mSend3 != $mReply3">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2/3/4'" />
                    <xsl:with-param name="ExpectedByteValue" select="concat($mSend1,$mSend2,$mSend3)" />
                  </xsl:call-template>
                </xsl:when>
                <!-- If exist DataItem, response should be at least greater than 4 bytes -->
                <xsl:when test="ddt:Received/ddt:DataItem">
                  <xsl:if test="$mResponseByteNumber &lt; 4">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="4" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Without DataItem, response is 4 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '4'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="4" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 4">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="4" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>

              <!-- Check a DID define in specific IO request is defined on generic IO request outputcontrol list data -->
              <xsl:if test="$mOutputControlGenericRequest2F &gt; 0">
                <!-- if no generic Io service, nothing to do because of ME013 -->
                <xsl:variable name="mDID" select="concat($mSend1, $mSend2)" />
                <xsl:if test="($mRequestName != 'OutputControl') and ($mDID != '0000')">
                  <!-- check only specific request with DID <> 0000 -->
                  <xsl:if test ="count(//ddt:Target/ddt:Datas/ddt:Data[local:LowerSpaceRemove(string(@Name))='outputpermanentcontrollist']/ddt:Bits/ddt:List/ddt:Item[@Value = local:ToDec($mDID)]) = 0">
                    <!-- ***************************************************** -->
                    <!-- Error ME014 : DAIMLER_ERR_OutputControlList_MissingID -->
                    <!-- ***************************************************** -->
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DAIMLER</xsl:with-param>
                      <xsl:with-param name="chapter">DAIMLER_ERR_OutputControlList_MissingID</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> : <xsl:value-of select="$mRequestName" /> $<xsl:value-of select="$mRequestSentBytes" />
                      </xsl:with-param>
                      <xsl:with-param name="info">DID: <b><xsl:value-of select="$mDID" /></b>,
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoOutputControlMissingID" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template> : OutputPermanentControlList
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddOutputControlID" />
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:if>
              </xsl:if>
            </xsl:if>
          </xsl:when>

          <!-- ============================================================ -->
          <!-- SERVICE $31 : StartRoutineByLocalIdentifier / RoutineControl -->
          <!-- ============================================================ -->
          <xsl:when test="$mSend0 = '31'">
            <xsl:choose>
              <!-- Service format is not the same between ECU on UDS specification in one hand and DiagOnCan spec A, B/C in other -->
              <xsl:when test="$mSpecification = 'UDS'">
                <!-- Check specific RID value is define on Routine Identifier (List) and overlapping -->
                <xsl:call-template name="Routine_Specific_UDS">
                  <xsl:with-param name="request" select="."/>
                </xsl:call-template>

                <xsl:if test="ddt:DossierMaintenabilite">
                  <xsl:choose>
                    <!-- RID and/or command value missing on sending bytes -->
                    <xsl:when test="$mSend1 = ''">
                      <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ByteNumber" select="'2/3/4'" />
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$mSend2 =''">
                      <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ByteNumber" select="'3/4'" />
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$mSend3 = ''">
                      <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ByteNumber" select="'4'" />
                      </xsl:call-template>
                    </xsl:when>
                    <!-- Reply RID and/or command value byte differt from sending one -->
                    <xsl:when test="$mSend1 != $mReply1 or $mSend2 != $mReply2 or $mSend3 != $mReply3">
                      <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ByteNumber" select="'2/3/4'" />
                        <xsl:with-param name="ExpectedByteValue" select="concat($mSend1,$mSend2,$mSend3)" />
                      </xsl:call-template>
                    </xsl:when>
                    <!-- If exist DataItem, response should be at least greater than 5 bytes -->
                    <xsl:when test="ddt:Received/ddt:DataItem">
                      <xsl:if test="$mResponseByteNumber &lt; 5">
                        <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                          <xsl:with-param name="Request" select="." />
                          <xsl:with-param name="ExpectedRxByteNumber" select="5" />
                        </xsl:call-template>
                      </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                      <!-- Without DataItem, response is 5 bytes lenght (Reply byte && Min byte) -->
                      <xsl:if test="$mRequestMinBytes != '5'">
                        <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                          <xsl:with-param name="Request" select="." />
                          <xsl:with-param name="ExpectedMinByte" select="5" />
                        </xsl:call-template>
                      </xsl:if>
                      <xsl:if test="$mResponseByteNumber != 5">
                        <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                          <xsl:with-param name="Request" select="." />
                          <xsl:with-param name="ExpectedRxByteNumber" select="5" />
                        </xsl:call-template>
                      </xsl:if>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <!-- Check specific RID value is define on Routine Identifier (List) and overlapping -->
                <xsl:call-template name="Routine_Specific_ABC">
                  <xsl:with-param name="request" select="."/>
                </xsl:call-template>

                <xsl:if test="ddt:DossierMaintenabilite">
                  <xsl:choose>
                      <!-- LID value missing on sending bytes -->
                      <xsl:when test="$mSend1 = ''">
                        <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                          <xsl:with-param name="Request" select="." />
                          <xsl:with-param name="ByteNumber" select="'2/3/4'" />
                        </xsl:call-template>
                      </xsl:when>
                      <!-- Reply LID value byte differt from sending one -->
                      <xsl:when test="$mSend1 != $mReply1">
                        <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                          <xsl:with-param name="Request" select="." />
                          <xsl:with-param name="ByteNumber" select="2" />
                          <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                        </xsl:call-template>
                      </xsl:when>
                      <!-- If exist DataItem, response should be at least greater than 3 bytes -->
                      <xsl:when test="ddt:Received/ddt:DataItem">
                        <xsl:if test="$mResponseByteNumber &lt; 3">
                          <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                            <xsl:with-param name="Request" select="." />
                            <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:when>
                      <xsl:otherwise>
                        <!-- Without DataItem, response is 3 bytes lenght (Reply byte && Min byte) -->
                        <xsl:if test="$mRequestMinBytes != '3'">
                          <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                            <xsl:with-param name="Request" select="." />
                            <xsl:with-param name="ExpectedMinByte" select="3" />
                          </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="$mResponseByteNumber != 3">
                          <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                            <xsl:with-param name="Request" select="." />
                            <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <!-- ========================================== -->
          <!-- SERVICE $32 : StopRoutineByLocalIdentifier -->
          <!-- ========================================== -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '32'">
            <!-- Service $32 do not exist for ECU on UDS -->
            <xsl:if test="$mSpecification != 'UDS'">
              <xsl:choose>
                <!-- LID value missing on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2/3/4'" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply LID value byte differt from sending one -->
                <xsl:when test="$mSend1 != $mReply1">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                    <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                  </xsl:call-template>
                </xsl:when>
                <!-- If exist DataItem, response should be at least greater than 3 bytes -->
                <xsl:when test="ddt:Received/ddt:DataItem">
                  <xsl:if test="$mResponseByteNumber &lt; 3">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Without DataItem, response is 3 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '3'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 3">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- ============================= -->
          <!-- SERVICE $34 : RequestDownload -->
          <!-- SERVICE $35 : RequestUpload   -->
          <!-- ============================= -->
          <xsl:when test="ddt:DossierMaintenabilite and  ($mSend0 = '34' or $mSend0 = '35')">
            <xsl:choose>
              <!-- Service format is not the same between ECU on UDS specification and DiagOnCan spec B/C in one hand and other specification in other -->
              <xsl:when test="mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC'">
                <xsl:choose>
                  <!-- Byte 2 value missing on sending bytes -->
                  <xsl:when test="$mSend1 = ''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- Byte 2 value differt from sending one -->
                  <xsl:when test="$mReply1 != $mSend1">
                    <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="2" />
                      <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- If exist DataItem, response should be at least greater than 2 bytes -->
                  <xsl:when test="ddt:Received/ddt:DataItem">
                    <xsl:if test="$mResponseByteNumber &lt; 2">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- Without DataItem, response is 2 bytes lenght (Reply byte && Min byte) -->
                    <xsl:if test="$mRequestMinBytes != '2'">
                      <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedMinByte" select="2" />
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$mResponseByteNumber != 2">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="ddt:Received/ddt:DataItem">
                    <xsl:if test="$mResponseByteNumber &lt; 1">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="1" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:if test="$mRequestMinBytes != '1'">
                      <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedMinByte" select="1" />
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$mResponseByteNumber != 1">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="1" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>

                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <!-- ============================= -->
          <!-- SERVICE $36 : RequestDownload -->
          <!-- SERVICE $37 : RequestUpload   -->
          <!-- ============================= -->
          <xsl:when test="ddt:DossierMaintenabilite and ($mSend0 = '36' or $mSend0 = '37')">
            <!-- Service $36 & $37 only for ECU DiagOnCAN spec B/C or UDS -->
            <xsl:if test="$mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC'">
              <xsl:choose>
                <!-- Byte 2 value missing on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Byte 2 value differt from sending one -->
                <xsl:when test="$mReply1 != $mSend1">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                    <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                  </xsl:call-template>
                </xsl:when>
                <!-- If exist DataItem, response should be at least greater than 2 bytes -->
                <xsl:when test="ddt:Received/ddt:DataItem">
                  <xsl:if test="$mResponseByteNumber &lt; 2">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Without DataItem, response is 2 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '2'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 2">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- ============================================= -->
          <!-- SERVICE $2C : DynamicallyDefineDataIdentifier -->
          <!-- ============================================= -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '2C'">
            <xsl:choose>
              <!-- Service format is not the same between ECU on UDS specification in one hand and DiagOnCan spec A, B/C in other -->
              <xsl:when test="$mSpecification = 'UDS'">
                <xsl:choose>
                  <!-- DID value missing or incomplete on sending bytes -->
                  <xsl:when test="$mSend2 =''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="'3/4'" />
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="$mSend3 = ''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="4" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- Reply DID differt from sending one -->
                  <xsl:when test="$mSend2 != $mReply2 or $mSend3 != $mReply3">
                    <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="'3/4'" />
                      <xsl:with-param name="ExpectedByteValue" select="concat($mSend2,$mSend3)" />
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- Response is 4 bytes lenght (Reply byte && Min byte) -->
                    <xsl:if test="$mRequestMinBytes != '4'">
                      <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedMinByte" select="4" />
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$mResponseByteNumber != 4">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="4" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <!-- LID value missing or incomplete on sending bytes -->
                  <xsl:when test="$mSend1 =''">
                    <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="'2'" />
                    </xsl:call-template>
                  </xsl:when>
                  <!-- Reply LID value byte differt from sending one -->
                  <xsl:when test="$mSend1 != $mReply1">
                    <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ByteNumber" select="2" />
                      <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- Response is 3 bytes lenght (Reply byte && Min byte) -->
                    <xsl:if test="$mRequestMinBytes != '3'">
                      <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedMinByte" select="3" />
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$mResponseByteNumber != 3">
                      <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                        <xsl:with-param name="Request" select="." />
                        <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <!-- =================================== -->
          <!-- SERVICE $2E : WriteDataByIdentifier -->
          <!-- =================================== -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '2E'">
            <!-- Service $2E only for ECU DiagOnCAN spec B/C or UDS -->
            <xsl:if test="$mSpecification = 'UDS' or $mSpecification = 'DiagOnCanBC'">
              <xsl:choose>
                <!-- DID value missing or incomplete on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2/3'" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$mSend2 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'3'" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply DID differt from sending one -->
                <xsl:when test="($mSend1 != $mReply1) or ($mSend2 != $mReply2)">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="'2/3'" />
                    <xsl:with-param name="ExpectedByteValue" select="concat($mSend1,$mSend2)" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Response is 3 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '3'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 3">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="3" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- ======================================== -->
          <!-- SERVICE $3B : WriteDataByLocalIdentifier -->
          <!-- ======================================== -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '3B'">
            <!-- Service $3B do not exist for ECU on UDS -->
            <xsl:if test="$mSpecification != 'UDS'">
              <xsl:choose>
                <!-- LID value missing on sending bytes -->
                <xsl:when test="$mSend1 = ''">
                  <xsl:call-template name="ME003_DaimlerRequestByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                  </xsl:call-template>
                </xsl:when>
                <!-- Reply LID value byte differt from sending one -->
                <xsl:when test="$mReply1 != $mSend1">
                  <xsl:call-template name="ME002_DaimlerReplyByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ByteNumber" select="2" />
                    <xsl:with-param name="ExpectedByteValue" select="$mSend1" />
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <!-- Response is 2 bytes lenght (Reply byte && Min byte) -->
                  <xsl:if test="$mRequestMinBytes != '2'">
                    <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedMinByte" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="$mResponseByteNumber != 2">
                    <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                      <xsl:with-param name="Request" select="." />
                      <xsl:with-param name="ExpectedRxByteNumber" select="2" />
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>

          <!-- =========================== -->
          <!-- SERVICE $3E : TesterPresent -->
          <!-- =========================== -->
          <xsl:when test="ddt:DossierMaintenabilite and $mSend0 = '10'">
            <xsl:choose>
              <!-- If UDS ECU, check response is at least 1 byte length -->
              <xsl:when test="$mSpecification = 'UDS'">
                <xsl:if test="$mResponseByteNumber &lt; 1">
                  <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedRxByteNumber" select="1" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$mRequestMinBytes != '1'">
                  <xsl:call-template name="ME009_DaimlerReplyMinByteErrorMessage">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedMinByte" select="1" />
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="$mResponseByteNumber != 1">
                  <xsl:call-template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
                    <xsl:with-param name="Request" select="." />
                    <xsl:with-param name="ExpectedRxByteNumber" select="1" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>

          <xsl:otherwise>
            <!-- Not allowed or not managed SID -->
          </xsl:otherwise>
        </xsl:choose>


        <!-- ********************************************** -->
        <!-- Error ME006 : DAIMLER_ERR_DataItemOutsideFrame -->
        <!-- ********************************************** -->
        <!-- Check if dataItem is define outside transmit or received frame -->
        <!-- Sent outside dataItems -->
        <xsl:for-each select="ddt:Sent/ddt:DataItem">
          <xsl:variable name="mData" select="key('allDatas',@Name)" />

          <!-- Check the name used by DataItem exist as data and Request attribute FirstByte exist (else issue) -->
          <xsl:if test="$mData and @FirstByte">
            <!-- Get bitLength of data -->
            <xsl:variable name="mdataLengthInBits">
              <xsl:call-template name ="GetDataBitLength">
                <xsl:with-param name="data" select="$mData" />
              </xsl:call-template>
            </xsl:variable>

            <!-- Get bit offset of the data -->
            <xsl:variable name="mBitOffset">
              <xsl:choose>
                <xsl:when test="@BitOffset">
                  <xsl:value-of select="@BitOffset" />
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <!-- Compute End Byte -->
            <xsl:variable name="mDataItemEndByte">
              <xsl:value-of select="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))" />
            </xsl:variable>

            <!-- Check computed End Byte -->
            <xsl:choose>
              <xsl:when test="$mDataItemEndByte = local:GeneralErrorCode()">
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DAIMLER</xsl:with-param>
                  <xsl:with-param name="chapter">DAIMLER_ERR_DataItemOutsideFrame</xsl:with-param>
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
                    </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre><br/>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                    <br/>--------------------<br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <pre><b><xsl:value-of select="@FirstByte" /></b>
                    <b>
                    <xsl:if test="string(number(@FirstByte))='NaN'">
                      <span class="redText"> &lt;- Not a valid number</span>
                    </xsl:if>
                    </b><br/>--------------------<br/></pre><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <pre><b><xsl:value-of select="$mBitOffset" /></b>
                    <b>
                    <xsl:if test="string(number($mBitOffset))='NaN'">
                      <span class="redText"> &lt;- Not a valid number</span>
                    </xsl:if>
                    </b><br/>--------------------<br/></pre><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <pre><b><xsl:value-of select="$mdataLengthInBits" /></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/bit" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>
                    <xsl:if test="string(number($mdataLengthInBits))='NaN'">
                      <span class="redText"> &lt;- Not a valid number</span>
                    </xsl:if>
                    </b><br/>--------------------<br/></pre><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <pre><b><xsl:value-of select="$mRequesteByteNumber" /></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>
                    <xsl:if test="string(number($mRequesteByteNumber))='NaN'">
                      <span class="redText"> &lt;- Not a valid number</span>
                    </xsl:if>
                    </b></pre>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckAll" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$mDataItemEndByte &gt; $mRequesteByteNumber">
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">DAIMLER</xsl:with-param>
                    <xsl:with-param name="chapter">DAIMLER_ERR_DataItemOutsideFrame</xsl:with-param>
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
                      </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre><br/>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsOutside" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template><br/>--------------------<br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataEndBytePosition" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> : <b><xsl:value-of select="$mDataItemEndByte" /></b>
                      <br/>--------------------<br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> : <b><xsl:value-of select="$mRequesteByteNumber" /> bytes</b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckAll" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>

        <!-- Received outside dataItems -->
        <xsl:for-each select="ddt:Received/ddt:DataItem">
          <xsl:variable name="mData" select="key('allDatas',@Name)" />

          <!-- Check the name used by DataItem exist as data, Response attribute FirstByte exist (else issue) and service is not $1906 -->
          <!--  Request $1906 have data outside frame, but it is normal -->
          <xsl:if test="$mData and @FirstByte and substring($mRequestSentBytes,1,4) != '1906'">
            <!-- Get bitLength of data -->
            <xsl:variable name="mdataLengthInBits">
              <xsl:call-template name ="GetDataBitLength">
                <xsl:with-param name="data" select="$mData" />
              </xsl:call-template>
            </xsl:variable>

            <!-- Get bit offset of the data -->
            <xsl:variable name="mBitOffset">
              <xsl:choose>
                <xsl:when test="@BitOffset">
                  <xsl:value-of select="@BitOffset" />
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <!-- Get Shift Byte Count value -->
            <xsl:variable name="mRequestShiftBytesCount">
              <xsl:choose>
                <xsl:when test="../ddt:ShiftBytesCount">
                  <xsl:value-of select="../ddt:ShiftBytesCount" />
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>

            <!-- Compute End Byte -->
            <xsl:variable name="mDataItemEndByte">
              <xsl:value-of select="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))" />
            </xsl:variable>

            <!-- Check computed End Byte -->
            <xsl:choose>
              <xsl:when test="$mDataItemEndByte = local:GeneralErrorCode()">
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DAIMLER</xsl:with-param>
                  <xsl:with-param name="chapter">DAIMLER_ERR_DataItemOutsideFrame</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)" /></pre><br/>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                    <br/>--------------------<br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <pre><b><xsl:value-of select="@FirstByte" /></b>
                    <b>
                    <xsl:if test="string(number(@FirstByte))='NaN'">
                      <span class="redText"> &lt;- Not a valid number</span>
                    </xsl:if>
                    </b><br/>--------------------<br/></pre><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <pre><b><xsl:value-of select="$mBitOffset" /></b>
                    <b>
                    <xsl:if test="string(number($mBitOffset))='NaN'">
                      <span class="redText"> &lt;- Not a valid number</span>
                    </xsl:if>
                    </b><br/>--------------------<br/></pre><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <pre><b><xsl:value-of select="$mdataLengthInBits" /></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/bit" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>
                    <xsl:if test="string(number($mdataLengthInBits))='NaN'">
                      <span class="redText"> &lt;- Not a valid number</span>
                    </xsl:if>
                    </b><br/>--------------------<br/></pre><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <pre><b><xsl:value-of select="$mRequestMinBytes + $mRequestShiftBytesCount" /></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>
                    <xsl:if test="string(number($mRequestMinBytes + $mRequestShiftBytesCount))='NaN'">
                      <span class="redText"> &lt;- Not a valid number</span>
                    </xsl:if>
                    </b></pre>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckAll" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$mDataItemEndByte &gt; ($mRequestMinBytes + $mRequestShiftBytesCount)">
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">DAIMLER</xsl:with-param>
                    <xsl:with-param name="chapter">DAIMLER_ERR_DataItemOutsideFrame</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> : <b><xsl:value-of select="$mRequestName" /></b><br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)" /></pre><br/>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsOutside" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template><br/>--------------------<br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataEndBytePosition" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> : <b><xsl:value-of select="$mDataItemEndByte" /></b>
                      <br/>--------------------<br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template> : <b><xsl:value-of select="$mRequestMinBytes + $mRequestShiftBytesCount" /></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckAll" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
    </xsl:for-each>
    
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template check_DaimlerAlliance ends')"/></logmsg>    
  </xsl:template>


  <!-- **************************************************** -->
  <!-- ME002 DAIMLER_ERR_ReplyByte error message definition -->
  <!-- **************************************************** -->
    <!-- Byte Txi != Byte Rxi -->
  <xsl:template name="ME002_DaimlerReplyByteErrorMessage">
    <xsl:param name="Request" />
    <xsl:param name="ByteNumber" />
    <xsl:param name="ExpectedByteValue" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME002_DaimlerReplyByteErrorMessage starts')"/></logmsg>

    <xsl:call-template name="error">
      <xsl:with-param name="type">DAIMLER</xsl:with-param>
      <xsl:with-param name="chapter">DAIMLER_ERR_ReplyByte</xsl:with-param>
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : <b><xsl:value-of select="$Request/@Name" /></b><br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string($Request/ddt:Sent/ddt:SentBytes),32)" />
      </xsl:with-param>
      <xsl:with-param name="info">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string($Request/ddt:Received/ddt:ReplyBytes),32)" /><br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template><b> n°<xsl:value-of select="$ByteNumber" /></b>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="action">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template><b> n°<xsl:value-of select="$ByteNumber" /></b>
        <br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> = <b>$<xsl:value-of select="$ExpectedByteValue" /></b>
      </xsl:with-param>
    </xsl:call-template>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME002_DaimlerReplyByteErrorMessage ends')"/></logmsg>
  </xsl:template>

  <!-- ****************************************************** -->
  <!-- ME003 DAIMLER_ERR_RequestByte error message definition -->
  <!-- ****************************************************** -->
    <!-- Byte Tx i missing -->
  <xsl:template name="ME003_DaimlerRequestByteErrorMessage">
    <xsl:param name="Request" />
    <xsl:param name="ByteNumber" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME003_DaimlerRequestByteErrorMessage starts')"/></logmsg>

    <xsl:call-template name="error">
      <xsl:with-param name="type">DAIMLER</xsl:with-param>
      <xsl:with-param name="chapter">DAIMLER_ERR_RequestByte</xsl:with-param>
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : <b><xsl:value-of select="$Request/@Name" /></b><br/>
      </xsl:with-param>
      <xsl:with-param name="info">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string($Request/ddt:Sent/ddt:SentBytes),32)" />
        <br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template><b> n°<xsl:value-of select="$ByteNumber" /></b>
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
        </xsl:call-template><br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> <b> n°<xsl:value-of select="$ByteNumber" /></b>
      </xsl:with-param>
    </xsl:call-template>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME003_DaimlerRequestByteErrorMessage ends')"/></logmsg>
  </xsl:template>

  <!-- ******************************************************** -->
  <!-- ME009 DAIMLER_ERR_ReplyMinBytes error message definition -->
  <!-- ******************************************************** -->
    <!-- !DataItem && Rx MinByte != ExpectedMinByte -->
  <xsl:template name="ME009_DaimlerReplyMinByteErrorMessage">
    <xsl:param name="Request" />
    <xsl:param name="ExpectedMinByte" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME009_DaimlerReplyMinByteErrorMessage starts')"/></logmsg>

    <xsl:call-template name="error">
      <xsl:with-param name="type">DAIMLER</xsl:with-param>
      <xsl:with-param name="chapter">DAIMLER_ERR_ReplyMinBytes</xsl:with-param>
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> :  <b><xsl:value-of select="$Request/@Name" /></b>
        <br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string($Request/ddt:Sent/ddt:SentBytes),32)" />
      </xsl:with-param>
      <xsl:with-param name="info">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> :  <b><xsl:value-of select="$Request/ddt:Received/@MinBytes" /></b>
        <br/>
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
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : <b><xsl:value-of select="$ExpectedMinByte" /></b>
      </xsl:with-param>
    </xsl:call-template>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME009_DaimlerReplyMinByteErrorMessage ends')"/></logmsg>
  </xsl:template>

  <!-- ***************************************************** -->
  <!-- ME010 DAIMLER_ERR_ReplyBytes error message definition -->
  <!-- ***************************************************** -->
    <!-- !DataItem && ResponseLength != ExpectedRxByteNumber -->
  <xsl:template name="ME010_DaimlerReplyBytesErrorMessage_WOData">
    <xsl:param name="Request" />
    <xsl:param name="ExpectedRxByteNumber" />

    <xsl:variable name="mRequestReceivedReplyBytes" select="$Request/ddt:Received/ddt:ReplyBytes" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME010_DaimlerReplyBytesErrorMessage_WOData starts')"/></logmsg>

    <xsl:call-template name="error">
      <xsl:with-param name="type">DAIMLER</xsl:with-param>
      <xsl:with-param name="chapter">DAIMLER_ERR_ReplyBytes</xsl:with-param>
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : <b><xsl:value-of select="$Request/@Name" /></b><br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string($Request/ddt:Sent/ddt:SentBytes),32)" />
      </xsl:with-param>
      <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)" />
          <br/>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> :<b><xsl:value-of select="string-length($mRequestReceivedReplyBytes) div 2" /></b>
      </xsl:with-param>
      <xsl:with-param name="action">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : <br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> = <b><xsl:value-of select="$ExpectedRxByteNumber" /></b>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME010_DaimlerReplyBytesErrorMessage_WOData ends')"/></logmsg>
  </xsl:template>

  <!-- DataItem && ResponseLength < ExpectedRxByteNumber -->
  <xsl:template name="ME010_DaimlerReplyBytesErrorMessage_WData">
    <xsl:param name="Request" />
    <xsl:param name="ExpectedRxByteNumber" />
    <xsl:variable name="mRequestReceivedReplyBytes" select="$Request/ddt:Received/ddt:ReplyBytes" />
  
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME010_DaimlerReplyBytesErrorMessage_WData starts')"/></logmsg>

    <xsl:call-template name="error">
      <xsl:with-param name="type">DAIMLER</xsl:with-param>
      <xsl:with-param name="chapter">DAIMLER_ERR_ReplyBytes</xsl:with-param>
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : <b><xsl:value-of select="$Request/@Name" /></b><br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string($Request/ddt:Sent/ddt:SentBytes),32)" />
      </xsl:with-param>
      <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : $<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)" />
          <br/>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="string-length($mRequestReceivedReplyBytes) div 2" /></b>
      </xsl:with-param>
      <xsl:with-param name="action">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> : <br/>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template> >= <b><xsl:value-of select="$ExpectedRxByteNumber" /></b>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DaimlerAlliance.xsl: template ME010_DaimlerReplyBytesErrorMessage_WData ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>