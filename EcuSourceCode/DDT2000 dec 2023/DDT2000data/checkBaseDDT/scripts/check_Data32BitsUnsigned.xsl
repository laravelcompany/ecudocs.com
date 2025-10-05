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



<!-- ******************************************************************************************
     Check Data 32 Bits Unsigned :
     ****************************************************************************************** -->
  <xsl:template name="Data32BitsUnsigned">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Data32BitsUnsigned.xsl: template Data32BitsUnsigned starts')"/></logmsg>

    <xsl:for-each select="ddt:Datas/ddt:Data/ddt:Bits[@count = '32']">
      <xsl:variable name="mSigned">
        <xsl:choose>
          <xsl:when test= "@signed">
            <xsl:value-of select="@signed"/>
          </xsl:when>
          <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:if test="$mSigned = 0">
        <xsl:choose>
          <xsl:when test="ddt:Scaled/@Unit or ddt:Scaled/@Step or ddt:Scaled/@Offset or ddt:Scaled/@DivideBy">
            <!-- ***************************** -->
            <!-- there are unit or formula     -->
            <!-- error : no suggested solution -->
            <!-- ***************************** -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_Unsigned32bitsNumericData</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="../@Name" /></b> <br/>
                <xsl:value-of select="@count" />
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desUnsignedBits" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/info32Bits" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- ******************************************************************************** -->
            <!-- there are not unit or formula                                                    -->
            <!-- error : suggested solution : Modify the format of the data : 4 bytes in BCD/HEXA -->
            <!-- ******************************************************************************** -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_Unsigned32bitsNumericData</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                  <xsl:with-param name="defaultText">Donnée*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="../@Name" /></b> <br/>
                <xsl:value-of select="@count" />
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desUnsignedBits" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/info32Bits" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData2" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Data32BitsUnsigned.xsl: template Data32BitsUnsigned ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
