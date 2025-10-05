<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:ddt="http://www-diag.renault.com/2002/ECU"
	xmlns:ds="http://www-diag.renault.com/2002/screens"
	xmlns:ga="DiagnosticAddressingSchema.xml"
	xmlns:local="#local-functions">

  <xsl:template match="ddt:Datas/ddt:Data/ddt:Bits/ddt:List">
      <!-- *************** -->
      <!--Check empty list -->
      <!-- *************** -->
      <xsl:if test="not(count(ddt:Item)&gt;=1)">
        <!-- Exception pour les données :
              + DTCDeviceAndFailureTypeOBD
              + DTCFailureType.ManufacturerOrSupplier
        -->
        <xsl:if test="not((../../@Name='DTCDeviceAndFailureTypeOBD') or (../../@Name = 'DTCFailureType.ManufacturerOrSupplier'))">
          <!-- *********************************** -->
          <!-- Warning MW001 DAIMLER_WAR_EmptyList -->
          <!-- *********************************** -->
          <xsl:call-template name="warning">
            <xsl:with-param name="type">DAIMLER</xsl:with-param>
            <xsl:with-param name="chapter">DAIMLER_WAR_EmptyList</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="../../@Name" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="../../@Name" /></b><br/>
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
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>

          <!-- ************************************ -->
          <!-- Error AE013 : ALLIANCE_ERR_EmptyList -->
          <!-- ************************************ -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">ALLIANCE</xsl:with-param>
            <xsl:with-param name="chapter">ALLIANCE_ERR_EmptyList</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="../../@Name" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b><xsl:value-of select="../../@Name" /></b><br/>
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
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:if>
    
      <!-- **************** -->
      <!-- Check Text value -->
      <!-- **************** -->
      <xsl:for-each select="ddt:Item">
        <xsl:choose>
          <xsl:when test="@Value and (not(@Text) or (@Text=''))">
            <!-- **************************************************************** -->
            <!-- Error DE203 : DDT200_ERR_InvalidNumericListItemText (empty text) -->
            <!-- **************************************************************** -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT200_ERR_InvalidNumericListItemText</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="../../../@Name"/></b>
                <br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desValue"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="@Value"/></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNumericListNoItemText"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNumericListNoItemText"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="string-length(normalize-space(@Text)) &lt;= 0">
            <!-- ********************************************************************* -->
            <!-- Error DE203 : DDT200_ERR_InvalidNumericListItemText (only space text) -->
            <!-- ********************************************************************* -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT200_ERR_InvalidNumericListItemText</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="../../../@Name"/></b>
                <br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desValue"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="@Value"/></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNumericListItemTextOnlySpace"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNumericListItemTextOnlySpace"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="contains(@Text, '&#10;')">
            <!-- *********************************************************************** -->
            <!-- Error DE203 : DDT200_ERR_InvalidNumericListItemText (Caractère CrLf) -->
            <!-- *********************************************************************** -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT200_ERR_InvalidNumericListItemText</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="../../../@Name"/></b>
                <br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desValue"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="@Value"/></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNumericListItemTextInvalidChar"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                [<b>CrLf</b>]
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNumericListItemTextInvalidChar"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template><br/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="invalidChar" select="local:CheckInvalidASCIIChar(string(@Text))"/>
            <xsl:if test="$invalidChar !=''">
              <!-- *********************************************************************** -->
              <!-- Error DE203 : DDT200_ERR_InvalidNumericListItemText (invalid character) -->
              <!-- *********************************************************************** -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT200_ERR_InvalidNumericListItemText</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="../../../@Name"/></b>
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="@Value"/></b>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNumericListItemTextInvalidChar"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  [<b><xsl:value-of select="$invalidChar"/></b>]
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNumericListItemTextInvalidChar"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>


      <!-- ****************** -->
      <!-- Check Range values -->
      <!-- ****************** -->
      <xsl:variable name="rangeSelection" select="ddt:Item[contains(@Text,'##') or contains(@Text,'#@')]" />
      <xsl:variable name="nbElement" select="count($rangeSelection)" />

      <xsl:for-each select="$rangeSelection" >
        <xsl:variable name="root" select="substring-before(@Text,'#')" />
        <xsl:variable name="currentPosition" select="position()" />
        <xsl:variable name="expectedValue" select="@Value + 1" />

        <xsl:choose>
          <xsl:when test="../ddt:Item[@Text = $root]" >
            <xsl:variable name="item" select="../ddt:Item[@Text = $root]" />
            <!-- ************************************* -->
            <!-- Warning AW005 ALLIANCE_WAR_ValueRange -->
            <!-- ************************************* -->
            <!-- Name of value range using for another text -->
            <xsl:call-template name="warning">
              <xsl:with-param name="type">ALLIANCE</xsl:with-param>
              <xsl:with-param name="chapter">ALLIANCE_WAR_ValueRange</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="../../../@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValueRangeName" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="@Text"/></b>
                (
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="@Value" /></b>
                )
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValueRangeNameConflit" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="$item/@Text" /></b>
                (
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$item/@Value" /></b>
                )
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="count(../ddt:Item[starts-with(@Text, string($root))]) = 1" >
            <!-- ************************************* -->
            <!-- Warning AW005 ALLIANCE_WAR_ValueRange -->
            <!-- ************************************* -->
            <!-- Only one value with dedicated sequence ## or #@ -->
            <xsl:call-template name="warning">
              <xsl:with-param name="type">ALLIANCE</xsl:with-param>
              <xsl:with-param name="chapter">ALLIANCE_WAR_ValueRange</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="../../../@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoOnlyOneValueRange" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template><b><xsl:value-of select="$root" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="count(../ddt:Item[starts-with(@Text, concat(string($root), '#@'))]) = 0" >
            <!-- ************************************* -->
            <!-- Warning AW005 ALLIANCE_WAR_ValueRange -->
            <!-- ************************************* -->
            <!-- No define reverse value -->
            <xsl:call-template name="warning">
              <xsl:with-param name="type">ALLIANCE</xsl:with-param>
              <xsl:with-param name="chapter">ALLIANCE_WAR_ValueRange</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="../../../@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNoReverseValueRange" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="@Text" /></b>
                (
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="@Value" /></b>
                )
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="count(../ddt:Item[starts-with(@Text, concat(string($root), '#@'))]) &gt; 1" >
            <!-- ************************************* -->
            <!-- Warning AW005 ALLIANCE_WAR_ValueRange -->
            <!-- ************************************* -->
            <!-- More than 1 reverse value -->
            <xsl:call-template name="warning">
              <xsl:with-param name="type">ALLIANCE</xsl:with-param>
              <xsl:with-param name="chapter">ALLIANCE_WAR_ValueRange</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="../../../@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMoreReverseValueRange" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>(<b><xsl:value-of select="concat(string($root),'#@')"/>xx</b>)
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/info4ValueRange" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="@Text" /></b>
                (
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValue" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="@Value" /></b>
                )
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="$rangeSelection">
              <xsl:variable name="indexPosition" select="position()" />              
              <xsl:if test="($indexPosition &gt; $currentPosition) and ($indexPosition &lt; $nbElement)">
                <xsl:if test="($indexPosition = $currentPosition +1) and ($root = substring-before(@Text,'#')) and (@Value != $expectedValue)" >
                  <!-- ************************************* -->
                  <!-- Warning AW005 ALLIANCE_WAR_ValueRange -->
                  <!-- ************************************* -->
                  <!-- Missing value -->
                  <xsl:call-template name="warning">
                    <xsl:with-param name="type">ALLIANCE</xsl:with-param>
                    <xsl:with-param name="chapter">ALLIANCE_WAR_ValueRange</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="../../../@Name" /></b>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoMissingValue" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template><b> <xsl:value-of select="$expectedValue" /></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/info4ValueRange" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template><b> <xsl:value-of select="$root" /></b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>
              </xsl:if>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>