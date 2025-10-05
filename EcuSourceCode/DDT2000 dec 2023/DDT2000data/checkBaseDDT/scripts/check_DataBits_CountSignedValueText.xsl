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


<!-- ******************************************************************************************
     Check Bits
     ****************************************************************************************** -->
  <xsl:template match="ddt:Datas/ddt:Data/ddt:Bits">

  <!-- ******************************************************************************************
       Variables declarations
       ****************************************************************************************** -->
    <xsl:variable name="mBitsCount">
      <xsl:choose>
        <xsl:when test="@count"><xsl:value-of select="@count" /></xsl:when>
        <xsl:otherwise>8</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="mBitsSigned">
      <xsl:choose>
        <xsl:when test="@signed"><xsl:value-of select="@signed" /></xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


  <!-- ******************************************************************************************
       Check Bits @count
       ****************************************************************************************** -->
    <xsl:choose>
      <!-- NaN: Not a Number -->
      <xsl:when test="string(number($mBitsCount))='NaN'">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_DataBitsCount</xsl:with-param>
          <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../@Name" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mBitsCount" />
              <span class="redText">
                      <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNotValidNumber" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </span></b>
          </xsl:with-param>
          <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNbBitOK" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$mBitsCount&lt;1">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_DataBitsCount</xsl:with-param>
          <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../@Name" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mBitsCount" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNbBitOK" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="$mBitsCount&gt;32">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_DataBitsCount</xsl:with-param>
          <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../@Name" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mBitsCount" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNbBitOK" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>

  <!-- ******************************************************************************************
       Check Bits @signed
       ****************************************************************************************** -->
    <xsl:if test="@signed">
      <!--<xsl:variable name="mBitsSigned" select="@signed"></xsl:variable>-->
      <xsl:if test="$mBitsSigned != 1">

        <xsl:call-template name="warning">
          <xsl:with-param name="type">CPDD</xsl:with-param>
          <xsl:with-param name="chapter">CPDD_WAR_DataBitsSigned</xsl:with-param>
          <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../@Name" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitSigned1"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mBitsSigned" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitSigned2"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionBitSigned"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>

  <!-- ******************************************************************************************
       Check Bits List Item
       ****************************************************************************************** -->
    <xsl:if test="ddt:List/ddt:Item">
      <xsl:for-each select="ddt:List/ddt:Item">
    <!-- ******************************************************************************************
         Check List Item @value
         ****************************************************************************************** -->
        <xsl:variable name="mBitsListItemValue" select="@Value"></xsl:variable>

        <!-- Calcul des bornes Min et Max en fonction du nombre de bit et de l'attribut Signed -->
        <xsl:variable name="mMaxValue" select="local:MaxValue(number($mBitsCount),number($mBitsSigned))"></xsl:variable>
        <xsl:variable name="mMinValue" select="local:MinValue(number($mBitsCount),number($mBitsSigned))"></xsl:variable>

        <xsl:if test="$mBitsListItemValue&lt;$mMinValue or $mBitsListItemValue&gt;$mMaxValue">
          <!-- ******************************************* -->
          <!-- Error DE195 : DDT2000_ERR_DataListItemValue -->
          <!-- ******************************************* -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_ERR_DataListItemValue</xsl:with-param>
            <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../../../@Name" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsCount" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitSigned1"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsSigned" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>[<xsl:value-of select="$mMinValue " />,<xsl:value-of select="$mMaxValue " />]</b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mBitsListItemValue" /></b>
            </xsl:with-param>
            <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>[<xsl:value-of select="$mMinValue" /> , <xsl:value-of select="$mMaxValue" />]</b>
            </xsl:with-param>
          </xsl:call-template>

          <!-- ************************************* -->
          <!-- Warning CW005 CPDD_WAR_DataListItemValue -->
          <!-- ************************************* -->
          <xsl:call-template name="warning">
            <xsl:with-param name="type">CPDD</xsl:with-param>
            <xsl:with-param name="chapter">CPDD_WAR_DataListItemValue</xsl:with-param>
            <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../../../@Name" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsCount" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitSigned1"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsSigned" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>[<xsl:value-of select="$mMinValue " />,<xsl:value-of select="$mMaxValue " />]</b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mBitsListItemValue" /></b>
            </xsl:with-param>
            <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>[<xsl:value-of select="$mMinValue" /> , <xsl:value-of select="$mMaxValue" />]</b>
            </xsl:with-param>
          </xsl:call-template>

          <!-- ******************************************* -->
          <!-- Error ME007 : DAIMLER_ERR_DataListItemValue -->
          <!-- ******************************************* -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">DAIMLER</xsl:with-param>
            <xsl:with-param name="chapter">DAIMLER_ERR_DataListItemValue</xsl:with-param>
            <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../../../@Name" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsCount" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitSigned1"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsSigned" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>[<xsl:value-of select="$mMinValue " />,<xsl:value-of select="$mMaxValue " />]</b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mBitsListItemValue" /></b>
            </xsl:with-param>
            <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>[<xsl:value-of select="$mMinValue" /> , <xsl:value-of select="$mMaxValue" />]</b>
            </xsl:with-param>
          </xsl:call-template>

          <!-- ******************************************** -->
          <!-- Error AE014 : ALLIANCE_ERR_DataListItemValue -->
          <!-- ******************************************** -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">ALLIANCE</xsl:with-param>
            <xsl:with-param name="chapter">ALLIANCE_ERR_DataListItemValue</xsl:with-param>
            <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../../../@Name" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsCount" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitSigned1"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsSigned" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>[<xsl:value-of select="$mMinValue " />,<xsl:value-of select="$mMaxValue " />]</b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mBitsListItemValue" /></b>
            </xsl:with-param>
            <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>[<xsl:value-of select="$mMinValue" /> , <xsl:value-of select="$mMaxValue" />]</b>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>

    <!-- ******************************************************************************************
         Check List Item @text
         ****************************************************************************************** -->
        <xsl:variable name="mBitsListItemText" select="@Text"></xsl:variable>

        <xsl:if test="string-length($mBitsListItemText)&gt;50"><!-- 50 characters-->
          <xsl:call-template name="warning">
            <xsl:with-param name="type">CPDD</xsl:with-param>
            <xsl:with-param name="chapter">CPDD_WAR_DataListItemText</xsl:with-param>
            <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="../../../@Name" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemtext"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mBitsListItemText" /></b> (value: <xsl:value-of select="$mBitsListItemValue" />)<br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="string-length($mBitsListItemText)" /></b>
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
              </xsl:call-template> : <b>50</b>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>

      </xsl:for-each>

    </xsl:if>

  </xsl:template>
</xsl:stylesheet>
