<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
  <xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

  <!-- ************* INCLUDE FILES ************ -->
  <xsl:include href="rules_DisplayTemplates.xsl" />
  <!-- **************************************** -->

  <!-- ********** VARIABLES GLOBALES ********** -->
  <!-- get/set current version -->
  <xsl:variable name="mCurrentVersion">
    <xsl:choose>
      <xsl:when test="//check/CheckerVersion">
        <xsl:value-of select="//check/CheckerVersion" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="currentVersion" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- get/set language -->
  <!-- ****************************************
     le paramètre language est passé par
     checkbaseDDT.vbs
     si le paramètre language n'est pas passé
     la valeur par défaut est fr
     ***************************************** -->
  <xsl:param name="language">fr</xsl:param>
  <!-- *******************************************
  Définir la langue du rapport xml
     pour afficher le rapport (entêtes de colonne,...etc) dans la même langue
     ******************************************* -->
  <xsl:param name="reportLanguage">
    <xsl:choose>
      <xsl:when test="//check/reportLanguage">
        <!-- *******************************************************************
    le fichier xml contient la langue au moment où ont été réalisés
         les tests. C'est cette langue qui servira à afficher le rapport,
         indépendemment de la langue DDT au moment où on affiche le rapport.
         ex: langue DDT au moment des tests = 'fr' ==> le rapport (.xml) est en 'fr' et contient dans la balise /reportLanguage 'fr'
             langue DDT au moment où on affiche le rapport = 'en'
                            ==> reportLanguage=//check/reportLanguage = 'fr'
                            ==> affichage des entêtes,..etc et des tests en  'fr'
         ******************************************************************** -->
        <xsl:value-of select="//check/reportLanguage" />
      </xsl:when>
      <xsl:otherwise>
        <!-- ********************************************************************
    le fichier xml ne contient pas la langue au moment où ont été réalisés
         les tests. La langue qui servira à afficher le rapport sera la langue DDT
         au moment où on affiche le rapport.
         ex: langue DDT au moment des tests = 'fr' ==> le rapport (.xml) est en 'fr'
             langue DDT au moment où on affiche le rapport = 'en'
                      ==> reportLanguage=$language = 'en'
                      ==>affichage : entêtes de colonne,...etc en 'en' et tests en 'fr'
        ********************************************************************** -->
        <xsl:value-of select="$language" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>


  <!-- ************************************************************************************************************* -->
  <!-- ************************************************************************************************************* -->
  <!-- ************************************************************************************************************* -->
  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <xsl:call-template name="rules_CSS" />
        <xsl:call-template name="rules_Scripts" />
        <style type="text/css">
          <![CDATA[
              body,table,td
              {
                font-family:Verdana, Arial, Helvetica, sans-serif; font-size:8pt;
              }
              td
              {
                padding:2px 2px 2px 2px;
                empty-cells:show;
              }
              td.item
              {
                /*  border-bottom:1px gray dashed; */
              }
              td.channelTitle
              {
                font-weight:bold;
                font-size:120%;
                border:1px black solid;
                border-left:0px;
                background-color:#f0f0f0;
              }
              td.channelTitle a:hover
              {
                background-color:#f0f0f0;
                text-decoration:underline;
              }
              td.separator
              {
                 border-bottom:1px dashed black;
              }
              a:hover
              {
                background-color:#f0f0f0;
              }
              a.imageLink:hover
              {
                background-color:transparent;
              }
              a
              {
                text-decoration:none;
              }
              a.item
              {
                font-weight:bold;
              }
              a.title
              {
                padding:4px;
              }
              a.title:hover
              {
                text-decoration:underline;
              }
              a.whiteLink
              {
                color:white;
              }
              a.whiteLink:hover
              {
                background-color:#808080;
              }
              .date
              {
                font-size:85%;
                font-style:italic;
              }
              .channelTitleImage
              {
                padding:2px;
                border:1px black solid;
                border-right:0px;
                background-color:#f0f0f0;
              }
              .channelDescription, .description, .author
              {
                display:block;
                margin-left:8px;
              }
              .channelDescription
              {
                font-size:105%;
              }
              .copyright, .author
              {
                font-size:80%;
                font-style:italic;
              }
              td, th
              {
                border:1px solid black;
                vertical-align:top;
              }
              th
              {
                vertical-align:middle;
                  PADDING-RIGHT: 1px;
                  PADDING-LEFT: 1px;
                  FONT-WEIGHT: bold;
              /*    FONT-SIZE: x-small;*/
                  MARGIN: 2px;
                  COLOR: white;
                  BORDER-TOP: 1px outset;
                  BORDER-RIGHT: 1px outset;
                  BORDER-LEFT: 1px outset;
                  BORDER-BOTTOM: 1px outset;
                  TEXT-ALIGN: center;
                  background-color:#000080;
              }
              td.cellule_normale
              {
                text-align:center;
              }
              table.warning th
              {
                color: black;
                  BACKGROUND-COLOR: orange;
              }
              div.warning
              {
                font-weight:bold;
                color: black;
                  BACKGROUND-COLOR: orange;
              }
              th.warningTitle, th.warningCount
              {
                font-size:120%;
                padding:8px;
              }
              td.cellule_warning
              {
                font-weight:bold;
                color: black;
                  BACKGROUND-COLOR: orange;
                  text-align:center;
              }
              table.error th
              {
                color: white;
                  BACKGROUND-COLOR: red;
              }
              div.error
              {
                font-weight:bold;
                color: white;
                  BACKGROUND-COLOR: red;
              }
              th.errorTitle, th.errorCount
              {
                font-size:120%;
                padding:8px;
              }
              td.cellule_error
              {
                font-weight:bold;
                color: white;
                  BACKGROUND-COLOR: red;
                  text-align:center;
              }
              td.cellule_error a
              {
                font-weight:bold;
                color: white;
              }
              td.cellule_error a:hover
              {
                background-color:red;
              }
              td.cellule_OK
              {
                font-weight:bold;
                color: white;
                  BACKGROUND-COLOR: green;
                  text-align:center;
              }
              td.cellule_OK a
              {
                color: white;
              }
              td.cellule_OK a:hover
              {
                background-color:green;
              }
              pre
              {
                margin:0px;
                padding-left:16px;
              }
              .redText
              {
                color:red;
              }
              td.cellule_currentversion
              {
                color: black;
                  BACKGROUND-COLOR:#e0e0e0 ;
              }

              ul
              {
                display:inline;
              }

              li
              {
                margin-left:25;
                display:list-item;
              }
            ]]>
        </style>
      </head>
      <body>
        <!-- ************************************************************* -->
        <!-- ************************************************************* -->
        <!--                        INITIALISATIONS                        -->
        <!-- ************************************************************* -->
        <!-- ************************************************************* -->
        <!-- ************************************************************* -->
        <!--                Compteurs de warning de DDT2000                -->
        <!-- ************************************************************* -->
        <!-- Counter DW001 --> <xsl:variable name="count_DDT2000_WAR_DataUsedInMultipleRequest" select="count(//check/warning[@chapter='DDT2000_WAR_DataUsedInMultipleRequest'])" />
        <!-- Counter DW002 --> <xsl:variable name="count_DDT2000_WAR_DataUnused" select="count(//check/warning[@chapter='DDT2000_WAR_DataUnused'])" />
        <!-- Counter DW003 --> <xsl:variable name="count_DDT2000_WAR_DataNameInvalidChar" select="count(//check/warning[@chapter='DDT2000_WAR_DataNameInvalidChar'])" />
        <!-- Counter DW005 --> <xsl:variable name="count_DDT2000_WAR_ShiftByteCount" select="count(//check/warning[@chapter='DDT2000_WAR_ShiftByteCount'])" />
        <!-- Counter DW006 --> <xsl:variable name="count_DDT2000_WAR_ReadDTCInformationReportDTC" select="count(//check/warning[@chapter='DDT2000_WAR_ReadDTCInformationReportDTC'])" />
        <!-- Warning DW007 associated with DW006 -->
        <!-- Counter DW008 --> <xsl:variable name="count_DDT2000_WAR_ReadDTCInformationReportSnapshot" select="count(//check/warning[@chapter='DDT2000_WAR_ReadDTCInformationReportSnapshot'])" />
        <!-- Counter DW009 --> <xsl:variable name="count_DDT2000_WAR_ClearDiagnosticInformationManual" select="count(//check/warning[@chapter='DDT2000_WAR_ClearDiagnosticInformationManual'])" />
        <!-- Counter DW010 --> <xsl:variable name="count_DDT2000_WAR_RequestNameInvalidChar" select="count(//check/warning[@chapter='DDT2000_WAR_RequestNameInvalidChar'])" />
        <!-- Counter DW011 --> <xsl:variable name="count_DDT2000_WAR_RequestTemplateMissing" select="count(//check/warning[@chapter='DDT2000_WAR_RequestTemplateMissing'])" />
        <!-- Counter DW012 --> <xsl:variable name="count_DDT2000_WAR_InjectorCode" select="count(//check/warning[@chapter='DDT2000_WAR_InjectorCode'])" />
        <!-- Counter DW187 REMOVE V1.11 <xsl:variable name="count_DDT2000_WAR_UDS_RoutineControl" select="count(//check/warning[@chapter='DDT2000_WAR_UDS_RoutineControl'])" /> -->
        <!-- Counter DW188 REMOVE V1.11 <xsl:variable name="count_DDT2000_WAR_UDS_OutputControl" select="count(//check/warning[@chapter='DDT2000_WAR_UDS_OutputControl'])" /> -->
        <!-- Counter DW192 --> <xsl:variable name="count_DDT2000_WAR_UDS_MissingReadDID" select="count(//check/warning[@chapter='DDT2000_WAR_UDS_MissingReadDID'])" />
        <!-- Counter DW193 --> <xsl:variable name="count_DDT2000_WAR_DataUnit" select="count(//check/warning[@chapter='DDT2000_WAR_DataUnit'])" />
        <!-- Counter DW194 --> <xsl:variable name="count_DDT2000_WAR_RoutineIdentifierMissing" select="count(//check/warning[@chapter='DDT2000_WAR_RoutineIdentifierMissing'])" />
        <!-- ************************************************************* -->
        <!--                     Total warning DDT2000                     -->
        <!-- ************************************************************* -->
        <xsl:variable name="total_DDT2000_WAR" select="
          $count_DDT2000_WAR_DataUsedInMultipleRequest        +
          $count_DDT2000_WAR_DataUnused                       +
          $count_DDT2000_WAR_DataNameInvalidChar              +
          $count_DDT2000_WAR_ShiftByteCount                   +
          $count_DDT2000_WAR_ReadDTCInformationReportDTC      +
          $count_DDT2000_WAR_ReadDTCInformationReportSnapshot +
          $count_DDT2000_WAR_ClearDiagnosticInformationManual +
          $count_DDT2000_WAR_RequestNameInvalidChar           +
          $count_DDT2000_WAR_RequestTemplateMissing           +
          $count_DDT2000_WAR_InjectorCode                     +
          $count_DDT2000_WAR_UDS_MissingReadDID               +
          $count_DDT2000_WAR_DataUnit                         +
          $count_DDT2000_WAR_RoutineIdentifierMissing
        " />
        <!-- ************************************************************* -->
        <!--                 Compteurs d'erreur de DDT2000                 -->
        <!-- ************************************************************* -->
        <!-- Counter DE001 --> <xsl:variable name="count_DDT2000_ERR_UndefinedSpecification" select="count(//check/error[@chapter='DDT2000_ERR_UndefinedSpecification'])" />
        <!-- Counter DE002 --> <xsl:variable name="count_DDT2000_ERR_ProtocolType" select="count(//check/error[@chapter='DDT2000_ERR_ProtocolType'])" />
        <!-- Counter DE003 --> <xsl:variable name="count_DDT2000_ERR_DataNameInvalidChar" select="count(//check/error[@chapter='DDT2000_ERR_DataNameInvalidChar'])" />
        <!-- Counter DE004 --> <xsl:variable name="count_DDT2000_ERR_DataBitsCount" select="count(//check/error[@chapter='DDT2000_ERR_DataBitsCount'])" />
        <!-- Counter DE005 --> <xsl:variable name="count_DDT2000_ERR_Unsigned32bitsNumericData" select="count(//check/error[@chapter='DDT2000_ERR_Unsigned32bitsNumericData'])" />
        <!-- Counter DE006 --> <xsl:variable name="count_DDT2000_ERR_DataBytesCount" select="count(//check/error[@chapter='DDT2000_ERR_DataBytesCount'])" />
        <!-- Counter DE007 --> <xsl:variable name="count_DDT2000_ERR_DTCDeviceIdentifierMissing" select="count(//check/error[@chapter='DDT2000_ERR_DTCDeviceIdentifierMissing'])" />
        <!-- Counter DE008 --> <xsl:variable name="count_DDT2000_ERR_FirstDTCMissing" select="count(//check/error[@chapter='DDT2000_ERR_FirstDTCMissing'])" />
        <!-- Counter DE009 --> <xsl:variable name="count_DDT2000_ERR_DataNumericalDividedBy0" select="count(//check/error[@chapter='DDT2000_ERR_DataNumericalDividedBy0'])" />
        <!-- Counter DE010 --> <xsl:variable name="count_DDT2000_ERR_RequestSentDataItemName" select="count(//check/error[@chapter='DDT2000_ERR_RequestSentDataItemName'])" />
        <!-- Counter DE011 --> <xsl:variable name="count_DDT2000_ERR_RequestSentDataOutSideOfRequest" select="count(//check/error[@chapter='DDT2000_ERR_RequestSentDataOutSideOfRequest'])" />
        <!-- Error   DE012 NOT CHECKED -->
        <!-- Counter DE013 --> <xsl:variable name="count_DDT2000_ERR_RequestSentDataItemFirstByte" select="count(//check/error[@chapter='DDT2000_ERR_RequestSentDataItemFirstByte'])" />
        <!-- Error   DE014 associated with DE013 -->
        <!-- Counter DE015 --> <xsl:variable name="count_DDT2000_ERR_RequestSentDataItemBitOffset" select="count(//check/error[@chapter='DDT2000_ERR_RequestSentDataItemBitOffset'])" />
        <!-- Counter DE017 --> <xsl:variable name="count_DDT2000_ERR_RequestSentDataItemRef" select="count(//check/error[@chapter='DDT2000_ERR_RequestSentDataItemRef'])" />
        <!-- Counter DE019 --> <xsl:variable name="count_DDT2000_ERR_DuplicateSentDataItemInRequest" select="count(//check/error[@chapter='DDT2000_ERR_DuplicateSentDataItemInRequest'])" />
        <!-- Counter DE020 --> <xsl:variable name="count_DDT2000_ERR_RequestReceivedDataItemName" select="count(//check/error[@chapter='DDT2000_ERR_RequestReceivedDataItemName'])" />
        <!-- Counter DE021 --> <xsl:variable name="count_DDT2000_ERR_RequestReceivedDataOutSideOfRequest" select="count(//check/error[@chapter='DDT2000_ERR_RequestReceivedDataOutSideOfRequest'])" />
        <!-- Error   DE022 NOT CHECKED -->
        <!-- Counter DE023 --> <xsl:variable name="count_DDT2000_ERR_RequestReceivedDataItemFirstByte" select="count(//check/error[@chapter='DDT2000_ERR_RequestReceivedDataItemFirstByte'])" />
        <!-- Error   DE024 associated with DE023 -->
        <!-- Counter DE025 --> <xsl:variable name="count_DDT2000_ERR_RequestReceivedDataItemBitOffset" select="count(//check/error[@chapter='DDT2000_ERR_RequestReceivedDataItemBitOffset'])" />
        <!-- Counter DE027 --> <xsl:variable name="count_DDT2000_ERR_DuplicateReceivedDataInRequest" select="count(//check/error[@chapter='DDT2000_ERR_DuplicateReceivedDataInRequest'])" />
        <!-- Counter DE031 --> <xsl:variable name="count_DDT2000_ERR_RequestNameInvalidChar" select="count(//check/error[@chapter='DDT2000_ERR_RequestNameInvalidChar'])" />
        <!-- Counter DE032 NOT CHECKED -->
        <!-- Counter DE033 --> <xsl:variable name="count_DDT2000_ERR_RequestSentBytes" select="count(//check/error[@chapter='DDT2000_ERR_RequestSentBytes'])" />
        <!-- Counter DE034 --> <xsl:variable name="count_DDT2000_ERR_RequestReceivedMinBytes" select="count(//check/error[@chapter='DDT2000_ERR_RequestReceivedMinBytes'])" />
        <!-- Counter DE035 --> <xsl:variable name="count_DDT2000_ERR_RequestReceivedReplyBytes" select="count(//check/error[@chapter='DDT2000_ERR_RequestReceivedReplyBytes'])" />
        <!-- Counter DE036 --> <xsl:variable name="count_DDT2000_ERR_RequestCoherenceSendBytesReplyBytes" select="count(//check/error[@chapter='DDT2000_ERR_RequestCoherenceSendBytesReplyBytes'])" />
        <!-- Counter DE037 --> <xsl:variable name="count_DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport" select="count(//check/error[@chapter='DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport'])" />
        <!-- Counter DE038 --> <xsl:variable name="count_DDT2000_ERR_TesterPresent" select="count(//check/error[@chapter='DDT2000_ERR_TesterPresent'])" />
        <!-- Counter DE050 --> <xsl:variable name="count_DDT2000_ERR_ReadDTCInformationReportDTC" select="count(//check/error[@chapter='DDT2000_ERR_ReadDTCInformationReportDTC'])" />
        <!-- Errors  DE051/DE052 associated with DE050 -->
        <!-- Counter DE054 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatusAvailabilityMask" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatusAvailabilityMask'])" />
        <!-- Counter DE055 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCDeviceIdentifier" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCDeviceIdentifier'])" />
        <!-- Counter DE056 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD'])" />
        <!-- Counter DE057 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCFailureType_Category" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCFailureType_Category'])" />
        <!-- Counter DE058 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCFailureType" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCFailureType'])" />
        <!-- Counter DE059 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier'])" />
        <!-- Counter DE060 --> <xsl:variable name="count_DDT2000_ERR_1902_StatusOfDTC" select="count(//check/error[@chapter='DDT2000_ERR_1902_StatusOfDTC'])" />
        <!-- Counter DE061 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested'])" />
        <!-- Counter DE062 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle'])" />
        <!-- Counter DE063 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear'])" />
        <!-- Counter DE064 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear'])" />
        <!-- Counter DE065 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatus_confirmedDTC" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatus_confirmedDTC'])" />
        <!-- Counter DE066 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatus_pendingDTC" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatus_pendingDTC'])" />
        <!-- Counter DE067 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle'])" />
        <!-- Counter DE068 --> <xsl:variable name="count_DDT2000_ERR_1902_DTCStatus_testFailed" select="count(//check/error[@chapter='DDT2000_ERR_1902_DTCStatus_testFailed'])" />
        <!-- Counter DE080 --> <xsl:variable name="count_DDT2000_ERR_ReadDTCInformationReportExtendedData" select="count(//check/error[@chapter='DDT2000_ERR_ReadDTCInformationReportExtendedData'])" />
        <!-- Errors  DE081/DE082/DE083 associated with DE080 -->
        <!-- Counter DE084 --> <xsl:variable name="count_DDT2000_ERR_1906FF_DTCMaskRecord"  select="count(//check/error[@chapter='DDT2000_ERR_1906FF_DTCMaskRecord'])" />
        <!-- Counter DE085 --> <xsl:variable name="count_DDT2000_ERR_1906FF_DTCRecord"  select="count(//check/error[@chapter='DDT2000_ERR_1906FF_DTCRecord'])" />
        <!-- Counter DE086 --> <xsl:variable name="count_DDT2000_ERR_1906FF_StatusOfDTC"  select="count(//check/error[@chapter='DDT2000_ERR_1906FF_StatusOfDTC'])" />
        <!-- Counter DE087 --> <xsl:variable name="count_DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber"  select="count(//check/error[@chapter='DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber'])" />
        <!-- Counter DE088 --> <xsl:variable name="count_DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter"  select="count(//check/error[@chapter='DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter'])" />
        <!-- Counter DE089 --> <xsl:variable name="count_DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter"  select="count(//check/error[@chapter='DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter'])" />
        <!-- Counter DE090 --> <xsl:variable name="count_DDT2000_ERR_1906FF_DTCExtendedData_Mileage"  select="count(//check/error[@chapter='DDT2000_ERR_1906FF_DTCExtendedData_Mileage'])" />
        <!-- Counter DE091 --> <xsl:variable name="count_DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName" select="count(//check/error[@chapter='DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName'])" />
        <!-- Counter DE100 --> <xsl:variable name="count_DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage" select="count(//check/error[@chapter='DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage'])" />
        <!-- Errors  DE101/DE102/DE103 associated with DE100 -->
        <!-- Counter DE104 --> <xsl:variable name="count_DTT2000_ERR_190680_DTCMaskRecord" select="count(//check/error[@chapter='DTT2000_ERR_190680_DTCMaskRecord'])" />
        <!-- Counter DE105 --> <xsl:variable name="count_DDT2000_ERR_190680_DTCRecord" select="count(//check/error[@chapter='DDT2000_ERR_190680_DTCRecord'])" />
        <!-- Counter DE106 --> <xsl:variable name="count_DDT2000_ERR_190680_StatusOfDTC" select="count(//check/error[@chapter='DDT2000_ERR_190680_StatusOfDTC'])" />
        <!-- Counter DE107 --> <xsl:variable name="count_DDT2000_ERR_190680_DTCExtendedDataRecordNumber" select="count(//check/error[@chapter='DDT2000_ERR_190680_DTCExtendedDataRecordNumber'])" />
        <!-- Counter DE108 --> <xsl:variable name="count_DDT2000_ERR_190680_DTCExtendedData_Mileage" select="count(//check/error[@chapter='DDT2000_ERR_190680_DTCExtendedData_Mileage'])" />
        <!-- Counter DE109 --> <xsl:variable name="count_DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName" select="count(//check/error[@chapter='DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName'])" />
        <!-- Counter DE121 --> <xsl:variable name="count_DDT2000_ERR_ReadDTCInformationReportSnapshot" select="count(//check/error[@chapter='DDT2000_ERR_ReadDTCInformationReportSnapshot'])" />
        <!-- Errors  DE122/DE123 associated with DE121 -->
        <!-- Counter DE124 --> <xsl:variable name="count_DDT2000_ERR_1904_DTCMaskRecord" select="count(//check/error[@chapter='DDT2000_ERR_1904_DTCMaskRecord'])" />
        <!-- Counter DE125 --> <xsl:variable name="count_DDT2000_ERR_1904_DTCRecord" select="count(//check/error[@chapter='DDT2000_ERR_1904_DTCRecord'])" />
        <!-- Counter DE126 --> <xsl:variable name="count_DDT2000_ERR_1904_StatusOfDTC" select="count(//check/error[@chapter='DDT2000_ERR_1904_StatusOfDTC'])" />
        <!-- Counter DE127 --> <xsl:variable name="count_DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName" select="count(//check/error[@chapter='DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName'])" />
        <!-- Counter DE130 --> <xsl:variable name="count_DDT2000_ERR_IdentificationRenaultR2" select="count(//check/error[@chapter='DDT2000_ERR_IdentificationRenaultR2'])" />
        <!-- Errors  DE131/DE132/DE133/DE134/DE135/DE136/DE137/DE138/DE139/DE140/DE141/DE142/DE143/DE144 associated with DE130 -->
        <!-- Counter DE145 --> <xsl:variable name="count_DDT2000_ERR_BadLengthBasicPartList" select="count(//check/error[@chapter='DDT2000_ERR_BadLengthBasicPartList'])" />
        <!-- Counter DE146 --> <xsl:variable name="count_DDT2000_ERR_BreakDownType" select="count(//check/error[@chapter='DDT2000_ERR_BreakDownType'])" />
        <!-- Counter DE150 --> <xsl:variable name="count_DDT2000_ERR_DeviceName" select="count(//check/error[@chapter='DDT2000_ERR_DeviceName'])" />
        <!-- Counter DE151 --> <xsl:variable name="count_DDT2000_ERR_DeviceDTC" select="count(//check/error[@chapter='DDT2000_ERR_DeviceDTC'])" />
        <!-- Counter DE152 --> <xsl:variable name="count_DDT2000_ERR_DeviceDuplicateDTC" select="count(//check/error[@chapter='DDT2000_ERR_DeviceDuplicateDTC'])" />
        <!-- Counter DE153 --> <xsl:variable name="count_DDT2000_ERR_DeviceTestType" select="count(//check/error[@chapter='DDT2000_ERR_DeviceTestType'])" />
        <!-- Counter DE154 --> <xsl:variable name="count_DDT2000_ERR_DeviceTestOBD" select="count(//check/error[@chapter='DDT2000_ERR_DeviceTestOBD'])" />
        <!-- Counter DE155 --> <xsl:variable name="count_DDT2000_ERR_DeviceOBDnoBaseDTC" select="count(//check/error[@chapter='DDT2000_ERR_DeviceOBDnoBaseDTC'])" />
        <!-- Counter DE160 --> <xsl:variable name="count_DDT2000_ERR_DTCDeviceIdentifier" select="count(//check/error[@chapter='DDT2000_ERR_DTCDeviceIdentifier'])" />
        <!-- Counter DE161 --> <xsl:variable name="count_DDT2000_ERR_FirstDTC" select="count(//check/error[@chapter='DDT2000_ERR_FirstDTC'])" />
        <!-- Counter DE170 --> <xsl:variable name="count_DDT2000_ERR_AddressFunction" select="count(//check/error[@chapter='DDT2000_ERR_AddressFunction'])" />
        <!-- Counter DE171 --> <xsl:variable name="count_DDT2000_ERR_GenericAddressing" select="count(//check/error[@chapter='DDT2000_ERR_GenericAddressing'])" />
        <!-- Counter DE172 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F187" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F187'])" />
        <!-- Counter DE173 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F188" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F188'])" />
        <!-- Counter DE174 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F18A" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F18A'])" />
        <!-- Counter DE175 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F18C" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F18C'])" />
        <!-- Counter DE176 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F190" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F190'])" />
        <!-- Counter DE177 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F191" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F191'])" />
        <!-- Counter DE178 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F194" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F194'])" />
        <!-- Counter DE179 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F195" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F195'])" />
        <!-- Counter DE180 --> <xsl:variable name="count_DDT2000_ERR_UDS_22F1A0" select="count(//check/error[@chapter='DDT2000_ERR_UDS_22F1A0'])" />
        <!-- Counter DE181 --> <xsl:variable name="count_DDT2000_ERR_UDS_StartDiagnosticSession" select="count(//check/error[@chapter='DDT2000_ERR_UDS_StartDiagnosticSession'])" />
        <!-- Counter DE182 --> <xsl:variable name="count_DDT2000_ERR_UDS_ClearDiagnosticInformation" select="count(//check/error[@chapter='DDT2000_ERR_UDS_ClearDiagnosticInformation'])" />
        <!-- Counter DE183 --> <xsl:variable name="count_DDT2000_ERR_UDS_1901" select="count(//check/error[@chapter='DDT2000_ERR_UDS_1901'])" />
        <!-- Counter DE184 --> <xsl:variable name="count_DDT2000_ERR_UDS_1902" select="count(//check/error[@chapter='DDT2000_ERR_UDS_1902'])" />
        <!-- Counter DE185 --> <xsl:variable name="count_DDT2000_ERR_UDS_1903" select="count(//check/error[@chapter='DDT2000_ERR_UDS_1903'])" />
        <!-- Counter DE186 --> <xsl:variable name="count_DDT2000_ERR_UDS_190A" select="count(//check/error[@chapter='DDT2000_ERR_UDS_190A'])" />
        <!-- Counter DE189 --> <xsl:variable name="count_DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList" select="count(//check/error[@chapter='DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList'])" />
        <!-- Counter DE190 --> <xsl:variable name="count_DDT2000_ERR_UDS_OutputControl_OutputControlCommand" select="count(//check/error[@chapter='DDT2000_ERR_UDS_OutputControl_OutputControlCommand'])" />
        <!-- Counter DE191 --> <xsl:variable name="count_DDT2000_ERR_UDS_ForbiddenRequests" select="count(//check/error[@chapter='DDT2000_ERR_UDS_ForbiddenRequests'])" />
        <!-- Counter DE193 --> <xsl:variable name="count_DDT2000_ERR_UDS_Autoident" select="count(//check/error[@chapter='DDT2000_ERR_UDS_Autoident'])" />
        <!-- Counter DE194 --> <xsl:variable name="count_DDT2000_ERR_DeviceNameInvalidChar_error" select="count(//check/error[@chapter='DDT2000_ERR_DeviceNameInvalidChar_error'])" />
        <!-- Counter DE195 --> <xsl:variable name="count_DDT2000_ERR_DataListItemValue" select="count(//check/error[@chapter='DDT2000_ERR_DataListItemValue'])" />
        <!-- Counter DE196 --> <xsl:variable name="count_DDT2000_ERR_FunctionAddressCGW" select="count(//check/error[@chapter='DDT2000_ERR_FunctionAddressCGW'])" />
        <!-- Counter DE197 --> <xsl:variable name="count_DDT2000_ERR_CanIdInconsistency" select="count(//check/error[@chapter='DDT2000_ERR_CanIdInconsistency'])" />
        <!-- Counter DE198 --> <xsl:variable name="count_DDT2000_ERR_DtcObdFaultType" select="count(//check/error[@chapter='DDT2000_ERR_DtcObdFaultType'])" />
        <!-- Counter DE199 --> <xsl:variable name="count_DDT2000_ERR_ProjectNotExist" select="count(//check/error[@chapter='DDT2000_ERR_ProjectNotExist'])" />
        <!-- Counter DE200 --> <xsl:variable name="count_DDT2000_ERR_TargetName" select="count(//check/error[@chapter='DDT2000_ERR_TargetName'])" />
        <!-- Counter DE201 --> <xsl:variable name="count_DDT200_ERR_MissingFiles" select="count(//check/error[@chapter='DDT200_ERR_MissingFiles'])" />
        <!-- Counter DE202 --> <xsl:variable name="count_DDT200_ERR_ForbiddenCharacter" select="count(//check/error[@chapter='DDT200_ERR_ForbiddenCharacter'])" />
        <!-- Counter DE203 --> <xsl:variable name="count_DDT200_ERR_InvalidNumericListItemText" select="count(//check/error[@chapter='DDT200_ERR_InvalidNumericListItemText'])" />
        <!-- Counter DE204 --> <xsl:variable name="count_DDT200_ERR_RoutineControlGeneric" select="count(//check/error[@chapter='DDT200_ERR_RoutineControlGeneric'])" />
        <!-- Counter DE205 --> <xsl:variable name="count_DDT200_ERR_RoutineControlType" select="count(//check/error[@chapter='DDT200_ERR_RoutineControlType'])" />
        <!-- Counter DE206 --> <xsl:variable name="count_DDT200_ERR_RoutineIdentifier" select="count(//check/error[@chapter='DDT200_ERR_RoutineIdentifier'])" />
        <!-- Counter DE207 --> <xsl:variable name="count_DDT200_ERR_RoutineControlMissingRID" select="count(//check/error[@chapter='DDT200_ERR_RoutineControlMissingRID'])" />
        

        <!-- ************************************************************* -->
        <!--                      Total erreur DDT2000                     -->
        <!-- ************************************************************* -->
        <xsl:variable name="total_DDT2000_ERR" select="
          $count_DDT2000_ERR_UndefinedSpecification                                   +
          $count_DDT2000_ERR_ProtocolType                                             +
          $count_DDT2000_ERR_DataNameInvalidChar                                      +
          $count_DDT2000_ERR_DataBitsCount                                            +
          $count_DDT2000_ERR_Unsigned32bitsNumericData                                +
          $count_DDT2000_ERR_DataBytesCount                                           +
          $count_DDT2000_ERR_DTCDeviceIdentifierMissing                               +
          $count_DDT2000_ERR_FirstDTCMissing                                          +
          $count_DDT2000_ERR_DataNumericalDividedBy0                                  +
          $count_DDT2000_ERR_RequestSentDataItemName                                  +
          $count_DDT2000_ERR_RequestSentDataOutSideOfRequest                          +
          $count_DDT2000_ERR_RequestSentDataItemFirstByte                             +
          $count_DDT2000_ERR_RequestSentDataItemBitOffset                             +
          $count_DDT2000_ERR_RequestSentDataItemRef                                   +
          $count_DDT2000_ERR_DuplicateSentDataItemInRequest                           +
          $count_DDT2000_ERR_RequestReceivedDataItemName                              +
          $count_DDT2000_ERR_RequestReceivedDataOutSideOfRequest                      +
          $count_DDT2000_ERR_RequestReceivedDataItemFirstByte                         +
          $count_DDT2000_ERR_RequestReceivedDataItemBitOffset                         +
          $count_DDT2000_ERR_DuplicateReceivedDataInRequest                           +
          $count_DDT2000_ERR_RequestNameInvalidChar                                   +
          $count_DDT2000_ERR_RequestSentBytes                                         +
          $count_DDT2000_ERR_RequestReceivedMinBytes                                  +
          $count_DDT2000_ERR_RequestReceivedReplyBytes                                +
          $count_DDT2000_ERR_RequestCoherenceSendBytesReplyBytes                      +
          $count_DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport    +
          $count_DDT2000_ERR_TesterPresent                                            +
          $count_DDT2000_ERR_ReadDTCInformationReportDTC                              +
          $count_DDT2000_ERR_1902_DTCStatusAvailabilityMask                           +
          $count_DDT2000_ERR_1902_DTCDeviceIdentifier                                 +
          $count_DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD                          +
          $count_DDT2000_ERR_1902_DTCFailureType_Category                             +
          $count_DDT2000_ERR_1902_DTCFailureType                                      +
          $count_DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier               +
          $count_DDT2000_ERR_1902_StatusOfDTC                                         +
          $count_DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested                 +
          $count_DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle       +
          $count_DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear                  +
          $count_DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear            +
          $count_DDT2000_ERR_1902_DTCStatus_confirmedDTC                              +
          $count_DDT2000_ERR_1902_DTCStatus_pendingDTC                                +
          $count_DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle             +
          $count_DDT2000_ERR_1902_DTCStatus_testFailed                                +
          $count_DDT2000_ERR_ReadDTCInformationReportExtendedData                     +
          $count_DDT2000_ERR_1906FF_DTCMaskRecord                                     +
          $count_DDT2000_ERR_1906FF_DTCRecord                                         +
          $count_DDT2000_ERR_1906FF_StatusOfDTC                                       +
          $count_DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber                       +
          $count_DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter                      +
          $count_DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter              +
          $count_DDT2000_ERR_1906FF_DTCExtendedData_Mileage                           +
          $count_DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName         +
          $count_DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage              +
          $count_DTT2000_ERR_190680_DTCMaskRecord                                     +
          $count_DDT2000_ERR_190680_DTCRecord                                         +
          $count_DDT2000_ERR_190680_StatusOfDTC                                       +
          $count_DDT2000_ERR_190680_DTCExtendedDataRecordNumber                       +
          $count_DDT2000_ERR_190680_DTCExtendedData_Mileage                           +
          $count_DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName  +
          $count_DDT2000_ERR_ReadDTCInformationReportSnapshot                         +
          $count_DDT2000_ERR_1904_DTCMaskRecord                                       +
          $count_DDT2000_ERR_1904_DTCRecord                                           +
          $count_DDT2000_ERR_1904_StatusOfDTC                                         +
          $count_DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName             +
          $count_DDT2000_ERR_IdentificationRenaultR2                                  +
          $count_DDT2000_ERR_BadLengthBasicPartList                                   +
          $count_DDT2000_ERR_BreakDownType                                            +
          $count_DDT2000_ERR_DeviceName                                               +
          $count_DDT2000_ERR_DeviceDTC                                                +
          $count_DDT2000_ERR_DeviceDuplicateDTC                                       +
          $count_DDT2000_ERR_DeviceTestType                                           +
          $count_DDT2000_ERR_DeviceTestOBD                                            +
          $count_DDT2000_ERR_DeviceOBDnoBaseDTC                                       +
          $count_DDT2000_ERR_DTCDeviceIdentifier                                      +
          $count_DDT2000_ERR_FirstDTC                                                 +
          $count_DDT2000_ERR_AddressFunction                                          +
          $count_DDT2000_ERR_GenericAddressing                                        +
          $count_DDT2000_ERR_UDS_22F187                                               +
          $count_DDT2000_ERR_UDS_22F188                                               +
          $count_DDT2000_ERR_UDS_22F18A                                               +
          $count_DDT2000_ERR_UDS_22F18C                                               +
          $count_DDT2000_ERR_UDS_22F190                                               +
          $count_DDT2000_ERR_UDS_22F191                                               +
          $count_DDT2000_ERR_UDS_22F194                                               +
          $count_DDT2000_ERR_UDS_22F195                                               +
          $count_DDT2000_ERR_UDS_22F1A0                                               +
          $count_DDT2000_ERR_UDS_StartDiagnosticSession                               +
          $count_DDT2000_ERR_UDS_ClearDiagnosticInformation                           +
          $count_DDT2000_ERR_UDS_1901                                                 +
          $count_DDT2000_ERR_UDS_1902                                                 +
          $count_DDT2000_ERR_UDS_1903                                                 +
          $count_DDT2000_ERR_UDS_190A                                                 +
          $count_DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList             +
          $count_DDT2000_ERR_UDS_OutputControl_OutputControlCommand                   +
          $count_DDT2000_ERR_UDS_ForbiddenRequests                                    +
          $count_DDT2000_ERR_UDS_Autoident                                            +
          $count_DDT2000_ERR_DeviceNameInvalidChar_error                              +
          $count_DDT2000_ERR_DataListItemValue                                        +
          $count_DDT2000_ERR_FunctionAddressCGW                                       +
          $count_DDT2000_ERR_CanIdInconsistency                                       +
          $count_DDT2000_ERR_DtcObdFaultType                                          +
          $count_DDT2000_ERR_ProjectNotExist                                          +
          $count_DDT2000_ERR_TargetName                                               +
          $count_DDT200_ERR_MissingFiles                                              +
          $count_DDT200_ERR_ForbiddenCharacter                                        +
          $count_DDT200_ERR_InvalidNumericListItemText                                +
          $count_DDT200_ERR_RoutineControlGeneric                                     +
          $count_DDT200_ERR_RoutineControlType                                        +
          $count_DDT200_ERR_RoutineIdentifier                                         +
          $count_DDT200_ERR_RoutineControlMissingRID
        " />


        <!-- ************************************************************* -->
        <!--                   Compteurs de warning CPDD                   -->
        <!-- ************************************************************* -->
        <!-- Counter CW001 --> <xsl:variable name="count_CPDD_WAR_DataUsedInMultipleRequest" select="count(//check/warning[@chapter='CPDD_WAR_DataUsedInMultipleRequest'])" />
        <!-- Counter CW002 --> <xsl:variable name="count_CPDD_WAR_DataComment" select="count(//check/warning[@chapter='CPDD_WAR_DataComment'])" />
        <!-- Counter CW003 --> <xsl:variable name="count_CPDD_WAR_DataItemLittleEndian" select="count(//check/warning[@chapter='CPDD_WAR_DataItemLittleEndian'])" />
        <!-- Counter CW004 --> <xsl:variable name="count_CPDD_WAR_Data_31BitsCount" select="count(//check/warning[@chapter='CPDD_WAR_Data_31BitsCount'])" />
        <!-- Counter CW005 --> <xsl:variable name="count_CPDD_WAR_DataListItemValue" select="count(//check/warning[@chapter='CPDD_WAR_DataListItemValue'])" />
        <!-- Counter CW006 --> <xsl:variable name="count_CPDD_WAR_DataListItemText" select="count(//check/warning[@chapter='CPDD_WAR_DataListItemText'])" />
        <!-- Counter CW007 --> <xsl:variable name="count_CPDD_WAR_DataBytesAscii" select="count(//check/warning[@chapter='CPDD_WAR_DataBytesAscii'])" />
        <!-- Counter CW008 --> <xsl:variable name="count_CPDD_WAR_DataBitsSigned" select="count(//check/warning[@chapter='CPDD_WAR_DataBitsSigned'])" />
        <!-- Counter CW020 --> <xsl:variable name="count_CPDD_WAR_DeviceTestType" select="count(//check/warning[@chapter='CPDD_WAR_DeviceTestType'])" />
        <!-- Counter CW021 --> <xsl:variable name="count_CPDD_WAR_DeviceTestOBD" select="count(//check/warning[@chapter='CPDD_WAR_DeviceTestOBD'])" />
        <!-- Counter CW023 --> <xsl:variable name="count_CPDD_WAR_DeviceDTC" select="count(//check/warning[@chapter='CPDD_WAR_DeviceDTC'])" />
        <!-- Counter CW024 --> <xsl:variable name="count_CPDD_WAR_ReplyMinBytes" select="count(//check/warning[@chapter='CPDD_WAR_ReplyMinBytes'])" />
        <!-- ************************************************************* -->
        <!--                       Total warning CPDD                      -->
        <!-- ************************************************************* -->
        <xsl:variable name="total_CPDD_WAR" select="
          $count_CPDD_WAR_DataUsedInMultipleRequest  +
          $count_CPDD_WAR_DataComment                +
          $count_CPDD_WAR_DataItemLittleEndian       +
          $count_CPDD_WAR_Data_31BitsCount           +
          $count_CPDD_WAR_DataListItemValue          +
          $count_CPDD_WAR_DataListItemText           +
          $count_CPDD_WAR_DataBytesAscii             +
          $count_CPDD_WAR_DataBitsSigned             +
          $count_CPDD_WAR_DeviceTestType             +
          $count_CPDD_WAR_DeviceTestOBD              +
          $count_CPDD_WAR_DeviceDTC                  +
          $count_CPDD_WAR_ReplyMinBytes
         " />
        <!-- ************************************************************* -->
        <!--                    Compteurs d'erreur CPDD                    -->
        <!-- ************************************************************* -->
        <!-- Counter CE002 --> <xsl:variable name="count_CPDD_ERR_DuplicateNormalizedDataName" select="count(//check/error[@chapter='CPDD_ERR_DuplicateNormalizedDataName'])" />
        <!-- Counter CE003 --> <xsl:variable name="count_CPDD_ERR_DataName" select="count(//check/error[@chapter='CPDD_ERR_DataName'])" />
        <!-- Counter CE030 --> <xsl:variable name="count_CPDD_ERR_RequestName" select="count(//check/error[@chapter='CPDD_ERR_RequestName'])" />
        <!-- Counter CE038 --> <xsl:variable name="count_CPDD_ERR_IdentificationRequestName" select="count(//check/error[@chapter='CPDD_ERR_IdentificationRequestName'])" />
        <!-- Counter CE150 --> <xsl:variable name="count_CPDD_ERR_DeviceName" select="count(//check/error[@chapter='CPDD_ERR_DeviceName'])" />
        <!-- Counter CE151 --> <xsl:variable name="count_CPDD_ERR_ReplyMinBytes" select="count(//check/error[@chapter='CPDD_ERR_ReplyMinBytes'])" />
        <!-- ************************************************************* -->
        <!--                        Total error CPDD                       -->
        <!-- ************************************************************* -->
        <xsl:variable name="total_CPDD_ERR" select="
          $count_CPDD_ERR_DuplicateNormalizedDataName      +
          $count_CPDD_ERR_DataName                         +
          $count_CPDD_ERR_RequestName                      +
          $count_CPDD_ERR_IdentificationRequestName        +
          $count_CPDD_ERR_DeviceName                       +
          $count_CPDD_ERR_ReplyMinBytes
        " />


        <!-- ************************************************************* -->
        <!--                  Compteurs de warning DAIMLER                 -->
        <!-- ************************************************************* -->
        <!-- Counter MW001 --> <xsl:variable name="count_DAIMLER_WAR_EmptyList" select="count(//check/warning[@chapter='DAIMLER_WAR_EmptyList'])" />
        <!-- Counter MW011 --> <xsl:variable name="count_DAIMLER_WAR_DataNameInvalidChar" select="count(//check/warning[@chapter='DAIMLER_WAR_DataNameInvalidChar'])" />
        <!-- Counter MW012 --> <xsl:variable name="count_DAIMLER_WAR_RequestNameInvalidChar" select="count(//check/warning[@chapter='DAIMLER_WAR_RequestNameInvalidChar'])" />
        <!-- ************************************************************* -->
        <!--                      Total warning DAIMLER                    -->
        <!-- ************************************************************* -->
        <xsl:variable name="total_DAIMLER_WAR" select="
          $count_DAIMLER_WAR_EmptyList              +
          $count_DAIMLER_WAR_DataNameInvalidChar    +
          $count_DAIMLER_WAR_RequestNameInvalidChar
        " />
        <!-- ************************************************************* -->
        <!--                   Compteurs d'erreur DAIMLER                  -->
        <!-- ************************************************************* -->
        <!-- Counter ME001 --> <xsl:variable name="count_DAIMLER_ERR_SID" select="count(//check/error[@chapter='DAIMLER_ERR_SID'])" />
        <!-- Counter ME002 --> <xsl:variable name="count_DAIMLER_ERR_ReplyByte" select="count(//check/error[@chapter='DAIMLER_ERR_ReplyByte'])" />
        <!-- Counter ME003 --> <xsl:variable name="count_DAIMLER_ERR_RequestByte" select="count(//check/error[@chapter='DAIMLER_ERR_RequestByte'])" />
        <!-- Counter ME004 --> <xsl:variable name="count_DAIMLER_ERR_MissingAutoIdent" select="count(//check/error[@chapter='DAIMLER_ERR_MissingAutoIdent'])" />
        <!-- Counter ME005 --> <xsl:variable name="count_DAIMLER_ERR_WrongAutoIdent" select="count(//check/error[@chapter='DAIMLER_ERR_WrongAutoIdent'])" />
        <!-- Counter ME006 --> <xsl:variable name="count_DAIMLER_ERR_DataItemOutsideFrame" select="count(//check/error[@chapter='DAIMLER_ERR_DataItemOutsideFrame'])" />
        <!-- Counter ME007 --> <xsl:variable name="count_DAIMLER_ERR_DataListItemValue" select="count(//check/error[@chapter='DAIMLER_ERR_DataListItemValue'])" />
        <!-- Counter ME008 --> <xsl:variable name="count_DAIMLER_ERR_IdentRequest" select="count(//check/error[@chapter='DAIMLER_ERR_IdentRequest'])" />
        <!-- Counter ME009 --> <xsl:variable name="count_DAIMLER_ERR_ReplyMinBytes" select="count(//check/error[@chapter='DAIMLER_ERR_ReplyMinBytes'])" />
        <!-- Counter ME010 --> <xsl:variable name="count_DAIMLER_ERR_ReplyBytes" select="count(//check/error[@chapter='DAIMLER_ERR_ReplyBytes'])" />
        <!-- Counter ME013 --> <xsl:variable name="count_DAIMLER_ERR_OutputControl_GenericRequest" select="count(//check/error[@chapter='DAIMLER_ERR_OutputControl_GenericRequest'])" />
        <!-- Counter ME014 --> <xsl:variable name="count_DAIMLER_ERR_OutputControlList_MissingID" select="count(//check/error[@chapter='DAIMLER_ERR_OutputControlList_MissingID'])" />
        <!-- Counter ME015 --> <xsl:variable name="count_DAIMLER_ERR_OutputPermanentControlList_Request" select="count(//check/error[@chapter='DAIMLER_ERR_OutputPermanentControlList_Request'])" />
        <!-- Counter ME016 --> <xsl:variable name="count_DAIMLER_ERR_DataName" select="count(//check/error[@chapter='DAIMLER_ERR_DataName'])" />
        <!-- Counter ME017 --> <xsl:variable name="count_DAIMLER_ERR_RequestName" select="count(//check/error[@chapter='DAIMLER_ERR_RequestName'])" />
        <!-- Counter ME018 --> <xsl:variable name="count_DAIMLER_ERR_RequestErrorSID" select="count(//check/error[@chapter='DAIMLER_ERR_RequestErrorSID'])" />
        <!-- Counter ME019 --> <xsl:variable name="count_DAIMLER_ERR_IdentF111" select="count(//check/error[@chapter='DAIMLER_ERR_IdentF111'])" />
        <!-- Counter ME020 --> <xsl:variable name="count_DAIMLER_ERR_IdentF121" select="count(//check/error[@chapter='DAIMLER_ERR_IdentF121'])" />
        <!-- Counter ME021 --> <xsl:variable name="count_DAIMLER_ERR_RoutineIdentifierMissing" select="count(//check/error[@chapter='DAIMLER_ERR_RoutineIdentifierMissing'])" />
        <!-- Counter ME022 --> <xsl:variable name="count_DAIMLER_ERR_ByteBoundary" select="count(//check/error[@chapter='DAIMLER_ERR_ByteBoundary'])" />
        <!-- Counter ME023 --> <xsl:variable name="count_DAIMLER_ERR_RequestOverlap" select="count(//check/error[@chapter='DAIMLER_ERR_RequestOverlap'])" />
        <!-- Counter ME024 --> <xsl:variable name="count_DAIMLER_ERR_ResponseOverlap" select="count(//check/error[@chapter='DAIMLER_ERR_ResponseOverlap'])" />

        <!-- ************************************************************* -->
        <!--                       Total error DAIMLER                     -->
        <!-- ************************************************************* -->
        <xsl:variable name="total_DAIMLER_ERR" select="
          $count_DAIMLER_ERR_SID                                +
          $count_DAIMLER_ERR_ReplyByte                          +
          $count_DAIMLER_ERR_RequestByte                        +
          $count_DAIMLER_ERR_MissingAutoIdent                   +
          $count_DAIMLER_ERR_WrongAutoIdent                     +
          $count_DAIMLER_ERR_DataItemOutsideFrame               +
          $count_DAIMLER_ERR_DataListItemValue                  +
          $count_DAIMLER_ERR_IdentRequest                       +
          $count_DAIMLER_ERR_ReplyMinBytes                      +
          $count_DAIMLER_ERR_ReplyBytes                         +
          $count_DAIMLER_ERR_OutputControl_GenericRequest       +
          $count_DAIMLER_ERR_OutputControlList_MissingID        +
          $count_DAIMLER_ERR_OutputPermanentControlList_Request +
          $count_DAIMLER_ERR_DataName                           +
          $count_DAIMLER_ERR_RequestName                        +
          $count_DAIMLER_ERR_RequestErrorSID                    +
          $count_DAIMLER_ERR_IdentF111                          +
          $count_DAIMLER_ERR_IdentF121                          +
          $count_DAIMLER_ERR_RoutineIdentifierMissing           +
          $count_DAIMLER_ERR_ByteBoundary                       +
          $count_DAIMLER_ERR_RequestOverlap                     +
          $count_DAIMLER_ERR_ResponseOverlap
        " />


        <!-- ************************************************************* -->
        <!--                  Compteurs de warning ALLIANCE                -->
        <!-- ************************************************************* -->
        <!-- Counter AW001 --> <xsl:variable name="count_ALLIANCE_WAR_DataName" select="count(//check/warning[@chapter='ALLIANCE_WAR_DataName'])" />
        <!-- Counter AW002 --> <xsl:variable name="count_ALLIANCE_WAR_EndianRedefinition" select="count(//check/warning[@chapter='ALLIANCE_WAR_EndianRedefinition'])" />
        <!-- Counter AW003 --> <xsl:variable name="count_ALLIANCE_WAR_RequestName" select="count(//check/warning[@chapter='ALLIANCE_WAR_RequestName'])" />
        <!-- Counter AW004 --> <xsl:variable name="count_ALLIANCE_WAR_DeviceName" select="count(//check/warning[@chapter='ALLIANCE_WAR_DeviceName'])" />
        <!-- Counter AW005 --> <xsl:variable name="count_ALLIANCE_WAR_ValueRange" select="count(//check/warning[@chapter='ALLIANCE_WAR_ValueRange'])" />
        <!-- Counter AW006 --> <xsl:variable name="count_ALLIANCE_WAR_BackupFileUsed" select="count(//check/warning[@chapter='ALLIANCE_WAR_BackupFileUsed'])" />
        <!-- Counter AW007 --> <xsl:variable name="count_ALLIANCE_WAR_NotNumericDataItemLittleEndian" select="count(//check/warning[@chapter='ALLIANCE_WAR_NotNumericDataItemLittleEndian'])" />

        <!-- ************************************************************* -->
        <!--                      Total warning ALLIANCE                    -->
        <!-- ************************************************************* -->
        <xsl:variable name="total_ALLIANCE_WAR" select="
          $count_ALLIANCE_WAR_DataName                        +
          $count_ALLIANCE_WAR_EndianRedefinition              +
          $count_ALLIANCE_WAR_RequestName                     +
          $count_ALLIANCE_WAR_DeviceName                      +
          $count_ALLIANCE_WAR_ValueRange                      +
          $count_ALLIANCE_WAR_BackupFileUsed                  +
          $count_ALLIANCE_WAR_NotNumericDataItemLittleEndian
        " />
        <!-- ************************************************************* -->
        <!--                  Compteurs d'erreur ALLIANCE                  -->
        <!-- ************************************************************* -->
        <!-- Counter AE001 --> <xsl:variable name="count_ALLIANCE_ERR_RequestErrorSID" select="count(//check/error[@chapter='ALLIANCE_ERR_RequestErrorSID'])" />
        <!-- Counter AE002 --> <xsl:variable name="count_ALLIANCE_ERR_ResponseErrorSID" select="count(//check/error[@chapter='ALLIANCE_ERR_ResponseErrorSID'])" />
        <!-- Counter AE003 --> <xsl:variable name="count_ALLIANCE_ERR_RequestErrorDID" select="count(//check/error[@chapter='ALLIANCE_ERR_RequestErrorDID'])" />
        <!-- Counter AE004 --> <xsl:variable name="count_ALLIANCE_ERR_ResponseErrorDID" select="count(//check/error[@chapter='ALLIANCE_ERR_ResponseErrorDID'])" />
        <!-- Counter AE005 --> <xsl:variable name="count_ALLIANCE_ERR_RequestErrorLID" select="count(//check/error[@chapter='ALLIANCE_ERR_RequestErrorLID'])" />
        <!-- Counter AE006 --> <xsl:variable name="count_ALLIANCE_ERR_ResponseErrorLID" select="count(//check/error[@chapter='ALLIANCE_ERR_ResponseErrorLID'])" />
        <!-- Counter AE007 --> <xsl:variable name="count_ALLIANCE_ERR_RequestErrorDataItemDID" select="count(//check/error[@chapter='ALLIANCE_ERR_RequestErrorDataItemDID'])" />
        <!-- Counter AE008 --> <xsl:variable name="count_ALLIANCE_ERR_ResponseErrorDataItemDID" select="count(//check/error[@chapter='ALLIANCE_ERR_ResponseErrorDataItemDID'])" />
        <!-- Counter AE009 --> <xsl:variable name="count_ALLIANCE_ERR_RequestErrorDataItemLID" select="count(//check/error[@chapter='ALLIANCE_ERR_RequestErrorDataItemLID'])" />
        <!-- Counter AE010 --> <xsl:variable name="count_ALLIANCE_ERR_ResponseErrorDataItemLID" select="count(//check/error[@chapter='ALLIANCE_ERR_ResponseErrorDataItemLID'])" />
        <!-- Counter AE011 --> <xsl:variable name="count_ALLIANCE_ERR_RequestOverlap" select="count(//check/error[@chapter='ALLIANCE_ERR_RequestOverlap'])" />
        <!-- Counter AE012 REMOVE V1.11 <xsl:variable name="count_ALLIANCE_ERR_NotNumericDataItemLittleEndian" select="count(//check/error[@chapter='ALLIANCE_ERR_NotNumericDataItemLittleEndian'])" /> -->
        <!-- Counter AE013 --> <xsl:variable name="count_ALLIANCE_ERR_EmptyList" select="count(//check/error[@chapter='ALLIANCE_ERR_EmptyList'])" />
        <!-- Counter AE014 --> <xsl:variable name="count_ALLIANCE_ERR_DataListItemValue" select="count(//check/error[@chapter='ALLIANCE_ERR_DataListItemValue'])" />
        <!-- Counter AE015 --> <xsl:variable name="count_ALLIANCE_ERR_DataUnit" select="count(//check/error[@chapter='ALLIANCE_ERR_DataUnit'])" />
        <!-- Counter AE016 --> <xsl:variable name="count_ALLIANCE_ERR_RequestTooLong" select="count(//check/error[@chapter='ALLIANCE_ERR_RequestTooLong'])" />
        <!-- Counter AE017 --> <xsl:variable name="count_ALLIANCE_ERR_ByteBoundary" select="count(//check/error[@chapter='ALLIANCE_ERR_ByteBoundary'])" />


        <!-- ************************************************************* -->
        <!--                      Total error ALLIANCE                     -->
        <!-- ************************************************************* -->
        <xsl:variable name="total_ALLIANCE_ERR" select="
          $count_ALLIANCE_ERR_RequestErrorSID                +
          $count_ALLIANCE_ERR_ResponseErrorSID               +
          $count_ALLIANCE_ERR_RequestErrorDID                +
          $count_ALLIANCE_ERR_ResponseErrorDID               +
          $count_ALLIANCE_ERR_RequestErrorLID                +
          $count_ALLIANCE_ERR_ResponseErrorLID               +
          $count_ALLIANCE_ERR_RequestErrorDataItemDID        +
          $count_ALLIANCE_ERR_ResponseErrorDataItemDID       +
          $count_ALLIANCE_ERR_RequestErrorDataItemLID        +
          $count_ALLIANCE_ERR_ResponseErrorDataItemLID       +
          $count_ALLIANCE_ERR_RequestOverlap                 +
          $count_ALLIANCE_ERR_EmptyList                      +
          $count_ALLIANCE_ERR_DataListItemValue              +
          $count_ALLIANCE_ERR_DataUnit                       +
          $count_ALLIANCE_ERR_RequestTooLong                 +
          $count_ALLIANCE_ERR_ByteBoundary
        " />
          <!-- $count_ALLIANCE_ERR_NotNumericDataItemLittleEndian + (REMOVE V1.11) -->




        <!-- ************************************************************* -->
        <!--                             HEADER                            -->
        <!-- ************************************************************* -->
        <!-- Afficher le nom du calculateur -->
        <h2>ECU : <xsl:value-of select="/check/message/info" /></h2>
        <!-- Afficher la date de création du rapport. Exemple : Date : 29/05/2008 15:23:49 -->
        Date : <xsl:value-of select="//time_end_total/date" /><br />
        <!-- Afficher le temps passé pour réaliser le contrôle complet. Exemple : Elapsed time : 0.078125 second(s) -->
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/elapsedTime"></xsl:with-param>
          <xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
        </xsl:call-template> : <xsl:value-of select="//time_end_total/elapsedTime" />
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/second"></xsl:with-param>
          <xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
        </xsl:call-template><br />
        <!-- Afficher la langue DDT2000. Exemple : DDT2000 language : fr -->
        <xsl:call-template name="getLocalizedText"><xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/DDTLanguage"></xsl:with-param>
          <xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
        </xsl:call-template> : <xsl:value-of select="$language"></xsl:value-of><br />
        <!-- Afficher la langue du rapport (langue DDT200 au moment de la création du rapport). Exemple :  Report language : en -->
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/reportLanguage"></xsl:with-param>
          <xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
        </xsl:call-template> : <xsl:value-of select="$reportLanguage"></xsl:value-of><br />
        <!-- Afficher la référence BMIR-V5633-2008-0002  dans le rapport. Exemple :  BMIR Reference : V5633-2008-0002  -->
        <xsl:call-template name="getLocalizedText">
          <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/referenceBMIR"></xsl:with-param>
          <xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
        </xsl:call-template> : V5633-2008-0002
        <hr />

        <!-- ************************************************************* -->
        <!--          TABLES OF THE VERSIONS / TABLE DES VERSIONS          -->
        <!-- ************************************************************* -->
        <h3>
          <a name="rDescriptionVersion" />
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/versionTable"></xsl:with-param>
            <xsl:with-param name="defaultText">Table des Versions*</xsl:with-param>
          </xsl:call-template>
        </h3>
        <b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/currentVersion"></xsl:with-param>
            <xsl:with-param name="defaultText">Version courante : *</xsl:with-param>
          </xsl:call-template>
          <xsl:if test="not(//check/CheckerVersion)">
              <span style="background-color: #ff0000;" />
              <span style="color: #ffffff;" />
          </xsl:if>
          <xsl:value-of select="$mCurrentVersion" />
        </b>
        <br />
        <br />
        <!-- Definition du tableau -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <th>Version</th>
            <th>Date</th>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/commentaire"></xsl:with-param>
                <xsl:with-param name="defaultText">commentaire*</xsl:with-param>
              </xsl:call-template>
            </th>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.0" />V1.0</td>
            <td class="cellule_normale">19/11/2007</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.1" />V1.1</td>
            <td class="cellule_normale">03/12/2007</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.2" />V1.2</td>
            <td class="cellule_normale">17/01/2008</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.3" />V1.3</td>
            <td class="cellule_normale">10/03/2008</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.4" />V1.4</td>
            <td class="cellule_normale">25/06/2009</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.5" />V1.5</td>
            <td class="cellule_normale">01/09/2011</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.6" />V1.6</td>
            <td class="cellule_normale">01/10/2012</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.7" />V1.7</td>
            <td class="cellule_normale">01/02/2015</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.8" />V1.8</td>
            <td class="cellule_normale">03/01/2018</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.9" />V1.9</td>
            <td class="cellule_normale">28/01/2019</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.10" />V1.10</td>
            <td class="cellule_normale">18/11/2019</td>
            <td class="cellule_normale"></td>
          </tr>
          <tr>
            <td class="cellule_normale"><a href="#DescriptionVersion_V1.11" />V1.11</td>
            <td class="cellule_normale">30/11/2020</td>
            <td class="cellule_normale"></td>
          </tr>
        </table>
        <br />
        <hr />


        <!-- ************************************************************* -->
        <!--                  TABLE DES MATIERES GENERALE                  -->
        <!-- ************************************************************* -->
        <!--
               Table des types de contrôles
           |=================================================================|
           |      Contrôles        |       Warning(s)    |     Erreur(s)     |
           |=================================================================|
           | DDT2000               |         X           |       Y           |
           |=================================================================|
           | CPDD                  |         X           |       Y           |
           |=================================================================|
           | DAIMLER-ODX           |         X           |       Y           |
           |=================================================================|
           | ALLIANCE-ODX          |         X           |       Y           |
           |=================================================================|
        ****************************************************************** -->
        <a name="toc_GENERAL">
          <h3>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/tableControlType"></xsl:with-param>
              <xsl:with-param name="defaultText">Table des controles*</xsl:with-param>
            </xsl:call-template>
          </h3>
        </a>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <!-- ================================ -->
          <!-- Afficher les entêtes de colonnes -->
          <!-- ================================ -->
          <tr>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>Warning(s)</th>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleError"></xsl:with-param>
                <xsl:with-param name="defaultText">Erreur(s)*</xsl:with-param>
              </xsl:call-template>
            </th>
          </tr>
          <!-- ================================================== -->
          <!-- DDT2000 : Afficher les compteurs Warning et Erreur -->
          <!-- ================================================== -->
          <tr>
            <td>
              <a href="#toc_DDT2000">DDT2000</a>
            </td>
            <!-- Affichage compteurs warning DDT2000 -->
            <xsl:choose>
              <xsl:when test="$total_DDT2000_WAR= 0">
                <td class="cellule_OK">0</td>
              </xsl:when>
              <xsl:otherwise>
                <td class="cellule_warning"><xsl:value-of select="$total_DDT2000_WAR" /></td>
              </xsl:otherwise>
            </xsl:choose>
            <!-- Affichage compteurs erreur DDT2000 -->
            <xsl:choose>
              <xsl:when test="$total_DDT2000_ERR= 0">
                <td class="cellule_OK">0</td>
              </xsl:when>
              <xsl:otherwise>
                <td class="cellule_error"><xsl:value-of select="$total_DDT2000_ERR" /></td>
              </xsl:otherwise>
            </xsl:choose>
          </tr>
          <!-- =============================================== -->
          <!-- CPDD : Afficher les compteurs Warning et Erreur -->
          <!-- =============================================== -->
          <tr>
            <td><a href="#toc_CPDD">CPDD</a></td>
            <!-- Affichage compteurs warning CPDD -->
            <xsl:choose>
              <xsl:when test="$total_CPDD_WAR = 0">
                <td class="cellule_OK">0</td>
              </xsl:when>
              <xsl:otherwise>
                <td class="cellule_warning"><xsl:value-of select="$total_CPDD_WAR" /></td>
              </xsl:otherwise>
            </xsl:choose>
            <!-- Affichage compteurs erreur CPDD -->
            <xsl:choose>
              <xsl:when test="$total_CPDD_ERR = 0">
                <td class="cellule_OK">0</td>
              </xsl:when>
              <xsl:otherwise>
                <td class="cellule_error"><xsl:value-of select="$total_CPDD_ERR" /></td>
              </xsl:otherwise>
            </xsl:choose>
          </tr>
          <!-- ================================================== -->
          <!-- DAIMLER : Afficher les compteurs Warning et Erreur -->
          <!-- ================================================== -->
          <xsl:choose>
            <xsl:when test="(//check/IsDaimlerProject) and (//check/IsDaimlerProject[. = 'False'])">
              <tr bgcolor="lightgray">
                <xsl:choose>
                  <xsl:when test="$reportLanguage='fr'">
                    <td ><a href="#toc_DAIMLER">DAIMLER-ODX (La base DDT ne contient pas de projet Daimler)</a></td>
                  </xsl:when>
                  <xsl:otherwise>
                    <td ><a href="#toc_DAIMLER">DAIMLER-ODX (DDT database do not contains any Daimler project)</a></td>
                  </xsl:otherwise>
                </xsl:choose>
                <!-- Affichage compteurs warning DAIMLER -->
                <td style="text-align:center;font-weight:bold"><xsl:value-of select="$total_DAIMLER_WAR" /></td>
                <!-- Affichage compteurs erreur DAIMLER -->
                <td style="text-align:center;font-weight:bold"><xsl:value-of select="$total_DAIMLER_ERR" /></td>
              </tr>
            </xsl:when>
            <xsl:otherwise>
              <tr>
                <td ><a href="#toc_DAIMLER">DAIMLER-ODX</a></td>
                <!-- Affichage compteurs warning DAIMLER -->
                <xsl:choose>
                  <xsl:when test="$total_DAIMLER_WAR= 0">
                    <td class="cellule_OK">0</td>
                  </xsl:when>
                  <xsl:otherwise>
                    <td class="cellule_warning"><xsl:value-of select="$total_DAIMLER_WAR" /></td>
                  </xsl:otherwise>
                </xsl:choose>
                <!-- Affichage compteurs erreur DAIMLER -->
                <xsl:choose>
                  <xsl:when test="$total_DAIMLER_ERR= 0">
                    <td class="cellule_OK">0</td>
                  </xsl:when>
                  <xsl:otherwise>
                    <td class="cellule_error"><xsl:value-of select="$total_DAIMLER_ERR" /></td>
                  </xsl:otherwise>
                </xsl:choose>
              </tr>
            </xsl:otherwise>
          </xsl:choose>
          <!-- =================================================== -->
          <!-- ALLIANCE : Afficher les compteurs Warning et Erreur -->
          <!-- =================================================== -->
          <tr>
            <td><a href="#toc_ALLIANCE">ALLIANCE-ODX</a></td>
            <!-- Affichage compteurs warning ALLIANCE -->
            <xsl:choose>
              <xsl:when test="$total_ALLIANCE_WAR= 0">
                <td class="cellule_OK">0</td>
              </xsl:when>
              <xsl:otherwise>
                <td class="cellule_warning"><xsl:value-of select="$total_ALLIANCE_WAR" /></td>
              </xsl:otherwise>
            </xsl:choose>
            <!-- Affichage compteurs erreur ALLIANCE -->
            <xsl:choose>
              <xsl:when test="$total_ALLIANCE_ERR= 0">
                <td class="cellule_OK">0</td>
              </xsl:when>
              <xsl:otherwise>
                <td class="cellule_error"><xsl:value-of select="$total_ALLIANCE_ERR" /></td>
              </xsl:otherwise>
            </xsl:choose>
          </tr>
        </table>
        <br />
        <hr />

        <!-- ************************************************************* -->
        <!--                     INFORMATIONS GENERALES                    -->
        <!-- ************************************************************* -->
        <!--
           |=======================================================|
           |           Description       |       Information(s)    |
           |=======================================================|
           | xxxxxxxxxx                  |   yyyyyyyyyyyyyy        |
           |=======================================================|
           | uuuuuuuuuuu                 |    vvvvvvvvvvvvvv       |
           ========================================================|
        ****************************************************************** -->
        <h4>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang">
            <xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoGeneral"></xsl:with-param>
            <xsl:with-param name="defaultText">Informations générales*</xsl:with-param>
          </xsl:call-template>
        </h4>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <th>Description</th>
            <th>Information</th>
          </tr>
          <xsl:apply-templates select="check/message" />
        </table>
        <br />
        <hr />
        <br />

        <!-- ************************************************************* -->
        <!--            TABLE DES CONTRÔLES DDT2000 (Ingénièrie)           -->
        <!-- ************************************************************* -->
        <a name="toc_DDT2000">
          <h3>
            <a href="#toc_GENERAL" title="Retour au sommaire">△</a>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/tableDDTControl"></xsl:with-param>
              <xsl:with-param name="defaultText">Table des contrôles DDT2000 (Ingénierie)*</xsl:with-param>
            </xsl:call-template>
          </h3>
        </a>

        <!-- **************************************************************************************
                              TABLE DES MATIERES WARNINGS DDT2000
             |=======================================================================|
             | Règles | Version |       Contrôles               |    xx Warning(s)   |
             |=======================================================================|
             | DW001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
             |=======================================================================|
             | DW002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |
             |=======================================================================|
        *************************************************************************************** -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
          <!-- Definition du header table des matières warning DDT2000
               |=======================================================================|
               | Règles | Version |       Contrôles               |    xx Warning(s)   |
               |=======================================================================|
          -->
          <tr>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
                <xsl:with-param name="defaultText">Règles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>Version</th>
            <th width="75%">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th><xsl:value-of select="$total_DDT2000_WAR" /> Warning(s)</th>
          </tr>
          <!-- Documenter les colonnes de la table des matières
               |=======================================================================|
               | DW001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
               |=======================================================================|
               | DW002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |<=====La ligne est grisée quand la version du test = la version courante du contrôle.
                   ^
                   |
                   |
                Il existe un lien sur chaque règle. Ce lien pointe sur la règle correspondante dans le rapport des règles en fin de rapport
          -->
<!-- ** DW001 DDT2000_WAR_DataUsedInMultipleRequest ******************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_DataUsedInMultipleRequest</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_DataUsedInMultipleRequest" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW002 DDT2000_WAR_DataUnused ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_DataUnused</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_DataUnused" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW003 DDT2000_WAR_DataNameInvalidChar ************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_DataNameInvalidChar</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_DataNameInvalidChar" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW005 DDT2000_WAR_ShiftByteCount ****************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_ShiftByteCount</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_ShiftByteCount" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW006/DW007 DDT2000_WAR_ReadDTCInformationReportDTC *********************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_ReadDTCInformationReportDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_ReadDTCInformationReportDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW008 DDT2000_WAR_ReadDTCInformationReportSnapshot ************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_ReadDTCInformationReportSnapshot</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_ReadDTCInformationReportSnapshot" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW009 DDT2000_WAR_ClearDiagnosticInformationManual ************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">009</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">009</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_ClearDiagnosticInformationManual</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_ClearDiagnosticInformationManual" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW010 DDT2000_WAR_RequestNameInvalidChar ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">010</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">010</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_RequestNameInvalidChar</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_RequestNameInvalidChar" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW011 DDT2000_WAR_RequestTemplateMissing ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">011</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">011</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_RequestTemplateMissing</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_RequestTemplateMissing" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW012 DDT2000_WAR_InjectorCode ******************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">012</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">012</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_InjectorCode</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_InjectorCode" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW187 DDT2000_WAR_UDS_RoutineControl ************************************************** -->
  <!-- REMOVE V1.11
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">187</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">187</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_UDS_RoutineControl</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_UDS_RoutineControl" /></xsl:with-param>
          </xsl:call-template>
  -->
<!-- ** DW188 DDT2000_WAR_UDS_OutputControl *************************************************** -->
  <!-- REMOVE V1.11
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">188</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">188</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_UDS_OutputControl</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_UDS_OutputControl" /></xsl:with-param>
          </xsl:call-template>
  -->
<!-- ** DW192 DDT2000_WAR_UDS_MissingReadDID ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">192</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">192</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_UDS_MissingReadDID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_UDS_MissingReadDID" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW193 DDT2000_WAR_DataUnit ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">193</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">193</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_DataUnit</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_DataUnit" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DW194 DDT2000_WAR_RoutineIdentifierMissing ******************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">194</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">194</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_WAR_RoutineIdentifierMissing</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_RoutineIdentifierMissing" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DDT2000 Other Warning Rules *********************************************************** -->
          <xsl:call-template name="AddOtherWarningRules">
            <xsl:with-param name="chapter">DDT2000_OtherWarnings</xsl:with-param>
          </xsl:call-template>
<!-- ****************************************************************************************** -->
        </table>
        <br />

        <!-- **************************************************************************************
                              TABLE DES MATIERES ERREURS DDT2000
             |=======================================================================|
             | Règles | Version |       Contrôles               |    xx Erreur(s)    |
             |=======================================================================|
             | DE001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
             |=======================================================================|
             | DE002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |
             |=======================================================================|

        *************************************************************************************** -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
          <!-- Definition du header table des matières error DDT2000
               |=======================================================================|
               | Règles | Version |       Contrôles               |    xx Erreur(s)    |
               |=======================================================================|
          -->
          <tr>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
                <xsl:with-param name="defaultText">Règles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>Version</th>
            <th width="75%">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>
              <xsl:value-of select="$total_DDT2000_ERR" />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleError"></xsl:with-param>
                <xsl:with-param name="defaultText">Erreur(s)*</xsl:with-param>
              </xsl:call-template>
            </th>
          </tr>
          <!-- Documenter les colonnes de la table des matières
               |=======================================================================|
               | DE001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
               |=======================================================================|
               | DE002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |<=====La ligne est grisée quand la version du test = la version courante du contrôle.
                   ^
                   |
                   |
                Il existe un lien sur chaque règle. Ce lien pointe sur la règle correspondante dans le rapport des règles en fin de rapport
          -->
<!-- ** DE001 DDT2000_ERR_UndefinedSpecification ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UndefinedSpecification</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UndefinedSpecification" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE002 DDT2000_ERR_ProtocolType ******************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ProtocolType</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ProtocolType" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE003 DDT2000_ERR_DataNameInvalidChar ************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DataNameInvalidChar</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataNameInvalidChar" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE004 DDT2000_ERR_DataBitsCount ******************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DataBitsCount</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataBitsCount" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE005 DDT2000_ERR_Unsigned32bitsNumericData ******************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_Unsigned32bitsNumericData</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_Unsigned32bitsNumericData" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE006 DDT2000_ERR_DataBytesCount ****************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DataBytesCount</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataBytesCount" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE007 DDT2000_ERR_DTCDeviceIdentifierMissing ****************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DTCDeviceIdentifierMissing</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DTCDeviceIdentifierMissing" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE008 DDT2000_ERR_FirstDTCMissing ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_FirstDTCMissing</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_FirstDTCMissing" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE009 DDT2000_ERR_DataNumericalDividedBy0 ********************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">009</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">009</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DataNumericalDividedBy0</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataNumericalDividedBy0" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE010 DDT2000_ERR_RequestSentDataItemName ********************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">010</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">010</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataItemName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataItemName" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE011 DDT2000_ERR_RequestSentDataOutSideOfRequest ************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">011</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">011</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataOutSideOfRequest</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataOutSideOfRequest" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE012 NOT CHECKED ********************************************************************* -->
<!-- ** DE013/DE014 DDT2000_ERR_RequestSentDataItemFirstByte ********************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">013</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">014</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataItemFirstByte</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataItemFirstByte" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE015 DDT2000_ERR_RequestSentDataItemBitOffset **************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">015</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">015</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataItemBitOffset</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataItemBitOffset" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE017 DDT2000_ERR_RequestSentDataItemRef ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">017</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">017</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataItemRef</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataItemRef" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE019 DDT2000_ERR_DuplicateSentDataItemInRequest ************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">019</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">019</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DuplicateSentDataItemInRequest</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DuplicateSentDataItemInRequest" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE020 DDT2000_ERR_RequestReceivedDataItemName ***************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">020</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">020</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedDataItemName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedDataItemName" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE021 DDT2000_ERR_RequestReceivedDataOutSideOfRequest ********************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">021</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">021</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedDataOutSideOfRequest</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedDataOutSideOfRequest" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE022 NOT CHECKED ********************************************************************* -->
<!-- ** DE023/DE024 DDT2000_ERR_RequestReceivedDataItemFirstByte ****************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">023</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">024</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedDataItemFirstByte</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedDataItemFirstByte" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE025 DDT2000_ERR_RequestReceivedDataItemBitOffset ************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">025</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">025</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedDataItemBitOffset</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedDataItemBitOffset" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE027 DDT2000_ERR_DuplicateReceivedDataInRequest ************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">027</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">027</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DuplicateReceivedDataInRequest</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DuplicateReceivedDataInRequest" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE029 REMOVE ************************************************************************** -->
<!-- ** DE030 REMOVE ************************************************************************** -->
<!-- ** DE031 DDT2000_ERR_RequestNameInvalidChar ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">031</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">031</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestNameInvalidChar</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestNameInvalidChar" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE032 NOT CHECKED ********************************************************************* -->
<!-- ** DE033 DDT2000_ERR_RequestSentBytes **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">033</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">033</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentBytes</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentBytes" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE034 DDT2000_ERR_RequestReceivedMinBytes ********************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">034</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">034</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedMinBytes</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedMinBytes" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE035 DDT2000_ERR_RequestReceivedReplyBytes ******************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">035</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">035</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedReplyBytes</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedReplyBytes" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE036 DDT2000_ERR_RequestCoherenceSendBytesReplyBytes ********************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">036</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">036</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_RequestCoherenceSendBytesReplyBytes</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestCoherenceSendBytesReplyBytes" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE037 DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport *************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">037</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">037</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE038 DDT2000_ERR_TesterPresent ******************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">038</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">038</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_TesterPresent</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_TesterPresent" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE050/DE051/DE052 DDT2000_ERR_ReadDTCInformationReportDTC ***************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">050</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">052</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE054 DDT2000_ERR_1902_DTCStatusAvailabilityMask ************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">054</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">054</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatusAvailabilityMask</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatusAvailabilityMask" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE055 DDT2000_ERR_1902_DTCDeviceIdentifier ******************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">055</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">055</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCDeviceIdentifier</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCDeviceIdentifier" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE056 DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD ************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">056</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">056</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE057 DDT2000_ERR_1902_DTCFailureType_Category **************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">057</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">057</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCFailureType_Category</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCFailureType_Category" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE058 DDT2000_ERR_1902_DTCFailureType ************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">058</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">058</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCFailureType</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCFailureType" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE059 DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier ************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">059</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">059</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE060 DDT2000_ERR_1902_StatusOfDTC **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">060</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">060</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_StatusOfDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_StatusOfDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE061 DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested **************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">061</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">061</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE062 DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle ****************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">062</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">062</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE063 DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear ***************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">063</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">063</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE064 DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear *********************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">064</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">064</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE065 DDT2000_ERR_1902_DTCStatus_confirmedDTC ***************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">065</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">065</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_confirmedDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_confirmedDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE066 DDT2000_ERR_1902_DTCStatus_pendingDTC ******************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">066</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">066</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_pendingDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_pendingDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE067 DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle ************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">067</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">067</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE068 DDT2000_ERR_1902_DTCStatus_testFailed ******************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">068</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">068</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testFailed</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testFailed" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE080/DE081/DE082/DE083 DDT2000_ERR_ReadDTCInformationReportExtendedData ************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">080</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">083</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportExtendedData</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportExtendedData"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DE084 DDT2000_ERR_1906FF_DTCMaskRecord ************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">084</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">084</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCMaskRecord</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCMaskRecord"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DE085 DDT2000_ERR_1906FF_DTCRecord **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">085</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">085</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCRecord</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCRecord"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DE086 DDT2000_ERR_1906FF_StatusOfDTC ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">086</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">086</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_StatusOfDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_StatusOfDTC"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DE087 DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber ********************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">087</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">087</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DE088 DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter ********************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">088</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">088</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DE089 DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter ************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">089</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">089</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DE090 DDT2000_ERR_1906FF_DTCExtendedData_Mileage ************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">090</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">090</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCExtendedData_Mileage</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCExtendedData_Mileage"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DE091 DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName ******************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">091</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">091</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE100/DE101/DE102/DE103 *************************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">100</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">103</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE104 DTT2000_ERR_190680_DTCMaskRecord ************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">104</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">104</xsl:with-param>
            <xsl:with-param name="paramChapter">DTT2000_ERR_190680_DTCMaskRecord</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DTT2000_ERR_190680_DTCMaskRecord" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE105 DDT2000_ERR_190680_DTCRecord **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">105</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">105</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_190680_DTCRecord</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_190680_DTCRecord" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE106 DDT2000_ERR_190680_StatusOfDTC ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">106</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">106</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_190680_StatusOfDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_190680_StatusOfDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE107 DDT2000_ERR_190680_DTCExtendedDataRecordNumber ********************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">107</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">107</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_190680_DTCExtendedDataRecordNumber</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_190680_DTCExtendedDataRecordNumber" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE108 DDT2000_ERR_190680_DTCExtendedData_Mileage ************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">108</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">108</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_190680_DTCExtendedData_Mileage</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_190680_DTCExtendedData_Mileage" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE109 DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName ************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">109</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">109</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE121/DE122/DE123 DDT2000_ERR_ReadDTCInformationReportSnapshot ************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">121</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">123</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportSnapshot</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportSnapshot" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE124 DDT2000_ERR_1904_DTCMaskRecord ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">124</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">124</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1904_DTCMaskRecord</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1904_DTCMaskRecord" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE125 DDT2000_ERR_1904_DTCRecord ****************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">125</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">125</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1904_DTCRecord</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1904_DTCRecord" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE126 DDT2000_ERR_1904_StatusOfDTC **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">126</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">126</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_1904_StatusOfDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1904_StatusOfDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE127 DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName ************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">127</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">127</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE130/DE131/DE132/DE133/DE134/DE135/DE136/DE137/DE138/DE139/DE140/DE141/DE142/DE143/DE144 DDT2000_ERR_IdentificationRenaultR2  -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">130</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">144</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_IdentificationRenaultR2" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE145 DDT2000_ERR_BadLengthBasicPartList ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">145</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">145</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_BadLengthBasicPartList</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_BadLengthBasicPartList" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE146 DDT2000_ERR_BreakDownType ******************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">146</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">146</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_BreakDownType</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_BreakDownType" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE150 DDT2000_ERR_DeviceName ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">150</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">150</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceName" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE151 DDT2000_ERR_DeviceDTC *********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">151</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">151</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE152 DDT2000_ERR_DeviceDuplicateDTC ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">152</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">152</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceDuplicateDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceDuplicateDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE153 DDT2000_ERR_DeviceTestType ****************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">153</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">153</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceTestType</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceTestType" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE154 DDT2000_ERR_DeviceTestOBD ******************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">154</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">154</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceTestOBD</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceTestOBD" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE155 DDT2000_ERR_DeviceOBDnoBaseDTC ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">155</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">155</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceOBDnoBaseDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceOBDnoBaseDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE160 DDT2000_ERR_DTCDeviceIdentifier ************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">160</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">160</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DTCDeviceIdentifier</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DTCDeviceIdentifier" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE161 DDT2000_ERR_FirstDTC ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">161</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">161</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_FirstDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_FirstDTC" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE170 DDT2000_ERR_AddressFunction ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">170</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">170</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_AddressFunction</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_AddressFunction" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE171 DDT2000_ERR_GenericAddressing *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">171</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">171</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_GenericAddressing</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_GenericAddressing" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE172 DDT2000_ERR_UDS_22F187 ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">172</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">172</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F187</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F187" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE173 DDT2000_ERR_UDS_22F188 ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">173</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">173</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F188</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F188" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE174 DDT2000_ERR_UDS_22F18A ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">174</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">174</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F18A</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F18A" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE175 DDT2000_ERR_UDS_22F18C ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">175</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">175</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F18C</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F18C" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE176 DDT2000_ERR_UDS_22F190 ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">176</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">176</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F190</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F190" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE177 DDT2000_ERR_UDS_22F191 ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">177</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">177</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F191</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F191" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE178 DDT2000_ERR_UDS_22F194 ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">178</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">178</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F194</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F194" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE179 DDT2000_ERR_UDS_22F195 ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">179</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">179</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F195</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F195" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE180 DDT2000_ERR_UDS_22F1A0 ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">180</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">180</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F1A0</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F1A0" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE181 DDT2000_ERR_UDS_StartDiagnosticSession ****************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">181</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">181</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_StartDiagnosticSession</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_StartDiagnosticSession" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE182 DDT2000_ERR_UDS_ClearDiagnosticInformation ************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">182</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">182</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_ClearDiagnosticInformation</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_ClearDiagnosticInformation" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE183 DDT2000_ERR_UDS_1901 ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">183</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">183</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_1901</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_1901" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE184 DDT2000_ERR_UDS_1902 ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">184</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">184</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_1902</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_1902" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE185 DDT2000_ERR_UDS_1903 ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">185</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">185</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_1903</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_1903" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE186 DDT2000_ERR_UDS_190A ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">186</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">186</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_190A</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_190A" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE189 DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList ************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">189</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">189</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE190 DDT2000_ERR_UDS_OutputControl_OutputControlCommand ****************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">190</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">190</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_OutputControl_OutputControlCommand</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_OutputControl_OutputControlCommand" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE191 DDT2000_ERR_UDS_ForbiddenRequests *********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">191</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">191</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_ForbiddenRequests</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_ForbiddenRequests" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE192 NOW DEFINE AS DW192 ************************************************************* -->
<!-- ** DE193 DDT2000_ERR_UDS_Autoident ******************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">193</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">193</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_Autoident</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_Autoident" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE194 DDT2000_ERR_DeviceNameInvalidChar_error ***************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">194</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">194</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceNameInvalidChar_error</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceNameInvalidChar_error" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE195 DDT2000_ERR_DataListItemValue *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">195</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">195</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DataListItemValue</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataListItemValue" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE196 DDT2000_ERR_FunctionAddressCGW ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">196</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">196</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_FunctionAddressCGW</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_FunctionAddressCGW" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE197 DDT2000_ERR_CanIdInconsistency ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">197</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">197</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_CanIdInconsistency</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_CanIdInconsistency" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE198 DDT2000_ERR_DtcObdFaultType ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">198</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">198</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_DtcObdFaultType</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DtcObdFaultType" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE199 DDT2000_ERR_ProjectNotExist ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">199</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">199</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_ProjectNotExist</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ProjectNotExist" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE200 DDT2000_ERR_TargetName ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">200</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">200</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT2000_ERR_TargetName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_TargetName" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE201 DDT200_ERR_MissingFiles ********************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">201</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">201</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT200_ERR_MissingFiles</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_MissingFiles" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE202 DDT200_ERR_ForbiddenCharacter *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">202</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">202</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT200_ERR_ForbiddenCharacter</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_ForbiddenCharacter" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE203 DDT200_ERR_ForbiddenCharacter *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">203</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">203</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT200_ERR_InvalidNumericListItemText</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_InvalidNumericListItemText" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE204 DDT200_ERR_RoutineControlGeneric ************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">204</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">204</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT200_ERR_RoutineControlGeneric</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_RoutineControlGeneric" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE205 DDT200_ERR_RoutineControlType *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">205</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">205</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT200_ERR_RoutineControlType</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_RoutineControlType" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE206 DDT200_ERR_RoutineControlType *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">206</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">206</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_RoutineIdentifier" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DE207 DDT200_ERR_RoutineControlMissingRID ********************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">DE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">207</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">207</xsl:with-param>
            <xsl:with-param name="paramChapter">DDT200_ERR_RoutineControlMissingRID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_RoutineControlMissingRID" /></xsl:with-param>
          </xsl:call-template>
<!-- ** DDT2000 Other Error Rules ************************************************************* -->
          <xsl:call-template name="AddOtherErrorRules">
            <xsl:with-param name="chapter">DDT2000_OtherErrors</xsl:with-param>
          </xsl:call-template>
<!-- ****************************************************************************************** -->
        </table>
        <br />
        <br />
        <hr />
        <br />
<!-- *******************************************************************************************************************************
                                   AFFICHAGE DES WARNINGS ET DES ERREURS DDT2000
     ******************************************************************************************************************************* -->
<!-- *******************************************************************************************************************************
                                       AFFICHAGE DES WARNINGS DDT2000
     ******************************************************************************************************************************* -->
        <div class="warning">
          <h2>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/DDTWarning"></xsl:with-param>
              <xsl:with-param name="defaultText">Warning(s) DDT2000*</xsl:with-param>
            </xsl:call-template>
          </h2>
        </div>
        <br />
<!-- ** DW001 DDT2000_WAR_DataUsedInMultipleRequest ******************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW001</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW001</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_DataUsedInMultipleRequest</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_DataUsedInMultipleRequest" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW002 DDT2000_WAR_DataUnused ********************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW002</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW002</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_DataUnused</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_DataUnused" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW003 DDT2000_WAR_DataNameInvalidChar ************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW003</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW003</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_DataNameInvalidChar</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_DataNameInvalidChar" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW005 DDT2000_WAR_ShiftByteCount ****************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW005</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW005</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_ShiftByteCount</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_ShiftByteCount" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW006/DW007 DDT2000_WAR_ReadDTCInformationReportDTC *********************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW006</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW007</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_ReadDTCInformationReportDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_ReadDTCInformationReportDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW008 DDT2000_WAR_ReadDTCInformationReportSnapshot ************************************ -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW008</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW008</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_ReadDTCInformationReportSnapshot</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_ReadDTCInformationReportSnapshot" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW009 DDT2000_WAR_ClearDiagnosticInformationManual ************************************ -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW009</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW009</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_ClearDiagnosticInformationManual</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_ClearDiagnosticInformationManual" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW010 DDT2000_WAR_RequestNameInvalidChar ********************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW010</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW010</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_RequestNameInvalidChar</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_RequestNameInvalidChar" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW011 DDT2000_WAR_RequestTemplateMissing ********************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW011</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW011</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_RequestTemplateMissing</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_RequestTemplateMissing" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW012 DDT2000_WAR_InjectorCode ******************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW012</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW012</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_InjectorCode</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_InjectorCode" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW187 DDT2000_WAR_UDS_RoutineControl ************************************************** -->
  <!--- REMOVE V1.11
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW187</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW187</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_UDS_RoutineControl</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_UDS_RoutineControl" /></xsl:with-param>
        </xsl:call-template>
  -->
<!-- ** DW188 DDT2000_WAR_UDS_OutputControl *************************************************** -->
  <!-- REMOVE V1.11 (Replace by AW007)
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW188</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW188</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_UDS_OutputControl</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_UDS_OutputControl" /></xsl:with-param>
        </xsl:call-template>
  -->
<!-- ** DW192 DDT2000_WAR_UDS_MissingReadDID ************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW192</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW192</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_UDS_MissingReadDID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_UDS_MissingReadDID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW193 DDT2000_WAR_DataUnit ************************************************************ -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW193</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW193</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_DataUnit</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_DataUnit" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DW193 DDT2000_WAR_RoutineIdentifierMissing ******************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">DW194</xsl:with-param>
          <xsl:with-param name="paramStopRule">DW194</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_WAR_RoutineIdentifierMissing</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_WAR_RoutineIdentifierMissing" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DDT2000 Other Warnings **************************************************************** -->
        <xsl:call-template name="DisplayOtherWarnings">
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramTitle">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_OtherWarnings</xsl:with-param>
        </xsl:call-template>
<!-- ****************************************************************************************** -->


<!-- ******************************************************************************************************************************
                                             AFFICHAGE DES ERREURS DDT2000
     ****************************************************************************************************************************** -->
        <div class="error">
          <h2>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/DDTError"></xsl:with-param>
              <xsl:with-param name="defaultText">Erreur(s) DDT2000*</xsl:with-param>
            </xsl:call-template>
          </h2>
        </div>
        <br />
<!-- ** DE001 DDT2000_ERR_UndefinedSpecification ********************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE001</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE001</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UndefinedSpecification</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UndefinedSpecification" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE002 DDT2000_ERR_ProtocolType ******************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE002</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE002</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ProtocolType</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ProtocolType" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE003 DDT2000_ERR_DataNameInvalidChar ************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE003</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE003</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DataNameInvalidChar</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataNameInvalidChar" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE004 DDT2000_ERR_DataBitsCount ******************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE004</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE004</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DataBitsCount</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataBitsCount" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE005 DDT2000_ERR_Unsigned32bitsNumericData ******************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE005</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE005</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_Unsigned32bitsNumericData</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_Unsigned32bitsNumericData" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE006 DDT2000_ERR_DataBytesCount ****************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE006</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE006</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DataBytesCount</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataBytesCount" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE007 DDT2000_ERR_DTCDeviceIdentifierMissing ****************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE007</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE007</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DTCDeviceIdentifierMissing</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DTCDeviceIdentifierMissing" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE008 DDT2000_ERR_FirstDTCMissing ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE008</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE008</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_FirstDTCMissing</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_FirstDTCMissing" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE009 DDT2000_ERR_DataNumericalDividedBy0 ********************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE009</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE009</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DataNumericalDividedBy0</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataNumericalDividedBy0" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE010 DDT2000_ERR_RequestSentDataItemName ********************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE010</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE010</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataItemName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataItemName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE011 DDT2000_ERR_RequestSentDataOutSideOfRequest ************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE011</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE011</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataOutSideOfRequest</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataOutSideOfRequest" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE012  NOT TESTED ********************************************************************* -->
<!-- ** DE013/DE014 DDT2000_ERR_RequestSentDataItemFirstByte ********************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE013</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE014</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataItemFirstByte</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataItemFirstByte" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE015 DDT2000_ERR_RequestSentDataItemBitOffset **************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE015</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE015</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataItemBitOffset</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataItemBitOffset" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE017 DDT2000_ERR_RequestSentDataItemRef ********************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE017</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE017</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentDataItemRef</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentDataItemRef" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE019 DDT2000_ERR_DuplicateSentDataItemInRequest ************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE019</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE019</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DuplicateSentDataItemInRequest</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DuplicateSentDataItemInRequest" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE020 DDT2000_ERR_RequestReceivedDataItemName ***************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE020</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE020</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedDataItemName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedDataItemName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE021 DDT2000_ERR_RequestReceivedDataOutSideOfRequest ********************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE021</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE021</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedDataOutSideOfRequest</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedDataOutSideOfRequest" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE022  NOT TESTED ********************************************************************* -->
<!-- ** DE023/DE024 DDT2000_ERR_RequestReceivedDataItemFirstByte ****************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE023</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE024</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedDataItemFirstByte</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedDataItemFirstByte" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE025 DDT2000_ERR_RequestReceivedDataItemBitOffset ************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE025</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE025</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedDataItemBitOffset</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedDataItemBitOffset" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE027 DDT2000_ERR_DuplicateReceivedDataInRequest ************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE027</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE027</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DuplicateReceivedDataInRequest</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DuplicateReceivedDataInRequest" /></xsl:with-param>
        </xsl:call-template>
<!-- Erreur DE029 supprimée -->
<!-- Erreur DE030 supprimée -->
<!-- ** DE031 DDT2000_ERR_RequestNameInvalidChar ********************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE031</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE031</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestNameInvalidChar</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestNameInvalidChar" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE032  NOT TESTED ********************************************************************* -->
<!-- ** DE033 DDT2000_ERR_RequestSentBytes **************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE033</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE033</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestSentBytes</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestSentBytes" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE034 DDT2000_ERR_RequestReceivedMinBytes ********************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE034</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE034</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedMinBytes</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedMinBytes" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE035 DDT2000_ERR_RequestReceivedReplyBytes ******************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE035</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE035</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestReceivedReplyBytes</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestReceivedReplyBytes" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE036 DDT2000_ERR_RequestCoherenceSendBytesReplyBytes ********************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE036</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE036</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_RequestCoherenceSendBytesReplyBytes</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_RequestCoherenceSendBytesReplyBytes" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE037 DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport *************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE037</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE037</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE038 DDT2000_ERR_TesterPresent ******************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE038</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE038</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_TesterPresent</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_TesterPresent" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE050/DE051/DE052 DDT2000_ERR_ReadDTCInformationReportDTC ***************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE050</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE052</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE054 DDT2000_ERR_1902_DTCStatusAvailabilityMask ************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE054</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE054</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatusAvailabilityMask</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatusAvailabilityMask" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE055 DDT2000_ERR_1902_DTCDeviceIdentifier ******************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE055</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE055</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCDeviceIdentifier</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCDeviceIdentifier" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE056 DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD ************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE056</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE056</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE057 DDT2000_ERR_1902_DTCFailureType_Category **************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE057</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE057</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCFailureType_Category</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCFailureType_Category" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE058 DDT2000_ERR_1902_DTCFailureType ************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE058</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE058</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCFailureType</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCFailureType" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE059 DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier ************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE059</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE059</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE060 DDT2000_ERR_1902_StatusOfDTC **************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE060</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE060</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_StatusOfDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_StatusOfDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE061 DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested **************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE061</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE061</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE062 DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle ****************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE062</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE062</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE063 DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear ***************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE063</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE063</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE064 DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear *********************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE064</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE064</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE065 DDT2000_ERR_1902_DTCStatus_confirmedDTC ***************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE065</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE065</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_confirmedDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_confirmedDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE066 DDT2000_ERR_1902_DTCStatus_pendingDTC ******************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE066</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE066</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_pendingDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_pendingDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE067 DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle ************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE067</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE067</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE068 DDT2000_ERR_1902_DTCStatus_testFailed ******************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE068</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE068</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1902_DTCStatus_testFailed</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1902_DTCStatus_testFailed" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE080/DE081/DE082/DE083 DDT2000_ERR_ReadDTCInformationReportExtendedData ************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE080</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE083</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportExtendedData</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportExtendedData" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE084 DDT2000_ERR_1906FF_DTCMaskRecord ************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE084</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE084</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCMaskRecord</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCMaskRecord" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE085 DDT2000_ERR_1906FF_DTCRecord **************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE085</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE085</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCRecord</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCRecord" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE086 DDT2000_ERR_1906FF_StatusOfDTC ************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE086</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE086</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_StatusOfDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_StatusOfDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE087 DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber ********************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE087</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE087</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE088 DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter ********************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE088</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE088</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE089 DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter ************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE089</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE089</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE090 DDT2000_ERR_1906FF_DTCExtendedData_Mileage ************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE090</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE090</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1906FF_DTCExtendedData_Mileage</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1906FF_DTCExtendedData_Mileage" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE091 DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName ******************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE091</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE091</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE100/DE101/DE102/DE103 DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage ******* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE100</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE103</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage" /></xsl:with-param>
        </xsl:call-template>
<!-- **  DE104 DTT2000_ERR_190680_DTCMaskRecord *********************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE104</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE104</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DTT2000_ERR_190680_DTCMaskRecord</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DTT2000_ERR_190680_DTCMaskRecord" /></xsl:with-param>
        </xsl:call-template>
<!-- **  DE105 DDT2000_ERR_190680_DTCRecord *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE105</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE105</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_190680_DTCRecord</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_190680_DTCRecord" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE106 DDT2000_ERR_190680_StatusOfDTC ************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE106</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE106</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_190680_StatusOfDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_190680_StatusOfDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE107 DDT2000_ERR_190680_DTCExtendedDataRecordNumber ********************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE107</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE107</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_190680_DTCExtendedDataRecordNumber</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_190680_DTCExtendedDataRecordNumber" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE108 DDT2000_ERR_190680_DTCExtendedData_Mileage ************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE108</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE108</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_190680_DTCExtendedData_Mileage</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_190680_DTCExtendedData_Mileage" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE109 DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName ************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE109</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE109</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE121/DE122/DE123 DDT2000_ERR_ReadDTCInformationReportSnapshot ************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE121</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE123</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportSnapshot</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportSnapshot" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE124 DDT2000_ERR_1904_DTCMaskRecord ************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE124</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE124</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1904_DTCMaskRecord</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1904_DTCMaskRecord" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE125 DDT2000_ERR_1904_DTCRecord ****************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE125</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE125</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1904_DTCRecord</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1904_DTCRecord" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE126 DDT2000_ERR_1904_StatusOfDTC ***************************************************  -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE126</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE126</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_1904_StatusOfDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_1904_StatusOfDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE127 DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName ************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE127</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE127</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE130/DE131/DE132/DE133/DE134/DE135/DE136/DE137/DE138/DE139/DE140/DE141/DE142/DE143/DE144 DDT2000_ERR_IdentificationRenaultR2  -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE130</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE144</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_IdentificationRenaultR2</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_IdentificationRenaultR2" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE145 DDT2000_ERR_BadLengthBasicPartList ********************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE145</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE145</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_BadLengthBasicPartList</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_BadLengthBasicPartList" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE146 DDT2000_ERR_BreakDownType ******************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE146</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE146</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_BreakDownType</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_BreakDownType" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE150 DDT2000_ERR_DeviceName ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE150</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE150</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE151 DDT2000_ERR_DeviceDTC *********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE151</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE151</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE152 DDT2000_ERR_DeviceDuplicateDTC ************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE152</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE152</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceDuplicateDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceDuplicateDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE153 DDT2000_ERR_DeviceTestType ****************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE153</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE153</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceTestType</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceTestType" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE154 DDT2000_ERR_DeviceTestOBD ******************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE154</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE154</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceTestOBD</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceTestOBD" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE155 DDT2000_ERR_DeviceOBDnoBaseDTC ************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE155</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE155</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceOBDnoBaseDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceOBDnoBaseDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE160 DDT2000_ERR_DTCDeviceIdentifier ************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE160</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE160</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DTCDeviceIdentifier</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DTCDeviceIdentifier" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE161 DDT2000_ERR_FirstDTC ************************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE161</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE161</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_FirstDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_FirstDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE170 DDT2000_ERR_AddressFunction ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE170</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE170</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_AddressFunction</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_AddressFunction" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE171 DDT2000_ERR_GenericAddressing *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE171</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE171</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_GenericAddressing</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_GenericAddressing" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE172 DDT2000_ERR_UDS_22F187 ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE172</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE172</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F187</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F187" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE173 DDT2000_ERR_UDS_22F188 ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE173</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE173</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F188</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F188" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE174 DDT2000_ERR_UDS_22F18A ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE174</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE174</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F18A</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F18A" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE175 DDT2000_ERR_UDS_22F18C ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE175</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE175</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F18C</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F18C" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE176 DDT2000_ERR_UDS_22F190 ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE176</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE176</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F190</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F190" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE177 DDT2000_ERR_UDS_22F191 ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE177</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE177</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F191</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F191" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE178 DDT2000_ERR_UDS_22F194 ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE178</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE178</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F194</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F194" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE179 DDT2000_ERR_UDS_22F195 ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE179</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE179</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F195</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F195" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE180 DDT2000_ERR_UDS_22F1A0 ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE180</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE180</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_22F1A0</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_22F1A0" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE181 DDT2000_ERR_UDS_StartDiagnosticSession ****************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE181</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE181</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_StartDiagnosticSession</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_StartDiagnosticSession" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE182 DDT2000_ERR_UDS_ClearDiagnosticInformation ************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE182</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE182</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_ClearDiagnosticInformation</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_ClearDiagnosticInformation" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE183 DDT2000_ERR_UDS_1901 ************************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE183</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE183</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_1901</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_1901" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE184 DDT2000_ERR_UDS_1902 ************************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE184</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE184</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_1902</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_1902" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE185 DDT2000_ERR_UDS_1903 ************************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE185</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE185</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_1903</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_1903" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE186 DDT2000_ERR_UDS_190A ************************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE186</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE186</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_190A</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_190A" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE189 DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList ************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE189</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE189</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE190 DDT2000_ERR_UDS_OutputControl_OutputControlCommand ****************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE190</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE190</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_OutputControl_OutputControlCommand</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_OutputControl_OutputControlCommand" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE191 DDT2000_ERR_UDS_ForbiddenRequests *********************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE191</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE191</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_ForbiddenRequests</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_ForbiddenRequests" /></xsl:with-param>
        </xsl:call-template>
<!-- DE192 modifié en warning DW192 -->
<!-- ** DE193 DDT2000_ERR_UDS_Autoident ******************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE193</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE193</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_UDS_Autoident</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_UDS_Autoident" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE194 DDT2000_ERR_DeviceNameInvalidChar_error ***************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE194</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE194</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DeviceNameInvalidChar_error</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DeviceNameInvalidChar_error" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE195 DDT2000_ERR_DataListItemValue *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE195</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE195</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DataListItemValue</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DataListItemValue" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE196 DDT2000_ERR_FunctionAddressCGW ************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE196</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE196</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_FunctionAddressCGW</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_FunctionAddressCGW" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE197 DDT2000_ERR_CanIdInconsistency ************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE197</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE197</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_CanIdInconsistency</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_CanIdInconsistency" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE198 DDT2000_ERR_DtcObdFaultType ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE198</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE198</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_DtcObdFaultType</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_DtcObdFaultType" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE199 DDT2000_ERR_ProjectNotExist ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE199</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE199</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_ProjectNotExist</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_ProjectNotExist" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE200 DDT2000_ERR_TargetName ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE200</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE200</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT2000_ERR_TargetName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT2000_ERR_TargetName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE201 DDT200_ERR_MissingFiles ********************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE201</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE201</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT200_ERR_MissingFiles</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_MissingFiles" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE202 DDT200_ERR_ForbiddenCharacter *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE202</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE202</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT200_ERR_ForbiddenCharacter</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_ForbiddenCharacter" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE203 DDT200_ERR_InvalidNumericListItemText ******************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE203</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE203</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT200_ERR_InvalidNumericListItemText</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_InvalidNumericListItemText" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE204 DDT200_ERR_RoutineControlGeneric ************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE204</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE204</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT200_ERR_RoutineControlGeneric</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_RoutineControlGeneric" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE205 DDT200_ERR_RoutineControlType *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE205</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE205</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT200_ERR_RoutineControlType</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_RoutineControlType" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE206 DDT200_ERR_RoutineIdentifier **************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE206</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE206</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_RoutineIdentifier" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DE207 DDT200_ERR_RoutineControlMissingRID ********************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">DE207</xsl:with-param>
          <xsl:with-param name="paramStopRule">DE207</xsl:with-param>
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramChapter">DDT200_ERR_RoutineControlMissingRID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DDT200_ERR_RoutineControlMissingRID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DDT2000 Other Errors ****************************************************************** -->
        <xsl:call-template name="DisplayOtherErrors">
          <xsl:with-param name="paramType">DDT2000</xsl:with-param>
          <xsl:with-param name="paramTitle">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_OtherErrors</xsl:with-param>
        </xsl:call-template>
<!-- ****************************************************************************************** -->



        <!-- ************************************************************* -->
        <!--             TABLE DES CONTRÔLES CPDD (Après-vente)            -->
        <!-- ************************************************************* -->
        <a name="toc_CPDD">
          <h3>
            <a href="#toc_GENERAL" title="Retour au sommaire">△</a>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/tableCPDDControl"></xsl:with-param>
              <xsl:with-param name="defaultText">Table des contrôles CPDD (Après-vente)*</xsl:with-param>
            </xsl:call-template>
            </h3>
          </a>

        <!-- **************************************************************************************
                              TABLE DES MATIERES WARNINGS CPDD
             |=======================================================================|
             | Règles | Version |       Contrôles               |    xx Warning(s)   |
             |=======================================================================|
             | CW001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
             |=======================================================================|
             | CW002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |
             |=======================================================================|
        *************************************************************************************** -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
          <!-- Definition du header table des matières warning CPDD
               |=======================================================================|
               | Règles | Version |       Contrôles               |    xx Warning(s)   |
               |=======================================================================|
          -->
            <tr>
              <th>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
                  <xsl:with-param name="defaultText">Règles*</xsl:with-param>
                </xsl:call-template>
              </th>
              <th>Version</th>
              <th width="75%">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                  <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
                </xsl:call-template>
              </th>
              <th><xsl:value-of select="$total_CPDD_WAR" /> Warning(s)</th>
            </tr>
          <!-- Documenter les colonnes de la table des matières
               |=======================================================================|
               | CW001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
               |=======================================================================|
               | CW002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |<=====La ligne est grisée quand la version du test = la version courante du contrôle.
                   ^
                   |
                   |
                Il existe un lien sur chaque règle. Ce lien pointe sur la règle correspondante dans le rapport des règles en fin de rapport
          -->
<!-- ** CW001 CPDD_WAR_DataUsedInMultipleRequest ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DataUsedInMultipleRequest</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataUsedInMultipleRequest"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW002 CPDD_WAR_DataComment ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DataComment</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataComment"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW003 CPDD_WAR_DataItemLittleEndian *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DataItemLittleEndian</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataItemLittleEndian"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW004 CPDD_WAR_Data_31BitsCount ******************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_Data_31BitsCount</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_Data_31BitsCount"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW005 CPDD_WAR_DataListItemValue ****************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DataListItemValue</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataListItemValue"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW006 CPDD_WAR_DataListItemText ******************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DataListItemText</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataListItemText"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW007 CPDD_WAR_DataBytesAscii ********************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DataBytesAscii</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataBytesAscii"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW008 CPDD_WAR_DataBitsSigned ********************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DataBitsSigned</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataBitsSigned"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW020 CPDD_WAR_DeviceTestType ********************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">020</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">020</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DeviceTestType</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DeviceTestType"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW021 CPDD_WAR_DeviceTestOBD ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">021</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">021</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DeviceTestOBD</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DeviceTestOBD"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW023 CPDD_WAR_DeviceDTC ************************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">023</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">023</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_DeviceDTC</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DeviceDTC"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CW024 CPDD_WAR_ReplyMinBytes ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">024</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">024</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_WAR_ReplyMinBytes</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_ReplyMinBytes"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CPDD Other Warning Rules ************************************************************** -->
          <xsl:call-template name="AddOtherWarningRules">
            <xsl:with-param name="chapter">CPDD_OtherWarnings</xsl:with-param>
          </xsl:call-template>
<!-- ****************************************************************************************** -->
        </table>
        <br />

        <!-- **************************************************************************************
                              TABLE DES MATIERES ERREURS CPDD
             |=======================================================================|
             | Règles | Version |       Contrôles               |    xx Warning(s)   |
             |=======================================================================|
             | CE001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
             |=======================================================================|
             | CE002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |
             |=======================================================================|
        *************************************************************************************** -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
          <!-- Definition du header table des matières error CPDD
               |=======================================================================|
               | Règles | Version |       Contrôles               |    xx Erreur(s)    |
               |=======================================================================|
          -->
          <tr>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
                <xsl:with-param name="defaultText">Règles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>Version</th>
            <th width="75%">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>
              <xsl:value-of select="$total_CPDD_ERR" />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleError"></xsl:with-param>
                <xsl:with-param name="defaultText">Erreur(s)*</xsl:with-param>
              </xsl:call-template>
            </th>
          </tr>
          <!-- Documenter les colonnes de la table des matières
               |=======================================================================|
               | CE001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
               |=======================================================================|
               | CE002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |<=====La ligne est grisée quand la version du test = la version courante du contrôle.
                   ^
                   |
                   |
                Il existe un lien sur chaque règle. Ce lien pointe sur la règle correspondante dans le rapport des règles en fin de rapport
          -->
<!-- ** CE002 CPDD_ERR_DuplicateNormalizedDataName ******************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_ERR_DuplicateNormalizedDataName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_DuplicateNormalizedDataName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CE003 CPDD_ERR_DataName *************************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_ERR_DataName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_DataName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CE030 CPDD_ERR_RequestName ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">030</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">030</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_ERR_RequestName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_RequestName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CE038 CPDD_ERR_IdentificationRequestName ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">038</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">038</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_ERR_IdentificationRequestName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_IdentificationRequestName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CE150 CPDD_ERR_DeviceName ************************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">150</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">150</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_ERR_DeviceName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_DeviceName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CE151 CPDD_ERR_ReplyMinBytes ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">CE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">151</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">151</xsl:with-param>
            <xsl:with-param name="paramChapter">CPDD_ERR_ReplyMinBytes</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_ReplyMinBytes"/></xsl:with-param>
          </xsl:call-template>
<!-- ** CPDD Other Error Rules **************************************************************** -->
          <xsl:call-template name="AddOtherErrorRules">
            <xsl:with-param name="chapter">CPDD_OtherErrors</xsl:with-param>
          </xsl:call-template>
<!-- ****************************************************************************************** -->
        </table>
        <br />
        <br />
        <hr />
        <br />
<!-- *******************************************************************************************************************************
                                   AFFICHAGE DES WARNINGS ET DES ERREURS CPDD
     ******************************************************************************************************************************* -->
<!-- *******************************************************************************************************************************
                                       AFFICHAGE DES WARNINGS CPDD
     ******************************************************************************************************************************* -->
        <div class="warning">
          <h2>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/CPDDWarning"></xsl:with-param>
              <xsl:with-param name="defaultText">Warning(s) CPDD*</xsl:with-param>
            </xsl:call-template>
          </h2>
        </div>
        <br />
<!-- ** CW001 CPDD_WAR_DataUsedInMultipleRequest ********************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW001</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW001</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DataUsedInMultipleRequest</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataUsedInMultipleRequest" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW002 CPDD_WAR_DataComment ************************************************************ -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW002</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW002</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DataComment</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataComment" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW003 CPDD_WAR_DataItemLittleEndian *************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW003</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW003</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DataItemLittleEndian</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataItemLittleEndian" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW004 CPDD_WAR_Data_31BitsCount ******************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW004</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW004</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_Data_31BitsCount</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_Data_31BitsCount" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW005 CPDD_WAR_DataListItemValue ****************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW005</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW005</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DataListItemValue</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataListItemValue" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW006 CPDD_WAR_DataListItemText ******************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW006</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW006</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DataListItemText</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataListItemText" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW007 CPDD_WAR_DataBytesAscii ********************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW007</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW007</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DataBytesAscii</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataBytesAscii" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW008 CPDD_WAR_DataBitsSigned ********************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW008</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW008</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DataBitsSigned</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DataBitsSigned" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW020 CPDD_WAR_DeviceTestType ********************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW020</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW020</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DeviceTestType</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DeviceTestType" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW021 CPDD_WAR_DeviceTestOBD ********************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW021</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW021</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DeviceTestOBD</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DeviceTestOBD" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW023 CPDD_WAR_DeviceDTC ************************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW023</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW023</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_DeviceDTC</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_DeviceDTC" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CW024 CPDD_WAR_ReplyMinBytes ********************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">CW024</xsl:with-param>
          <xsl:with-param name="paramStopRule">CW024</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_WAR_ReplyMinBytes</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_WAR_ReplyMinBytes" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CPDD Other Warnings ******************************************************************* -->
        <xsl:call-template name="DisplayOtherWarnings">
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramTitle">CPDD</xsl:with-param>
          <xsl:with-param name="chapter">CPDD_OtherWarnings</xsl:with-param>
        </xsl:call-template>
<!-- ****************************************************************************************** -->


<!-- *******************************************************************************************************************************
                                             AFFICHAGE DES ERREURS CPDD
     ******************************************************************************************************************************* -->
        <div class="error">
          <h2>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/CPDDError"></xsl:with-param>
              <xsl:with-param name="defaultText">Erreur(s) CPDD*</xsl:with-param>
            </xsl:call-template>
          </h2>
        </div>
        <br />
<!-- ** CE002 CPDD_ERR_DuplicateNormalizedDataName ******************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">CE002</xsl:with-param>
          <xsl:with-param name="paramStopRule">CE002</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_ERR_DuplicateNormalizedDataName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_DuplicateNormalizedDataName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CE003 CPDD_ERR_DataName *************************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">CE003</xsl:with-param>
          <xsl:with-param name="paramStopRule">CE003</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_ERR_DataName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_DataName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CE030 CPDD_ERR_RequestName ************************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">CE030</xsl:with-param>
          <xsl:with-param name="paramStopRule">CE030</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_ERR_RequestName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_RequestName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CE038 CPDD_ERR_IdentificationRequestName ********************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">CE038</xsl:with-param>
          <xsl:with-param name="paramStopRule">CE038</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_ERR_IdentificationRequestName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_IdentificationRequestName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CE150 CPDD_ERR_DeviceName ************************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">CE150</xsl:with-param>
          <xsl:with-param name="paramStopRule">CE150</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_ERR_DeviceName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_DeviceName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CE151 CPDD_ERR_ReplyMinBytes ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">CE151</xsl:with-param>
          <xsl:with-param name="paramStopRule">CE151</xsl:with-param>
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramChapter">CPDD_ERR_ReplyMinBytes</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_CPDD_ERR_ReplyMinBytes" /></xsl:with-param>
        </xsl:call-template>
<!-- ** CPDD Other Errors ********************************************************************* -->
        <xsl:call-template name="DisplayOtherErrors">
          <xsl:with-param name="paramType">CPDD</xsl:with-param>
          <xsl:with-param name="paramTitle">CPDD</xsl:with-param>
          <xsl:with-param name="chapter">CPDD_OtherErrors</xsl:with-param>
        </xsl:call-template>
<!-- ****************************************************************************************** -->




        <!-- ************************************************************* -->
        <!--               TABLE DES CONTRÔLES DAIMLER (ODX)               -->
        <!-- ************************************************************* -->
        <a name="toc_DAIMLER">
          <h3>
            <a href="#toc_GENERAL" title="Retour au sommaire">△</a>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/tableDAIMLERControl"></xsl:with-param>
              <xsl:with-param name="defaultText">Table des contrôles DAIMLER (ODX)*</xsl:with-param>
            </xsl:call-template>
          </h3>
        </a>

        <!-- **************************************************************************************
                              TABLE DES MATIERES WARNINGS DAIMLER
             |=======================================================================|
             | Règles | Version |       Contrôles               |    xx Warning(s)   |
             |=======================================================================|
             | MW001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
             |=======================================================================|
             | MW002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |
             |=======================================================================|
        *************************************************************************************** -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
          <!-- Definition du header table des matières warning DAIMLER
               |=======================================================================|
               | Règles | Version |       Contrôles               |    xx Warning(s)   |
               |=======================================================================|
          -->
          <tr>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
                <xsl:with-param name="defaultText">Règles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>Version</th>
            <th width="75%">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th><xsl:value-of select="$total_DAIMLER_WAR" /> Warning(s)</th>
          </tr>
          <!-- Documenter les colonnes de la table des matières
               |=======================================================================|
               | MW001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
               |=======================================================================|
               | MW002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |<=====La ligne est grisée quand la version du test = la version courante du contrôle.
                   ^
                   |
                   |
                Il existe un lien sur chaque règle. Ce lien pointe sur la règle correspondante dans le rapport des règles en fin de rapport
          -->
<!-- ** MW001 DAIMLER_WAR_EmptyList *********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">MW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_WAR_EmptyList</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_WAR_EmptyList"/></xsl:with-param>
          </xsl:call-template>
<!-- ** MW011 DAIMLER_WAR_DataNameInvalidChar ************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">MW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">011</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">011</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_WAR_DataNameInvalidChar</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_WAR_DataNameInvalidChar"/></xsl:with-param>
          </xsl:call-template>
<!-- ** MW012 DAIMLER_WAR_RequestNameInvalidChar ********************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">MW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">012</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">012</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_WAR_RequestNameInvalidChar</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_WAR_RequestNameInvalidChar"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DAIMLER Other Warning Rules *********************************************************** -->
          <xsl:call-template name="AddOtherWarningRules">
            <xsl:with-param name="chapter">DAIMLER_OtherWarnings</xsl:with-param>
          </xsl:call-template>
<!-- ****************************************************************************************** -->
        </table>
        <br />

        <!-- **************************************************************************************
                              TABLE DES MATIERES ERREURS DAIMLER
             |=======================================================================|
             | Règles | Version |       Contrôles               |    xx Erreur(s)    |
             |=======================================================================|
             | DE001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
             |=======================================================================|
             | DE002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |
             |=======================================================================|

        *************************************************************************************** -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
          <!-- Definition du header table des matières error DAIMLER
               |=======================================================================|
               | Règles | Version |       Contrôles               |    xx Erreur(s)    |
               |=======================================================================|
          -->
          <tr>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
                <xsl:with-param name="defaultText">Règles*</xsl:with-param>
              </xsl:call-template>
            </th><th>Version</th>
            <th width="75%">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>
              <xsl:value-of select="$total_DAIMLER_ERR" />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleError"></xsl:with-param>
                <xsl:with-param name="defaultText">Erreur(s)*</xsl:with-param>
              </xsl:call-template>
            </th>
          </tr>
          <!-- Documenter les colonnes de la table des matières
               |=======================================================================|
               | DE001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
               |=======================================================================|
               | DE002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |<=====La ligne est grisée quand la version du test = la version courante du contrôle.
                   ^
                   |
                   |
                Il existe un lien sur chaque règle. Ce lien pointe sur la règle correspondante dans le rapport des règles en fin de rapport
          -->
<!-- ** ME001 DAIMLER_ERR_SID ***************************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_SID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_SID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME002 DAIMLER_ERR_ReplyByte *********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_ReplyByte</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ReplyByte"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME003 DAIMLER_ERR_RequestByte ********************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_RequestByte</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RequestByte"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME004 DAIMLER_ERR_MissingAutoIdent **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_MissingAutoIdent</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_MissingAutoIdent"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME005 DAIMLER_ERR_WrongAutoIdent ****************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_WrongAutoIdent</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_WrongAutoIdent"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME006 DAIMLER_ERR_DataItemOutsideFrame ************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_DataItemOutsideFrame</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_DataItemOutsideFrame"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME007 DAIMLER_ERR_DataListItemValue *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_DataListItemValue</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_DataListItemValue"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME008 DAIMLER_ERR_IdentRequest ******************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_IdentRequest</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_IdentRequest"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME009 DAIMLER_ERR_ReplyMinBytes ******************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">009</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">009</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_ReplyMinBytes</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ReplyMinBytes"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME010 DAIMLER_ERR_ReplyBytes ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">010</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">010</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_ReplyBytes</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ReplyBytes"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME013 DAIMLER_ERR_OutputControl_GenericRequest **************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">013</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">013</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_OutputControl_GenericRequest</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_OutputControl_GenericRequest"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME014 DAIMLER_ERR_OutputControlList_MissingID ***************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">014</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">014</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_OutputControlList_MissingID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_OutputControlList_MissingID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME015 DAIMLER_ERR_OutputPermanentControlList_Request ********************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">015</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">015</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_OutputPermanentControlList_Request</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_OutputPermanentControlList_Request"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME016 DAIMLER_ERR_DataName ************************************************************ -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">016</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">016</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_DataName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_DataName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME017 DAIMLER_ERR_RequestName ********************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">017</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">017</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_RequestName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RequestName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME018 DAIMLER_ERR_RequestErrorSID ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">018</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">018</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_RequestErrorSID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RequestErrorSID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME019 DAIMLER_ERR_IdentF111 *********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">019</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">019</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_IdentF111</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_IdentF111"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME020 DAIMLER_ERR_IdentF121 *********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">020</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">020</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_IdentF121</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_IdentF121"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME021 DAIMLER_ERR_RoutineIdentifierMissing ******************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">021</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">021</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_RoutineIdentifierMissing</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RoutineIdentifierMissing"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME022 DAIMLER_ERR_ByteBoundary ******************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">022</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">022</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_ByteBoundary</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ByteBoundary"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME023 DAIMLER_ERR_RequestOverlap ****************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">023</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">023</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_RequestOverlap</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RequestOverlap"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ME024 DAIMLER_ERR_ResponseOverlap ****************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">ME</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">024</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">024</xsl:with-param>
            <xsl:with-param name="paramChapter">DAIMLER_ERR_ResponseOverlap</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ResponseOverlap"/></xsl:with-param>
          </xsl:call-template>
<!-- ** DAIMLER Other Error Rules ************************************************************* -->
          <xsl:call-template name="AddOtherErrorRules">
            <xsl:with-param name="chapter">DAIMLER_OtherErrors</xsl:with-param>
          </xsl:call-template>
<!-- ****************************************************************************************** -->
        </table>
        <br />
        <br />
        <hr />
        <br />
<!-- *******************************************************************************************************************************
                                   AFFICHAGE DES WARNINGS ET DES ERREURS DAIMLER
     ******************************************************************************************************************************* -->
<!-- *******************************************************************************************************************************
                                       AFFICHAGE DES WARNINGS DAIMLER
     ******************************************************************************************************************************* -->
        <div class="warning">
          <h2>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/DAIMLERWarning"></xsl:with-param>
              <xsl:with-param name="defaultText">Warning(s) DAIMLER*</xsl:with-param>
            </xsl:call-template>
          </h2>
        </div>
        <br />
<!-- ** MW001 DAIMLER_WAR_EmptyList *********************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">MW001</xsl:with-param>
          <xsl:with-param name="paramStopRule">MW001</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_WAR_EmptyList</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_WAR_EmptyList" /></xsl:with-param>
        </xsl:call-template>
<!-- ** MW011 DAIMLER_WAR_DataNameInvalidChar ************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">MW011</xsl:with-param>
          <xsl:with-param name="paramStopRule">MW011</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_WAR_DataNameInvalidChar</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_WAR_DataNameInvalidChar" /></xsl:with-param>
        </xsl:call-template>
<!-- ** MW012 DAIMLER_WAR_RequestNameInvalidChar ********************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">MW012</xsl:with-param>
          <xsl:with-param name="paramStopRule">MW012</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_WAR_RequestNameInvalidChar</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_WAR_RequestNameInvalidChar" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DAIMLER Other Warnings **************************************************************** -->
        <xsl:call-template name="DisplayOtherWarnings">
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramTitle">DAIMLER</xsl:with-param>
          <xsl:with-param name="chapter">DAIMLER_OtherWarnings</xsl:with-param>
        </xsl:call-template>
<!-- ****************************************************************************************** -->
<!-- ******************************************************************************************************************************
                                             AFFICHAGE DES ERREURS DAIMLER
     ****************************************************************************************************************************** -->
        <div class="error">
          <h2>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/DAIMLERError"></xsl:with-param>
              <xsl:with-param name="defaultText">Erreur(s) DAIMLER*</xsl:with-param>
            </xsl:call-template>
          </h2>
        </div>
        <br />
<!-- ** ME001 DAIMLER_ERR_SID ***************************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME001</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME001</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_SID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_SID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME002 DAIMLER_ERR_ReplyByte *********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME002</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME002</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_ReplyByte</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ReplyByte" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME003 DAIMLER_ERR_RequestByte ********************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME003</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME003</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_RequestByte</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RequestByte" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME004 DAIMLER_ERR_MissingAutoIdent **************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME004</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME004</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_MissingAutoIdent</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_MissingAutoIdent" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME005 DAIMLER_ERR_WrongAutoIdent ****************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME005</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME005</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_WrongAutoIdent</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_WrongAutoIdent" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME006 DAIMLER_ERR_DataItemOutsideFrame ************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME006</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME006</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_DataItemOutsideFrame</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_DataItemOutsideFrame" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME007 DAIMLER_ERR_DataListItemValue *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME007</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME007</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_DataListItemValue</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_DataListItemValue" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME008 DAIMLER_ERR_IdentRequest ******************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME008</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME008</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_IdentRequest</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_IdentRequest" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME009 DAIMLER_ERR_ReplyMinBytes ******************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME009</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME009</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_ReplyMinBytes</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ReplyMinBytes" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME010 DAIMLER_ERR_ReplyBytes ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME010</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME010</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_ReplyBytes</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ReplyBytes" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME013 DAIMLER_ERR_OutputControl_GenericRequest **************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME013</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME013</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_OutputControl_GenericRequest</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_OutputControl_GenericRequest" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME014 DAIMLER_ERR_OutputControlList_MissingID ***************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME014</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME014</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_OutputControlList_MissingID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_OutputControlList_MissingID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME015 DAIMLER_ERR_OutputPermanentControlList_Request ********************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME015</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME015</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_OutputPermanentControlList_Request</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_OutputPermanentControlList_Request" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME016 DAIMLER_ERR_DataName ************************************************************ -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME016</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME016</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_DataName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_DataName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME017 DAIMLER_ERR_RequestName ********************************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME017</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME017</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_RequestName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RequestName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME018 DAIMLER_ERR_RequestErrorSID ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME018</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME018</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_RequestErrorSID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RequestErrorSID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME019 DAIMLER_ERR_IdentF111 *********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME019</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME019</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_IdentF111</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_IdentF111" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME020 DAIMLER_ERR_IdentF121 *********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME020</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME020</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_IdentF121</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_IdentF121" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME021 DAIMLER_ERR_RoutineIdentifierMissing ******************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME021</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME021</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_RoutineIdentifierMissing</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RoutineIdentifierMissing" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME022 DAIMLER_ERR_ByteBoundary ******************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME022</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME022</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_ByteBoundary</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ByteBoundary" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME023 DAIMLER_ERR_RequestOverlap ****************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME023</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME023</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_RequestOverlap</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_RequestOverlap" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ME024 DAIMLER_ERR_ResponseOverlap ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">ME024</xsl:with-param>
          <xsl:with-param name="paramStopRule">ME024</xsl:with-param>
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramChapter">DAIMLER_ERR_ResponseOverlap</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_DAIMLER_ERR_ResponseOverlap" /></xsl:with-param>
        </xsl:call-template>
<!-- ** DAIMLER Other Errors ****************************************************************** -->
        <xsl:call-template name="DisplayOtherErrors">
          <xsl:with-param name="paramType">DAIMLER</xsl:with-param>
          <xsl:with-param name="paramTitle">DAIMLER</xsl:with-param>
          <xsl:with-param name="chapter">DAIMLER_OtherErrors</xsl:with-param>
        </xsl:call-template>
<!-- ****************************************************************************************** -->



        <!-- ************************************************************* -->
        <!--               TABLE DES CONTRÔLES ALLIANCE (ODX)              -->
        <!-- ************************************************************* -->
        <a name="toc_ALLIANCE">
          <h3>
            <a href="#toc_GENERAL" title="Retour au sommaire">△</a>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/tableALLIANCEControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Table des contrôles ALLIANCE (ODX)*</xsl:with-param>
              </xsl:call-template>
            </h3>
          </a>

        <!-- **************************************************************************************
                              TABLE DES MATIERES WARNINGS ALLIANCE
             |=======================================================================|
             | Règles | Version |       Contrôles               |    xx Warning(s)   |
             |=======================================================================|
             | AW001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
             |=======================================================================|
             | AW002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |
             |=======================================================================|
        *************************************************************************************** -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
          <!-- Definition du header table des matières warning ALLIANCE
               |=======================================================================|
               | Règles | Version |       Contrôles               |    xx Warning(s)   |
               |=======================================================================|
          -->
          <tr>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
                <xsl:with-param name="defaultText">Règles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>Version</th>
            <th width="75%">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th><xsl:value-of select="$total_ALLIANCE_WAR" /> Warning(s)</th>
          </tr>
          <!-- Documenter les colonnes de la table des matières
               |=======================================================================|
               | AW001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
               |=======================================================================|
               | AW002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |<=====La ligne est grisée quand la version du test = la version courante du contrôle.
                   ^
                   |
                   |
                Il existe un lien sur chaque règle. Ce lien pointe sur la règle correspondante dans le rapport des règles en fin de rapport
          -->
<!-- ** AW001 ALLIANCE_WAR_DataName *********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_WAR_DataName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_DataName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AW002 ALLIANCE_WAR_EndianRedefinition ************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_WAR_EndianRedefinition</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_EndianRedefinition"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AW003 ALLIANCE_WAR_RequestName ******************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_WAR_RequestName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_RequestName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AW004 ALLIANCE_WAR_DeviceName ********************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_WAR_DeviceName</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_DeviceName"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AW005 ALLIANCE_WAR_ValueRange ********************************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_WAR_ValueRange</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_ValueRange"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AW006 ALLIANCE_WAR_BackupFileUsed ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_WAR_BackupFileUsed</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_BackupFileUsed"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AW007 ALLIANCE_WAR_NotNumericDataItemLittleEndian ************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AW</xsl:with-param>
            <xsl:with-param name="paramTypeRule">WAR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_WAR_NotNumericDataItemLittleEndian</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_NotNumericDataItemLittleEndian"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ALLIANCE Other Warning Rules ********************************************************** -->
          <xsl:call-template name="AddOtherWarningRules">
            <xsl:with-param name="chapter">ALLIANCE_OtherWarnings</xsl:with-param>
          </xsl:call-template>
<!-- ****************************************************************************************** -->
        </table>
        <br />

        <!-- **************************************************************************************
                              TABLE DES MATIERES ERREURS ALLIANCE
             |=======================================================================|
             | Règles | Version |       Contrôles               |    xx Erreur(s)    |
             |=======================================================================|
             | AE001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
             |=======================================================================|
             | AE002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |
             |=======================================================================|

        *************************************************************************************** -->
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
          <!-- Definition du header table des matières error ALLIANCE
               |=======================================================================|
               | Règles | Version |       Contrôles               |    xx Erreur(s)    |
               |=======================================================================|
          -->
          <tr>
            <th>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
                <xsl:with-param name="defaultText">Règles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th>Version</th>
            <th width="75%">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleControl"></xsl:with-param>
                <xsl:with-param name="defaultText">Contrôles*</xsl:with-param>
              </xsl:call-template>
            </th>
            <th><xsl:value-of select="$total_ALLIANCE_ERR" />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitleError"></xsl:with-param>
                <xsl:with-param name="defaultText">Erreur(s)*</xsl:with-param>
              </xsl:call-template>
            </th>
          </tr>
          <!-- Documenter les colonnes de la table des matières
               |=======================================================================|
               | AE001  |  V1.1   | xxxxxxxxxxxxxxxxxxx           |         X          |
               |=======================================================================|
               | AE002  |  V1.3   | YYYYYYYYYYYYYYYYYYYYY         |         T          |<=====La ligne est grisée quand la version du test = la version courante du contrôle.
                   ^
                   |
                   |
                Il existe un lien sur chaque règle. Ce lien pointe sur la règle correspondante dans le rapport des règles en fin de rapport
          -->
<!-- ** AE001 ALLIANCE_ERR_RequestErrorSID **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">001</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorSID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorSID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE002 ALLIANCE_ERR_ResponseErrorSID *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">002</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorSID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorSID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE003 ALLIANCE_ERR_RequestErrorDID **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">003</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorDID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorDID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE004 ALLIANCE_ERR_ResponseErrorDID *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">004</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorDID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorDID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE005 ALLIANCE_ERR_RequestErrorLID **************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">005</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorLID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorLID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE006 ALLIANCE_ERR_ResponseErrorLID *************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">006</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorLID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorLID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE007 ALLIANCE_ERR_RequestErrorDataItemDID ******************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">007</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorDataItemDID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorDataItemDID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE008 ALLIANCE_ERR_ResponseErrorDataItemDID ******************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">008</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorDataItemDID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorDataItemDID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE009 ALLIANCE_ERR_RequestErrorDataItemLID ******************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">009</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">009</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorDataItemLID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorDataItemLID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE010 ALLIANCE_ERR_ResponseErrorDataItemLID ******************************************* -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">010</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">010</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorDataItemLID</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorDataItemLID"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE011 ALLIANCE_ERR_RequestOverlap ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">011</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">011</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestOverlap</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestOverlap"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE012 ALLIANCE_ERR_NotNumericDataItemLittleEndian ************************************* -->
  <!-- REMOVE V1.11 (Replace by AW007)
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">012</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">012</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_NotNumericDataItemLittleEndian</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_NotNumericDataItemLittleEndian"/></xsl:with-param>
          </xsl:call-template>
  -->
<!-- ** AE013 ALLIANCE_ERR_EmptyList ********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">013</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">013</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_EmptyList</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_EmptyList"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE014 ALLIANCE_ERR_DataListItemValue ************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">014</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">014</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_DataListItemValue</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_DataListItemValue"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE015 ALLIANCE_ERR_DataUnit *********************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">015</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">015</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_DataUnit</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_DataUnit"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE016 ALLIANCE_ERR_RequestTooLong ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">016</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">016</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestTooLong</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestTooLong"/></xsl:with-param>
          </xsl:call-template>
<!-- ** AE017 ALLIANCE_ERR_RequestTooLong ***************************************************** -->
          <xsl:call-template name="addRules">
            <xsl:with-param name="rulePrefix">AE</xsl:with-param>
            <xsl:with-param name="paramTypeRule">ERR</xsl:with-param>
            <xsl:with-param name="paramStartRuleNb">017</xsl:with-param>
            <xsl:with-param name="paramStopRuleNb">017</xsl:with-param>
            <xsl:with-param name="paramChapter">ALLIANCE_ERR_ByteBoundary</xsl:with-param>
            <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ByteBoundary"/></xsl:with-param>
          </xsl:call-template>
<!-- ** ALLIANCE Other Error Rules ************************************************************ -->
          <xsl:call-template name="AddOtherErrorRules">
            <xsl:with-param name="chapter">ALLIANCE_OtherErrors</xsl:with-param>
          </xsl:call-template>
<!-- ****************************************************************************************** -->
        </table>
        <br />
        <br />
        <hr />
        <br />

<!-- *******************************************************************************************************************************
                                   AFFICHAGE DES WARNINGS ET DES ERREURS ALLIANCE
     ******************************************************************************************************************************* -->
<!-- *******************************************************************************************************************************
                                       AFFICHAGE DES WARNINGS ALLIANCE
     ******************************************************************************************************************************* -->
        <div class="warning">
          <h2>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/ALLIANCEWarning"></xsl:with-param>
              <xsl:with-param name="defaultText">Warning(s) ALLIANCE-ODX*</xsl:with-param>
            </xsl:call-template>
          </h2>
        </div>
        <br />
<!-- ** AW001 ALLIANCE_WAR_DataName *********************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">AW001</xsl:with-param>
          <xsl:with-param name="paramStopRule">AW001</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_WAR_DataName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_DataName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AW002 ALLIANCE_WAR_EndianRedefinition ************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">AW002</xsl:with-param>
          <xsl:with-param name="paramStopRule">AW002</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_WAR_EndianRedefinition</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_EndianRedefinition" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AW003 ALLIANCE_WAR_RequestName ******************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">AW003</xsl:with-param>
          <xsl:with-param name="paramStopRule">AW003</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_WAR_RequestName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_RequestName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AW004 ALLIANCE_WAR_DeviceName ********************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">AW004</xsl:with-param>
          <xsl:with-param name="paramStopRule">AW004</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_WAR_DeviceName</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_DeviceName" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AW005 ALLIANCE_WAR_ValueRange ********************************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">AW005</xsl:with-param>
          <xsl:with-param name="paramStopRule">AW005</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_WAR_ValueRange</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_ValueRange" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AW006 ALLIANCE_WAR_BackupFileUsed ***************************************************** -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">AW006</xsl:with-param>
          <xsl:with-param name="paramStopRule">AW006</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_WAR_BackupFileUsed</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_BackupFileUsed" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AW007 ALLIANCE_WAR_NotNumericDataItemLittleEndian ************************************* -->
        <xsl:call-template name="DisplayWarning">
          <xsl:with-param name="paramStartRule">AW007</xsl:with-param>
          <xsl:with-param name="paramStopRule">AW007</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_WAR_NotNumericDataItemLittleEndian</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_WAR_NotNumericDataItemLittleEndian" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ALLIANCE Other Warnings *************************************************************** -->
        <xsl:call-template name="DisplayOtherWarnings">
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramTitle">ALLIANCE</xsl:with-param>
          <xsl:with-param name="chapter">ALLIANCE_OtherWarnings</xsl:with-param>
        </xsl:call-template>
<!-- ****************************************************************************************** -->


<!-- ******************************************************************************************************************************
                                             AFFICHAGE DES ERREURS ALLIANCE
     ****************************************************************************************************************************** -->
        <div class="error">
          <h2>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/ALLIANCEError"></xsl:with-param>
              <xsl:with-param name="defaultText">Erreur(s) ALLIANCE-ODX*</xsl:with-param>
            </xsl:call-template>
          </h2>
        </div>
<!-- ** AE001 ALLIANCE_ERR_RequestErrorSID **************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE001</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE001</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorSID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorSID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE002 ALLIANCE_ERR_ResponseErrorSID *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE002</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE002</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorSID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorSID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE003 ALLIANCE_ERR_RequestErrorDID **************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE003</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE003</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorDID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorDID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE004 ALLIANCE_ERR_ResponseErrorDID *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE004</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE004</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorDID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorDID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE005 ALLIANCE_ERR_RequestErrorLID **************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE005</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE005</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorLID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorLID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE006 ALLIANCE_ERR_ResponseErrorLID *************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE006</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE006</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorLID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorLID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE007 ALLIANCE_ERR_RequestErrorDataItemDID ******************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE007</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE007</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorDataItemDID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorDataItemDID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE008 ALLIANCE_ERR_ResponseErrorDataItemDID ******************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE008</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE008</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorDataItemDID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorDataItemDID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE009 ALLIANCE_ERR_RequestErrorDataItemLID ******************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE009</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE009</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestErrorDataItemLID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestErrorDataItemLID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE010 ALLIANCE_ERR_ResponseErrorDataItemLID ******************************************* -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE010</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE010</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_ResponseErrorDataItemLID</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ResponseErrorDataItemLID" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE011 ALLIANCE_ERR_RequestOverlap ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE011</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE011</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestOverlap</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestOverlap" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE012 ALLIANCE_ERR_NotNumericDataItemLittleEndian ************************************* -->
  <!-- REMOVE V1.11 (Replace by AW007)
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE012</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE012</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_NotNumericDataItemLittleEndian</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_NotNumericDataItemLittleEndian" /></xsl:with-param>
        </xsl:call-template>
  -->
<!-- ** AE013 ALLIANCE_ERR_EmptyList ********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE013</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE013</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_EmptyList</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_EmptyList" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE014 ALLIANCE_ERR_DataListItemValue ************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE014</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE014</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_DataListItemValue</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_DataListItemValue" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE015 ALLIANCE_ERR_DataUnit *********************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE015</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE015</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_DataUnit</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_DataUnit" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE016 ALLIANCE_ERR_RequestTooLong ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE016</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE016</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_RequestTooLong</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_RequestTooLong" /></xsl:with-param>
        </xsl:call-template>
<!-- ** AE017 ALLIANCE_ERR_ByteBoundary ***************************************************** -->
        <xsl:call-template name="DisplayError">
          <xsl:with-param name="paramStartRule">AE017</xsl:with-param>
          <xsl:with-param name="paramStopRule">AE017</xsl:with-param>
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramChapter">ALLIANCE_ERR_ByteBoundary</xsl:with-param>
          <xsl:with-param name="paramCounter"><xsl:value-of select="$count_ALLIANCE_ERR_ByteBoundary" /></xsl:with-param>
        </xsl:call-template>
<!-- ** ALLIANCE Other Errors ***************************************************************** -->
        <xsl:call-template name="DisplayOtherErrors">
          <xsl:with-param name="paramType">ALLIANCE</xsl:with-param>
          <xsl:with-param name="paramTitle">ALLIANCE</xsl:with-param>
          <xsl:with-param name="chapter">ALLIANCE_OtherErrors</xsl:with-param>
        </xsl:call-template>
<!-- ****************************************************************************************** -->

        <xsl:call-template name="rules_DisplayTemplates" />
      </body>
    </html>
  </xsl:template>


  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Template Message
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <xsl:template match="/check/message">
    <tr>
      <xsl:choose>
        <xsl:when test="position() mod 2 != 0">
          <td class="cellule_currentversion"><xsl:copy-of select="name" /></td>
          <td class="cellule_currentversion"><xsl:copy-of select="info" /></td>
        </xsl:when>
        <xsl:otherwise>
          <td><xsl:copy-of select="name" /></td>
          <td><xsl:copy-of select="info" /></td>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>

  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Template rule title
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <xsl:template name="ruleTitle">
    <xsl:param name="language"></xsl:param>
    <xsl:param name="code"></xsl:param>
    <xsl:call-template name="getLocalizedText">
      <xsl:with-param name="lang" select="$reportLanguage"></xsl:with-param>
      <xsl:with-param name="aNode" select="/check/rule/code[.=$code]/../titleA"></xsl:with-param>
      <xsl:with-param name="defaultText">pas trouvé</xsl:with-param>
    </xsl:call-template>
  </xsl:template>



  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Template Add Rules
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <!-- ce template utilise le template BoucleRuleRef -->
  <xsl:template name="addRules">
    <xsl:param name="rulePrefix" />
    <xsl:param name="paramTypeRule" />
    <xsl:param name="paramStartRuleNb" />
    <xsl:param name="paramStopRuleNb" />
    <xsl:param name="paramChapter" />
    <xsl:param name="paramCounter" />

    <xsl:variable name="mRule" select="concat($rulePrefix,format-number($paramStartRuleNb,'000'))" />
    <xsl:variable name="mRule1" select="concat($rulePrefix,format-number($paramStopRuleNb,'000'))" />
    <xsl:variable name="mRuleV"><xsl:value-of select="check/rule/code[text()=$mRule]/../version" /></xsl:variable>
    <xsl:variable name="mClass"><xsl:if test="$mRuleV = $mCurrentVersion">cellule_currentversion</xsl:if></xsl:variable> <!-- Si la version du test = la version courante du contrôle alors la ligne du test dans la table des matières est grisée -->
    <xsl:variable name="mHref" select="concat('#',$paramChapter)" />

    <tr>
      <!-- Documenter la règle associée au contrôle avec le lien vers la règle correspondante expliquée en fin de rapport -->

      <!-- Mise en forme de la 1ere cellule en fonction du nombre de règle concerné (1, 2 ou plus) -->
      <xsl:choose>
        <xsl:when test="number($paramStartRuleNb) = number($paramStopRuleNb)">
          <td class="{$mClass}">
            <a name="R{$mRule}">
              <a href="#{$mRule}"><xsl:value-of select="$mRule" /></a>
            </a>
          </td>
        </xsl:when>
        <xsl:when test="number($paramStartRuleNb)+1  = number($paramStopRuleNb)">
          <td class="{$mClass}">
            <a name="R{$mRule}">
              <a href="#{$mRule}"><xsl:value-of select="$mRule" /> &amp; <xsl:value-of select="$mRule1" /></a>
            </a>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td class="{$mClass}">
            <a name="R{$mRule}">
              <a href="#{$mRule}"><xsl:value-of select="$mRule" /> -&gt; <xsl:value-of select="$mRule1" /></a>
            </a>
            <!-- Permet de naviguer entre la table des matières et la liste des règles -->
              <!-- L'appel au template BoucleRuleRef permet de créer les liens pour toutes les règles comprise entre le n° de départ (paramStartRuleNb) et le n° final (paramStopRuleNb) -->
            <xsl:call-template name="BoucleRuleRef">
              <xsl:with-param name="index" select="number($paramStartRuleNb)+1" />
              <xsl:with-param name="valMax" select="$paramStopRuleNb" />
              <xsl:with-param name="rulePrefix" select="$rulePrefix" />
            </xsl:call-template>
            <!-- Ajout de la dernière règle -->
            <a name="R{$mRule1}"><a href="#{$mRule1}"></a></a>
          </td>
        </xsl:otherwise>
      </xsl:choose>

      <!-- Partie commune -->
      <td class="{$mClass}">
        <xsl:value-of select="check/rule/code[text()=$mRule]/../version"></xsl:value-of>
      </td>
      <!-- Mise en forme en fonction de la valeur du compteur -->
      <xsl:choose>
        <xsl:when test="$paramCounter = 0">
          <td class="{$mClass}">
            <xsl:call-template name="ruleTitle">
              <xsl:with-param name="language"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="code"><xsl:value-of select="$mRule" /></xsl:with-param>
            </xsl:call-template>
          </td>
          <td class="cellule_normale"><xsl:value-of select="$paramCounter" /></td>
        </xsl:when>
        <xsl:otherwise>
          <td class="{$mClass}">
            <a href="{$mHref}">
              <xsl:call-template name="ruleTitle">
                <xsl:with-param name="language"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="code"><xsl:value-of select="$mRule" /></xsl:with-param>
              </xsl:call-template>
            </a>
          </td>
          <!-- compteur > 0 == > mise en forme en fonction du type de règle -->
          <xsl:choose>
            <xsl:when test="$paramTypeRule = 'WAR'">
              <td class="cellule_warning"><xsl:value-of select="$paramCounter" /></td>
            </xsl:when>
            <xsl:otherwise>
              <td class="cellule_error"><xsl:value-of select="$paramCounter" /></td>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>

  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Template BoucleRuleRef
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
     <!-- implémentation d'une boucle for (i = index; index < valMax; index ++) -->
  <xsl:template name="BoucleRuleRef">
    <xsl:param name="index" />
    <xsl:param name="valMax" />
    <xsl:param name="rulePrefix" />

    <xsl:if test="number($index) &lt; number($valMax)">
      <xsl:variable name="rName" select="concat('R',$rulePrefix,format-number($index,'000'))" />
      <xsl:variable name="href" select="concat('#',$rulePrefix,format-number($index,'000'))" />

      <a name="{$rName}"><a href="{$href}"></a></a>
      <xsl:call-template name="BoucleRuleRef">
        <xsl:with-param name="index" select="number($index)+1" />
        <xsl:with-param name="valMax" select="$valMax" />
        <xsl:with-param name="rulePrefix" select="$rulePrefix" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Templates Add Other Rules
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <xsl:template name="AddOtherWarningRules">
    <xsl:param name="chapter"/>

    <xsl:variable name="mCount" select="count(//check/warning[@chapter=$chapter])" />
    <tr>
      <td />
      <td />
      <xsl:choose>
        <xsl:when test="$mCount = 0">
          <td>Other</td>
          <td class="cellule_normale">0</td>
        </xsl:when>
        <xsl:otherwise>
          <td><a href="#{$chapter}">Other</a></td>
          <td class="cellule_warning"><xsl:value-of select="$mCount" /></td>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>

  <xsl:template name="AddOtherErrorRules">
    <xsl:param name="chapter"/>

    <xsl:variable name="mCount" select="count(//check/error[@chapter=$chapter])" />
    <tr>
      <td />
      <td />
      <xsl:choose>
        <xsl:when test="$mCount = 0">
          <td>Other</td>
          <td class="cellule_normale">0</td>
        </xsl:when>
        <xsl:otherwise>
          <td><a href="#{$chapter}">Other</a></td>
          <td class="cellule_error"><xsl:value-of select="$mCount" /></td>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>

  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Templates DisplayWarning
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <xsl:template name="DisplayWarning">
    <xsl:param name="paramStartRule"/>
    <xsl:param name="paramStopRule" />
    <xsl:param name="paramType" />
    <xsl:param name="paramChapter" />
    <xsl:param name="paramCounter" />

    <xsl:if test="$paramCounter  != 0">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
        <tr>
          <th><a href="#toc_ALLIANCE" title="Retour au sommaire" class="whiteLink">▲</a></th>
          <th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">△</a></th>
          <xsl:choose>
            <xsl:when test="$paramStartRule = $paramStopRule">
              <th><a href="#{$paramStartRule}"><xsl:value-of select="$paramStartRule" /></a></th>
            </xsl:when>
            <xsl:otherwise>
              <th><a href="#{$paramStartRule}"><xsl:value-of select="$paramStartRule" /> - <xsl:value-of select="$paramStopRule"/></a></th>
            </xsl:otherwise>
          </xsl:choose>
          <th><xsl:value-of select="check/rule/code[text()=$paramStartRule]/../version"></xsl:value-of></th>
          <th class="warningTitle">
            <a name="{$paramChapter}">
              <xsl:call-template name="ruleTitle">
                <xsl:with-param name="language"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="code"><xsl:value-of select="$paramStartRule" /></xsl:with-param>
              </xsl:call-template>
            </a>
          </th>
          <th class="warningCount"><xsl:value-of select="$paramCounter" /> warning(s)</th>
        </tr>
        <tr><td colspan="6"></td></tr>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
        <tr>
          <th>Description</th>
          <th>Information</th>
          <th>Action</th>
        </tr>
        <xsl:apply-templates select="check/warning[@chapter=$paramChapter and @type=$paramType]" />
      </table>
      <br />
      <br />
    </xsl:if>
  </xsl:template>

  <xsl:template name="DisplayOtherWarnings">
    <xsl:param name="paramType"/>
    <xsl:param name="paramTitle" />
    <xsl:param name="chapter" />

    <xsl:variable name="mTitle" select="concat($paramType,'_OtherWarnings')"/>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
      <tr>
        <th><a href="#toc_ALLIANCE" title="Retour au sommaire" class="whiteLink">▲</a></th>
        <th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">△</a></th>
        <th class="warningTitle"><a name="{$mTitle}">(<xsl:value-of select="$paramTitle" />) Other warning(s)</a></th>
        <th class="warningCount"><xsl:value-of select="count(//check/warning[@chapter=$chapter])" /> warning(s)</th>
      </tr>
      <tr><td colspan="4"></td></tr>
    </table>

    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
      <th>Description</th><th>Information</th><th>Action</th>
      <xsl:apply-templates select="check/warning[@chapter = $chapter]" />
    </table>
    <br/>
    <br/>
  </xsl:template>

  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Template warning
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <xsl:template match="/check/warning">
    <tr>
      <td><xsl:copy-of select="name" /></td>
      <td><xsl:copy-of select="info" /></td>
      <td><xsl:copy-of select="action" /></td>
    </tr>
  </xsl:template>



  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Templates DisplayError
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <xsl:template name="DisplayError">
    <xsl:param name="paramStartRule" />
    <xsl:param name="paramStopRule" />
    <xsl:param name="paramType" />
    <xsl:param name="paramChapter" />
    <xsl:param name="paramCounter" />

    <xsl:if test="$paramCounter != 0">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
        <tr>
          <th><a href="#toc_DDT2000" title="Retour au sommaire" class="whiteLink">▲</a></th>
          <th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">△</a></th>
          <xsl:choose>
            <xsl:when test="$paramStartRule = $paramStopRule">
              <th><a href="#{$paramStartRule}"><xsl:value-of select="$paramStartRule" /></a></th>
            </xsl:when>
            <xsl:otherwise>
              <th><a href="#{$paramStartRule}"><xsl:value-of select="$paramStartRule" /> - <xsl:value-of select="$paramStopRule"/></a></th>
            </xsl:otherwise>
          </xsl:choose>
          <th><xsl:value-of select="check/rule/code[text()=$paramStartRule]/../version"></xsl:value-of></th>
          <th class="errorTitle">
            <a name="{$paramChapter}">
              <xsl:call-template name="ruleTitle">
                <xsl:with-param name="language"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="code"><xsl:value-of select="$paramStartRule" /></xsl:with-param>
              </xsl:call-template>
            </a>
          </th>
          <th class="errorCount"><xsl:value-of select="$paramCounter" /> error(s)</th>
        </tr>
        <tr><td colspan="6"></td></tr>
      </table>
      <table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
        <th>Description</th>
        <th>Information</th>
        <th>Action</th>
        <xsl:apply-templates select="check/error[@chapter=$paramChapter and @type=$paramType]" />
      </table>
      <br />
      <br />
    </xsl:if>
  </xsl:template>


  <xsl:template name="DisplayOtherErrors">
    <xsl:param name="paramType"/>
    <xsl:param name="paramTitle" />
    <xsl:param name="chapter" />

    <xsl:variable name="mTitle" select="concat($paramType,'_OtherErrors')"/>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
      <tr>
        <th><a href="#toc_ALLIANCE" title="Retour au sommaire" class="whiteLink">▲</a></th>
        <th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">△</a></th>
        <th class="errorTitle"><a name="{$mTitle}">(<xsl:value-of select="$paramTitle" />) Other error(s)</a></th>
        <th class="errorCount"><xsl:value-of select="count(//check/error[@chapter=$chapter])" /> error(s)</th>
      </tr>
      <tr><td colspan="4"></td></tr>
    </table>

    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
      <th>Description</th><th>Information</th><th>Action</th>
      <xsl:apply-templates select="check/error[@chapter = $chapter]" />
    </table>
    <br/>
    <br/>
  </xsl:template>

  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            Template error
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <xsl:template match="/check/error">
    <tr>
      <td><xsl:copy-of select="name" /></td>
      <td><xsl:copy-of select="info" /></td>
      <td><xsl:copy-of select="action" /></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>