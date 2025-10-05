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
  xmlns:ga="DiagnosticAddressingSchema.xml"
  >

<!--
     le paramètre language est passé par
     checkbaseDDT.vbs.
     si le paramètre language n'est pas passé
     la valeur par défaut est fr
-->
<xsl:param name="language">fr</xsl:param>

<!-- [XSL-XSLT] Updated namespace, added the required version attribute, and added namespaces necessary for script extensions. -->
<!-- [XSL-XSLT] Explicitly apply the default (and only) indent-result behavior -->
<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" cdata-section-elements="Description" />
<!-- [XSL-XSLT] Simulate lack of built-in templates -->
<xsl:template match="@*|/|node()" />
<!--

  DDTECUPreview.xsl

  Stylesheet for XML DDT2000 ECU Parameters,
  XSL compatible with Microsoft Internet Explorer 5,
  see http://msdn.microsoft.com/xml/xslguide.

  Author:
  Copyright 2000 RENAULT

-->
<!-- *** -->
<!-- Clé -->
<!-- *** -->
<!-- Calculer les clés sur les données indexées par leur nom -->
<xsl:key name="allDatas" match="//ddt:Target/ddt:Datas/ddt:Data" use="@Name" />
<xsl:key name="allRequests" match="//ddt:Target/ddt:Requests/ddt:Request" use="@Name"/>
<xsl:key name="allSentDataItem" match="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent/ddt:DataItem" use="@Name" />
<xsl:key name="allReceivedDataItem" match="//ddt:Target/ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem" use="@Name" />
<xsl:key name="allDataNameNormalized" match="//ddt:Target/ddt:Datas/ddt:Data" use="local:NormalizeName(string(@Name))" />
<xsl:key name="allRequestNameNormalized" match="//ddt:Target/ddt:Requests/ddt:Request" use="local:NormalizeName(string(@Name))" />
<xsl:key name="allRequestSentBytes" match="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent" use="ddt:SentBytes" />
<xsl:key name="allRequestSentBytesWithMaintenabilityReport" match="//ddt:Target/ddt:Requests/ddt:Request/ddt:DossierMaintenabilite" use="../ddt:Sent/ddt:SentBytes" />

<!-- ******* -->
<!-- Include -->
<!-- ******* -->
<xsl:include href="check_SpecB.xsl" />
<xsl:include href="check_Spec_UDS.xsl" />
<xsl:include href="check_DaimlerAlliance.xsl" />
<xsl:include href="check_DataItem_Numeric.xsl" />
<xsl:include href="check_DataItem_NoNumeric.xsl" />
<xsl:include href="check_DataItem_NumericList.xsl" />
<xsl:include href="check_Request_RDBLI_21.xsl" />
<xsl:include href="check_Data_InMultipleRequest_Or_Unused.xsl" />
<xsl:include href="check_Duplicate_Data_InRequest.xsl" />
<xsl:include href="check_Duplicate_Request.xsl" />
<xsl:include href="check_ShiftBytesCount.xsl" />
<xsl:include href="check_Data32BitsUnsigned.xsl" />
<xsl:include href="check_DataNumericalDividedBy0.xsl" />
<xsl:include href="check_RequestSentDataItem.xsl" />
<xsl:include href="check_RequestReceivedDataItem.xsl" />
<xsl:include href="check_Duplicate_Data.xsl" />
<xsl:include href="check_DataItem_LittleEndian.xsl" />
<xsl:include href="check_Data_31BitsCount.xsl" />
<xsl:include href="check_DataNumericList.xsl" />
<xsl:include href="check_AddressFunction.xsl" />
<xsl:include href="check_ProtocolType.xsl" />
<xsl:include href="check_GenericAdressing.xsl" />

<xsl:include href="check_DataName.xsl" />
<xsl:include href="check_DataComment_Length.xsl" />
<xsl:include href="check_DataBits_CountSignedValueText.xsl" />
<xsl:include href="check_DataBytes_Count_and_ASCII.xsl" />
<xsl:include href="check_Request.xsl" />
<xsl:include href="check_Device.xsl" />
<xsl:include href="check_DTCDeviceIdentifier.xsl" />
<xsl:include href="check_FirstDTC.xsl" />
<xsl:include href="check_TesterPresent_WithResponse.xsl" />

<xsl:include href="check_DataRead_Identification_Renault.xsl" />
<xsl:include href="check_ReadDTCInformation_ReportDTC.xsl" />
<xsl:include href="check_ReadDTCInformation_ReportExtendedData.xsl" />
<xsl:include href="check_ReadDTCInformation_ReportExtendedData_Mileage.xsl" />
<xsl:include href="check_ReadDTCInformation_ReportSnapshot.xsl" />

<xsl:include href="listRules.xsl" />

<xsl:include href="check_CanIDs.xsl" />
<xsl:include href="check_DataUnit.xsl" />
<xsl:include href="check_Overlap.xsl" />
<xsl:include href="check_ByteBoundary.xsl" />
<xsl:include href="check_Projects.xsl"/>
<xsl:include href="check_TargetName.xsl" />
<xsl:include href="check_ExtFiles.xsl" />
<xsl:include href="check_ForbiddenCharacters.xsl"/>

<xsl:include href="check_Routines_UDS.xsl"/>
<xsl:include href="check_Routines_ABC.xsl"/>

<xsl:include href="Tools.xsl" />

<!-- ************ Fonctions VB ************ -->
<xsl:include href="local_Functions.xsl" />

<!-- ************ FIN INCLUSIONS ************ -->


<!--  ************************************************
      ** DEFINITION DU NUMERO DE VERSION DU CHECKER ** 
      ************************************************ -->
  <!-- Ne pas oublier de mettre le V devant le n° de verion. Ex:
      <xsl:text>Vx.y</xsl:text> -->
  <xsl:variable name="currentVersion">
    <xsl:text>V1.11</xsl:text>
  </xsl:variable>


<!--  ***********************************************************
      ** DETERMINATION DU FICHIER GENERICADDRESSING A UTILISER **
      *********************************************************** -->
  <!-- Emplacement des fichiers -->
  <xsl:variable name="mGenAddFileNameLocal" select="'C:\DDT2000data\vehicles\GenericAddressing.xml'"/>
  <xsl:variable name="mGenAddFileNameServer" select="'\\s1592aos\SiteWeb\DDT2000data\vehicles\GenericAddressing.xml'"/>
  <!-- Selection du fichier en fonction de son existance -->
  <xsl:variable name="mGenAddFileName">
    <xsl:choose>
      <xsl:when test="local:FileExists($mGenAddFileNameLocal)"><xsl:value-of select="$mGenAddFileNameLocal"/></xsl:when>
      <xsl:when test="local:FileExists($mGenAddFileNameServer)"><xsl:value-of select="$mGenAddFileNameServer"/></xsl:when>
      <xsl:otherwise><xsl:text>Not Found</xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


<!--  ************************************************
      ** DETERMINATION DU FICHIER PROJET A UTILISER **
      ************************************************ -->
  <!-- Emplacement des fichiers -->
  <xsl:variable name="mProjectsFileNameLocal" select="'C:\DDT2000data\vehicles\projects.xml'"/>
  <xsl:variable name="mProjectsFileNameServer" select="'\\s1592aos\SiteWeb\DDT2000data\vehicles\projects.xml'"/>
  <!-- Selection du fichier en fonction de son existance -->
  <xsl:variable name="mProjectsFileName">
    <xsl:choose>
      <xsl:when test="local:FileExists($mProjectsFileNameLocal)"><xsl:value-of select="$mProjectsFileNameLocal"/></xsl:when>
      <xsl:when test="local:FileExists($mProjectsFileNameServer)"><xsl:value-of select="$mProjectsFileNameServer"/></xsl:when>
      <xsl:otherwise><xsl:text>Not Found</xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Creation d'une première variable listant tous les projet Daimler contenus dans la base DDT -->
  <!-- Si il n'y en a aucun, cette variable sera vide -->
  <!-- Si le fichier Projects.xml n'a pas été trouvé, alors la valeur de la variable est 'FileNotExist' (cf variable IsDaimlerProject) -->
  <xsl:variable name="DaimlerProjectList">
    <xsl:choose>
      <xsl:when test="$mProjectsFileName != 'Not Found'">
        <xsl:for-each select="//ddt:Target/Projects/*">
          <xsl:variable name="code" select="name(.)" />
          <xsl:if test="document($mProjectsFileName)/projects/Manufacturer/name[.='DAIMLER']/../project[@code=$code]">
            <xsl:value-of select="$code"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>FileNotExist</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Creation de la variable final indiquant si la base contient au moins un projet Daimler -->
  <!-- Si la taille de la variable DaimlerProjectList est supérieur à 0, alors au moins un projet Daimler est défini -->
  <!-- Cas particulier : Dans le cas ou le fichier Projects.xml n'a pu être trouvé, on souhaite que la base soit considéré comme étant une base Daimler -->
  <!--    Pour cela, lorsque le fichier Projects.xml n'a pu être trouvé, la variable DaimlerProjectList a pour valeur 'FileNotExist' -->
  <!--    Sa taille étant donc supérieur à 0, la base est considérée comme étant une base Daimler -->
  <xsl:variable name="IsDaimlerProject">
    <xsl:choose>
      <xsl:when test="string-length($DaimlerProjectList) &gt; 0">
        <xsl:text>True</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>False</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


<!--  ********************************************************
      ** DETERMINATION DU FICHIER UNIT A UTILISER & VERSION **
      ******************************************************** -->
  <!-- Emplacement des fichiers -->
  <xsl:variable name="mUnitFileNameOfficial" select="'C:\DDT2000data\vehicles\units.xml'"/>
  <xsl:variable name="mUnitFileNameBackUp1" select="'C:\DDT2000data\checkBaseDDT\scripts\units.xml'"/>
  <xsl:variable name="mUnitFileNameBackUp2" select="'C:\Program Files (x86)\DDT2000\units.xml'"/>
  <!-- Selection du fichier en fonction de son existance -->
  <xsl:variable name="mUnitFileName">
    <xsl:choose>
      <xsl:when test="local:FileExists($mUnitFileNameOfficial)"><xsl:value-of select="$mUnitFileNameOfficial"/></xsl:when>
      <xsl:when test="local:FileExists($mUnitFileNameBackUp1)"><xsl:value-of select="$mUnitFileNameBackUp1"/></xsl:when>
      <xsl:when test="local:FileExists($mUnitFileNameBackUp2)"><xsl:value-of select="$mUnitFileNameBackUp2"/></xsl:when>
      <xsl:otherwise><xsl:text>Not Found</xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!-- Récupération du numéro de version -->
  <xsl:variable name="mUnitVersion">
    <xsl:choose>
      <xsl:when test="$mUnitFileName = 'Not Found'"><xsl:text>Not available</xsl:text></xsl:when>
      <xsl:when test="not(document($mUnitFileName)/units/@version)"><xsl:text>Not available</xsl:text></xsl:when>
      <xsl:otherwise><xsl:value-of select="document($mUnitFileName)/units/@version"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

<!--  *****************************************
      ** DETERMINATION DU NOM DU CALCULATEUR **
      ***************************************** -->      
  <xsl:variable name="mTargetName" select="string(/xml/ddt:Target/@Name)"/>
  <xsl:variable name="logFileName" select="local:NormalizeName(string(/xml/ddt:Target/@Name))"/>


<!--  ***************************************
      ** DETERMINATION DU PROTOCOL UTILISE ** 
      *************************************** -->
  <xsl:variable name="mSpecification">
    <xsl:choose>
      <!-- Test ReadDTC = '17FF00' and no $19 services -->
      <xsl:when test="//ddt:Target/ddt:Requests/ddt:Request[@Name = 'ReadDTC']/ddt:Sent/ddt:SentBytes = '17FF00'
              and
              not (//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[starts-with(ddt:SentBytes,'19')])">
        <xsl:choose>
          <xsl:when test="//ddt:Target/ddt:CAN">
            <xsl:text>DiagOnCanA</xsl:text>
          </xsl:when>
          <xsl:when test="//ddt:Target/ddt:K">
            <xsl:text>KWP2000</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>UNKNOWN_ReadDTC_NoPhysicalLayer</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <!-- Test ReadDTCInformation.ReportDTC='1902FF' and no $17 services -->
      <xsl:when test="//ddt:Target/ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportDTC']/ddt:Sent[starts-with(ddt:SentBytes,'1902')]
              and
              not (//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[starts-with(ddt:SentBytes,'17')])">
        <xsl:choose>
          <xsl:when test="(//ddt:Target/ddt:Requests/ddt:Request[@Name = 'TesterPresent.WithResponse']/ddt:Sent[starts-with(ddt:SentBytes,'3E00')])
                        or(//ddt:Target/ddt:Requests/ddt:Request[@Name = 'TesterPresent.WithResponse']/ddt:Sent[starts-with(ddt:SentBytes,'3E80')])">
            <xsl:text>UDS</xsl:text>
          </xsl:when>
          <xsl:when test="//ddt:Target/ddt:Requests/ddt:Request[@Name = 'TesterPresent.WithResponse']/ddt:Sent[starts-with(ddt:SentBytes,'3E')]">
            <xsl:text>DiagOnCanBC</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>UNKNOWN_ReadDTCInformation.ReportDTC_InvalidTesterPresent</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <!-- no or incorrect DTC reading service or both definition -->
      <xsl:otherwise>
        <xsl:text>UNKNOWN_UnexpectedDtcServiceDefinition</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


<!--  **********************************
      ** DEBUT DU CONTROLE DE LA BASE ** 
      ********************************** -->
  <xsl:template match="/">
    <check>
      <time_begin_total>
        <xsl:variable name="startTimerTotal" select="local:GetCurrentTimer()"></xsl:variable>
        <xsl:value-of select="local:GetCurrentTime()" />
      </time_begin_total>
        <xsl:apply-templates select="/xml/ddt:Target" />
      <time_end_total>
        <date><xsl:value-of select="local:GetCurrentTime()" /></date>
        <elapsedTime><xsl:value-of select="local:DiffTimer($startTimerTotal)" /></elapsedTime>
      </time_end_total>
    </check>
  </xsl:template>
  <!-- ************************************************************** -->
  



  <xsl:template match="ddt:Target">
    <!-- Set log file and get checker version -->
    <CheckerVersion><xsl:value-of select="local:CreateLogFile($logFileName, string($currentVersion))"/></CheckerVersion>
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: template match ddt:Target starts')"/></logmsg>

    <reportLanguage><xsl:value-of select="$language"/></reportLanguage>
    <IsDaimlerProject><xsl:value-of select="$IsDaimlerProject"/></IsDaimlerProject>

    <!--  ***************************************
          ** Lister les règles dans le rapport **
          *************************************** -->
    <xsl:call-template name="ListRules" />

    <!--  ****************************
          ** INFORMATIONS GENERALES **
          **************************** -->

    <!-- ** INFORMATIONS GENERALES : Nom de l'ECU ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desEcuName" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info"><xsl:value-of select="@Name" /></xsl:with-param>
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : Nom générique de l'ECU ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desGenericEcuName" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info"><xsl:value-of select="@group" /></xsl:with-param>
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : Fonction de l'ECU ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desFunction" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info"><xsl:value-of select="ddt:Function/@Name" /></xsl:with-param>
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : Adresse de la fonction ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desAddress" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info"><xsl:value-of select="ddt:Function/@Address" />
          (<xsl:call-template name="toHex">
            <xsl:with-param name="number"><xsl:value-of select="ddt:Function/@Address" /></xsl:with-param>
            <xsl:with-param name="digits">2</xsl:with-param>
            <xsl:with-param name="prefix">$</xsl:with-param>
          </xsl:call-template>)
      </xsl:with-param>
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : Logical address de la fonction ** -->
    <xsl:if test="ddt:Function/@LogicalAddress">
      <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desLogicalAddress" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
        <xsl:with-param name="info">
          $<xsl:value-of select="ddt:Function/@LogicalAddress" />
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <!-- ** INFORMATIONS GENERALES : Protocole de communication ** -->
    <xsl:call-template name="ProtocolType" />

    <!-- ** INFORMATIONS GENERALES : CAN IDs ** -->
    <xsl:if test="ddt:CAN">
      <xsl:call-template name="CanIDs"/>
    </xsl:if>

    <!-- ** INFORMATIONS GENERALES : Spécification utilisée ** -->
    <xsl:choose>
      <xsl:when test="$mSpecification = 'KWP2000'">
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/specification" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">01-58-108</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$mSpecification = 'DiagOnCanA'">
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/specification" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">36-00-013/--A</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$mSpecification = 'DiagOnCanBC'">
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/specification" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">36-00-013/--B, 36-00-013/--C</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$mSpecification = 'UDS'">
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/specification" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">36-00-011/--D (UDS)</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="message">
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/specification" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/UndefinedSpec" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_UndefinedSpecification</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/UndefinedSpec" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desReadDTCandReportDTC" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template><br/>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

    <!-- ** INFORMATIONS GENERALES : Auto-idents ** -->
    <xsl:apply-templates select="ddt:AutoIdents" />

    <!-- ** INFORMATIONS GENERALES : Date Officialisation ** -->
    <xsl:apply-templates select="ddt:DateOfficialisation" />

    <!-- ** INFORMATIONS GENERALES : Nombre de requête ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/numberOf" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info" select="count(ddt:Requests/ddt:Request)" />
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : Nombre de requête étant rapport de maintenabilité ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/numberOf" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/with" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desMaintainabilityReport" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info" select="count(ddt:Requests/ddt:Request/ddt:DossierMaintenabilite)" />
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : nombre de données ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/numberOf" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info" select="count(ddt:Datas/ddt:Data)" />
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : nombre de données de référence reçues ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desRefReceivedDataNb" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info" select="count(ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem[@Ref='1'])" />
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES :  Nombre de donnée de référence envoyées ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desRefSentDataNb" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info" select="count(ddt:Requests/ddt:Request/ddt:Sent/ddt:DataItem[@Ref='1'])" />
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : Fichier "GenericAddressing" utilisé ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/GenericAddressingFile" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info"><xsl:value-of select="$mGenAddFileName"/></xsl:with-param>
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : Fichier "Projects.xml" utilisé ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/ProjectFile" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info"><xsl:value-of select="$mProjectsFileName"/></xsl:with-param>
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!-- ** INFORMATIONS GENERALES : Fichier "units.xml" utilisé et version ** -->
    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/UnitsFile" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
        <br />
        Version
      </xsl:with-param>
      <xsl:with-param name="info">
        <xsl:value-of select="$mUnitFileName"/>
        <br />
        <xsl:value-of select="$mUnitVersion"/>
      </xsl:with-param>
      <xsl:with-param name="action" />
    </xsl:call-template>

    <!--  *************************************************
          ** VERIFICATION ACCESSIBILITE FICHIERS EXTERNE **
          ************************************************* -->
    <xsl:call-template name="ExternalFiles"/>

    <!--  *************************************************************
          ** VERIFICATION COHERENCE BASE / FICHIER GENERICADDRESSING **
          ************************************************************* -->
    <xsl:call-template name="GenericAdressing" />

    <!--  **************************************
          ** VERIFICATION CARACTERES INTERDIT **
          ************************************** -->
    <time_begin>
      <xsl:variable name="forbiddenCharTimer" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()"/>
    </time_begin>
    <xsl:call-template name="check_ForbiddenCharacters"/>
    <time_end>
    ***Time checking forbidden characters: <xsl:value-of select="local:DiffTimer($forbiddenCharTimer)"/>*****
    <xsl:value-of select="local:GetCurrentTime()"/>
    </time_end>

    <!-- ******************************************
         Check Target Name
         ****************************************** -->
    <time_begin>
      <xsl:variable name="targetNameTimer" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()"/>
    </time_begin>
    <xsl:call-template name="TargetName"/>
    <time_end>
    ***Time checking ECU name: <xsl:value-of select="local:DiffTimer($targetNameTimer)"/>*****
    <xsl:value-of select="local:GetCurrentTime()"/>
    </time_end>


    <!-- ******************************************
         Check Projects exists on projects.xml file 
         ****************************************** -->
    <time_begin>
      <xsl:variable name="projectsTimer" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()"/>
    </time_begin>
    <xsl:call-template name="check_Projects"/>
    <time_end>
    ***Time checking Projects: <xsl:value-of select="local:DiffTimer($projectsTimer)"/>*****
    <xsl:value-of select="local:GetCurrentTime()"/>
    </time_end>

    <!-- *******************
           Check request $21..
           ******************* -->
    <!--
    <time_begin>
      <xsl:variable name="startTimer1" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:apply-templates select="ddt:Requests/ddt:Request/ddt:Sent[substring(ddt:SentBytes,1,2) = '21']" />
    <time_end>
      ***Time Check request $21..: <xsl:value-of select="local:DiffTimer($startTimer1)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    -->
    <!-- **************************************************************
           Check Request Sent DataItem FirstByte and BitOffset attributes
           ************************************************************** -->
    <time_begin>
      <xsl:variable name="startTimer2" select="local:GetCurrentTimer()"></xsl:variable>
      <h44><xsl:value-of select="$startTimer2"></xsl:value-of></h44>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="RequestSentDataItem" />
    <time_end>
      ***Time RequestSentDataItem: <xsl:value-of select="local:DiffTimer($startTimer2)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- **************************************************************
           Check Request Received DataItem FirstByte and BitOffset attributes
           ************************************************************** -->
    <time_begin>
      <xsl:variable name="startTimer3" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="RequestReceivedDataItem" />
    <time_end>
      ***Time RequestReceivedDataItem : <xsl:value-of select="local:DiffTimer($startTimer3)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *********************************************************************************************
         Check data Bits
           @count
           @Signed
             ListItem
               @value
               @text
        ********************************************************************************************** -->
    <time_begin>
      <xsl:variable name="startTimer4" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Bits starts')"/></logmsg>
      <xsl:apply-templates select="ddt:Datas/ddt:Data/ddt:Bits" />
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Bits ends')"/></logmsg>
    <time_end>
      ***Time Check data Bits  : <xsl:value-of select="local:DiffTimer($startTimer4)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- **********************
         Check data Bytes count
        *********************** -->
    <time_begin>
      <xsl:variable name="startTimer5" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Bytes starts')"/></logmsg>
      <xsl:apply-templates select="ddt:Datas/ddt:Data/ddt:Bytes" />
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Bytes ends')"/></logmsg>
    <time_end>
      ***Time Check data Bytes : <xsl:value-of select="local:DiffTimer($startTimer5)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
       <!-- ***************************************
       Check unsigned 32 bits data (not supported)
       ******************************************* -->
    <time_begin>
      <xsl:variable name="startTimer6" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="Data32BitsUnsigned" />
    <time_end>
      ***Time Data32BitsUnsigned: <xsl:value-of select="local:DiffTimer($startTimer6)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
       <!-- ***************************************
       Check divided by 0 data
       ******************************************* -->
    <time_begin>
      <xsl:variable name="startTimer24" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="DataNumericalDividedBy0" />
    <time_end>
      ***Time DataNumericalDividedBy0: <xsl:value-of select="local:DiffTimer($startTimer24)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *******************************************
       Check data  Bit Count >16 et !=24 et != 32 bits
       *********************************************** -->
    <time_begin>
      <xsl:variable name="startTimer7" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="Data_31BitsCount" />
    <time_end>
      ***Time Data_31BitsCount: <xsl:value-of select="local:DiffTimer($startTimer7)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- ********************************* -->
    <!-- **** Check data numeric list **** -->
    <!-- ********************************* -->
    <time_begin>
      <xsl:variable name="startTimer_dataNumericList" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Bits/ddt:List starts')"/></logmsg>
      <xsl:apply-templates select="ddt:Datas/ddt:Data/ddt:Bits/ddt:List" />
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates dddt:Datas/ddt:Data/ddt:Bits/ddt:List ends')"/></logmsg>
    <time_end>
      ***Time Data_NumericList: <xsl:value-of select="local:DiffTimer($startTimer_dataNumericList)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *****************
       Check ShiftBytesCount
       ********************* -->
    <time_begin>
      <xsl:variable name="startTimer8" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="ShiftBytesCount" />
    <time_end>
      ***Time ShiftBytesCount: <xsl:value-of select="local:DiffTimer($startTimer8)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *******************************************
       Check Data used in multiple request/unused data
       *********************************************** -->
    <time_begin>
      <xsl:variable name="startTimer9" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
        <xsl:call-template name="DataInMultipleRequestOrUnused" />
    <time_end>
      ***Time DataInMultipleRequestOrUnused: <xsl:value-of select="local:DiffTimer($startTimer9)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *******************************************
       Check Duplicate Data used in request
       *********************************************** -->
    <time_begin>
      <xsl:variable name="startTimer19" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
        <xsl:call-template name="DuplicateDataInRequest" />
    <time_end>
      ***Time DuplicateDataInRequest: <xsl:value-of select="local:DiffTimer($startTimer19)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- ***********************
       Check Duplicate Data
       *********************** -->
    <time_begin>
      <xsl:variable name="startTimer10" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
        <!--xsl:call-template name="DuplicateData"/-->
    <time_end>
      ***Time DuplicateData: <xsl:value-of select="local:DiffTimer($startTimer10)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- ***********************
       Check Duplicate Request
       *********************** -->
    <time_begin>
      <xsl:variable name="startTimer11" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
        <xsl:call-template name="DuplicateRequest" />
    <time_end>
      ***Time DuplicateRequest: <xsl:value-of select="local:DiffTimer($startTimer11)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- ***********************
       Check Little Endian format
       *********************** -->
    <time_begin>
      <xsl:variable name="startTimer12" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="DataItem_LittleEndian" />
    <time_end>
      ***Time DataItem_LittleEndian: <xsl:value-of select="local:DiffTimer($startTimer12)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>

    <!-- ***********************
       Check unit
       *********************** -->
     <time_begin>
      <xsl:variable name="startTimerUnit" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
     </time_begin>
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Bits/ddt:Scaled[@Unit] starts')"/></logmsg>
      <xsl:if test="$mUnitFileName != 'Not Found'">
        <xsl:apply-templates select="ddt:Datas/ddt:Data/ddt:Bits/ddt:Scaled[@Unit]" />
      </xsl:if>
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Bits/ddt:Scaled[@Unit] ends')"/></logmsg>
     <time_end>
      ***Time DataUnit: <xsl:value-of select="local:DiffTimer($startTimerUnit)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
     </time_end>

    <!-- *********
       Check Address
       ************** -->
    <time_begin>
      <xsl:variable name="startTimer13" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="AddressFunction" />
    <time_end>
      ***Time AddressFunction: <xsl:value-of select="local:DiffTimer($startTimer13)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *****************************************************************************************
       Check Data Name length
       *********************************************************************************************-->
    <time_begin>
      <xsl:variable name="startTimer14" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data starts')"/></logmsg>
      <xsl:apply-templates select="ddt:Datas/ddt:Data" />
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data ends')"/></logmsg>
    <time_end>
      ***Time Check Data Name : <xsl:value-of select="local:DiffTimer($startTimer14)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *****************************************************************************************
       Check Data Comment length
       ********************************************************************************************* -->
    <time_begin>
      <xsl:variable name="startTimer15" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Comment starts')"/></logmsg>
      <xsl:apply-templates select="ddt:Datas/ddt:Data/ddt:Comment" />
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Datas/ddt:Data/ddt:Comment ends')"/></logmsg>
    <time_end>
      ***Time Check Data Comment : <xsl:value-of select="local:DiffTimer($startTimer15)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *********************************************************************************
      Check request
        @Name  length
            invalid char
        <SentBytes>  pair
              DDT2000 limits
              CPDD limits
        <MinBytes>  DDT2000 limits
              CPDD limits
        <ReplyBytes>  DDT2000 limits
                CPDD limits
       ************************************************************************************* -->
    <!--<xsl:apply-templates select="ddt:Requests/ddt:Request" />-->
    <time_begin>
      <xsl:variable name="startTimer16" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="Request" />
    <time_end>
      ***Time Check Request: <xsl:value-of select="local:DiffTimer($startTimer16)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *********************************************************************************
       Check generic RoutineControl request
       ************************************************************************************* -->
    <time_begin>
      <xsl:variable name="startTimerGenericRoutineControl" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:choose>
        <xsl:when test="$mSpecification = 'UDS'">
          <xsl:call-template name="Routine_Generic_UDS" />
        </xsl:when>
        <xsl:otherwise>
          <!-- Pas de règle pour les specifications KWP2000-A-B/C pour le moment -->
        </xsl:otherwise>
      </xsl:choose>
    <time_end>
      ***Time Check Request: <xsl:value-of select="local:DiffTimer($startTimerGenericRoutineControl)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>
    <!-- *********************************************************************************
       Check DeviceName
       ************************************************************************************* -->
    <time_begin>
      <xsl:variable name="startTimer17" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Devices/ddt:Device starts')"/></logmsg>
      <xsl:apply-templates select="ddt:Devices/ddt:Device" />
      <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: apply-templates ddt:Devices/ddt:Device ends')"/></logmsg>
    <time_end>
      ***Time Check Device : <xsl:value-of select="local:DiffTimer($startTimer17)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>

    <xsl:choose>
      <!-- ********************************************** -->
      <!-- Contrôles spécification 01-58-108, 36-00-013/A -->
      <!-- ********************************************** -->
      <xsl:when test="($mSpecification = 'KWP2000') or ($mSpecification = 'DiagOnCanA')">
        <time_begin><xsl:value-of select="local:GetCurrentTime()" /></time_begin>
        <xsl:call-template name="ReadDTC_SpecA" />
        <time_end><xsl:value-of select="local:GetCurrentTime()" /></time_end>
        <!-- *********************************************************************************
         Check FirstDTC
         ************************************************************************************* -->
        <time_begin>
          <xsl:variable name="startTimer21" select="local:GetCurrentTimer()"></xsl:variable>
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_begin>
          <xsl:call-template name="FirstDTC" />
        <time_end>
          ***Time Check FirstDTC: <xsl:value-of select="local:DiffTimer($startTimer21)" />*****
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_end>
      </xsl:when>

      <!-- *********************************** -->
      <!-- Contrôles spécification 36-00-013/B -->
      <!-- *********************************** -->
      <xsl:when test="$mSpecification = 'DiagOnCanBC'">
        <time_begin>
          <xsl:variable name="startTimer18" select="local:GetCurrentTimer()"></xsl:variable>
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_begin>
          <xsl:call-template name="check_SpecB" />
        <time_end>
          ***Time check_SpecB: <xsl:value-of select="local:DiffTimer($startTimer18)" />*****
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_end>
        <!-- *********************************************************************************
         Check DTCDeviceIdentifier
         ************************************************************************************* -->
        <time_begin>
          <xsl:variable name="startTimer20" select="local:GetCurrentTimer()"></xsl:variable>
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_begin>
          <xsl:call-template name="DTCDeviceIdentifier" />
        <time_end>
          ***Time Check DTCDeviceIdentifier: <xsl:value-of select="local:DiffTimer($startTimer20)" />*****
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_end>
      </xsl:when>

      <!-- *********************************** -->
      <!-- Contrôles spécification UDS -->
      <!-- *********************************** -->
      <xsl:when test="$mSpecification = 'UDS'">
        <time_begin>
          <xsl:variable name="startTimer22" select="local:GetCurrentTimer()"></xsl:variable>
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_begin>
          <xsl:call-template name="check_Spec_UDS" />
        <time_end>
          ***Time check Spec UDS: <xsl:value-of select="local:DiffTimer($startTimer22)" />*****
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_end>
        <!-- *********************************************************************************
         Check DTCDeviceIdentifier
         ************************************************************************************* -->
        <time_begin>
          <xsl:variable name="startTimer23" select="local:GetCurrentTimer()"></xsl:variable>
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_begin>
          <xsl:call-template name="DTCDeviceIdentifier" />
        <time_end>
          ***Time Check DTCDeviceIdentifier: <xsl:value-of select="local:DiffTimer($startTimer23)" />*****
          <xsl:value-of select="local:GetCurrentTime()" />
        </time_end>
      </xsl:when>
    </xsl:choose>


    <!-- *********************************** -->
    <!-- Contrôles DAIMLER-->
    <!-- *********************************** -->
    <time_begin>
      <xsl:variable name="startTimer23" select="local:GetCurrentTimer()"></xsl:variable>
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_begin>
      <xsl:call-template name="check_DaimlerAlliance" />
    <time_end>
      ***Time check DAIMLER: <xsl:value-of select="local:DiffTimer($startTimer23)" />*****
      <xsl:value-of select="local:GetCurrentTime()" />
    </time_end>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: template match ddt:Target ends')"/></logmsg>
  </xsl:template>



<!-- ************************************************************************************************************************ -->
<!-- ********************************** TEMPLATES DEFINITIONS *************************************************************** -->
<!-- ************************************************************************************************************************ -->
<!-- *********** -->
<!-- Auto-idents -->
<!-- *********** -->
  <xsl:template match="ddt:AutoIdents">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: template match ddt:AutoIdents starts')"/></logmsg>
  
    <xsl:call-template name="message">
      <xsl:with-param name="description">Auto-Ident</xsl:with-param>
      <xsl:with-param name="info">
        <table style="border-collapse:collapse">
            <tr>
              <th style="background-color:white;color:black;">VDiag</th>
              <th style="background-color:white;color:black;">Supplier</th>
              <th style="background-color:white;color:black;">Soft</th>
              <th style="background-color:white;color:black;">Version</th>
            </tr>

            <xsl:for-each select="ddt:AutoIdent">
              <tr>
                <td>
                  <xsl:value-of select="@DiagVersion" />
                  (<xsl:call-template name="toHex">
                    <xsl:with-param name="number"><xsl:value-of select="@DiagVersion" /></xsl:with-param>
                    <xsl:with-param name="digits">2</xsl:with-param>
                    <xsl:with-param name="prefix">$</xsl:with-param>
                  </xsl:call-template>)
                </td>
                <td><xsl:value-of select="@Supplier" /></td>
                <td><xsl:value-of select="@Soft" /></td>
                <td><xsl:value-of select="@Version" /></td>
              </tr>
            </xsl:for-each>
        </table>
      </xsl:with-param>
    </xsl:call-template>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: template match ddt:AutoIdents ends')"/></logmsg>
  </xsl:template>


<!-- ********************** -->
<!-- Date d'officialisation -->
<!-- ********************** -->
  <xsl:template match="ddt:DateOfficialisation">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: template match ddt:DateOfficialisation starts')"/></logmsg>

    <xsl:call-template name="message">
      <xsl:with-param name="description">
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desOfficializationDate" />
          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="info"><xsl:value-of select="." /></xsl:with-param>
    </xsl:call-template>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: template match ddt:DateOfficialisation ends')"/></logmsg>
  </xsl:template>


<!-- ******** -->
<!-- Protocol -->
<!-- ******** -->
  <xsl:template match="ddt:Protocol">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: template match ddt:Protocol starts')"/></logmsg>

    <Protocol><xsl:value-of select="@Name" /></Protocol>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'checkbaseDDT.xsl: template match ddt:Protocol ends')"/></logmsg>
  </xsl:template>


</xsl:stylesheet>
