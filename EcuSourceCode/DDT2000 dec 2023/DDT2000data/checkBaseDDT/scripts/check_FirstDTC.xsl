<?xml version="1.0" encoding="windows-1252"?>
<!--
    [XSL-XSLT] This stylesheet automatically updated from an IE5-compatible XSL stylesheet to XSLT.
    The following problems which need manual attention may exist in this stylesheet:
    -->
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds local"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:ddt="http://www-diag.renault.com/2002/ECU"
	xmlns:ds="http://www-diag.renault.com/2002/screens"
	xmlns:local="#local-functions"
	>


<!-- ****************************************************************************************************************
     Check FirstDTC (spécification 36-00-13/A):
       Vérifier que la liste des DTC de la donnée FirstDTC = l'ensemble des DTC déclarés dans les organes
     **************************************************************************************************************** -->
  <xsl:template name="FirstDTC">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_FirstDTC.xsl: template FirstDTC starts')"/></logmsg>

    <xsl:choose>
      <xsl:when test="ddt:Datas/ddt:Data[@Name='FirstDTC']">
        <xsl:for-each select = "ddt:Devices/ddt:Device">

          <xsl:if test="@DTC">

            <!-- Définition des variables -->
            <xsl:variable name="mDTC" select="@DTC"></xsl:variable>
            <xsl:variable name="mDeviceName" select="@Name"></xsl:variable>

            <!-- ********************************************************************************************************************* -->
            <!-- Vérifier que chaque DTC (numéro + nom de l'organe) déclaré dans les organes est aussi déclaré dans la donnée FirstDTC -->
            <!-- ********************************************************************************************************************* -->
            <xsl:choose>
              <xsl:when test="//ddt:Target/ddt:Datas/ddt:Data[@Name='FirstDTC']/ddt:Bits/ddt:List/ddt:Item[@Value = $mDTC] and
                      //ddt:Target/ddt:Datas/ddt:Data[@Name='FirstDTC']/ddt:Bits/ddt:List/ddt:Item[@Text = $mDeviceName]">
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DDT2000</xsl:with-param>
                  <xsl:with-param name="chapter">DDT2000_ERR_FirstDTC</xsl:with-param>
                  <xsl:with-param name="description">
                          <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b>FirstDTC</b>
                  </xsl:with-param>
                  <xsl:with-param name="info">DTC : <b><xsl:value-of select="$mDTC" /></b>
                                  (<xsl:call-template name="toHex">
                                    <xsl:with-param name="number"><xsl:value-of select="$mDTC" /></xsl:with-param>
                                    <xsl:with-param name="digits">3</xsl:with-param>
                                    <xsl:with-param name="prefix">$</xsl:with-param>
                                  </xsl:call-template>) : <xsl:value-of select="$mDeviceName" /><br/>
                          <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissingInData"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> <b>FirstDTC</b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                          <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> <b>FirstDTC</b>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>

        <!-- ******************************************************************************************************************* -->
        <!-- Vérifier que chaque DTC (numéro + texte associé) déclaré dans la donnée FirstDTC est aussi déclaré dans les organes -->
        <!-- ******************************************************************************************************************* -->
        <xsl:for-each select="//ddt:Target/ddt:Datas/ddt:Data[@Name='FirstDTC']/ddt:Bits/ddt:List/ddt:Item">

          <!-- Définition des variables -->
          <xsl:variable name="mValueDTC" select="@Value"></xsl:variable>
          <xsl:variable name="mText" select="@Text"></xsl:variable>

          <xsl:choose>
            <xsl:when test="//ddt:Target/ddt:Devices/ddt:Device[@DTC = $mValueDTC] and
                    //ddt:Target/ddt:Devices/ddt:Device[@Name = $mText]">

            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_FirstDTC</xsl:with-param>
                <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b>FirstDTC</b>
                </xsl:with-param>
                <xsl:with-param name="info">DTC : <b><xsl:value-of select="$mValueDTC" /></b>
                  (<xsl:call-template name="toHex">
                    <xsl:with-param name="number"><xsl:value-of select="$mValueDTC" /></xsl:with-param>
                    <xsl:with-param name="digits">3</xsl:with-param>
                    <xsl:with-param name="prefix">$</xsl:with-param>
                  </xsl:call-template>) : <xsl:value-of select="$mText" /><br/>
                        <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsDeclaredInData"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> <b>FirstDTC</b>
                        <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissingInDevice"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionUpdateDTC"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> <b>FirstDTC</b>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:when>

      <!-- ******************************************************************************************************************* -->
      <!-- La donnée FirstDTC n'est pas déclaré                                                                                -->
      <!-- ******************************************************************************************************************* -->
      <xsl:otherwise>
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_FirstDTCMissing</xsl:with-param>
          <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>FirstDTC</b>
          </xsl:with-param>
          <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>FirstDTC</b>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> <b>FirstDTC</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_FirstDTC.xsl: template FirstDTC ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
