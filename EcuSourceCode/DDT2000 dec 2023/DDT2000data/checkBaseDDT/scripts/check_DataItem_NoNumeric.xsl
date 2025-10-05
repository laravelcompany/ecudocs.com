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

<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

  <xsl:template name="checkDataItemNoNumeric">
    <xsl:param name="type" />
    <xsl:param name="chapter" />
    <xsl:param name="reqName" />
    <xsl:param name="dataName" />
    <xsl:param name="msgMissing" />
    <xsl:param name="startByte" />
    <xsl:param name="offsetBit" />
    <xsl:param name="numberBytes" />
    <xsl:param name="ascii" />

    <xsl:choose>
      <xsl:when test="//ddt:Target/ddt:Datas/ddt:Data[@Name=$dataName]/ddt:Bits">
        <xsl:call-template name="error">
          <xsl:with-param name="type"><xsl:value-of select="$type" /></xsl:with-param>
          <xsl:with-param name="chapter"><xsl:value-of select="$chapter" /></xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b><xsl:value-of select="$reqName" /></b> : <br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b><xsl:value-of select="$dataName" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBadFormat" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedFormat"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>No Numeric</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <!-- ****************** -->
      <!-- Donnée en émission -->
      <!-- ****************** -->
      <xsl:when test="ddt:Sent/ddt:DataItem[@Name = $dataName]">
        <xsl:apply-templates select="ddt:Sent/ddt:DataItem[@Name = $dataName]" mode="NoNumeric">
            <xsl:with-param name="mType"><xsl:value-of select="$type" /></xsl:with-param>
            <xsl:with-param name="mChapter"><xsl:value-of select="$chapter" /></xsl:with-param>
            <xsl:with-param name="rName"><xsl:value-of select="$reqName" /></xsl:with-param>
            <xsl:with-param name="sByte"><xsl:value-of select="$startByte" /></xsl:with-param>
            <xsl:with-param name="offBit"><xsl:value-of select="$offsetBit" /></xsl:with-param>
            <xsl:with-param name="nbBytes"><xsl:value-of select="$numberBytes" /></xsl:with-param>
            <xsl:with-param name="ascii"><xsl:value-of select="$ascii" /></xsl:with-param>
            <xsl:with-param name="inOut">Sent</xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>

      <!-- ******************* -->
      <!-- Donnée en réception -->
      <!-- ******************* -->
      <xsl:when test="ddt:Received/ddt:DataItem[@Name = $dataName]">
        <xsl:apply-templates select="ddt:Received/ddt:DataItem[@Name = $dataName]" mode="NoNumeric">
            <xsl:with-param name="mType"><xsl:value-of select="$type" /></xsl:with-param>
            <xsl:with-param name="mChapter"><xsl:value-of select="$chapter" /></xsl:with-param>
            <xsl:with-param name="rName"><xsl:value-of select="$reqName" /></xsl:with-param>
            <xsl:with-param name="sByte"><xsl:value-of select="$startByte" /></xsl:with-param>
            <xsl:with-param name="offBit"><xsl:value-of select="$offsetBit" /></xsl:with-param>
            <xsl:with-param name="nbBytes"><xsl:value-of select="$numberBytes" /></xsl:with-param>
            <xsl:with-param name="ascii"><xsl:value-of select="$ascii" /></xsl:with-param>
            <xsl:with-param name="inOut">Received</xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>

      <!-- ************* -->
      <!-- pas de donnée -->
      <!-- ************* -->
      <xsl:otherwise>
        <xsl:call-template name="error">
          <xsl:with-param name="type"><xsl:value-of select="$type" /></xsl:with-param>
          <xsl:with-param name="chapter"><xsl:value-of select="$chapter" /></xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b><xsl:value-of select="$reqName" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b><xsl:value-of select="$dataName" /></b><br/>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataDefinitionNotExist"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDefinitionData"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="$dataName" /></b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

  <xsl:template match="ddt:DataItem" mode="NoNumeric">
    <xsl:param name="mType" />
    <xsl:param name="mChapter" />
    <xsl:param name="rName" />
    <xsl:param name="sByte" />
    <xsl:param name="offBit" />
    <xsl:param name="nbBytes" />
    <xsl:param name="ascii" />
    <xsl:param name="inOut" />
    <xsl:variable name="nom" select="@Name" />

    <!-- ****************
         Check First Byte
         **************** -->
    <xsl:choose>
      <xsl:when test="@FirstByte">
        <xsl:if test = "@FirstByte != $sByte">
          <xsl:call-template name="error">
            <xsl:with-param name="type"><xsl:value-of select="$mType" /></xsl:with-param>
            <xsl:with-param name="chapter"><xsl:value-of select="$mChapter" /></xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b><xsl:value-of select="$rName" /></b> : <br/>
              (<b><xsl:value-of select="$inOut" /></b>)
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b><xsl:value-of select="$nom" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b><xsl:value-of select="@FirstByte" /></b><br/>
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
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b><xsl:value-of select="$sByte" /></b>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
    </xsl:choose>

    <!-- ****************
         Check Bit offset
         **************** -->
    <xsl:choose>
      <xsl:when test="@BitOffset">
        <xsl:if test = "@BitOffset!= $offBit">
          <xsl:call-template name="error">
            <xsl:with-param name="type"><xsl:value-of select="$mType" /></xsl:with-param>
            <xsl:with-param name="chapter"><xsl:value-of select="$mChapter" /></xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :   <b><xsl:value-of select="$rName" /></b> : <br/>
              (<b><xsl:value-of select="$inOut" /></b>)
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$nom" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="@BitOffset" /></b><br/>
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
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b><xsl:value-of select="$offBit" /></b>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
    </xsl:choose>


    <!-- ******************
         Check number bytes
         ****************** -->
    <xsl:choose>
      <xsl:when test="key('allDatas',$nom)">
        <xsl:if test = "//ddt:Target/ddt:Datas/ddt:Data[@Name=$nom]/ddt:Bytes[@count != $nbBytes]">
          <xsl:call-template name="error">
            <xsl:with-param name="type"><xsl:value-of select="$mType" /></xsl:with-param>
            <xsl:with-param name="chapter"><xsl:value-of select="$mChapter" /></xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b><xsl:value-of select="$rName" /></b> <br/>
              (<b><xsl:value-of select="$inOut" /></b>)
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$nom" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="//ddt:Target/ddt:Datas/ddt:Data[@Name=$nom]/ddt:Bytes/@count" /></b><br/>
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
              </xsl:call-template> : <b><xsl:value-of select="$nbBytes" /></b>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
    </xsl:choose>


    <!-- ******************************
         Check format ASCII or BCD/HEXA
         ****************************** -->
    <xsl:choose>
      <xsl:when test="//ddt:Target/ddt:Datas/ddt:Data[@Name=$nom]/ddt:Bytes[@ascii = $ascii]">
        <!-- définition contrôle ascii=1 et data dans la base ascii=1 Check = OK-->
      </xsl:when>
      <xsl:when test="//ddt:Target/ddt:Datas/ddt:Data[@Name=$nom]/ddt:Bytes[@ascii != $ascii]">
        <!-- définition contrôle ascii=0(BCD/HEXA) et data dans la base ascii=1 Check = KO
             expected BCD/HEXA value -->
        <xsl:call-template name="error">
          <xsl:with-param name="type"><xsl:value-of select="$mType" /></xsl:with-param>
          <xsl:with-param name="chapter"><xsl:value-of select="$mChapter" /></xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <b><xsl:value-of select="$rName" /></b><br/>
            (<b><xsl:value-of select="$inOut" /></b>)
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="$nom" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBadFormat" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>ASCII</b>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedFormat"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>BCD/HEXA</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$ascii=1">
          <!-- définition contrôle ascii=1 et data dans la base data au format BCD/HEXA (pas de paramètre sur la balise Bytes) Check = KO
               expected ASCII value -->
          <xsl:call-template name="error">
            <xsl:with-param name="type"><xsl:value-of select="$mType" /></xsl:with-param>
            <xsl:with-param name="chapter"><xsl:value-of select="$mChapter" /></xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <b><xsl:value-of select="$rName" /></b><br/>
              (<b><xsl:value-of select="$inOut" /></b>)
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$nom" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBadFormat" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>BCD/HEXA</b>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedFormat"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b>ASCII</b>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
