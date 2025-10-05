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
     List rules
     ****************************************************************************************** -->
  <xsl:template name="ListRules">
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                         WARNINGS DDT 2000                         -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <rule><!-- DW001 DDT2000_WAR_DataUsedInMultipleRequest -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DW001</code>
      <critic>warning</critic>
      <titleA>Data used in multiple request</titleA>
      <titleA xml:lang="fr">Donnée(s) déclarée(s) dans plusieurs requêtes</titleA>
      <name>Data</name>
      <name xml:lang="fr">Donnée</name>
      <info>List all the data used in multiple requests</info>
      <info xml:lang="fr">Lister toutes les données utilisées dans plusieurs requêtes</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DW002 DDT2000_WAR_DataUnused -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DW002</code>
      <critic>warning</critic>
      <titleA>Unused data</titleA>
      <titleA xml:lang="fr">Donnée(s) inutilisée(s)</titleA>
      <name>Data</name>
      <name xml:lang="fr">Données</name>
      <info>List all the unused data</info>
      <info xml:lang="fr">Lister toutes les données inutilisées</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DW003 DDT2000_WAR_DataNameInvalidChar -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DW003</code>
      <impact>I02,I03</impact>
      <critic>warning</critic>
      <titleA>Invalid(s) character(s) into the name of the data</titleA>
      <titleA xml:lang="fr">Caractère(s) invalide(s) dans le nom de la donnée</titleA>
      <name>Data name</name>
      <name xml:lang="fr">Nom de la donnée</name>
      <info>
        Valid first character:  <b><xsl:value-of select="local:getValidChars('en', 1)" /></b><br />
        else other valids characters: <b><xsl:value-of select="local:getValidChars('en', 0)" /></b>
      </info>
      <info xml:lang="fr">
        1er caractère autorisé : <b><xsl:value-of select="local:getValidChars('fr', 1)" /></b><br />
        autres caractères autorisés : <b><xsl:value-of select="local:getValidChars('fr', 0)" /></b>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DW005 DDT2000_WAR_ShiftByteCount -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DW005</code>
      <critic>warning</critic>
      <titleA>Request: ShiftByteCount</titleA>
      <titleA xml:lang="fr">Requête : ShiftByteCount</titleA>
      <name>Request</name>
      <name xml:lang="fr">Requête</name>
      <info>
        List all the requests with <b>ShiftByteCount != 0</b><br />
        excepted $1902xx, 17FF and $19YYxx for UDS
      </info>
      <info xml:lang="fr">
        Lister toutes les requêtes avec <b>ShiftBytesCount != 0</b><br />
        exceptées les requêtes $1902.., $17FF.. et $19YYxx pour UDS
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DW006 DDT2000_WAR_ReadDTCInformationReportDTC -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DW006</code>
      <critic>warning</critic>
      <titleA>Request ReadDTCInformation.ReportDTC</titleA>
      <titleA xml:lang="fr">Requête ReadDTCInformation.ReportDTC</titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>The sent bytes <b>$1902xx and $17FF00</b> are defined in the database simultaneously</info>
      <info xml:lang="fr">Les octets émis <b>$1902xx et $17FF00</b> sont définis simultanément dans la base</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DW007 associated with DW006 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DW007</code>
      <critic>warning</critic>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Check the data defined :
        <ul>
          <li>DTCStatusAvailabilityMask</li>
          <li>DTCDeviceIdentifier</li>
          <li>DTCDeviceAndFailureTypeOBD</li>
          <li>DTCFailureType.Category</li>
          <li>DTCFailureType</li>
          <li>DTCFailureType.ManufacturerOrSupplier</li>
          <li>StatusOfDTC</li>
          <li>DTCStatus.warningIndicatorRequested</li>
          <li>DTCStatus.testNotCompletedThisMonitoringCycle</li>
          <li>DTCStatus.testFailedSinceLastClear</li>
          <li>DTCStatus.testNotCompletedSinceLastClear</li>
          <li>DTCStatus.confirmedDTC</li>
          <li>DTCStatus.pendingDTC</li>
          <li>DTCStatus.testFailedThisMonitoringCycle</li>
          <li>DTCStatus.testFailed</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Contrôler si toutes les données en réception sont déclarées :
        <ul>
          <li>DTCStatusAvailabilityMask</li>
          <li>DTCDeviceIdentifier</li>
          <li>DTCDeviceAndFailureTypeOBD</li>
          <li>DTCFailureType.Category</li>
          <li>DTCFailureType</li>
          <li>DTCFailureType.ManufacturerOrSupplier</li>
          <li>StatusOfDTC</li>
          <li>DTCStatus.warningIndicatorRequested</li>
          <li>DTCStatus.testNotCompletedThisMonitoringCycle</li>
          <li>DTCStatus.testFailedSinceLastClear</li>
          <li>DTCStatus.testNotCompletedSinceLastClear</li>
          <li>DTCStatus.confirmedDTC</li>
          <li>DTCStatus.pendingDTC</li>
          <li>DTCStatus.testFailedThisMonitoringCycle</li>
          <li>DTCStatus.testFailed</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DW008 DDT2000_WAR_ReadDTCInformationReportSnapshot -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DW008</code>
      <impact>I04,I06</impact>
      <critic>warning</critic>
      <titleA>Request ReadDTCInformation.ReportSnapshot doesn't define</titleA>
      <titleA xml:lang="fr">La requête ReadDTCInformation.ReportSnapshot n'est pas définie</titleA>
      <name>Request <b>ReadDTCInformation.ReportSnapshot</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b></name>
      <info>Check if the request <b>ReadDTCInformation.ReportSnapshot</b> exists</info>
      <info xml:lang="fr">Contrôler si la requête <b>ReadDTCInformation.ReportSnapshot</b> existe</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DW009 DDT2000_WAR_ClearDiagnosticInformationManual -->
      <chapters>
        <chapter title1="Requests" title2="ClearDiagnosticInformation ($14XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DW009</code>
      <critic>warning</critic>
      <titleA>
        Request: If ClearDiagnosticInformation.Manual exists,<br />
        the failure page doesn't erase failure
      </titleA>
      <titleA xml:lang="fr">
        Requête: Si ClearDiagnosticInformation.Manual existe,<br />
        la page failure ne peu pas effacer les défauts</titleA>
      <name> Request <b>ClearDiagnosticInformation.Manual</b></name>
      <name xml:lang="fr">Requête <b>ClearDiagnosticInformation.Manual</b></name>
      <info>
        If ClearDiagnosticInformation.Manual exists,<br />
        the failure page doesn't erase failure
      </info>
      <info xml:lang="fr">
        Si ClearDiagnosticInformation.Manual existe,<br />
        la page failure ne peu pas effacer les défauts
      </info>
      <version>V1.0</version>
    </rule>
    <rule><!-- DW010 DDT2000_WAR_RequestNameInvalidChar -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DW010</code>
      <impact>I02,I03</impact>
      <critic>warning</critic>
      <titleA>Invalid(s) character(s) into the name of the request</titleA>
      <titleA xml:lang="fr">Caractère(s) invalide(s) dans le nom de la requête</titleA>
      <name>Request name</name>
      <name xml:lang="fr">Nom de la requête</name>
      <info>
        Valid first character : <b><xsl:value-of select="local:getValidChars('en', 1)" /></b><br />
        else other valids characters: <b><xsl:value-of select="local:getValidChars('en', 0)" /></b>
      </info>
      <info xml:lang="fr">
        1er caratère autorisé : <b><xsl:value-of select="local:getValidChars('fr', 1)" /></b><br />
        autres caractères autorisés: <b><xsl:value-of select="local:getValidChars('fr', 0)" /></b>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DW011 DDT2000_WAR_RequestTemplateMissing -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DW011</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Template of the response(ReplyBytes) is missing</titleA>
      <titleA xml:lang="fr">Template de la réponse(ReplyBytes) n'est pas documenté</titleA>
      <name>Template of the response</name>
      <name xml:lang="fr">Template de la réponse</name>
      <info>
        Template of the response(ReplyBytes) must start with : <br />
        <b>LID + $40</b>
      </info>
      <info xml:lang="fr">
        Template de la réponse(ReplyBytes) doit commencer par : <br />
        <b>LID + $40</b>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DW012 DDT2000_WAR_InjectorCode -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DW012</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Requests: $21AD and $22FDC5 both present</titleA>
      <titleA xml:lang="fr">Requêtes: $21AD et $22FDC5 présentes</titleA>
      <name>Requests: $21AD and $22FDC5 both present</name>
      <name xml:lang="fr">Requêtes: $21AD et $22FDC5 présentes</name>
      <info>Error risk while reading injection codes</info>
      <info xml:lang="fr">Risque d'erreur lors de la lecture des codes injecteur</info>
      <version>V1.5</version>
    </rule>
    <!-- <rule>DW187 DDT2000_WAR_UDS_RoutineControl REMOVE V1.11
      <chapters>
        <chapter title1="Requests" title2="RoutineControl ($31)" />
      </chapters>
      <type>DDT2000</type>
      <code>DW187</code>
      <impact>I04</impact>
      <critic>warning</critic>
      <titleA>Request: RoutineControl ($31) is not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: RoutineControl ($31) non conforme au protocole UDS</titleA>
      <name>Request <b>RoutineControl ($31)</b></name>
      <name xml:lang="fr">Requête : <b>RoutineControl ($31)</b></name>
      <info>Request <b>RoutineControl ($31)</b> must have name starting with <b>RoutineControl</b></info>
      <info xml:lang="fr">La requête <b>RoutineControl ($31)</b> doit avoir un nom commançant par <b>RoutineControl</b></info>
      <version>V1.5</version>
    </rule> -->
    <!--<rule> DW188 DDT2000_WAR_UDS_OutputControl REMOVE V1.11
      <chapters>
        <chapter title1="Requests" title2="OutputControl ($2F)" />
      </chapters>
      <type>DDT2000</type>
      <code>DW188</code>
      <impact>I04</impact>
      <critic>warning</critic>
      <titleA>Request: OutputControl ($2F) is not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: OutputControl ($2F) non conforme au protocole UDS</titleA>
      <name>Request <b>OutputControl ($2F)</b></name>
      <name xml:lang="fr">Requête <b>OutputControl ($2F)</b></name>
      <info>OutputControl ($2F) must have a <b>name starting with</b> OutputControl</info>
      <info xml:lang="fr">OutputControl ($2F) doit avoir un <b>nom commançant par</b> OutputControl</info>
      <version>V1.5</version>
    </rule> -->
    <rule><!-- DW192 DDT2000_WAR_UDS_MissingReadDID -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DW192</code>
      <impact>I04,I06</impact>
      <critic>warning</critic>
      <titleA>Request: no request ($22) has been found for the DID in request ($2F) as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: aucune requête($22) n'a été trouvée pour le DID de la requête($2F) conformément au protocole UDS</titleA>
      <name>Request : <b>Missing request ($22) for the DID</b></name>
      <name xml:lang="fr">Requête : <b>requête manquante ($22) pour le DID</b></name>
      <info>Create the request ($22) for the DID</info>
      <info xml:lang="fr">Ajouter la requête ($22) pour le DID</info>
      <version>V1.7</version>
    </rule>
    <rule><!-- DW193 DDT2000_WAR_DataUnit -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DW193</code>
      <impact>I08</impact>
      <critic>warning</critic>
      <titleA>Unknown data unit</titleA>
      <titleA xml:lang="fr">Unité de la donnée inconue</titleA>
      <name>Data unit information</name>
      <name xml:lang="fr">Donnée information unité</name>
      <info>Authorized  values : value on normalized unit list</info>
      <info xml:lang="fr">Valeurs autorisées : Liste des unités normalisées</info>
      <version>V1.10</version>
    </rule>
    <rule> <!-- DW194 DDT2000_WAR_RoutineIdentifierMissing -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DW194</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Missing <b>RoutineIdentifier</b> data for generic <b>RoutineControl</b> request </titleA>
      <titleA xml:lang="fr">La donnée <b>RoutineIdentifier</b> est manquante pour la requête générique <b>RoutineContrôle</b></titleA>
      <name>Data: RoutineIdentifier</name>
      <name xml:lang="fr">Donnée : RoutineIdentifier</name>
      <info>
        <b>routineIdentifier</b> information must have:
        <ul>
          <li><b>Data name</b>: RoutineIdentifier rather than RoutineIdentifierList</li>
          <li><b>Length</b>: 16 bits</li>
          <li><b>Data type</b>: numeric list with at least 1 defined item (Value/Text)</li>
          <li><b>First byte</b>: 2</li>
          <li><b>Bit offset</b>: 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        L'information <b>routineIdentifier</b> doit avoir :
        <ul>
          <li><b>Nom de donnée</b> :  RoutineIdentifier plutôt que RoutineIdentifierList</li>
          <li><b>Longueur</b> : 16 bits</li>
          <li><b>Type de donnée</b> : liste numerique ayant au minimum 1 élément (Valeur/Libellé) défini</li>
          <li><b>Octet de début</b> : 2</li>
          <li><b>Décalage de bit</b> : 0</li>
        </ul>
      </info>
      <version>V1.11</version>
    </rule>
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                          ERRORS DDT 2000                          -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <rule><!-- DE001 DDT2000_ERR_UndefinedSpecification -->
      <chapters>
        <chapter title1="Parameters" title2="Communication protocol" />
      </chapters>
      <type>DDT2000</type>
      <code>DE001</code>
      <impact>I01</impact>
      <critic>error</critic>
      <titleA>Undefined diagnostic specifications: 36-00-13/--A or 36-00-13/--B ?</titleA>
      <titleA xml:lang="fr">Spécifications de diagnostic impossible à définir: 36-00-13/--A or 36-00-13/--B ?</titleA>
      <name>
        Diagnostic spécifications : <br />
        36--00--13/--A or 36--00--13/--B
      </name>
      <name xml:lang="fr">
        Spécifications de diagnostic :<br />
        36--00--13/--A ou 36--00--13/--B
      </name>
      <info>The requests <b>$1902xx</b> et <b>$17FF00</b> do not permit to define the used diagnostic specification</info>
      <info xml:lang="fr">Les requêtes <b>$1902xx</b> et <b>$17FF00</b> ne permettent pas de définir la spécification de disgnostic utilisée</info>
      <version>V1.2</version>
    </rule>
    <rule><!-- DE002 DDT2000_ERR_ProtocolType -->
      <chapters>
        <chapter title1="Parameters" title2="Communication protocol" />
      </chapters>
      <type>DDT2000</type>
      <code>DE002</code>
      <impact>I01</impact>
      <critic>error</critic>
      <titleA>Unknown Protocol Type: (FastInit MultiPoint,FastInit MonoPoint,Can,...)</titleA>
      <titleA xml:lang="fr">Protocole de communication  inconnu: (FastInit MultiPoint,FastInit MonoPoint,Can,...)</titleA>
      <name>Protocol of communication</name>
      <name xml:lang="fr">Protocole de communication</name>
      <info>The comunication protocol must be defined</info>
      <info xml:lang="fr">Le protocole de communication doit être défini</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE003 DDT2000_ERR_DataNameInvalidChar -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE003</code>
      <titleA>Data: invalid(s) character(s) in the name of the data</titleA>
      <titleA xml:lang="fr">Donnée : Caractère(s) invalide(s) dans le nom de la donnée</titleA>
      <impact>I02,I03</impact>
      <critic>error</critic>
      <name>Data: invalid(s) character(s) in the name of the data</name>
      <name xml:lang="fr">Donnée : Caractère(s) invalide(s) dans le nom de la donnée</name>
      <info>
        Valid first character: <b><xsl:value-of select="local:getValidChars('en', 1)" /></b><br />
        else other valids characters: <b><xsl:value-of select="local:getValidChars('en', 0)" /></b>
      </info>
      <info xml:lang="fr">
        1er caratère autorisé : <b><xsl:value-of select="local:getValidChars('fr', 1)" /></b><br />
        autres caractères autorisés : <b><xsl:value-of select="local:getValidChars('fr', 0)" /></b>
      </info>
      <version>V1.9</version>
    </rule>
    <rule><!-- DE004 DDT2000_ERR_DataBitsCount -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE004</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Data: Number of bits &lt;1  or Number of bits &gt; 32</titleA>
      <titleA xml:lang="fr">Donnée: Nombre de bits &lt;1 ou nombre de bits &gt; 32</titleA>
      <name><b>Number of bits</b> of data</name>
      <name xml:lang="fr"><b>Nombre de bits</b> de la donnée</name>
      <info>
        Number of bits: authorized values <b>[1,32]</b><br />
        (Caution : unsigned 32 bits not supported)
      </info>
      <info xml:lang="fr">
        Valeurs autorisées : <b>Nombre de bits = [1,32]</b><br />
        (Attention : format 32 bits non signés ne sont pas supporté)
      </info>
      <version>V1.0</version>
    </rule>
    <rule><!-- DE005 DDT2000_ERR_Unsigned32bitsNumericData -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE005</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Data: Format: unsigned 32 bits numeric not supported</titleA>
      <titleA xml:lang="fr">Donnée: Format: 32 bits non signés non autorisé</titleA>
      <name><b>Number of bits</b> of data</name>
      <name xml:lang="fr"><b>Nombre de bits</b> de la donnée</name>
      <info><b>Unsigned 32 bits not supported</b></info>
      <info xml:lang="fr"><b>32 bits non signés non supporté</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE006 DDT2000_ERR_DataBytesCount -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE006</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>
        Data byte number: <br />
        KLine : number of bytes &lt;1 or number of bytes &gt;255 or number of bytes not an Integer<br />
        DiagOnCan : number of bytes &lt;1 or number of bytes &gt;4095 or number of bytes not an Integer<br />
        DoIP : number of bytes &lt;1 or number of bytes &gt;4095 or number of bytes not an Integer
      </titleA>
      <titleA xml:lang="fr">
        Nombre d'octet de la donnée:<br />
        Ligne K : nombre d'octets &lt;1 ou nombre d'octets &gt;255 ou nombre d'octets pas entier<br />
        DiagOnCan : nombre d'octets &lt;1 ou nombre d'octets &gt;4095 ou nombre d'octets pas entier<br />
        DoIP : nombre d'octets &lt;1 ou nombre d'octets &gt;4095 ou nombre d'octets pas entier
      </titleA>
      <name>Data <b>bytes number</b></name>
      <name xml:lang="fr"><b>Nombre d'octets</b> de la donnée</name>
      <info>
        <b>K line</b> physical layer: Authorized values <b>[1,255]</b><br />
        <b>DiagOnCAN</b> physical layer: Authorized values <b>[1,4095]</b><br />
        <b>DoIP</b> physical: Authorized values <b>[1,4095]</b>
      </info>
      <info xml:lang="fr">
        Couche physique <b>ligne K</b> : Valeurs autorisées <b>[1,255]</b><br />
        Couche physique <b>DiagOnCAN</b> : Valeurs autorisées <b>[1,4095]</b><br />
        Couche physique <b>DoIP</b> : Valeurs autorisées <b>[1,4095]</b>
      </info>
      <version>V1.0</version>
    </rule>
    <rule><!-- DE007 DDT2000_ERR_DTCDeviceIdentifierMissing -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE007</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Data DTCDeviceIdentifier is missing</titleA>
      <titleA xml:lang="fr">La donnée DTCDeviceIdentifier n'est pas déclarée</titleA>
      <name>Data <b>DTCDeviceIdentifier</b></name>
      <name xml:lang="fr">Donnée <b>DTCDeviceIdentifier</b></name>
      <info>The data <b>DTCDeviceIdentifier</b> must be defined</info>
      <info xml:lang="fr">La donnée <b>DTCDeviceIdentifier</b> doit être définie</info>
      <version>V1.0</version>
    </rule>
    <rule><!-- DE008 DDT2000_ERR_FirstDTCMissing -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE008</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Data FirstDTC is missing</titleA>
      <titleA xml:lang="fr">La donnée FirstDTC n'est pas déclarée</titleA>
      <name>Data <b>FirstDTC </b></name>
      <name xml:lang="fr">Donnée <b>FirstDTC </b></name>
      <info>The data <b>FirstDTC </b> must be defined</info>
      <info xml:lang="fr">La donnée <b>FirstDTC </b> doit être définie</info>
      <version>V1.0</version>
    </rule>
    <rule><!-- DE009 DDT2000_ERR_DataNumericalDividedBy0 -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE009</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Data: Numeric data (Ax+B/C) divided by C = 0 or C is of format xE+yy</titleA>
      <titleA xml:lang="fr">Donnée: Donnée au format numérique (Ax+B/C) divisée par C = 0 ou C de foramt xE+yy</titleA>
      <name>
        Data<br />
        <b>numerical of type Ax+B/C where C = 0 or C is of format xE+yy</b>
      </name>
      <name xml:lang="fr">
        Donnée<br />
        <b>numérique de type Ax+B/C où C = 0 ou C de foramt xE+yy</b>
      </name>
      <info>The numerical data <b>of type Ax+B/C </b>must have C different from 0 and different from xE+yy</info>
      <info xml:lang="fr">La donnée numérique <b>de type Ax+B/C</b> doit avoir C différent de 0 et différent de xE+yy</info>
      <version>V1.7</version>
    </rule>
    <rule><!-- DE010 DDT2000_ERR_RequestSentDataItemName -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE010</code>
      <impact></impact>
      <critic>error</critic>
      <titleA>Request: Sent Data Name missing</titleA>
      <titleA xml:lang="fr">Requête: Nom de la donnée émise non défini</titleA>
      <name>
        Sent data<br />
        Attribute : <b>Name</b>
      </name>
      <name xml:lang="fr">
        Donnée émise<br />
        Attribut : <b>Nom</b>
      </name>
      <info>Define and fix the data</info>
      <info xml:lang="fr">Définir et corriger la donnée</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE011 DDT2000_ERR_RequestSentDataOutSideOfRequest -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE011</code>
      <impact>I06</impact>
      <critic>error</critic>
      <titleA>Request: sent data outside of the request</titleA>
      <titleA xml:lang="fr">Requête: donnée émise située hors de la requête</titleA>
      <name>Sent data</name>
      <name xml:lang="fr">Donnée émise</name>
      <info>
        the sent data must be included in the request<br />
        Check the length of the request and the sent data (first byte, bit offset,...)
      </info>
      <info xml:lang="fr">
        Les données émises doivent être dans la requête<br />
        Vérifier la longueur de la requête et les caractéristiques de la donnée (octet de début,décalage,..)
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE012 NOT CHECKED -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE012</code>
      <impact>I06</impact>
      <critic>error</critic>
      <name>Sent data</name>
      <name xml:lang="fr">Donnée émise</name>
      <info>Check if the sent data is defined</info>
      <info xml:lang="fr">Vérifier si la donnée émise est définie</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE013 DDT2000_ERR_RequestSentDataItemFirstByte -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE013</code>
      <impact>I06</impact>
      <critic>error</critic>
      <titleA>
        Request: FirstByte of sent data<br />
        FirstByte missing or<br />
        FirstByte&lt;2 bytes or<br />
        FirstByte&gt;255 bytes(KLine) 4095 bytes(Can)<br />
        FirstByte&gt;127 (with maintainability report)
      </titleA>
      <titleA xml:lang="fr">
        Requête: octet de début d'une donnée en émission<br />
        Octet de début manquant ou<br />
        Octet de début&lt;2 octets ou <br />
        Octet de début&gt;255 octets(KLine) 4095 octets(Can)<br />
        Octet de début&gt;127 (avec dossier de maintenabilité)
      </titleA>
      <name>
        Sent data<br />
        Attribute : <b>first byte</b>
      </name>
      <name xml:lang="fr">
        Donnée émise<br />
        Attribut : <b>octet de début</b>
      </name>
      <info>Check if the first byte is defined</info>
      <info xml:lang="fr">Vérifier si l'attribut <b>octet de début</b> est défini</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE014 associated with DE013 -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE014</code>
      <impact>I06</impact>
      <critic>error</critic>
      <name>
        Sent data<br />
        Attribute : <b>first byte</b>
      </name>
      <name xml:lang="fr">
        Donnée émise<br />
        Attribut : <b>octet de début</b>
      </name>
      <info>
        <b>K line</b> protocol : Authorized values <b>[2,255]</b><br />
        <b>DiagOnCAN</b> protocol : Valeurs autorisées <b>[2,4095]</b>
      </info>
      <info xml:lang="fr">
        Protocole <b>Ligne K</b> : Valeurs autorisées <b>[2,255]</b><br />
        Protocole <b>DiagOnCAN</b> : Valeurs autorisées <b>[2,4095]</b>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE015 DDT2000_ERR_RequestSentDataItemBitOffset -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE015</code>
      <impact>I06</impact>
      <critic>error</critic>
      <titleA>Request: Bit offset of the sent data: (bit offset &lt;0 or bit offset &gt;7)</titleA>
      <titleA xml:lang="fr">Requête: Décalage (bit offset)de la donnée émise : (bit offset &lt;0 or &gt;7)</titleA>
      <name>
        Sent data<br />
        Attribute : <b>BitOffset</b>
      </name>
      <name xml:lang="fr">
        Donnée émise<br />
        Attribut: <b>décalage (BitOffset)</b>
      </name>
      <info>Authorized values <b>[0,7]</b></info>
      <info xml:lang="fr">Valeurs autorisées <b>[0,7]</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE017 DDT2000_ERR_RequestSentDataItemRef -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE017</code>
      <impact>I06</impact>
      <critic>error</critic>
      <titleA>Request: sent data is defined as reference</titleA>
      <titleA xml:lang="fr">Requête: donnée émise définie comme référence</titleA>
      <name>
        Sent data<br />
        Attribute : <b>reference</b>
      </name>
      <name xml:lang="fr">
        Donnée émise<br />
        Attribut : <b>référence</b>
      </name>
      <info>Do not define the data as <b>reference</b></info>
      <info xml:lang="fr">Ne pas définir la donnée comme <b>référence</b></info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE019 DDT2000_ERR_DuplicateSentDataItemInRequest -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE019</code>
      <impact>I03</impact>
      <critic>error</critic>
      <titleA>Request: Duplicated sent data inside a request</titleA>
      <titleA xml:lang="fr">Requête: Duplication de donnée émise dans une requête</titleA>
      <name>Sent Data </name>
      <name xml:lang="fr">Donnée émise</name>
      <info><b>The sent data must not be duplicated inside a request</b></info>
      <info xml:lang="fr"><b>Les données émises ne doivent pas être dupliquées dans une requête</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE020 DDT2000_ERR_RequestReceivedDataItemName -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE020</code>
      <impact>I03</impact>
      <critic>error</critic>
      <titleA>Received data name missing</titleA>
      <titleA xml:lang="fr">Donnée reçue non définie</titleA>
      <name>
        Received data<br />
        Attribute : <b>Name</b>
      </name>
      <name xml:lang="fr">
        Donnée reçue<br />
        Attribut : <b>Nom</b>
      </name>
      <info>Define and fix the data</info>
      <info xml:lang="fr">Définir et corriger la donnée</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE021 DDT2000_ERR_RequestReceivedDataOutSideOfRequest -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE021</code>
      <impact>I03</impact>
      <critic>error</critic>
      <titleA>Request: Received data outside of the reply</titleA>
      <titleA xml:lang="fr">Requête: donnée reçue hors réponse</titleA>
      <name>Received data</name>
      <name xml:lang="fr">Donnée reçue</name>
      <info>
        The received data must be included in the request<br />
        Check the length of the reply and the received data (first byte, bit offset,...)<br />
        (excepted the requests $1906... with variable reply)
      </info>
      <info xml:lang="fr">
        Les données reçues doivent être dans la requête<br />
        Vérifier la longueur de la réponse et les caractéristiques des données reçues (octet de début,décalage,..)<br />
        (exceptées les requêtes à réponse variable telles que $1906... où les dépassements sont autorisés)
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE022 NOT CHECKED -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE022</code>
      <impact>I03</impact>
      <critic>error</critic>
      <name>Received data</name>
      <name xml:lang="fr">Donnée reçue</name>
      <info>Check if the received data is defined</info>
      <info xml:lang="fr">Vérifier si la donnée reçue est définie</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE023 DDT2000_ERR_RequestReceivedDataItemFirstByte -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE023</code>
      <impact>I03</impact>
      <critic>error</critic>
      <name>
        Received data<br />
        Attribute : <b>first byte</b>
      </name>
      <name xml:lang="fr">
        Donnée reçue<br />
        Attribut : <b>octet de début</b>
      </name>
      <titleA>
        Request: first byte of the received data<br />
        FirstByte missing or<br />
        FirstByte&lt;2 bytes or<br />
        FirstByte&gt;255 bytes(KLine) or 4095 bytes(Can and DoIP)
      </titleA>
      <titleA xml:lang="fr">
        Requête: octet de début d'une donnée en réception<br />
        Octet de début manquant ou<br />
        Octet de début&lt;2 octets or<br />
        Octet de début&gt;255 octets(KLine) ou 4095 octets(Can et DoIP)
      </titleA>
      <info>Check if the first byte is defined</info>
      <info xml:lang="fr">Vérifier si l'attribut <b>octet de début</b> est défini</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE024 associated with DE023 -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE024</code>
      <impact>I03</impact>
      <critic>error</critic>
      <name>
        Received data<br />
        Attribute : <b>first byte</b>
      </name>
      <name xml:lang="fr">
        Donnée reçue<br />
        Attribut : <b>octet de début</b>
      </name>
      <info>
        <b>K line</b> physical layer: Authorized values <b>[2,255]</b><br />
        <b>DiagOnCAN</b> physical layer: Authorized values <b>[2,4095]</b><br />
        <b>DoIP</b> physical: Authorized values <b>[2,4095]</b>
      </info>
      <info xml:lang="fr">
        Couche physique <b>ligne K</b> : Valeurs autorisées <b>[2,255]</b><br />
        Couche physique <b>DiagOnCAN</b> : Valeurs autorisées <b>[2,4095]</b><br />
        Couche physique <b>DoIP</b> : Valeurs autorisées <b>[2,4095]</b>
      </info>
      <version>V1.1<br />V1.9</version>
    </rule>
    <rule><!-- DE025 DDT2000_ERR_RequestReceivedDataItemBitOffset -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE025</code>
      <impact>I03</impact>
      <critic>error</critic>
      <titleA>Request: Bit offset of the received data (bit offset &lt;0 or bit offset &gt;7)</titleA>
      <titleA xml:lang="fr">Requête: Décalage de la donnée en réception (bit offset &lt;0 or bit offset &gt;7)</titleA>
      <name>
        Received data<br />
        Attribute : <b>BitOffset</b>
      </name>
      <name xml:lang="fr">
        Donnée reçue<br />
        Attribut: <b>décalage (BitOffset)</b>
      </name>
      <info>Authorized values <b>[0,7]</b></info>
      <info xml:lang="fr">Valeurs autorisées <b>[0,7]</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE027 DDT2000_ERR_DuplicateReceivedDataInRequest -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE027</code>
      <impact>I03</impact>
      <critic>error</critic>
      <titleA>Request: Duplicated received data inside a request</titleA>
      <titleA xml:lang="fr">Requête: Duplication de donnée reçue dans une requête</titleA>
      <name>Received data </name>
      <name xml:lang="fr">Donnée reçue</name>
      <info>The received data must not be duplicated inside a request</info>
      <info xml:lang="fr">Des données reçues ne doivent pas être dupliquées dans une requête</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE031 DDT2000_ERR_RequestNameInvalidChar -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE031</code>
      <impact>I02,I03</impact>
      <critic>error</critic>
      <titleA>Request: Name invalid char: (characters '<b>;</b>' or '<b>CrLf</b>' detected) or (<b>space</b> at the end)</titleA>
      <titleA xml:lang="fr">Requête: caractères invalide '<b>;</b>' ou '<b>CrLf</b>' dans le nom de la requête ou <b>espace</b> à la fin du nom</titleA>
      <name>Request: invalid(s) character(s) into the name of the request</name>
      <name xml:lang="fr">Requête : Caractère(s) invalide(s) dans le nom de la requête</name>
      <info>
        Valid first character: <b><xsl:value-of select="local:getValidChars('en', 1)" /></b><br />
        else other valids characters: <b><xsl:value-of select="local:getValidChars('en', 0)" /></b> <br />
        only space is prohibited at the end of the name.
      </info>
      <info xml:lang="fr">
        1er caratère autorisé : <b><xsl:value-of select="local:getValidChars('fr', 1)" /></b><br />
        autres caractères autorisés : <b><xsl:value-of select="local:getValidChars('fr', 0)" /></b><br />
        seul l'espace est interdit à la fin du nom
      </info>
      <version>V1.9</version>
    </rule>
    <rule><!-- DE032 NOT CHECKED -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE032</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>
        Request<br />
        Attributs : <b>sent bytes</b>
      </name>
      <name xml:lang="fr">
        Requête<br />
        Attribut : <b>Octets émis</b>
      </name>
      <info>The length of the number of the sent bytes must be even value</info>
      <info xml:lang="fr">Vérifier que la longueur du nombre d'octet émis est pair</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE033 DDT2000_ERR_RequestSentBytes -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE033</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>
        Request: Number of sent bytes<br />
        sent bytes&lt;1 byte or<br />
        sent bytes&gt;255 bytes(KLine) 4095 bytes(Can)<br />
        sent bytes&gt;2 bytes(request $21XX - only 1 byte for LID)
      </titleA>
      <titleA xml:lang="fr">
        Requête: Nombre d'octet émis<br />
        nbre octet émis&lt;1 octet ou<br />
        nbre octet émis&gt;255 octets(KLine) 4095 octets(Can)<br />
        nbre octet émis&gt;2 octets(requête $21XX - 1 octet seulement pour LID)
      </titleA>
      <name>
        Request<br />
        Attribute : <b>sent byte</b>
      </name>
      <name xml:lang="fr">
        Requête<br />
        Attribut : <b>octet émis</b>
      </name>
      <info>
        <b>K line</b> protocol : Authorized values <b>[1,255]</b><br />
        <b>DiagOnCAN</b> protocol : Authorized values <b>[1,4095]</b><br />
        <b>Request $21XX</b> : Only <b>1</b> byte for LID
      </info>
      <info xml:lang="fr">
        Protocole <b>Ligne K</b> : Valeurs autorisées <b>[1,255]</b><br />
        Protocole <b>DiagOnCAN</b> : Valeurs autorisées <b>[1,4095]</b><br />
        Pour une <b>requête $21XX</b> : <b>1</b> octet seulement pour LID
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE034 DDT2000_ERR_RequestReceivedMinBytes -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE034</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>
        Request: Received minimum bytes (MinBytes)<br />
        MinBytes &lt;1 or<br />
        MinByte &gt;255 bytes(Kline) 4095 bytes(Can))<br />
        MinByte &gt;127 (with maintainability report)
      </titleA>
      <titleA xml:lang="fr">
        Requête: nombre minimum d'octet reçu (MinBytes)<br />
        MinBytes &lt;1 octet ou<br />
        MinByte &gt;255 octets(Kline) 4095 octets(Can))<br />
        MinByte &gt;127 (avec dossier de maintenabilité)
      </titleA>
      <name>
        Request<br />
        Attribute : <b>minimum byte (MinByte)</b></name>
      <name xml:lang="fr">
        Requête<br />
        Attribut : <b>nombre minimale d'octet reçu (MinByte)</b></name>
      <info>
        <b>K line</b> protocol : Authorized values <b>[1,255]</b><br />
        <b>DiagOnCAN</b> protocol : Valeurs autorisées <b>[1,4095]</b><br />
        <b>Maintainability report</b> : Authorized values <b>[1,127]</b>
      </info>
      <info xml:lang="fr">
        Protocole <b>Ligne K</b> : Valeurs autorisées <b>[1,255]</b><br />
        Protocole <b>DiagOnCAN</b> : Valeurs autorisées <b>[1,4095]</b><br />
        Avec <b>dossier de maintenabilité</b> : Valeurs autorisées <b>[1,127]</b>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE035 DDT2000_ERR_RequestReceivedReplyBytes -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE035</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>
        Request: Template of the response (ReplyBytes)<br />
        ReplyBytes&lt;1 or<br />
        ReplyBytes&gt;255 bytes(Kline) 4095 bytes(Can)<br />
        ReplyBytes&gt;127 (with maintainability report)
      </titleA>
      <titleA xml:lang="fr">
        Requête: Template de la réponse (ReplyBytes)<br />
        DDT2000, CPDD : ReplyBytes&lt;1 ou<br />
        DDT2000 : ReplyBytes&gt;255 bytes(Kline) 4095 bytes(Can)<br />
        DDT2000 : ReplyBytes&gt;127 (avec dossier de maintenabilité)
      </titleA>
      <name>
        Request<br />
        Attribute : <b>Template of the response (ReplyByte)</b>
      </name>
      <name xml:lang="fr">
        Requête<br />
        Attribut : <b>Template de la réponse (ReplyByte)</b>
      </name>
      <info>
        <b>K line</b> protocol : Authorized values(bytes) <b>[1,255]</b><br />
        <b>DiagOnCAN</b> protocol : Authorized values(bytes) <b>[1,4095]</b><br />
        <b>Maintainability report</b> : Authorized values <b>[1,127]</b>
      </info>
      <info xml:lang="fr">
        Protocole <b>Ligne K</b> : Valeurs autorisées(octets) <b>[1,255]</b><br />
        Protocole <b>DiagOnCAN</b> : Valeurs autorisées(octets) <b>[1,4095]</b><br />
        Avec <b>dossier de maintenabilité</b> : Valeurs autorisées <b>[1,127]</b>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE036 DDT2000_ERR_RequestCoherenceSendBytesReplyBytes -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE036</code>
      <impact>I05</impact>
      <critic>error</critic>
      <titleA>
        Incoherence between Reply byte  and send bytes<br />
        ReplyBytes service = SendBytes service + $40....
      </titleA>
      <titleA xml:lang="fr">
        Incohérence de la réponse ECU à une requête émise<br />
        ReplyBytes service = SendBytes service + $40....
      </titleA>
      <name>
        Request<br />
        The reply bytes must be coherent with the sent bytes
      </name>
      <name xml:lang="fr">
        Requête<br />
        Cohérence de la réponse ECU à une requête émise
      </name>
      <info>The following rule must be checked : <b>reply bytes service = send bytes service + $40</b></info>
      <info xml:lang="fr">la règle suivante doit être vérifiée : <b>octets reçus service = octets émis service + $40</b></info>
      <version>V1.2</version>
    </rule>
    <rule><!-- DE037 DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <code>DE037</code>
      <type>DDT2000</type>
      <impact>I14</impact>
      <critic>error</critic>
      <titleA>
        Request: Duplicated request (considering sent bytes) and maintainability report<br />
        or Duplicated identification requests with sent bytes $2180
      </titleA>
      <titleA xml:lang="fr">
        Requête: Requêtes dupliquées (octets émis) avec dossier de maintenabilité<br />
        ou Requêtes d'identification dupliquées (octets émis $2180)
      </titleA>
      <name>Request</name>
      <name xml:lang="fr">Requête</name>
      <info>
        The requests (sent bytes) with maintainability report must not be duplicated<br />
        or the identification requests (sent bytes $2180) must not be duplicated
      </info>
      <info xml:lang="fr">
        Les requêtes (octets émis) avec dossier de maintenabilité ne doivent pas être dupliquées<br />
        ou les requêtes d'identification (octets émis $2180) ne doivent pas être dupliquées
      </info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE038 DDT2000_ERR_TesterPresent -->
      <chapters>
        <chapter title1="Requests" title2="TesterPresent ($3EXX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE038</code>
      <impact>I05</impact>
      <critic>error</critic>
      <titleA>Request: TesterPresent.WithResponse is missing</titleA>
      <titleA xml:lang="fr">Requête: TesterPresent.WithResponse est absente</titleA>
      <name>Request : <b>TesterPresent.WithResponse</b></name>
      <name xml:lang="fr">Requête : <b>TesterPresent.WithResponse</b></name>
      <info>TesterPresent.WithResponse must be added</info>
      <info xml:lang="fr">TesterPresent.WithResponse doit être ajouté</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE050 DDT2000_ERR_ReadDTCInformationReportDTC -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE050</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request: Error(s) on ReadDTCInformation.ReportDTC</titleA>
      <titleA xml:lang="fr">Requête: Erreur(s) sur ReadDTCInformation.ReportDTC</titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>Sent bytes = <b>$1902xx</b></info>
      <info xml:lang="fr">Les octets émis = <b>$1902xx</b></info>
      <version>V1.2</version>
    </rule>
    <rule><!-- DE051 associated with DE050 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE051</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>Number of bytes to be received (MinBytes) = <b>3</b></info>
      <info xml:lang="fr">Le nombre minimum d'octet à recevoir (MinBytes) = <b>3</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE052 associated with DE050 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE052</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>Shift bytes count =<b>4</b></info>
      <info xml:lang="fr">Le shift bytes count =<b>4</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE054 DDT2000_ERR_1902_DTCStatusAvailabilityMask -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE054</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatusAvailabilityMask</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatusAvailabilityMask</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatusAvailabilityMask</b>
        <ul>
          <li>Format: Numeric 8 bits unsigned</li>
          <li>Start byte= 3</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatusAvailabilityMask</b>
        <ul>
          <li>Format: Numérique 8 bits non signés</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE055 DDT2000_ERR_1902_DTCDeviceIdentifier -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE055</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCDeviceIdentifier</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCDeviceIdentifier</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCDeviceIdentifier</b>
        <ul>
          <li>Format: List Numeric 16 bits unsigned</li>
          <li>Start byte= 4</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 16</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCDeviceIdentifier</b>
        <ul>
          <li>Format: Liste numérique 16 bits non signés</li>
          <li>Octet de début= 4</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 16</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE056 DDT2000_ERR_1902_DTCDeviceAndFailureTypeOBD -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE056</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCDeviceAndFailureTypeOBD</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCDeviceAndFailureTypeOBD</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCDeviceAndFailureTypeOBD</b>
        <ul>
          <li>Format: List Numeric 16 bits unsigned</li>
          <li>Start byte= 4</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 16</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCDeviceAndFailureTypeOBD</b>
        <ul>
          <li>Format: Liste numérique 16 bits non signés</li>
          <li>Octet de début= 4</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 16</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE057 DDT2000_ERR_1902_DTCFailureType_Category -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE057</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCFailureType.Category</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCFailureType.Category</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCFailureType.Category</b>
        <ul>
          <li>Format: List Numeric 4 bits unsigned</li>
          <li>Start byte= 6</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 4</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCFailureType.Category</b>
        <ul>
          <li>Format: Liste numérique 4 bits non signés</li>
          <li>Octet de début= 6</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 4</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE058 DDT2000_ERR_1902_DTCFailureType -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE058</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCFailureType</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCFailureType</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCFailureType</b>
        <ul>
          <li>Format: List Numeric 8 bits unsigned</li>
          <li>Start byte= 6</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCFailureType</b>
        <ul>
          <li>Format: Liste numérique 8 bits non signés</li>
          <li>Octet de début= 6</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE059 DDT2000_ERR_1902_DTCFailureType_ManufacturerOrSupplier -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE059</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCFailureType.ManufacturerOrSupplier</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCFailureType.ManufacturerOrSupplier</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCFailureType.ManufacturerOrSupplier</b>
        <ul>
          <li>Format: List Numeric 4 bits unsigned</li>
          <li>Start byte= 6</li>
          <li>OffsetBit= 4</li>
          <li>Number of bits= 4</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCFailureType.ManufacturerOrSupplier</b>
        <ul>
          <li>Format: Liste numérique 4 bits non signés</li>
          <li>Octet de début= 6</li>
          <li>Décalage (offsetBit)= 4</li>
          <li>Nombre de bits= 4</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE060 DDT2000_ERR_1902_StatusOfDTC -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE060</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>StatusOfDTC</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>StatusOfDTC</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>StatusOfDTC</b>
        <ul>
          <li>Format: Numeric 8 bits unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>StatusOfDTC</b>
        <ul>
          <li>Format: Numérique 8 bits non signés</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE061 DDT2000_ERR_1902_DTCStatus_warningIndicatorRequested -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE061</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatus.warningIndicatorRequested</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatus.warningIndicatorRequested</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatus.warningIndicatorRequested</b>
        <ul>
          <li>Format: Numeric 1 bit unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 1</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatus.warningIndicatorRequested</b>
        <ul>
          <li>Format: Numérique 1 bit non signé</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 1</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE062 DDT2000_ERR_1902_DTCStatus_testNotCompletedThisMonitoringCycle -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE062</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatus.testNotCompletedThisMonitoringCycle</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatus.testNotCompletedThisMonitoringCycle</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatus.testNotCompletedThisMonitoringCycle</b>
        <ul>
          <li>Format: Numeric 1 bit unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 1</li>
          <li>Number of bits= 1</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatus.testNotCompletedThisMonitoringCycle</b>
        <ul>
          <li>Format: Numérique 1 bit non signé</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 1</li>
          <li>Nombre de bits= 1</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE063 DDT2000_ERR_1902_DTCStatus_testFailedSinceLastClear -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE063</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatus.testFailedSinceLastClear</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatus.testFailedSinceLastClear</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatus.testFailedSinceLastClear</b>
        <ul>
          <li>Format: List Numeric 1 bit unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 2</li>
          <li>Number of bits= 1</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatus.testFailedSinceLastClear</b>
        <ul>
          <li>Format: Liste numérique 1 bit non signé</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 2</li>
          <li>Nombre de bits= 1</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE064 DDT2000_ERR_1902_DTCStatus_testNotCompletedSinceLastClear -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE064</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatus.testNotCompletedSinceLastClear</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatus.testNotCompletedSinceLastClear</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatus.testNotCompletedSinceLastClear</b>
        <ul>
          <li>Format: List Numeric 1 bit unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 3</li>
          <li>Number of bits= 1</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatus.testNotCompletedSinceLastClear</b>
        <ul>
          <li>Format: Liste numérique 1 bit non signé</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 3</li>
          <li>Nombre de bits= 1</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE065 DDT2000_ERR_1902_DTCStatus_confirmedDTC -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE065</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatus.confirmedDTC</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatus.confirmedDTC</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatus.confirmedDTC</b>
        <ul>
          <li>Format: List Numeric 1 bit unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 4</li>
          <li>Number of bits= 1</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatus.confirmedDTC</b>
        <ul>
          <li>Format: Liste numérique 1 bit non signé</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 4</li>
          <li>Nombre de bits= 1</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE066 DDT2000_ERR_1902_DTCStatus_pendingDTC -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE066</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatus.pendingDTC</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatus.pendingDTC</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatus.pendingDTC</b>
        <ul>
          <li>Format: List Numeric 1 bit unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 5</li>
          <li>Number of bits= 1</li>
          <li>signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatus.pendingDTC</b>
        <ul>
          <li>Format: Liste numérique 1 bit non signé</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 5</li>
          <li>Nombre de bits= 1</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE067 DDT2000_ERR_1902_DTCStatus_testFailedThisMonitoringCycle -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE067</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatus.testFailedThisMonitoringCycle</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatus.testFailedThisMonitoringCycle</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatus.testFailedThisMonitoringCycle</b>
        <ul>
          <li>Format: List Numeric 1 bit unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 6</li>
          <li>Number of bits= 1</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatus.testFailedThisMonitoringCycle</b>
        <ul>
          <li>Format: Liste numérique 1 bit non signé</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 6</li>
          <li>Nombre de bits= 1</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE068 DDT2000_ERR_1902_DTCStatus_testFailed -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE068</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportDTC</b>: error on data <b>DTCStatus.testFailed</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b> : erreur sur la donnée <b>DTCStatus.testFailed</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC</b></name>
      <info>
        Caracteristics of the data <b>DTCStatus.testFailed</b>
        <ul>
          <li>Format: List Numeric 1 bit unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 7</li>
          <li>Number of bits= 1</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCStatus.testFailed</b>
        <ul>
          <li>Format: Liste numérique 1 bit non signé</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 7</li>
          <li>Nombre de bits= 1</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE080 DDT2000_ERR_ReadDTCInformationReportExtendedData -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE080</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request: Error(s) on ReadDTCInformation.ReportExtendedData</titleA>
      <titleA xml:lang="fr">Requête: Erreur(s) sur ReadDTCInformation.ReportExtendedData</titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>Check if the request <b>ReadDTCInformation.ReportExtendedData</b> exists</info>
      <info xml:lang="fr">Contrôler si la requête <b>ReadDTCInformation.ReportExtendedData</b> existe</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE081 associated with DE080 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE081</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lanf="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>Sent bytes = <b>$1906000000FF</b></info>
      <info xml:lang="fr">Octets émis = <b>$1906000000FF</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE082 associated with DE080 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE082</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>Number of bytes to be received (MinBytes) = <b>6</b></info>
      <info xml:lang="fr">Le nombre minimum d'octet à recevoir (MinBytes) = <b>6</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE083 associated with DE080 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE083</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>Shift bytes count = <b>0</b></info>
      <info xml:lang="fr">Le shift bytes count = <b>0</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE084 DDT2000_ERR_1906FF_DTCMaskRecord -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE084</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData</b>: error on data <b>DTCMaskRecord</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b> : erreur sur la donnée <b>DTCMaskRecord</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>
        Caracteristics of the data <b>DTCMaskRecord</b>
        <ul>
          <li>Format: No Numeric 3 bytes BCD/HEXA</li>
          <li>Start byte= 3</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 3</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCMaskRecord</b>
        <ul>
          <li>Format: Non numérique 3 octets BCD/HEXA</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 3</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE085 DDT2000_ERR_1906FF_DTCRecord -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE085</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData</b>: error on data <b>DTCRecord</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b> : erreur sur la donnée <b>DTCRecord</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>
        Caracteristics of the data <b>DTCRecord</b>
        <ul>
          <li>Format: No Numeric 3 bytes BCD/HEXA</li>
          <li>Start byte= 3</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 3</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCRecord</b>
        <ul>
          <li>Format: Non numérique 3 octets BCD/HEXA</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 3</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE086 DDT2000_ERR_1906FF_StatusOfDTC -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE086</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData</b>: error on data <b>StatusOfDTC</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b> : erreur sur la donnée <b>StatusOfDTC</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>
        Caracteristics of the data <b>StatusOfDTC</b>
        <ul>
          <li>Format: Numeric 8 bits unsigned</li>
          <li>Start byte= 6</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>StatusOfDTC</b>
        <ul>
          <li>Format: Numérique 8 bits non signés</li>
          <li>Octet de début= 6</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE087 DDT2000_ERR_1906FF_DTCExtendedDataRecordNumber -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE087</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData</b>: error on data <b>DTCExtendedDataRecordNumber</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b> : erreur sur la donnée <b>DTCExtendedDataRecordNumber</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>
        Caracteristics of the data <b>DTCExtendedDataRecordNumber</b>
        <ul>
          <li>Format: List Numeric 8 bits unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCExtendedDataRecordNumber</b>
        <ul>
          <li>Format: List numérique 8 bits non signés</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE088 DDT2000_ERR_1906FF_DTCExtendedData_AgingCounter -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE088</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData</b>: error on data <b>DTCExtendedData.AgingCounter</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b> : erreur sur la donnée <b>DTCExtendedData.AgingCounter</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>
        Caracteristics of the data <b>DTCExtendedData.AgingCounter</b>
        <ul>
          <li>Format: Numeric 8 bits unsigned</li>
          <li>Start Byte= 8</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCExtendedData.AgingCounter</b>
        <ul>
          <li>Format: Numérique 8 bits non signés</li>
          <li>Octet de début= 8</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE089 DDT2000_ERR_1906FF_DTCExtendedData_DTCOccurrenceCounter -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE089</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData</b>: error on data <b>DTCExtendedData.DTCOccurrenceCounter</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b> : erreur sur la donnée <b>DTCExtendedData.DTCOccurrenceCounter</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>
        Caracteristics of the data <b>DTCExtendedData.DTCOccurrenceCounter</b>
        <ul>
          <li>Format: Numeric 8 bits unsigned</li>
          <li>Start byte= 8</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCExtendedData.DTCOccurrenceCounter</b>
        <ul>
          <li>Format: Numérique 8 bits non signés</li>
          <li>Octet de début= 8</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE090 DDT2000_ERR_1906FF_DTCExtendedData_Mileage -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE090</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData</b>: error on data <b>DTCExtendedData.Mileage</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b> : erreur sur la donnée <b>DTCExtendedData.Mileage</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData</b></name>
      <info>
        Caracteristics of the data <b>DTCExtendedData.Mileage</b>
        <ul>
          <li>Format: Numeric 24 bits unsigned (km)</li>
          <li>Start byte= 3</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 24</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCExtendedData.Mileage</b>
        <ul>
          <li>Format: Numérique 24 bits non signés</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 24</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE091 DDT2000_ERR_ReadDTCInformationReportExtendedData_RequestName -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE091</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request ReadDTCInformation.ReportExtendedData: Invalid resquest name </titleA>
      <titleA xml:lang="fr">Requête ReadDTCInformation.ReportExtendedData: Erreur sur le nom de la requête </titleA>
      <name>Request: Sent Bytes = <b>$1906000000FF</b></name>
      <name xml:lang="fr">Requête : Octets émis = <b>$1906000000FF</b></name>
      <info>The valid name of the request is <b>ReadDTCInformation.ReportExtendedData</b></info>
      <info xml:lang="fr">Le nom conforme de la requête est <b>ReadDTCInformation.ReportExtendedData</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE100 DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE100</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request: Error(s) on ReadDTCInformation.ReportExtendedData.Mileage</titleA>
      <titleA xml:lang="fr">Requête: Erreur(s) sur ReadDTCInformation.ReportExtendedData.Mileage</titleA>
      <name>Request: <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête : <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>Check if the request <b>ReadDTCInformation.ReportExtendedData.Mileage</b> exists</info>
      <info xml:lang="fr">Contrôler si la requête <b>ReadDTCInformation.ReportExtendedData.Mileage</b> existe</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE101 associated with DE100 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE101</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>Sent bytes = <b>$190600000080</b></info>
      <info xml:lang="fr">Octets émis = <b>$190600000080</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE102 associated with DE100 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE102</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>Number of bytes to be received (MinBytes) = <b>6</b> or <b>10</b></info>
      <info xml:lang="fr">Le nombre minimum d'octet à recevoir (MinBytes) = <b>6</b> ou <b>10</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE103 associated with DE100 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE103</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>Shift bytes count =<b>0</b></info>
      <info xml:lang="fr">Le shift bytes count =<b>0</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE104 DTT2000_ERR_190680_DTCMaskRecord -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE104</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData.Mileage</b>: error on data <b>DTCMaskRecord</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData.Mileage</b> : erreur sur la donnée <b>DTCMaskRecord</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>
        Caracteristics of the data <b>DTCMaskRecord</b>
        <ul>
          <li>Format: No Numeric 3 bytes BCD/HEXA</li>
          <li>Start byte= 3</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 3</li>
          <li>Ascii= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCMaskRecord</b><br />
        <ul>
          <li>Format: Non numérique 3 octets BCD/HEXA</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 3</li>
          <li>ascii= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE105 DDT2000_ERR_190680_DTCRecord -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE105</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData.Mileage</b>: error on data <b>DTCRecord</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData.Mileage</b> : erreur sur la donnée <b>DTCRecord</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>
        Caracteristics of the data <b>DTCRecord</b>
        <ul>
          <li>Format: No Numeric 3 bytes BCD/HEXA</li>
          <li>Start byte= 3</li>
          <li>OffsetByte= 0</li>
          <li>Number of bytes= 3</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCRecord</b>
        <ul>
          <li>Format: Non numérique 3 octets BCD/HEXA</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 3</li>
          <li>Ascii= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE106 DDT2000_ERR_190680_StatusOfDTC -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE106</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData.Mileage</b>: error on data <b>StatusOfDTC</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData.Mileage</b> : erreur sur la donnée <b>StatusOfDTC</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>
        Caracteristics of the data <b>StatusOfDTC</b>
        <ul>
          <li>Format: Numeric 8 bits unsigned</li>
          <li>Start Byte= 6</li>
          <li>OffsetBit= 0</li>
          <li>Number of Bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>StatusOfDTC</b>
        <ul>
          <li>Format: Numérique 8 bits non signés</li>
          <li>Octet de début= 6</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE107 DDT2000_ERR_190680_DTCExtendedDataRecordNumber -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE107</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData.Mileage</b>: error on data <b>DTCExtendedDataRecordNumber</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData.Mileage</b> : erreur sur la donnée <b>DTCExtendedDataRecordNumber</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>
        Caracteristics of the data <b>DTCExtendedDataRecordNumber</b>
        <ul>
          <li>Format: List Numeric 8 bits unsigned</li>
          <li>Start byte= 7</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCExtendedDataRecordNumber</b>
        <ul>
          <li>Format: Liste numérique 8 bits non signés</li>
          <li>Octet de début= 7</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE108 DDT2000_ERR_190680_DTCExtendedData_Mileage -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE108</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportExtendedData.Mileage</b>: error on data <b>DTCExtendedData.Mileage</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData.Mileage</b> : erreur sur la donnée <b>DTCExtendedData.Mileage</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportExtendedData_Mileage</b></name>
      <info>
        Caracteristics of the data <b>DTCExtendedData.Mileage</b>
        <ul>
          <li>Format: Numeric 24 bits unsigned (km)</li>
          <li>Start byte= 8</li>
          <li>OffsetByte= 0</li>
          <li>Number of bits= 24</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCExtendedData.Mileage</b>
        <ul>
          <li>Format: Numérique 24 bits non signés (km)</li>
          <li>Octet de début= 8</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 24</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE109 DDT2000_ERR_ReadDTCInformationReportExtendedDataMileage_RequestName -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportExtendedData($1906XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE109</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request ReadDTCInformation.ReportExtendedData.Mileage: Invalid resquest name </titleA>
      <titleA xml:lang="fr">Requête ReadDTCInformation.ReportExtendedData.Mileage: Erreur sur le nom de la requête </titleA>
      <name>
        Request :<br />
        Sent Bytes = <b>$190600000080</b>
      </name>
      <name xml:lang="fr">
        Requête :<br />
        Octets émis = <b>$190600000080</b>
      </name>
      <info>The valid name of the request is <b>ReadDTCInformation.ReportExtendedData.Mileage</b></info>
      <info xml:lang="fr">Le nom conforme de la requête est <b>ReadDTCInformation.ReportExtendedData.Mileage</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE121 DDT2000_ERR_ReadDTCInformationReportSnapshot -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportSnapshot ($1904XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE121</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request: Error(s) on ReadDTCInformation.ReportSnapshot</titleA>
      <titleA xml:lang="fr">Requête: Erreur(s) ReadDTCInformation.ReportSnapshot</titleA>
      <name>Request <b>ReadDTCInformation.ReportSnapshot</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b></name>
      <info>Sent bytes = <b>$1904000000FF</b></info>
      <info xml:lang="fr">Octets émis = <b>$1904000000FF</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE122 associated with DE121 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportSnapshot ($1904XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE122</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportSnapshot</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b></name>
      <info>Number of bytes to be received (MinBytes) = <b>6</b></info>
      <info xml:lang="fr">Le nombre minimum d'octet à recevoir (MinBytes) = <b>6</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE123 associated with DE121 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportSnapshot ($1904XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE123</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>ReadDTCInformation.ReportSnapshot</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b></name>
      <info>Shift bytes count =<b>4</b></info>
      <info xml:lang="fr">Le shift bytes count =<b>0</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE124 DDT2000_ERR_1904_DTCMaskRecord -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportSnapshot ($1904XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE124</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportSnapshot</b>: error on data <b>DTCMaskRecord</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b> : erreur sur la donnée <b>DTCMaskRecord</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportSnapshot</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b></name>
      <info>
        Caracteristics of the data <b>DTCMaskRecord</b>
        <ul>
          <li>Format: No Numeric 3 bytes BCD/HEXA</li>
          <li>Start byte= 3</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 3</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCMaskRecord</b>
        <ul>
          <li>Format: Non numérique 3 octets BCD/HEXA</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 3</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE125 DDT2000_ERR_1904_DTCRecord -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportSnapshot ($1904XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE125</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportSnapshot</b>: error on data <b>DTCRecord</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b> : erreur sur la donnée <b>DTCRecord</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportSnapshot</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b></name>
      <info>
        Caracteristics of the data <b>DTCRecord</b>
        <ul>
          <li>Format: No Numeric 3 bytes BCD/HEXA</li>
          <li>Start byte= 3</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 3</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DTCRecord</b>
        <ul>
          <li>Format: Non numérique 3 octets BCD/HEXA</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 3</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE126 DDT2000_ERR_1904_StatusOfDTC -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportSnapshot ($1904XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE126</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request <b>ReadDTCInformation.ReportSnapshot</b>: error on data <b>StatusOfDTC</b></titleA>
      <titleA xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b> : erreur sur la donnée <b>StatusOfDTC</b></titleA>
      <name>Request <b>ReadDTCInformation.ReportSnapshot</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportSnapshot</b></name>
      <info>
        Caracteristics of the data <b>StatusOfDTC</b>
        <ul>
          <li>Format: Numeric 8 bits unsigned</li>
          <li>Start byte= 6</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>StatusOfDTC</b><br />
        <ul>
          <li>Format: Numérique 8 bits non signé</li>
          <li>Octet de début= 6</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE127 DDT2000_ERR_ReadDTCInformationReportSnapshot_RequestName -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportSnapshot ($1904XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE127</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request ReadDTCInformation.ReportSnapshot: Invalid resquest name </titleA>
      <titleA xml:lang="fr">Requête ReadDTCInformation.ReportSnapshot: Erreur sur le nom de la requête </titleA>
      <name>
        Request :<br />
        Sent Bytes = <b>$1904000000FF</b>
      </name>
      <name xml:lang="fr">
        Requête : <br />
        Octets émis = <b>$1904000000FF</b>
      </name>
      <info>The valid name of the request is <b>ReadDTCInformation.ReportSnapshot</b></info>
      <info xml:lang="fr">Le nom conforme de la requête est <b>ReadDTCInformation.ReportSnapshot</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE130 DDT2000_ERR_IdentificationRenaultR2 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE130</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request: Error(s) on DataRead.Identification.RenaultR2</titleA>
      <titleA xml:lang="fr">Requête: Erreur(s) sur DataRead.Identification.RenaultR2</titleA>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>Check if the request <b>DataRead.Identification.RenaultR2</b> exists</info>
      <info xml:lang="fr">Contrôler si la requête <b>DataRead.Identification.RenaultR2</b> existe</info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE131 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE131</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>Sent bytes = <b>$2180</b></info>
      <info xml:lang="fr">Octets émis = <b>$2180</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE132 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE132</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>Number of bytes to be received (MinBytes) = <b>26</b></info>
      <info xml:lang="fr">Le nombre minimum d'octet à recevoir (MinBytes) = <b>26</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE133 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE133</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>Shift bytes count =<b>0</b></info>
      <info xml:lang="fr">Le shift bytes count =<b>0</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE134 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE134</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>PartNumber.LowerPart</b>
        <ul>
          <li>Format: No Numeric 5 bytes ASCII</li>
          <li>Start byte= 3</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 5</li>
          <li>Ascii = 1</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>PartNumber.LowerPart</b>
        <ul>
          <li>Format: Non numérique 5 octets ASCII</li>
          <li>Octet de début= 3</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 5</li>
          <li>Ascii = 1</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE135 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE135</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>DiagnosticIdentificationCode</b>
        <ul>
          <li>Format: No Numeric 1 byte BCD/HEXA</li>
          <li>Start byte= 8</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 1</li>
          <li>Ascii= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>DiagnosticIdentificationCode</b>
        <ul>
          <li>Format: Non numérique 1 octet BCD/HEXA</li>
          <li>Octet de début= 8</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 1</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE136 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE136</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>SupplierNumber.ITG</b>
        <ul>
          <li>Format: No Numeric 3 bytes ASCII</li>
          <li>Start byte= 9</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 3</li>
          <li>Ascii= 1</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>SupplierNumber.ITG</b>
        <ul>
          <li>Format: Non numérique 3 octets ASCII</li>
          <li>Octet de début= 9</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 3</li>
          <li>Ascii = 1</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE137 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE137</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>HardwareNumber.LowerPart</b>
        <ul>
          <li>Format: No Numeric 5 bytes ASCII</li>
          <li>Start byte= 12</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 5</li>
          <li>Ascii= 1</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>HardwareNumber.LowerPart</b>
        <ul>
          <li>Format: Non numérique 5 octets ASCII</li>
          <li>Octet de début= 12</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 5</li>
          <li>Ascii = 1</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE138 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE138</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>SoftwareNumber</b>
        <ul>
          <li>Format: No Numeric 2 bytes BCD/HEXA</li>
          <li>Start byte= 17</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 2</li>
          <li>Ascii= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>SoftwareNumber</b>
        <ul>
          <li>Format: Non numérique 2 octets BCD/HEXA</li>
          <li>Octet de début= 17</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 2</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE139 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE139</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>EditionNumber</b>
        <ul>
          <li>Format: No Numeric 2 bytes BCD/HEXA</li>
          <li>Start byte= 19</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 2</li>
          <li>Ascii= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>EditionNumber</b>
        <ul>
          <li>Format: Non numérique 2 octets BCD/HEXA</li>
          <li>Octet de début= 19</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 2</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE140 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE140</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>CalibrationNumber</b>
        <ul>
          <li>Format: No Numeric 2 bytes BCD/HEXA</li>
          <li>Start byte= 21</li>
          <li>OffsetBit= 0</li>
          <li>Number of bytes= 2</li>
          <li>Ascii= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>CalibrationNumber</b>
        <ul>
          <li>Format: Non numérique 2 octets BCD/HEXA</li>
          <li>Octet de début= 21</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre d'octets= 2</li>
          <li>Ascii = 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE141 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE141</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>PartNumber.BasicPartList</b>
        <ul>
          <li>Format: List Numeric 8 bits unsigned</li>
          <li>Start byte= 23</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>PartNumber.BasicPartList</b>
        <ul>
          <li>Format: Liste numérique 8 bits non signés</li>
          <li>Octet de début= 23</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE142 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE142</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>HardwareNumber.BasicPartList</b>
        <ul>
          <li>Format: List Numeric 8 bits unsigned</li>
          <li>Start byte= 24</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>HardwareNumber.BasicPartList</b>
        <ul>
          <li>Format: Liste numérique 8 bits non signés</li>
          <li>Octet de début= 24</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE143 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE143</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>ApprovalNumber.BasicPartList</b>
        <ul>
          <li>Format: List Numeric 8 bits unsigned</li>
          <li>Start byte= 25</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 3</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>ApprovalNumber.BasicPartList</b>
        <ul>
          <li>Format: Liste numérique 8 bits non signés</li>
          <li>Octet de début= 25</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 3</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE144 associated with DE130 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE144</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>
        Caracteristics of the data <b>ManufacturerIdentificationCode</b>
        <ul>
          <li>Format: List Numeric 8 bits unsigned</li>
          <li>Start byte= 26</li>
          <li>OffsetBit= 0</li>
          <li>Number of bits= 8</li>
          <li>Signed= 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        Caractéristiques de la donnée <b>ManufacturerIdentificationCode</b>
        <ul>
          <li>Format: Liste numérique 8 bits non signés</li>
          <li>Octet de début= 26</li>
          <li>Décalage (offsetBit)= 0</li>
          <li>Nombre de bits= 8</li>
          <li>Signe= 0</li>
        </ul>
      </info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE145 DDT2000_ERR_BadLengthBasicPartList -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.Identification.RenaultR2 ($2180)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE145</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Request: Length BasicPartList Data &gt;5 characters</titleA>
      <titleA xml:lang="fr">Requête: Longueur des libellés des BasicPartList &gt; 5 caractères</titleA>
      <name>Request <b>DataRead.Identification.RenaultR2</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR2</b></name>
      <info>Maximum length of BasicPartList texts = <b>5 characters</b></info>
      <info xml:lang="fr">Longueur maximum des textes BasicPartList = <b>5 caractères</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE146 DDT2000_ERR_BreakDownType -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE146</code>
      <critic>error</critic>
      <titleA>BreakDown Type: the initialization type of fault and associated id is incorrect</titleA>
      <titleA xml:lang="fr">L'initialisation du type de panne et l'id associé est incorrecte</titleA>
      <name>Type of fault</name>
      <name xml:lang="fr">Type de panne</name>
      <info>
        Initialize in the choice:
        <ul>
          <li>type of fault = <b>No failures</b> i d= <b>0</b></li>
          <li>type of fault = <b>Failures Flags</b> id = <b>1</b></li>
          <li>type of fault = <b>10 DTC failures read with After sales Frames</b> id = <b>2</b></li>
          <li>type of fault = <b>DTC Failures</b> id = <b>3</b></li>
        </ul>
         when the <b>ReadDTCInformation.ReportDTC</b> request exists
      </info>
      <info xml:lang="fr">
        Initialiser au choix :
        <ul>
          <li>type de panne = <b>Ne contient pas de pannes</b> id = <b>0</b></li>
          <li>type de panne = <b>Flags de pannes</b> id = <b>1</b></li>
          <li>type de panne = <b>10 pannes DTC dans les trames APV</b> id = <b>2</b></li>
          <li>type de panne = <b>Pannes DTC</b> id = <b>3</b></li>
        </ul>
        quand la requête <b>ReadDTCInformation.ReportDTC</b> existe
      </info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE150 DDT2000_ERR_DeviceName -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE150</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Missing device name</titleA>
      <titleA xml:lang="fr">Manque le nom de l'organe</titleA>
      <name>Device Name</name>
      <name xml:lang="fr">Nom de l'organe</name>
      <info>The attribute <b>Name</b> must be defined</info>
      <info xml:lang="fr">L'attribut <b>Name</b> doit être défini</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE151 DDT2000_ERR_DeviceDTC -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE151</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>DTC device (DTC&lt;1 or DTC&gt;65535)</titleA>
      <titleA xml:lang="fr">Organe DTC (DTC&lt;1 or DTC&gt;65535)</titleA>
      <name>Device: <b>Base DTC</b> </name>
      <name xml:lang="fr">Organe : <b>Base DTC</b></name>
      <info>Authorized values for Base DTC <b>[1,65535]</b></info>
      <info xml:lang="fr">Valeurs autorisées pour Base DTC <b>[1,65535]</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE152 DDT2000_ERR_DeviceDuplicateDTC -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE152</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Device: Duplicate DTC</titleA>
      <titleA xml:lang="fr">Organe: Duplication du DTC</titleA>
      <name>Device: <b>Base DTC</b></name>
      <name xml:lang="fr">Organe : <b>Base DTC</b></name>
      <info>The value <b>Base DTC</b> must not be duplicated</info>
      <info xml:lang="fr">La valeur <b>Base DTC</b> ne doit pas être dupliqué</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE153 DDT2000_ERR_DeviceTestType -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE153</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>Device: Types of fault (Type&lt;0 or Type&gt;255)</titleA>
      <titleA xml:lang="fr">Organe: Types de panne (Type&lt;0 ou Type&gt;255)</titleA>
      <name>Device: <b>Types of fault</b></name>
      <name xml:lang="fr">Organe : <b>Types de panne</b></name>
      <info>Authorized values for Types of fault <b>[0,255]</b></info>
      <info xml:lang="fr">Valeurs autorisées pour Types de panne <b>[0,255]</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE154 DDT2000_ERR_DeviceTestOBD -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE154</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>OBD status (OBD&lt;1 or OBD&gt;65535)</titleA>
      <titleA xml:lang="fr">Code OBD (OBD&lt;1 or OBD&gt;65535)</titleA>
      <name>Device: <b>OBD status</b></name>
      <name xml:lang="fr">Organe : <b>Code OBD</b></name>
      <info>Authorized values for OBD status <b>[1,65535]</b></info>
      <info xml:lang="fr">valeurs autorisées pour le Code OBD <b>[1,65535]</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- DE155 DDT2000_ERR_DeviceOBDnoBaseDTC -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE155</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>OBD value without Base DTC</titleA>
      <titleA xml:lang="fr">Valeur OBD sans Base DTC</titleA>
      <name>Device: <b>OBD</b></name>
      <name xml:lang="fr">Organe : <b>OBD</b></name>
      <info> Requires a <b>Base DTC</b> different from 0</info>
      <info xml:lang="fr">Requiert un <b>Base DTC</b> différent de 0</info>
      <version>V1.8</version>
    </rule>
    <rule><!-- DE160 DDT2000_ERR_DTCDeviceIdentifier -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE160</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>
        Incoherence between the DTC declared in the Devices tab<br />
        and the DTC declared in the data DTCDeviceIdentifier
      </titleA>
      <titleA xml:lang="fr">
        Incohérence entre la liste des DTC déclarés dans l'onglet Organes <br />
        et la liste des DTC déclarés dans la donnée DTCDeviceIdentifier
      </titleA>
      <name>Device (<b>Base DTC</b>) and Data (<b>DTCDeviceIdentifier</b>)</name>
      <name xml:lang="fr">Organe (<b>Base DTC</b>) et Donnée <b>DTCDeviceIdentifier</b></name>
      <info>
        The list of DTC declared in the data DTCDeviceIdentifier must be<br />
        equal to the list of the Base DTC declared in the Devices tab
      </info>
      <info xml:lang="fr">
        La liste des DTC déclarés dans la donnée DTCDeviceIdentifier<br />
        doit être identique à la liste des Base DTC déclarés dans l'onglet Organes
      </info>
      <version>V1.0</version>
    </rule>
    <rule><!-- DE161 DDT2000_ERR_FirstDTC -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE161</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>
        Incoherence between the DTC declared in the Devices tab<br />
        and the DTC declared in the data FirstDTC
      </titleA>
      <titleA xml:lang="fr">
        Incohérence entre la liste des DTC déclarés dans l'onglet Organes<br />
        et la liste des DTC déclarés dans la donnée FirstDTC
      </titleA>
      <name>Device (<b>Base DTC</b>) and Data (<b>FirstDTC</b>)</name>
      <name xml:lang="fr">Organe (<b>Base DTC</b>) et Donnée <b>FirstDTC</b></name>
      <info>
        The list of DTC declared in the data FirstDTC must be<br />
        equal to the list of the Base DTC declared in the Devices tab
      </info>
      <info xml:lang="fr">
        La liste des DTC déclarés dans la donnée FirstDTC<br />
        doit être identique à la liste des Base DTC déclarés dans l'onglet Organes
      </info>
      <version>V1.0</version>
    </rule>
    <rule><!-- DE170 DDT2000_ERR_AddressFunction -->
      <chapters>
        <chapter title1="ECU tab" title2="ECU function address" />
      </chapters>
      <type>DDT2000</type>
      <code>DE170</code>
      <impact>I01</impact>
      <critic>error</critic>
      <titleA>Address function: Invalid address function (address&lt;1 or address&gt;254)</titleA>
      <titleA xml:lang="fr">Adresse de la fonction: adresse invalide (adresse&lt;1 ou adresse&gt;254)</titleA>
      <name>Address of the function</name>
      <name xml:lang="fr">Adresse de la fonction</name>
      <info>Values authorized for the address of the function = <b>[1,254] (decimal values)</b></info>
      <info xml:lang="fr">Valeurs autorisées pour l'adresse de la fonction = <b>[1,254] (valeurs décimales)</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE171 DDT2000_ERR_GenericAddressing -->
      <chapters>
        <chapter title1="ECU tab" title2="ECU function address" />
      </chapters>
      <type>DDT2000</type>
      <code>DE171</code>
      <impact>I01</impact>
      <critic>error</critic>
      <titleA>Address/Name function/CanID: Incoherence between the Address function and its name or the CanID</titleA>
      <titleA xml:lang="fr">Adresse/Nom fonction/Id CAN: Incohérence entre l'adresse de la fonction et son nom ou les Identifiants CAN</titleA>
      <name>Address/Name of the function/CanID and GenericAddressing file.xml</name>
      <name xml:lang="fr">Adresse/Nom de la fonction/IDCan et fichier GenericAddressing.xml</name>
      <info>The values authorized for the address and name of the function and the CanID are specified in the GenericAdressing file (if available)</info>
      <info xml:lang="fr">Les valeurs autorisées pour l'adresse et le nom de la fonction et les identifiants CAN sont spécifiés dans le fichier GenericAddressing (si disponible)</info>
      <version>V1.4</version>
    </rule>
    <rule><!-- DE172 DDT2000_ERR_UDS_22F187 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.vehicleManufacturerSparePartNumber($22F187)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE172</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F187) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F187) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.vehicleManufacturerSparePartNumber($22F187)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.vehicleManufacturerSparePartNumber($22F187)</b></name>
      <info>
        DataRead.vehicleManufacturerSparePartNumber($22F187) must have:
        <ul>
          <li><b>Name</b>: DataRead.vehicleManufacturerSparePartNumber</li>
          <li><b>Sent bytes</b>: $22F187</li>
          <li><b>Number of received bytes</b>: 13</li>
          <li><b>Data received</b>: " vehicleManufacturerSparePartNumber" of type "ascii"</li>
        </ul>
      </info>
      <info xml:lang="fr">
        DataRead.vehicleManufacturerSparePartNumber($22F187) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.vehicleManufacturerSparePartNumber</li>
          <li><b>Octets envoyés</b> : $22F187</li>
          <li><b>Nomber d'octets reçus</b> : 13</li>
          <li><b>Donnée reçue</b> : "vehicleManufacturerSparePartNumber" de type "ascii"</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE173 DDT2000_ERR_UDS_22F188 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.vehicleManufacturerECUSoftwareNumber($22F188)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE173</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F188) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F188) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.vehicleManufacturerECUSoftwareNumber($22F188)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.vehicleManufacturerECUSoftwareNumber($22F188)</b></name>
      <info>
        DataRead.vehicleManufacturerECUSoftwareNumber($22F188) must have:
        <ul>
          <li><b>Nom</b> : DataRead.vehicleManufacturerECUSoftwareNumber</li>
          <li><b>Octets envoyés</b> : $22F188</li>
          <li><b>Nomber d'octets reçus</b> : 13</li>
          <li><b>Donnée reçue</b> : "vehicleManufacturerECUSoftwareNumber" de type "ascii"</li>
        </ul>
      </info>
      <info xml:lang="fr">
        DataRead.vehicleManufacturerECUSoftwareNumber($22F188) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.vehicleManufacturerECUSoftwareNumber</li>
          <li><b>Octets envoyés</b> : $22F188</li>
          <li><b>Nomber d'octets reçus</b> : 13</li>
          <li><b>Donnée reçue</b> : "vehicleManufacturerECUSoftwareNumber" de type "ascii"</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE174 DDT2000_ERR_UDS_22F18A -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.systemSupplierIdentifier($22F18A)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE174</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F18A) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F18A) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.systemSupplierIdentifier($22F18A)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.systemSupplierIdentifier($22F18A)</b></name>
      <info>
        DataRead.systemSupplierIdentifier($22F18A) must have:
        <ul>
          <li><b>Name</b>: DataRead.systemSupplierIdentifier</li>
          <li><b>Sent bytes</b>: $22F18A</li>
          <li><b>Number of received bytes</b>: 67 max</li>
          <li><b>Data received</b>: "systemSupplierIdentifier" of type "ascii"</li>
        </ul>
      </info>
      <info xml:lang="fr">
        DataRead.systemSupplierIdentifier($22F18A) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.systemSupplierIdentifier</li>
          <li><b>Octets envoyés</b> : $22F18A</li>
          <li><b>Nomber d'octets reçus</b> : 67 max</li>
          <li><b>Donnée reçue</b> : "systemSupplierIdentifier" de type "ascii"</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE175 DDT2000_ERR_UDS_22F18C -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.ECUSerialNumber($22F18C)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE175</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F18C) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F18C) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.ECUSerialNumber($22F18C)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.ECUSerialNumber($22F18C)</b></name>
      <info>
        DataRead.ECUSerialNumber($22F18C) must have:
        <ul>
          <li><b>Name</b>: DataRead.ECUSerialNumber</li>
          <li><b>Sent bytes</b>: $22F18C</li>
          <li><b>Number of received bytes</b>: 23</li>
          <li><b>Data received</b>: "ECUSerialNumber" of type "ascii"</li>
        </ul>
      </info>
      <info xml:lang="fr">
        DataRead.ECUSerialNumber($22F18C) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.ECUSerialNumber</li>
          <li><b>Octets envoyés</b> : $22F18C</li>
          <li><b>Nomber d'octets reçus</b> : 23</li>
          <li><b>Donnée reçue</b> : "ECUSerialNumber" de type "ascii"</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE176 DDT2000_ERR_UDS_22F190 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.VIN($22F190)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE176</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F190) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F190) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.VIN($22F190)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.VIN($22F190)</b></name>
      <info>
        DataRead.VIN($22F190) must have:
        <ul>
          <li><b>Name</b>: DataRead.VIN</li>
          <li><b>Sent bytes</b>: $22F190</li>
          <li><b>Number of received bytes</b>: 20</li>
          <li><b>Data received</b>: "VIN" of type "ascii"</li>
        </ul>
      </info>
      <info xml:lang="fr">
        DataRead.VIN($22F190) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.VIN</li>
          <li><b>Octets envoyés</b> : $22F190</li>
          <li><b>Nomber d'octets reçus</b> : 20</li>
          <li><b>Donnée reçue</b> : "VIN" de type "ascii"</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE177 DDT2000_ERR_UDS_22F191 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.vehicleManufacturerECUHardwareNumber($22F191)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE177</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F191) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F191) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.vehicleManufacturerECUHardwareNumber($22F191)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.vehicleManufacturerECUHardwareNumber($22F191)</b></name>
      <info>
        DataRead.vehicleManufacturerECUHardwareNumber($22F191) must have:
        <ul>
          <li><b>Name</b>: DataRead.vehicleManufacturerECUHardwareNumber</li>
          <li><b>Sent bytes</b>: $22F191</li>
          <li><b>Number of received bytes</b>: 13</li>
          <li><b>Data received</b>: "vehicleManufacturerECUHardwareNumber" of type "ascii"</li>
        </ul>
      </info>
      <info xml:lang="fr">
        DataRead.vehicleManufacturerECUHardwareNumber($22F191) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.vehicleManufacturerECUHardwareNumber</li>
          <li><b>Octets envoyés</b> : $22F191</li>
          <li><b>Nomber d'octets reçus</b> : 13</li>
          <li><b>Donnée reçue</b> : "vehicleManufacturerECUHardwareNumber" de type "ascii"</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE178 DDT2000_ERR_UDS_22F194 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.systemSupplierECUSoftwareNumber($22F194)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE178</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F194) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F194) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.systemSupplierECUSoftwareNumber($22F194)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.systemSupplierECUSoftwareNumber($22F194)</b></name>
      <info>
        DataRead.systemSupplierECUSoftwareNumber($22F194) must have:
        <ul>
          <li><b>Name</b>: DataRead.systemSupplierECUSoftwareNumber</li>
          <li><b>Sent bytes</b>: $22F194</li>
          <li><b>Number of received bytes</b>: 35 max</li>
          <li><b>Data received</b>: "systemSupplierECUSoftwareNumber" of type "ascii"</li>
        </ul>
      </info>
      <info xml:lang="fr">
        DataRead.systemSupplierECUSoftwareNumber($22F194) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.systemSupplierECUSoftwareNumber</li>
          <li><b>Octets envoyés</b>: $22F194</li>
          <li><b>Nomber d'octets reçus</b>: 35 max</li>
          <li><b>Donnée reçue</b>: "systemSupplierECUSoftwareNumber" de type "ascii"</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE179 DDT2000_ERR_UDS_22F195 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.systemSupplierECUSoftwareVersionNumber($22F195)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE179</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F195) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F195) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.systemSupplierECUSoftwareVersionNumber($22F195)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.systemSupplierECUSoftwareVersionNumber($22F195)</b></name>
      <info>
        DataRead.systemSupplierECUSoftwareVersionNumber($22F195) must have:
        <ul>
          <li><b>Name</b>: DataRead.systemSupplierECUSoftwareVersionNumber</li>
          <li><b>Sent bytes</b>: $22F195</li>
          <li><b>Number of received bytes</b>: 35 max</li>
          <li><b>Data received</b>: "systemSupplierECUSoftwareVersionNumber" of type "ascii"</li>
        </ul>
    </info>
      <info xml:lang="fr">
        DataRead.systemSupplierECUSoftwareVersionNumber($22F195) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.systemSupplierECUSoftwareVersionNumber</li>
          <li><b>Octets envoyés</b> : $22F195</li>
          <li><b>Nomber d'octets reçus</b> : 35 max</li>
          <li><b>Donnée reçue</b> : "systemSupplierECUSoftwareVersionNumber" de type "ascii"</li>
        </ul>
    </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE180 DDT2000_ERR_UDS_22F1A0 -->
      <chapters>
        <chapter title1="Requests" title2="DataRead.diagnosticVersion($22F1A0)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE180</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request: Identification ($22F1A0) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: L'identification ($22F1A0) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>DataRead.diagnosticVersion($22F1A0)</b></name>
      <name xml:lang="fr">Requête <b>DataRead.diagnosticVersion($22F1A0)</b></name>
      <info>
        DataRead.diagnosticVersion($22F1A0) must have:
        <ul>
          <li><b>Name</b>: DataRead.diagnosticVersion</li>
          <li><b>Sent bytes</b>: $22F1A0</li>
          <li><b>Number of received bytes</b>: 4</li>
          <li><b>Data received</b>: "diagnosticVersioné</li>
        </ul>
      </info>
      <info xml:lang="fr">
        DataRead.diagnosticVersion($22F1A0) doit avoir :
        <ul>
          <li><b>Nom</b> : DataRead.diagnosticVersion</li>
          <li><b>Octets envoyés</b> : $22F1A0</li>
          <li><b>Nomber d'octets reçus</b> : 4</li>
          <li><b>Donnée reçue</b> : "diagnosticVersion"</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE181 DDT2000_ERR_UDS_StartDiagnosticSession -->
      <chapters>
        <chapter title1="Requests" title2="StartDiagnosticSession ($10XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE181</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request StartDiagnosticSession ($10XX) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête StartDiagnosticSession ($10XX) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>StartDiagnosticSession ($10XX)</b></name>
      <name xml:lang="fr">Requête <b>StartDiagnosticSession ($10XX)</b></name>
      <info>
        StartDiagnosticSession ($10XX) must have:
        <ul>
          <li><b>Name starting with</b>: StartDiagnosticSession</li>
          <li><b>2 Sent bytes</b>: $10XX</li>
          </ul>
      </info>
      <info xml:lang="fr">
          StartDiagnosticSession ($10XX) doit avoir :
          <ul>
            <li><b>Nom qui commence par</b> : StartDiagnosticSession</li>
            <li><b>2 Octets envoyés</b> : $10XX</li>
          </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE182 DDT2000_ERR_UDS_ClearDiagnosticInformation -->
      <chapters>
        <chapter title1="Requests" title2="ClearDiagnosticInformation ($14XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE182</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request ClearDiagnosticInformation ($14XXXXXX) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête ClearDiagnosticInformation ($14XXXXXX) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>ClearDiagnosticInformation ($14XXXXXX)</b></name>
      <name xml:lang="fr">Requête <b>ClearDiagnosticInformation ($14XXXXXX)</b></name>
      <info>
        ClearDiagnosticInformation ($14XXXXXX) must have:
        <ul>
          <li><b>Name starting with</b>: ClearDiagnosticInformation</li>
          <li><b>4 Sent bytes</b>: $14XXXXXX</li>
        </ul>
      </info>
      <info xml:lang="fr">
        ClearDiagnosticInformation ($14XXXXXX) doit avoir :
        <ul>
          <li><b>Nom qui commence par</b> : ClearDiagnosticInformation</li>
          <li><b>4 Octets envoyés</b> : $14XXXXXX</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE183 DDT2000_ERR_UDS_1901 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportNumberOfDTCByStatusMask ($1901XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE183</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request ReadDTCInformation.ReportNumberOfDTCByStatusMask ($1901XX) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête ReadDTCInformation.ReportNumberOfDTCByStatusMask ($1901XX) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>ReadDTCInformation.ReportNumberOfDTCByStatusMask ($1901XX)</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportNumberOfDTCByStatusMask ($1901XX)</b></name>
      <info>
        ReadDTCInformation.ReportNumberOfDTCByStatusMask ($1901XX) must have:
        <ul>
          <li><b>Name starting with</b>: ReadDTCInformation.ReportNumberOfDTCByStatusMask</li>
          <li><b>3 Sent bytes</b>: $1901XX</li>
        </ul>
      </info>
      <info xml:lang="fr">
        ReadDTCInformation.ReportNumberOfDTCByStatusMask ($1901XX) doit avoir :
        <ul>
          <li><b>Nom qui commence par</b> : ReadDTCInformation.ReportNumberOfDTCByStatusMask</li>
          <li><b>3 Octets envoyés</b> : $1901XX</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE184 DDT2000_ERR_UDS_1902 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTC ($1902XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE184</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request ReadDTCInformation.ReportDTC ($1902XX) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête ReadDTCInformation.ReportDTC ($1902XX) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>ReadDTCInformation.ReportDTC ($1902XX)</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTC ($1902XX)</b></name>
      <info>
        ReadDTCInformation.ReportDTC ($1902XX) must have:
        <ul>
          <li><b>Name starting with</b>: ReadDTCInformation.ReportDTC</li>
          <li><b>3 Sent bytes</b>: $1902XX</li>
        </ul>
      </info>
      <info xml:lang="fr">
        ReadDTCInformation.ReportDTC ($1902XX) doit avoir :
        <ul>
          <li><b>Nom qui commence par</b> : ReadDTCInformation.ReportDTC</li>
          <li><b>3 Octets envoyés</b> : $1902XX</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE185 DDT2000_ERR_UDS_1903 -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE185</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX) is not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX) non conforme au protocole UDS</titleA>
      <name>Request <b>ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX)</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX)</b></name>
      <info>
        ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX) must have:
        <ul>
          <li><b>Name starting with</b>: ReadDTCInformation.ReportDTCSnapshotIdentification</li>
        </ul>
      </info>
      <info xml:lang="fr">
        ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX) doit avoir :
        <ul>
          <li><b>Nom qui commence par</b> : ReadDTCInformation.ReportDTCSnapshotIdentification</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE186 DDT2000_ERR_UDS_190A -->
      <chapters>
        <chapter title1="Requests" title2="ReadDTCInformation.ReportSupportedDTC ($190AXX)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE186</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Request ReadDTCInformation.ReportSupportedDTC ($190AXX) is missing or not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête ReadDTCInformation.ReportSupportedDTC ($190AXX) non définie ou  non conforme au protocole UDS</titleA>
      <name>Request <b>ReadDTCInformation.ReportSupportedDTC ($190AXX)</b></name>
      <name xml:lang="fr">Requête <b>ReadDTCInformation.ReportSupportedDTC ($190AXX)</b></name>
      <info>
        ReadDTCInformation.ReportSupportedDTC ($190AXX) must have:
        <ul>
          <li><b>Name starting with</b>: ReadDTCInformation.ReportSupportedDTC</li>
        </ul>
      </info>
      <info xml:lang="fr">
        ReadDTCInformation.ReportSupportedDTC ($190AXX) doit avoir :
        <ul>
          <li><b>Nom qui commence par</b> : ReadDTCInformation.ReportSupportedDTC</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE189 DDT2000_ERR_UDS_OutputControl_OutputPermanentControlList -->
      <chapters>
        <chapter title1="Requests" title2="OutputControl ($2F)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE189</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Data OutputPermanentControlList is not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Donnée OutputPermanentControlList non conforme au protocole UDS</titleA>
      <name>Data <b>OutputPermanentControlList</b></name>
      <name xml:lang="fr">Donnée <b>OutputPermanentControlList</b></name>
      <info>
        OutputPermanentControlList must have:
        <ul>
          <li><b>Name</b>: OutputPermanentControlList</li>
          <li><b>Length</b>: 2 Bytes</li>
          <li><b>List</b>: 1 Item (Value/Text) or more with at least 1 data name starting with each Text</li>
        </ul>
      </info>
      <info xml:lang="fr">
        OutputPermanentControlList doit avoir :
        <ul>
          <li><b>Nom</b> : OutputPermanentControlList</li>
          <li><b>Longueur</b> : 2 Octets</li>
          <li><b>Liste</b> : 1 Elément (Valeur/Libellé) ou plus et pour chaque Texte au moins 1 donnée dont le nom commence par ce Texte</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE190 DDT2000_ERR_UDS_OutputControl_OutputControlCommand -->
      <chapters>
        <chapter title1="Requests" title2="OutputControl ($2F)" />
      </chapters>
      <type>DDT2000</type>
      <code>DE190</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Data OutputControlCommand is not as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Donnée OutputControlCommand non conforme au protocole UDS</titleA>
      <name>Data <b>OutputControlCommand</b></name>
      <name xml:lang="fr">Donnée <b>OutputControlCommand</b></name>
      <info>
        OutputControlCommand must have:
        <ul>
          <li><b>Name</b>: OutputControlCommand</li>
          <li><b>Length</b>: 1 Byte</li>
          <li><b>List</b>: 2 Item (Value/Text) or more with at least 1 data name starting with each Text</li>
        </ul>
      </info>
      <info xml:lang="fr">
        OutputControlCommand doit avoir :
        <ul>
          <li><b>Nom</b> : OutputControlCommand</li>
          <li><b>Longueur</b> : 1 Octet</li>
          <li><b>Liste</b> : 2 Eléments (Valeur/Libellé) ou plus et pour chaque Texte au moins 1 donnée dont le nom commence par ce Texte</li>
        </ul>
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- DE191 DDT2000_ERR_UDS_ForbiddenRequests -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE191</code>
      <impact>I04,I05,I06</impact>
      <critic>error</critic>
      <titleA>Request: forbidden request(s) ($21 and/or $3B) as specified by UDS protocol</titleA>
      <titleA xml:lang="fr">Requête: requête(s) interdite(s) ($21 et/ou $3B) non conforme au protocole UDS</titleA>
      <name>Request : <b>forbidden request(s) ($21 and/or $3B)</b></name>
      <name xml:lang="fr">Requête : <b>requête(s) interdite(s) ($21 et/ou $3B)</b></name>
      <info>Do not use request(s)</info>
      <info xml:lang="fr">Requête(s) à ne pas utiliser</info>
      <version>V1.7</version>
    </rule>
    <rule><!-- DE193 DDT2000_ERR_UDS_Autoident -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DDT2000</type>
      <code>DE193</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>DataItem length is different from the length in the autoidentification</titleA>
      <titleA xml:lang="fr">La taille du DataItem est différente de celle dans l'autoidentification</titleA>
      <name>DataItems : <b>length is different from what is declared in autoidentification</b></name>
      <name xml:lang="fr">DataItems : <b>taille différente de ce qui est declaré dans l'autoidentification</b></name>
      <info>
        DataItems : <b>Supplier ($22F18A)</b>, <b>Soft ($22F194)</b>, <b>Version ($22F195)</b>, <b>Diag Version ($22F1A0)</b><br />
        Should have the same length as the ones in the Autoidentification
      </info>
      <info xml:lang="fr">
        Les Données : <b>Fournisseur ($22F18A)</b>, <b>Logiciel ($22F194)</b>, <b>Version ($22F195)</b>, <b>Version Diag($22F1A0)</b><br />
        Doivent avoir les mêmes tailles que celles déclarées dans l'Autoidentification</info>
      <version>V1.7</version>
    </rule>
    <rule><!-- DE194 DDT2000_ERR_DeviceNameInvalidChar_error -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE194</code>
      <impact>I02,I03</impact>
      <critic>error</critic>
      <titleA>Device: invalid(s) character(s) in the name of the device</titleA>
      <titleA xml:lang="fr">Organe : Caractère(s) invalide(s) dans le nom de l'organe</titleA>
      <name>Device name</name>
      <name xml:lang="fr">Nome de l'organe</name>
      <info>Valid characters : <b><xsl:value-of select="local:getValidChars('fr', 0)" /></b></info>
      <info xml:lang="fr">Caratères autorisés : <b><xsl:value-of select="local:getValidChars('fr', 0)" /></b></info>
      <version>V1.9</version>
    </rule>
    <rule><!-- DE195 DDT2000_ERR_DataListItemValue -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE195</code>
      <impact>I12</impact>
      <critic>error</critic>
      <titleA>
        Data: Values of the list item except limits<br />
        Low limit and High limit = function(Number of bits ,Signed)
      </titleA>
      <titleA xml:lang="fr">
        Donnée: Valeurs hors limites pour les valeurs d'une liste numérique<br />
        Limite basse et limite haute = fonction(nbre de bits, signe)
      </titleA>
      <name>Numeric list data</name>
      <name xml:lang="fr">Donnée liste numérique</name>
      <info>Authorized  values : function(number of bits ,signed)</info>
      <info xml:lang="fr">Valeurs autorisées sont fonction du nombre de bits et du signe : fonction(nombre de bits ,signe)</info>
      <version>V1.9</version>
    </rule>
    <rule><!-- DE196 DDT2000_ERR_FunctionAddressCGW -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE196</code>
      <impact>I01</impact>
      <critic>error</critic>
      <titleA>Address function: Invalid address function for central gateway ECU</titleA>
      <titleA xml:lang="fr">Adresse de la fonction : adresse invalide pour un calculateur central gateway</titleA>
      <name>Address of the function</name>
      <name xml:lang="fr">Adresse de la fonction</name>
      <info>Authorized values  for the address: <b>$D2</b> (210), <b>$D4</b> (212)</info>
      <info xml:lang="fr">Valeurs autorisées pour l'adresse : <b>$D2</b> (210), <b>$D4</b> (212)</info>
      <version>V1.10</version>
    </rule>
    <rule><!-- DE197 DDT2000_ERR_CanIdInconsistency -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE197</code>
      <impact>I01</impact>
      <critic>error</critic>
      <titleA>Inconsistency CAN identifier(s)</titleA>
      <titleA xml:lang="fr">Incohérence identifiant(s) CAN</titleA>
      <name>CAN identifiers</name>
      <name xml:lang="fr">Identifiants CAN</name>
      <info>
        On parameters tab, both Extended check boxes must have same state (checked or not checked).<br />
        The Extented check box should be set if the identifier value is greater than $7FF (2047)
      </info>
      <info xml:lang="fr">
        Dans l'onglet paramètre, les deux cases Extended doivent être dans le même état (cochée ou non cochée). <br />
        La case Extented doit être cochée si la valeur de l'identifiant est supérieure à $7FF (2047)
      </info>
      <version>V1.10</version>
    </rule>
    <rule><!-- DE198 DDT2000_ERR_DtcObdFaultType -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE198</code>
      <impact>I06</impact>
      <critic>error</critic>
      <titleA>Inconsistency 'Base DTC'/'OBD' or 'OBD Status'</titleA>
      <titleA xml:lang="fr">Incohérence 'Base DTC'/'OBD' ou 'Code OBD'</titleA>
      <name>Device</name>
      <name xml:lang="fr">Organe</name>
      <info>
        If both 'Base DTC' and 'OBD' values are defined (different from 0), values should be equal.<br />
        Only one 'OBD status' is allowed for all 'Types of fault'. it's value should be equal to 'Base DTC' and/or 'OBD' value
      </info>
      <info xml:lang="fr">
        Si les deux valeurs 'Base DTC' et 'OBD' sont définies (différente de 0), alors les valeurs doivent être égales.<br />
        Un seul 'Code OBD' est autorisé pour tous les 'Types de panne'. Sa valeur doit être égale à celle(s) définie(s) dans 'Base DTC' et/ou 'OBD'
      </info>
      <version>V1.10</version>
    </rule>
    <rule><!-- DE199 DDT2000_ERR_ProjectNotExist -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE199</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Unknown vehicle project on central vehicles projects database</titleA>
      <titleA xml:lang="fr">Projet véhicule inconnu dans la base centrale des projects véhicules</titleA>
      <name>Vehicle project</name>
      <name xml:lang="fr">Projet véhicule</name>
      <info>Vehicle project must be define on central vehicle projects database (if available)</info>
      <info xml:lang="fr">Le projet véhicule doit être défini dans la base centrale des projets véhicule (si disponible)</info>
      <version>V1.10</version>
    </rule>
    <rule><!-- DE200 DDT2000_ERR_TargetName -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE200</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Invalid character on ECU name</titleA>
      <titleA xml:lang="fr">Caractère invalide dans le nom du calculateur</titleA>
      <name>ECU name</name>
      <name xml:lang="fr">Nom du calculateur</name>
      <info>Valid characters: <b><xsl:value-of select="local:getTargetNameValidChars('en')" /></b></info>
      <info xml:lang="fr">Caratères autorisés : <b><xsl:value-of select="local:getTargetNameValidChars('fr')" /></b></info>
      <version>V1.10</version>
    </rule>
    <rule> <!-- DE201 DDT200_ERR_MissingFiles -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE201</code>
      <impact>I01, I08</impact>
      <critic>error</critic>
      <titleA>Missing file</titleA>
      <titleA xml:lang="fr">Fichier manquant</titleA>
      <name>Mandatory external files</name>
      <name xml:lang="fr">Fichiers externe requis</name>
      <info>Unable to found file on expected folders</info>
      <info xml:lang="fr">Impossible de trouver le fichier dans les dossiers prévus</info>
      <version>V1.11</version>
    </rule>
    <rule> <!-- DE202 DDT200_ERR_ForbiddenCharacter -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE202</code>
      <impact>I02</impact>
      <critic>error</critic>
      <titleA>Forbidden character</titleA>
      <titleA xml:lang="fr">Caractère interdit</titleA>
      <name>Used characters</name>
      <name xml:lang="fr">Caractères utilisés</name>
      <info>Character is not a part of Windows-1252 (Code Page 1252) character set</info>
      <info xml:lang="fr">Le caractère n'appartient pas au jeu de caractère Windows-1252 (Page de code 1252)</info>
      <version>V1.11</version>
    </rule>
    <rule> <!-- DE203 DDT200_ERR_InvalidNumericListItemText -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE203</code>
      <impact>I02</impact>
      <critic>error</critic>
      <titleA>Incorrect value description</titleA>
      <titleA xml:lang="fr">Descrition de la valeur incorrect</titleA>
      <name>Numeric list data: text associated with a value</name>
      <name xml:lang="fr">Donnée liste numérique : texte associé à une valeur</name>
      <info>
          Text associated with a value is invalid.
          <br/>
          <b>It must be neither empty nor only fill with 'space' character.</b>
          <br/>
          <b>Only diplayable ASCII character are allowed.</b>
      </info>
      <info xml:lang="fr">
          Le texte associé à la valeur est invalide :
          <br/>
          <b>Il ne doit être ni vide, ni uniquement composé du caractère 'espace'.</b>
          <br/>
          <b>Seuls les caractères ASCII affichable sont autorisés.</b>
      </info>
      <version>V1.11</version>
    </rule>
    <rule> <!-- DE204 DDT200_ERR_RoutineControlGeneric -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE204</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA><b>RoutineControl</b> generic request</titleA>
      <titleA xml:lang="fr">Requête <b>RoutineControl</b> générique</titleA>
      <name>Request: RoutineControl</name>
      <name xml:lang="fr">Requête : RoutineControl</name>
      <info>As soon as a <b>$31 service identitifier (SID) request</b> is defined, the generic <b>RoutineControl</b> request must exists</info>
      <info xml:lang="fr">Dès qu'une <b>requête ayant un identifiant de service (SID) $31</b> est définie, la requête générique <b>RoutineControl</b> doit exister</info>
      <version>V1.11</version>
    </rule>
    <rule> <!-- DE205 DDT200_ERR_RoutineControlType -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE205</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Invalid <b>RoutineControlType</b> data for generic <b>RoutineControl</b> request </titleA>
      <titleA xml:lang="fr">Donnée <b>RoutineControlType</b> invalide pour la requête générique <b>RoutineContrôle</b></titleA>
      <name>Data: RoutineControlType</name>
      <name xml:lang="fr">Donnée : RoutineControlType</name>
      <info>
        <b>routineControlType</b> information must have:
        <ul>
          <li><b>Data name</b>: RoutineControlType</li>
          <li><b>Length</b>: 8 bits</li>
          <li><b>Data type</b>: numeric list with at least 2 defined items (Value/Text)</li>
          <li><b>First byte</b>: 2</li>
          <li><b>Bit offset</b>: 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        L'information <b>routineControlType</b> doit avoir :
        <ul>
          <li><b>Nom de donnée</b> :  RoutineControlType</li>
          <li><b>Longueur</b> : 8 bits</li>
          <li><b>Type de donnée</b> : liste numerique ayant au minimum 2 éléments (Valeur/Libellé) définis</li>
          <li><b>Octet de début</b> : 2</li>
          <li><b>Décalage de bit</b> : 0</li>
        </ul>
      </info>
      <version>V1.11</version>
    </rule>
    <rule> <!-- DE206 DDT200_ERR_RoutineIdentifier -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE206</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Invalid <b>RoutineIdentifier</b> or <b><i>RoutineIdentifierList</i></b> data for generic <b>RoutineControl</b> request </titleA>
      <titleA xml:lang="fr">Donnée <b>RoutineIdentifier</b> ou <b><i>RoutineIdentifierList</i></b> invalide pour la requête générique <b>RoutineContrôle</b></titleA>
      <name>Data: RoutineIdentifier or RoutineIdentifierList</name>
      <name xml:lang="fr">Donnée : RoutineIdentifier ou RoutineIdentifierList</name>
      <info>
        <b>routineIdentifier</b> information must have:
        <ul>
          <li><b>Data name</b>: RoutineIdentifier (or RoutineIdentifierList, but RoutineIdentifier is better)</li>
          <li><b>Length</b>: 16 bits</li>
          <li><b>Data type</b>: numeric list with at least 1 defined item (Value/Text)</li>
          <li><b>First byte</b>: 2</li>
          <li><b>Bit offset</b>: 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        L'information <b>routineIdentifier</b> doit avoir :
        <ul>
          <li><b>Nom de donnée</b> :  RoutineIdentifier (ou RoutineIdentifierList, mais RoutineIdentifier est préférable)</li>
          <li><b>Longueur</b> : 16 bits</li>
          <li><b>Type de donnée</b> : liste numerique ayant au minimum 1 élément (Valeur/Libellé) défini</li>
          <li><b>Octet de début</b> : 2</li>
          <li><b>Décalage de bit</b> : 0</li>
        </ul>
      </info>
      <version>V1.11</version>
    </rule>
    <rule> <!-- DE207 DDT200_ERR_RoutineControlMissingRID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DDT2000</type>
      <code>DE207</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Routine Identifier (<b>RID</b>) is missing in the routine identifier list</titleA>
      <titleA xml:lang="fr">Un identifiant de routine (<b>RID</b>) est absent de la liste des identifiants de routine</titleA>
      <name>Request <b>RoutineControl</b>: RID is missing on RoutineIdentifier and/or <i>RoutineIdentifierList</i> data</name>
      <name xml:lang="fr">Requête <b>RoutineControl</b> : un RID n'est pas déclaré dans la donnée RoutineIdentifier et/ou la donnée <i>RoutineIdentifierList</i></name>
      <info>Each RID define on specific RoutineControl request must be declared on RoutineIdentifier and/or <i>RoutineIdentifierList</i> data</info>
      <info xml:lang="fr">Tout RID défini dans une requête RoutineControl spécifique doit être déclarer dans la donnée RoutineIdentifier et/ou la donnée <i>RoutineIdentifierList</i></info>
      <version>V1.11</version>
    </rule>

    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                           WARNINGS CPDD                           -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <rule><!-- CW001 CPDD_WAR_DataUsedInMultipleRequest -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW001</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Data used in multiple request</titleA>
      <titleA xml:lang="fr">Donnée(s) déclarée(s) dans plusieurs requêtes</titleA>
      <name>Data</name>
      <name xml:lang="fr">Donnée</name>
      <info>List all the data used in multiple requests</info>
      <info xml:lang="fr">Lister toutes les données utilisées dans plusieurs requêtes</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW002 CPDD_WAR_DataComment -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW002</code>
      <impact>I009</impact>
      <critic>warning</critic>
      <titleA>Data: Length of the description &gt;= 100 characters </titleA>
      <titleA xml:lang="fr">Donnée: Longueur de la description &gt;= 100 caractères</titleA>
      <name>Data: "Description" field</name>
      <name xml:lang="fr">Donnée : champs "Description"</name>
      <info>Maximum length of <b>100 characters</b></info>
      <info xml:lang="fr">Longueur maximal de <b>100 caractères</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- CW003 CPDD_WAR_DataItemLittleEndian -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW003</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Data: Little Endian format</titleA>
      <titleA xml:lang="fr">Donnée: format Little Endian</titleA>
      <name>
        Data<br />
        Attribute : <b>littleEndian</b></name>
      <name xml:lang="fr">
        Donnée<br />
          Attribut : <b>littleEndian</b></name>
      <info>List all the data with <b>littleEndian</b> format</info>
      <info xml:lang="fr">Lister toutes les données au format <b>littleEndian</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW004 CPDD_WAR_Data_31BitsCount -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <code>CW004</code>
      <type>CPDD</type>
      <impact>I10</impact>
      <critic>warning</critic>
      <titleA>Data: number of bits &gt;16 and != 24 and != 32</titleA>
      <titleA xml:lang="fr">Donnée: nombre de bits &gt;16 and != 24 and != 32</titleA>
      <name>
        Data<br />
        Attribute :  <b>number of bits</b></name>
      <name xml:lang="fr">
        Donnée<br />
        Attribut :  <b>nombre de bits</b></name>
      <info><b>NOT authorized</b> values : number of bits <b>&gt; 16 et !=24 et !=32</b></info>
      <info xml:lang="fr">Valeurs <b>NON autorisées</b> : nombre de bits <b>&gt; 16 et !=24 et !=32</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW005 CPDD_WAR_DataListItemValue -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW005</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>
        Data: Values of the list item except limits<br />
        Low limit and High limit = function(Number of bits ,Signed)</titleA>
      <titleA xml:lang="fr">
        Donnée: Valeurs hors limites pour les valeurs d'une liste numérique<br />
        Limite basse et limite haute = fonction(nbre de bits, signe)</titleA>
      <name>Numeric list data</name>
      <name xml:lang="fr">Donnée liste numérique</name>
      <info>Authorized  values : function(number of bits ,signed)</info>
      <info xml:lang="fr">Valeurs autorisées sont fonction du nombre de bits et du signe : fonction(nombre de bits ,signe)</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW006 CPDD_WAR_DataListItemText -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW006</code>
      <impact>I09</impact>
      <critic>warning</critic>
      <titleA>Data: length list item text &gt;50 characters</titleA>
      <titleA xml:lang="fr">Donnée: Longueur du texte dans une liste numérique &gt;50 caractères</titleA>
      <name>Numeric list data</name>
      <name xml:lang="fr">Donnée liste numérique</name>
      <info>Maximum length<b>= 50 characters</b></info>
      <info xml:lang="fr">Longueur maximum <b>= 50 caractères</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- CW007 CPDD_WAR_DataBytesAscii -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW007</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Data: Incoherence between the format ascii and the ascii indicator != 1</titleA>
      <titleA xml:lang="fr">Donnée: incohérence entre le format ascii et l'indicateur ascii != 1</titleA>
      <name>Not numerique <b>ASCII</b> Data</name>
      <name xml:lang="fr">Donnée non numérique <b>ASCII</b></name>
      <info>Check that the ascii indicator = 1 when the format of the data is ascii</info>
      <info xml:lang="fr">Vérifier que la valeur de l'indicateur <b>ASCII =1</b> quand la donnée est au format <b>ASCII</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW008 CPDD_WAR_DataBitsSigned -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW008</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Data: Incoherence between the attribute Signed and the Signed indicator != 1</titleA>
      <titleA xml:lang="fr">Donnée: incohérence entre l'attribut Signe et  l'indicateur Signed != 1</titleA>
      <name>
        Data<br />
        Attribute : <b>signed</b>
      </name>
      <name xml:lang="fr">
        Donnée<br />
        Attribut : <b>signed</b>
      </name>
      <info>Check that the signed indicator = <b>1</b> when signed data</info>
      <info xml:lang="fr">Vérifier que l'attribut signed = <b>1</b>  quand la donnée est signée.</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW020 CPDD_WAR_DeviceTestType -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW020</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Device: Type of fault missing</titleA>
      <titleA xml:lang="fr">Organe: Manque le type du défaut </titleA>
      <name>
        Device<br />
        Attribute : <b>Type</b>
      </name>
      <name xml:lang="fr">
        Organe<br />
        Attribut : <b>Type</b>
      </name>
      <info>Check if the <b>Type</b> attribute is present</info>
      <info xml:lang="fr">Vérifier l'existence de l'attribut <b>Type</b>(type de défaut)</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW021 CPDD_WAR_DeviceTestOBD -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW021</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Device: OBD indicator missing</titleA>
      <titleA xml:lang="fr">Organe: Manque l'indicateur OBD</titleA>
      <name>
        Device<br />
        Attribute : <b>OBD</b>
      </name>
      <name xml:lang="fr">
        Organe<br />
        Attribut : <b>OBD</b>
      </name>
      <info>Check if the <b>OBD</b> attribute is present</info>
      <info xml:lang="fr">Vérifier l'existence de l'attribut <b>OBD</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW023 CPDD_WAR_DeviceDTC -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CW023</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Device: DTC attribute missing</titleA>
      <titleA xml:lang="fr">Organe: Manque l'attribut DTC</titleA>
      <name>
        Device<br />
        Attribute : <b>DTC</b>
      </name>
      <name xml:lang="fr">
        Organe<br />
        Attribut : <b>DTC</b>
      </name>
      <info>Check if the <b>DTC</b> attribute is present</info>
      <info xml:lang="fr">Vérifier l'existence de l'attribut <b>DTC</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CW024 CPDD_WAR_ReplyMinBytes -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>CPDD</type>
      <code>CW024</code>
      <impact>I10, I15</impact>
      <critic>warning</critic>
      <titleA>Request: Received template (Reply byte) shorter than number of expected byte (Data length) </titleA>
      <titleA xml:lang="fr">Requête : template de reception (Octets reçus) plus court que le nombre d'octet prévus</titleA>
      <name>
        Request<br />
        Received : <b>Data length</b>
      </name>
      <name xml:lang="fr">
        Requête<br />
        Reçu : <b>Nombre d'octets</b>
      </name>
      <info>Value <b>less</b> or <b>equal</b> to template number bytes</info>
      <info xml:lang="fr">Valeur <b>inférieure</b> ou <b>égale</b> au nombre d'octet du template</info>
      <version>V1.9</version>
    </rule>
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                            ERRORS CPDD                            -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <rule><!-- CE002 CPDD_ERR_DuplicateNormalizedDataName -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CE002</code>
      <impact>I07,I10</impact>
      <critic>error</critic>
      <titleA>Data: Duplicate data name normalized with CPDD mode</titleA>
      <titleA xml:lang="fr">Donnée: Duplication du nom de la donnée (normalisé à la mode CPDD)</titleA>
      <name>Data: <b>Name normalized</b> (CPDD mode)</name>
      <name xml:lang="fr">Donnée: <b>nom normalisé</b> (mode CPDD)</name>
      <info>A normalized data name with CPDD mode must not be duplicated</info>
      <info xml:lang="fr">Un nom normalisé suivant le mode CPDD ne doit pas être dupliqué</info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CE003 CPDD_ERR_DataName -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CE003</code>
      <impact>I09</impact>
      <critic>error</critic>
      <titleA>Data: length of name (normalized with CPDD mode) &gt;255 characters</titleA>
      <titleA xml:lang="fr">Donnée: longueur du nom (normalisé à la mode CPDD) &gt;255 caractères</titleA>
      <name>Data name</name>
      <name xml:lang="fr">Nom de la donnée</name>
      <info>
        Name normalized with CPDD mode<br />
        Maximum length <b>=255 characters</b>
      </info>
      <info xml:lang="fr">
        Nom normalisé à la mode CPDD<br />
        Longueur maximum <b>=255 caractères</b>
      </info>
      <version>V1.4</version>
    </rule>
    <rule><!-- CE030 CPDD_ERR_RequestName -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CE030</code>
      <impact>I08,I09</impact>
      <critic>error</critic>
      <titleA>Request: Length of name &gt; 255 characters</titleA>
      <titleA xml:lang="fr">Requête: Longueur du nom de la requête &gt; 255 caractères</titleA>
      <name>Request name</name>
      <name xml:lang="fr">Nom de la requête</name>
      <info>Maximun length = <b>255 characters</b></info>
      <info xml:lang="fr">Longueur maximum = <b>255 caractères</b></info>
      <version>V1.1</version>
    </rule>
    <rule><!-- CE038 CPDD_ERR_IdentificationRequestName -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CE038</code>
      <impact>I09</impact>
      <critic>error</critic>
      <titleA>Request: Identification is not a specified by Renault standards</titleA>
      <titleA xml:lang="fr">Requête: L'identification n'est pas conforme à la règle métier Renault</titleA>
      <name>Request <b>DataRead.Identification.RenaultR[x]</b></name>
      <name xml:lang="fr">Requête <b>DataRead.Identification.RenaultR[x]]</b></name>
      <info>DataRead.Identification.RenaultR[x] must be of type RenaultR1 or RenaultR2 or RenaultR3 only</info>
      <info xml:lang="fr">DataRead.Identification.RenaultR[x] doit être du type RenaultR1 or RenaultR2 or RenaultR3 seulement</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- CE150 CPDD_ERR_DeviceName -->
      <chapters>
        <chapter title1="Devices" title2="General" />
      </chapters>
      <type>CPDD</type>
      <code>CE150</code>
      <impact>I09</impact>
      <critic>error</critic>
      <titleA>Device: Length of name &gt;100 characters</titleA>
      <titleA xml:lang="fr">Organe: Longueur du nom &gt;100 caractères</titleA>
      <name>Device name</name>
      <name xml:lang="fr">Nom de l'organe</name>
      <info>Maximum length <b>= 100 characters</b></info>
      <info xml:lang="fr">longueur maximun <b>= 100 caractères</b></info>
      <version>V1.4</version>
    </rule>
    <rule><!-- CE151 CPDD_ERR_ReplyMinBytes -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>CPDD</type>
      <code>CE151</code>
      <impact>I10, I15</impact>
      <critic>error</critic>
      <titleA>Request: Received template (Reply byte) shorter than number of expected byte (Data length) </titleA>
      <titleA xml:lang="fr">Requête : template de reception (Octets reçus) plus court que le nombre d'octet prévus</titleA>
      <name>
        Request<br />
        Received : <b>Data length</b>
      </name>
      <name xml:lang="fr">
        Requête<br />
        Reçu : <b>Nombre d'octets</b>
      </name>
      <info>Value <b>less</b> or <b>equal</b> to template number bytes</info>
      <info xml:lang="fr">Valeur <b>inférieure</b> ou <b>égale</b> au nombre d'octet du template</info>
      <version>V1.9</version>
    </rule>
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                         WARNINGS DAIMLER                          -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <rule><!-- MW001 DAIMLER_WAR_EmptyList -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DAIMLER</type>
      <code>MW001</code>
      <impact>I12</impact>
      <critic>warning</critic>
      <titleA>Data: empty list</titleA>
      <titleA xml:lang="fr">Donnée: liste vide</titleA>
      <name>Data: no items in the list</name>
      <name xml:lang="fr">Donnée: pas d'éléments dans la liste</name>
      <info>Data of type list should contain at least 2 items</info>
      <info xml:lang="fr">Donnée de type liste doit contenir au moins 2 éléments</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- MW011 DAIMLER_WAR_DataNameInvalidChar -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DAIMLER</type>
      <code>MW011</code>
      <impact>I02,I03</impact>
      <critic>warning</critic>
      <titleA>Invalid(s) character(s) into the name of the data</titleA>
      <titleA xml:lang="fr">Caractère(s) invalide(s) dans le nom de la donnée</titleA>
      <name>Data name</name>
      <name xml:lang="fr">Nom de la donnée</name>
      <info>
        Valid first character:  <b><xsl:value-of select="local:getValidChars('en', 1)" /></b><br />
        else other valids characters: <b><xsl:value-of select="local:getValidChars('en', 0)" /></b>
      </info>
      <info xml:lang="fr">
        1er caractère autorisé : <b><xsl:value-of select="local:getValidChars('fr', 1)" /></b><br />
        autres caractères autorisés : <b><xsl:value-of select="local:getValidChars('fr', 0)" /></b>
      </info>
      <version>V1.7</version>
    </rule>
    <rule><!-- MW012 DAIMLER_WAR_RequestNameInvalidChar -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DAIMLER</type>
      <code>MW012</code>
      <impact>I02,I03</impact>
      <critic>warning</critic>
      <titleA>Invalid(s) character(s) into the name of the request</titleA>
      <titleA xml:lang="fr">Caractère(s) invalide(s) dans le nom de la requête</titleA>
      <name>Request name</name>
      <name xml:lang="fr">Nom de la requête</name>
      <info>
        Valid first character: <b><xsl:value-of select="local:getValidChars('en', 1)" /></b><br />
        else other valids characters: <b><xsl:value-of select="local:getValidChars('en', 0)" /></b>
      </info>
      <info xml:lang="fr">
        1er caratère autorisé : <b><xsl:value-of select="local:getValidChars('fr', 1)" /></b><br />
        autres caractères autorisés : <b><xsl:value-of select="local:getValidChars('fr', 0)" /></b>
      </info>
      <version>V1.7</version>
    </rule>
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                          ERRORS DAIMLER                           -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <rule><!-- ME001 DAIMLER_ERR_SID -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME001</code>
      <impact>I12</impact>
      <critic>error</critic>
      <titleA>Request: SID of the template of the response(ReplyBytes) is wrong or missing</titleA>
      <titleA xml:lang="fr">Requête: SID du template de la réponse(Octets reçus) n'est pas documentée ou érronée</titleA>
      <name>Request : SID of the template of the response(ReplyBytes) is wrong or missing</name>
      <name xml:lang="fr">Requête : SID du template de la réponse(Octets reçus) n'est pas documentée ou érronée</name>
      <info>
        Template of the response(ReplyBytes) must start with : <br />
        <b>SID + $40</b>
      </info>
      <info xml:lang="fr">
        Template de la réponse(Octets reçus) doit commencer par : <br />
        <b>SID + $40</b></info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME002 DAIMLER_ERR_ReplyByte -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME002</code>
      <impact>I12</impact>
      <critic>error</critic>
      <titleA>Request: Byte of the template of the response(ReplyBytes) is wrong or missing</titleA>
      <titleA xml:lang="fr">Requête: Octet du template de la réponse(Octets reçus) n'est pas documentée ou erronée</titleA>
      <name>Request : Byte of the template of the response(ReplyBytes) is wrong or missing</name>
      <name xml:lang="fr">Requête : Octet du template de la réponse(Octets reçus) n'est pas documentée ou erronée</name>
      <info>
        Template of the response(ReplyBytes) must have:<br />
        Byte of the request(SentBytes) is equal to the byte of the response(ReplyBytes)
      </info>
      <info xml:lang="fr">
        Template de la réponse(Octets reçus) doit avoir :<br />
        Octet de la requête(Octets envoyés) doit être égal à l'octet de la response(Octets reçus)
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME003 DAIMLER_ERR_RequestByte -->
      <chapters>
        <chapter title1="Requests" title2="General" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME003</code>
      <impact>I12</impact>
      <critic>error</critic>
      <titleA>Request: Byte of the request(SentBytes) is missing</titleA>
      <titleA xml:lang="fr">Requête: Octet de la requête(Octets envoyés) n'est pas documenté</titleA>
      <name>Request: Byte of the request(SentBytes) is missing</name>
      <name xml:lang="fr">Requête: Octet de la requête(Octets envoyés) n'est pas documenté</name>
      <info>The specified byte should be added to the request(SentBytes)</info>
      <info xml:lang="fr">L'octet spécifié doit être ajouté à la requête(Octets envoyés)</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME004 DAIMLER_ERR_MissingAutoIdent -->
      <chapters>
        <chapter title1="Parameters" title2="Auto-identification" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME004</code>
      <impact>I12</impact>
      <critic>error</critic>
      <titleA>Auto-identification is missing</titleA>
      <titleA xml:lang="fr">L'auto-identification n'est pas documentée</titleA>
      <name>Auto-identification is missing</name>
      <name xml:lang="fr">L'auto-identification n'est pas documentée</name>
      <info>Auto-identification list should at least contain one line</info>
      <info xml:lang="fr">La liste d'auto-identification doit contenir au moins un élément</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME005 DAIMLER_ERR_WrongAutoIdent -->
      <chapters>
        <chapter title1="Parameters" title2="Auto-identification" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME005</code>
      <impact>I12</impact>
      <critic>error</critic>
      <titleA>An auto-identification element is wrong</titleA>
      <titleA xml:lang="fr">Un élément d'auto-identification est mal documenté</titleA>
      <name>Auto-identification: wrong Supplier or Soft</name>
      <name xml:lang="fr">Auto-identification: erreur dans Fournisseur ou Logiciel</name>
      <info>Supplier should not be 000 and Soft should not be 0000</info>
      <info xml:lang="fr">Fournisseur ne doit pas être 000 et Logiciel ne doit pas être 0000</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME006 DAIMLER_ERR_DataItemOutsideFrame -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME006</code>
      <impact>I03</impact>
      <critic>error</critic>
      <titleA>Request: Data outside of the frame (sent or received)</titleA>
      <titleA xml:lang="fr">Requête: donnée hors trame (envoyée ou reçue)</titleA>
      <name>Data</name>
      <name xml:lang="fr">Donnée</name>
      <info>
        The data must be included in the request (sent or received)<br />
        Check the length and the data (first byte, bit offset,...)<br />
        (Requests with variable reply length are excluded from the check, like $1906...)
      </info>
      <info xml:lang="fr">
        Les données doivent être dans la requête (envoyée ou reçue)<br />
        Vérifier la longueur et les caractéristiques des données (octet de début,décalage,..)<br />
        (exceptées les requêtes à réponse variable telles que $1906... où les dépassements sont autorisés)
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME007 DAIMLER_ERR_DataListItemValue -->
      <chapters>
        <chapter title1="Datum" title2="General" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME007</code>
      <impact>I12</impact>
      <critic>error</critic>
      <titleA>
        Data: Values of the list item except limits<br />
        Low limit and High limit = function(Number of bits ,Signed)</titleA>
      <titleA xml:lang="fr">
        Donnée: Valeurs hors limites pour les valeurs d'une liste numérique<br />
        Limite basse et limite haute = fonction(nbre de bits, signe)</titleA>
      <name>Numeric list data</name>
      <name xml:lang="fr">Donnée liste numérique</name>
      <info>Authorized  values : function(number of bits ,signed)</info>
      <info xml:lang="fr">Valeurs autorisées sont fonction du nombre de bits et du signe : fonction(nombre de bits ,signe)</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME008 DAIMLER_ERR_IdentRequest -->
      <chapters>
        <chapter title1="Requests" title2="DAIMLER" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME008</code>
      <impact>I03</impact>
      <critic>error</critic>
      <titleA>DAIMLER: identification request $21EF is missing or with wrong dataitems</titleA>
      <titleA xml:lang="fr">DAIMLER: requête d'identification $21EF absente ou avec des données erronées</titleA>
      <name>DAIMLER request <b>$21EF</b></name>
      <name xml:lang="fr">Requête DAIMLER <b>$21EF</b></name>
      <info>
        - DAIMLER identification request $21EF is mandatory<br />
        - Dataitem DAIMLER Hardware number : FirstByte should be 3<br />
        - Dataitem DAIMLER Software number : FirstByte should be 13
      </info>
      <info xml:lang="fr">
        - Requête d'identification DAIMLER $21EF est obligatoire<br />
        - Dataitem DAIMLER Hardware number : FirstByte doit être 3<br />
        - Dataitem DAIMLER Software number : FirstByte doit être 13
      </info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME009 DAIMLER_ERR_ReplyMinBytes -->
      <chapters>
        <chapter title1="Requests" title2="DAIMLER" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME009</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>DAIMLER : reply minbytes</titleA>
      <titleA xml:lang="fr">DAIMLER : réponse minbytes</titleA>
      <name>
        DAIMLER :<br />
        Request without data items and with minimum number of bytes to be received (MinBytes) not as per specification
      </name>
      <name xml:lang="fr">
        DAIMLER : <br />
        Requête sans data item et avec un nombre minimum d'octets à recevoir (MinBytes) différent de la spécification
      </name>
      <info>Number of bytes to be received (MinBytes) = <b>1 or 2 or 3</b> as per specification</info>
      <info xml:lang="fr">Le nombre minimum d'octet à recevoir (MinBytes) = <b>1 ou 2 ou 3</b> comme définit par la spécification</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME010 DAIMLER_ERR_ReplyBytes -->
      <chapters>
        <chapter title1="Requests" title2="DAIMLER" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME010</code>
      <impact>I04,I06</impact>
      <critic>error</critic>
      <titleA>DAIMLER : reply bytes</titleA>
      <titleA xml:lang="fr">DAIMLER : octets de la réponse</titleA>
      <name>
        DAIMLER :<br />
        Number of reply bytes not as per specification if no data items or with less bytes if data items defined
      </name>
      <name xml:lang="fr">
        DAIMLER : <br />
        Nombre d'octets de la réponse différent de la spécification si aucun data item ou inférieur si data items définis
      </name>
      <info>Number of reply bytes &gt;= <b>1 or 2 or 3</b> as per specification</info>
      <info xml:lang="fr">Nombre d'octets de la réponse doit être &gt;= <b>1 ou 2 ou 3</b> comme définit par la spécification</info>
      <version>V1.5</version>
    </rule>
    <rule><!-- ME013 DAIMLER_ERR_OutputControl_GenericRequest -->
      <chapters>
        <chapter title1="Requests" title2="OutputControl ($2F)" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME013</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>OutputControl Generic Request missing or wrong</titleA>
      <titleA xml:lang="fr">Requête générique OutputControl absente ou invalide</titleA>
      <name>Request : the OutputControl Generic Request ($2F for UDS or $30 for Spec B) is missing or wrong</name>
      <name xml:lang="fr">Requête : Absence de la requête générique OutputControl ($2F pour l'UDS ou $30 pour la Spec B) ou mauvaise définition</name>
      <info>
        Request name should be : <b>OutputControl</b>.<br />
        The data name containing LIDs/DIDs list should be : <b>OutputTemporaryControlList</b> (only spec B) and/or <b>OutputPermanentControlList</b>.
      </info>
      <info xml:lang="fr">
        Le nom de la requête doit être : <b>OutputControl</b>.<br />
        Le nom des données contenant la liste des LIDs/DIDs doit être : <b>OutputTemporaryControlList</b> (seulement pour la spec B) et/ou <b>OutputPermanentControlList</b>.
      </info>
      <version>V1.7</version>
    </rule>
    <rule><!-- ME014 DAIMLER_ERR_OutputControlList_MissingID -->
      <chapters>
        <chapter title1="Requests" title2="OutputControl ($2F)" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME014</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>ID missing in the Output Control List</titleA>
      <titleA xml:lang="fr">ID absent dans l'Output Control List</titleA>
      <name>Output Control : ID missing in the Output Control List ($2F for UDS or $30 for Spec B)</name>
      <name xml:lang="fr">Output Control : Absence de l'ID dans l'Output Control List ($2F pour l'UDS ou $30 pour la Spec B)</name>
      <info>
        <ul>
          <li>For UDS (request $2F) : the DID must be in the <b>Output Permanent Control List</b></li>
          <li>For Spec B (request $30) : the ID must be in the <b>Output Permanent Control List</b> or the <b>Output Temporary Control List</b></li>
        </ul>
      </info>
      <info xml:lang="fr">
        <ul>
          <li>Pour l'UDS (requête $2F) : le DID doit être dans l'<b>Output Permanent Control List</b></li>
          <li>Pour la Spec B (requête $30) : l'ID doit être dans l'<b>Output Permanent Control List</b> ou l'<b>Output Temporary Control List</b></li>
        </ul>
      </info>
      <version>V1.7</version>
    </rule>
    <rule><!-- ME015 DAIMLER_ERR_OutputPermanentControlList_Request -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME015</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Read request ($22) missing for an ID in the OutputPermanentControlList (spec UDS)</titleA>
      <titleA xml:lang="fr">Requête de lecture ($22) absente pour un ID dans l'OutputPermanentControlList (spec UDS)</titleA>
      <name>Output Control : Read request ($22) missing for an ID in the OutputPermanentControlList (spec UDS)</name>
      <name xml:lang="fr">Output Control : Requête de lecture ($22) absente pour un ID dans l'OutputPermanentControlList (spec UDS)</name>
      <info>The <b>DID</b> in the <b>OutputPermanentControlList</b> must have a <b>read request ($22)</b> defined</info>
      <info xml:lang="fr">Chaque <b>DID</b> dans la <b>OutputPermanentControlList</b> doit avoir une <b>requête de lecture ($22)</b> définie</info>
      <version>V1.8</version>
    </rule>
    <rule><!-- ME016 DAIMLER_ERR_DataName -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME016</code>
      <impact>I09</impact>
      <critic>error</critic>
      <titleA>Data: length of name &gt;127 characters</titleA>
      <titleA xml:lang="fr">Donnée: longueur du nom &gt;127 caractères</titleA>
      <name>Data name</name>
      <name xml:lang="fr">Nom de la donnée</name>
      <info>
        Name normalized<br />
        Maximum length <b>=127 characters</b>
      </info>
      <info xml:lang="fr">
        Nom normalisé<br />
        Longueur maximum <b>=127 caractères</b>
      </info>
      <version>V1.8</version>
    </rule>
    <rule><!-- ME017 DAIMLER_ERR_RequestName -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME017</code>
      <impact>I08, I09</impact>
      <critic>error</critic>
      <titleA>Request: Length of name &gt; 127 characters</titleA>
      <titleA xml:lang="fr">Requête: Longueur du nom de la requête &gt; 127 caractères</titleA>
      <name>Request name</name>
      <name xml:lang="fr">Nom de la requête</name>
      <info>Maximun length = <b>127 characters</b></info>
      <info xml:lang="fr">Longueur maximum = <b>127 caractères</b></info>
      <version>V1.8</version>
    </rule>
    <rule><!-- ME018 DAIMLER_ERR_RequestErrorSID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME018</code>
      <impact>I06,I08</impact>
      <critic>error</critic>
      <titleA>Sent service identifier (SID)</titleA>
      <titleA xml:lang="fr">Identifiant de service (SID) émis</titleA>
      <name>Sent service identifier (SID)</name>
      <name xml:lang="fr">Identifiant de service (SID) émis</name>
      <info>The request bytes are missing or first byte is not a valid diagnostic service identifier value</info>
      <info xml:lang="fr">Les octets de la requête manquant ou le 1er octet n'est pas un identifiant de service de diagnostic valide</info>
      <version>V1.10</version>
    </rule>
    <rule><!-- ME019 DAIMLER_ERR_IdentF111 -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME019</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>DAIMLER: identification request $22F111 is missing or with wrong dataitems</titleA>
      <titleA xml:lang="fr">DAIMLER: requête d'identification $22F111 absente ou avec des données erronées</titleA>
      <name>DAIMLER request <b>$22F111</b></name>
      <name xml:lang="fr">Requête DAIMLER <b>$22F111</b></name>
      <info>
        - DAIMLER identification request $22F111 is mandatory<br />
        - Dataitem DAIMLER Hardware number : FirstByte should be 4
      </info>
      <info xml:lang="fr">
        - Requête d'identification DAIMLER $22F111 est obligatoire<br />
        - Dataitem DAIMLER Hardware number : FirstByte doit être 4
      </info>
      <version>V1.10</version>
    </rule>
    <rule><!-- ME020 DAIMLER_ERR_IdentF121 -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME020</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>DAIMLER: identification request $22F121 is missing or with wrong dataitems</titleA>
      <titleA xml:lang="fr">DAIMLER: requête d'identification $22F121 absente ou avec des données erronées</titleA>
      <name>DAIMLER request <b>$22F121</b></name>
      <name xml:lang="fr">Requête DAIMLER <b>$22F121</b></name>
      <info>
        - DAIMLER identification request $22F121 is mandatory<br />
        - Dataitem DAIMLER Software number : FirstByte should be 4
    </info>
      <info xml:lang="fr">
        - Requête d'identification DAIMLER $22F121 est obligatoire<br />
        - Dataitem DAIMLER Software number : FirstByte doit être 4
    </info>
      <version>V1.10</version>
    </rule>
    <rule> <!-- ME021 DAIMLER_ERR_RoutineIdentifierMissing -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME021</code>
      <impact>I04</impact>
      <critic>error</critic>
      <titleA>Missing <b>RoutineIdentifier</b> data for generic <b>RoutineControl</b> request</titleA>
      <titleA xml:lang="fr">La donnée <b>RoutineIdentifier</b> est manquante pour la requête générique <b>RoutineContrôle</b></titleA>
      <name>Data: RoutineIdentifier</name>
      <name xml:lang="fr">Donnée : RoutineIdentifier</name>
      <info>
        <b>routineIdentifier</b> information must have:
        <ul>
          <li><b>Data name</b>: RoutineIdentifier</li>
          <li><b>Length</b>: 16 bits</li>
          <li><b>Data type</b>: numeric list with at least 1 defined item (Value/Text)</li>
          <li><b>First byte</b>: 2</li>
          <li><b>Bit offset</b>: 0</li>
        </ul>
      </info>
      <info xml:lang="fr">
        L'information <b>routineIdentifier</b> doit avoir :
        <ul>
          <li><b>Nom de donnée</b> :  RoutineIdentifier</li>
          <li><b>Longueur</b> : 16 bits</li>
          <li><b>Type de donnée</b> : liste numerique ayant au minimum 1 élément (Valeur/Libellé) défini</li>
          <li><b>Octet de début</b> : 2</li>
          <li><b>Décalage de bit</b> : 0</li>
        </ul>
      </info>
      <version>V1.11</version>
    </rule>
    <rule> <!-- ME022 DAIMLER_ERR_ByteBoundary -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME022</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Bad data position in request (Data alignment on frame - Byte boundary)</titleA>
      <titleA xml:lang="fr">Mauvaise position de la donnée dans la requête (alignement de la donnée dans la trame - Byte boundary)</titleA>
      <name>Data position in request</name>
      <name xml:lang="fr">Position de la donnée dans la requête</name>
      <info>For writing requests:
        <ul>
          <li><b>Not numeric</b> data (ASCII or BCD/HEXA) must have a bit offset to 0</li>
          <li><b>Numeric</b> or <b>Numeric List</b> data with a bit count &lt; 8 must be on only 1 byte</li>
          <li><b>Numeric</b> or <b>Numeric List</b> data with a bit count &gt;= 8 must have a bit offset to 0 and a bit count equal to 8, 16, 24 or 32</li>
        </ul>
      </info>
      <info xml:lang="fr"> Pour les requêtes d'écriture :
        <ul>
          <li>Les données <b>non numérique</b> (ASCII ou BCD-HEXA) doivent avoir un décalage de bit à 0</li>
          <li>Les données <b>numérique</b> ou <b>liste numérique</b> ayant un nombre de bit &lt; 8 doivent être sur 1 seul octet</li>
          <li>Les données <b>numérique</b> ou <b>liste numérique<b> ayant un nombre de bit &gt;= 8 doivent avoir un décalage de bit à 0 et nombre de bit égal à 8, 16, 24 ou 32</b></b></li>
        </ul>
      </info>
      <version>V1.11</version>
    </rule>

    <rule> <!-- ME023 DAIMLER_ERR_RequestOverlap -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME023</code>
      <impact>I08</impact>
      <critic>error</critic>
      <critic>error</critic>
      <titleA>Request: Overlap data on sending frame</titleA>
      <titleA xml:lang="fr">Chevauchement de donnée dans la trame d'émission</titleA>
      <name>Request: Sent bytes</name>
      <name xml:lang="fr">Requête: Octets émis</name>
      <info>At least 2 sending data overlap</info>
      <info xml:lang="fr">Au moins 2 données émisent se chevauchent</info>
      <version>V1.11</version>
    </rule>

    <rule> <!-- ME024 DAIMLER_ERR_ResponseOverlap -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>DAIMLER</type>
      <code>ME024</code>
      <impact>I08</impact>
      <critic>error</critic>
      <critic>error</critic>
      <titleA>Request: Overlap data on received frame</titleA>
      <titleA xml:lang="fr">Chevauchement de donnée dans la trame de reception</titleA>
      <name>Request: Received bytes</name>
      <name xml:lang="fr">Requête: Octets reçu</name>
      <info>At least 2 received data overlap</info>
      <info xml:lang="fr">Au moins 2 données reçuent se chevauchent</info>
      <version>V1.11</version>
    </rule>

    
    
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                         WARNINGS ALLIANCE                         -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <rule><!-- AW001 ALLIANCE_WAR_DataName -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AW001</code>
      <impact>I08</impact>
      <critic>warning</critic>
      <titleA>Length of data name (normalized) is &gt; 255 characters</titleA>
      <titleA xml:lang="fr">La longueur du nom (normalisé) est &gt; 255 caractères</titleA>
      <name>Data name</name>
      <name xml:lang="fr">Nom de la donnée</name>
      <info>The maximal length of normalized data name is <b>255 characters</b></info>
      <info xml:lang="fr">Longueur maximal du nom normalisé d'une donnée est de <b>255 caractères</b></info>
      <version>V1.8</version>
    </rule>
    <rule><!-- AW002 ALLIANCE_WAR_EndianRedefinition -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AW002</code>
      <impact>I08</impact>
      <critic>warning</critic>
      <titleA>Data: both little/big endian definition</titleA>
      <titleA xml:lang="fr">Donnée: double définition little/big endian</titleA>
      <name>Data <b>endian</b> definition on request</name>
      <name xml:lang="fr">Definition de l'<b>endian</b> de la donnée dans la requête</name>
      <info>Only one endian definition recommended</info>
      <info xml:lang="fr">Seul une définition endian est recommendée</info>
      <version>V1.9</version>
    </rule>
    <rule><!-- AW003 ALLIANCE_WAR_RequestName -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AW003</code>
      <impact>I08</impact>
      <critic>warning</critic>
      <titleA>Length of request name &gt; 255 characters</titleA>
      <titleA xml:lang="fr">La longueur du nom de la requête &gt; 255 caractères</titleA>
      <name>Request name</name>
      <name xml:lang="fr">Nom de la requête</name>
      <info>The maximun length of request name is <b>255 characters</b></info>
      <info xml:lang="fr">La longueur maximum du nom d'une requête est de <b>255 caractères</b></info>
      <version>V1.8</version>
    </rule>
    <rule><!-- AW004 ALLIANCE_WAR_DeviceName -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AW004</code>
      <impact>I08</impact>
      <critic>warning</critic>
      <titleA>Length of device name is &gt; 255 characters</titleA>
      <titleA xml:lang="fr">La longueur du nom de l'organe est &gt; 255 caractères</titleA>
      <name>Device name</name>
      <name xml:lang="fr">Nom de l'organe</name>
      <info>The maximun length of device name is <b>255 characters</b></info>
      <info xml:lang="fr">La longueur maximum du nom d'un organe est de <b>255 caractères</b></info>
      <version>V1.9</version>
    </rule>
    <rule><!-- AW005 ALLIANCE_WAR_ValueRange -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AW005</code>
      <impact>I08</impact>
      <critic>warning</critic>
      <titleA>Numeric list data value range definition inconsistency</titleA>
      <titleA xml:lang="fr">Incohérence de la définition des plages de valeur des données liste numérique</titleA>
      <name>Numeric list data: value range</name>
      <name xml:lang="fr">Données liste numérique : plage de valeur</name>
      <info>
        <ul>
          <li>Values should consecutive</li>
          <li>One and only one inverse value ('#@') is allowed by value range</li>
          <li>Avoid using dedicated sequence ('##' or '#@') for only one value</li>
          <li>Avoid using the name of the range value (text before dedicated sequence) to another single value</li>
        </ul>
      </info>
      <info xml:lang="fr">
        <ul>
          <li>Les valeurs doivent être consécutives</li>
          <li>Une et une seule valeur inverse ('#@') est autorisée par plage de valeur</li>
          <li>Eviter d'utiliser la séquence dédiée ('##' ou '#@') pour définir une valeur unique</li>
          <li>Eviter d'utiliser le nom de la plage de valeur (le texte précédente la séquence dédiée) pour une autre valeur unique</li>
        </ul>
      </info>
      <version>V1.10</version>
    </rule>
    <rule> <!-- AW006 ALLIANCE_WAR_BackupFileUsed -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AW006</code>
      <impact>I08</impact>
      <critic>warning</critic>
      <titleA>Use of unofficial file</titleA>
      <titleA xml:lang="fr">Utilisation d'un fichier non officiel</titleA>
      <name>Mandatory files</name>
      <name xml:lang="fr">Fichiers requis</name>
      <info>The mandatory file is not available on official folder. Use a default file.</info>
      <info xml:lang="fr">Impossible de trouver le fichier requis dans le dossier officiel. Utilisation d'un fichier par défaut.</info>
      <version>V1.11</version>
    </rule>
    <rule><!-- AW007 ALLIANCE_WAR_NotNumericDataItemLittleEndian -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AW007</code>
      <impact>I04,I08</impact>
      <critic>warning</critic>
      <titleA>"Little Endian" format on not numeric data (ASCII or BCD/HEXA)</titleA>
      <titleA xml:lang="fr">Format "Little Endian" sur une donnée non numérique (ASCII ou BCD/HEXA)</titleA>
      <name>Not numeric data with <b>Little Endian</b> format</name>
      <name xml:lang="fr">Donnée non numérique avec le format<b>Little Endian</b></name>
      <info><b>Little Endian</b> format is forbidden for the <b>not numeric</b> data (ASCII or BCD/HEXA)</info>
      <info xml:lang="fr">Le format <b>Little Endian</b> est interdit sur les données <b>non numérique</b> (ASCII ou BCD/HEXA)</info>
      <version>V1.11</version>
    </rule>
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                          ERRORS ALLIANCE                          -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <rule><!-- AE001 ALLIANCE_ERR_RequestErrorSID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE001</code>
      <impact>I06,I08</impact>
      <critic>error</critic>
      <titleA>Sent service identifier (SID)</titleA>
      <titleA xml:lang="fr">Identifiant de service (SID) émis</titleA>
      <name>Sent service identifier (SID)</name>
      <name xml:lang="fr">Identifiant de service (SID) émis</name>
      <info>The request bytes are missing or first byte is not a valid diagnostic service identifier value</info>
      <info xml:lang="fr">Les octets de la requête manquant ou le 1er octet n'est pas un identifiant de service de diagnostic valide</info>
      <version>V1.8</version>
    </rule>
    <rule><!-- AE002 ALLIANCE_ERR_ResponseErrorSID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE002</code>
      <impact>I06,I08</impact>
      <critic>error</critic>
      <titleA>Received service identifier (SID)</titleA>
      <titleA xml:lang="fr">Identifiant de service (SID) reçu</titleA>
      <name>Received service identifier (SID)</name>
      <name xml:lang="fr">Identifiant de service (SID) reçu</name>
      <info>The response bytes are missing or first byte is not equal to the diagnostic service identifier value + $40</info>
      <info xml:lang="fr">Les octet de la réponse sont absent ou le 1er octet est différent de la valeur de l'identifiant du service de diagnostic + $40</info>
      <version>V1.8</version>
    </rule>
    <rule><!-- AE003 ALLIANCE_ERR_RequestErrorDID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE003</code>
      <impact>I06,I08</impact>
      <critic>error</critic>
      <titleA>DID sending</titleA>
      <titleA xml:lang="fr">Emission du DID </titleA>
      <name>DID sending</name>
      <name xml:lang="fr">Emission du DID</name>
      <info>Diagnostic service identifier (Sent first byte) is 0x22 or 0x2E or 0x2F and less than 3 bytes are defined</info>
      <info xml:lang="fr">L'identifiant du service de diagnostic (1er octet émis) est 0x22 ou 0x2E ou 0x2F et moins de 3 octets sont définis</info>
      <version>V1.8</version>
    </rule>
    <rule><!-- AE004 ALLIANCE_ERR_ResponseErrorDID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE004</code>
      <impact>I06,I08</impact>
      <critic>error</critic>
      <titleA>DID receiving</titleA>
      <titleA xml:lang="fr">Réception du DID</titleA>
      <name>DID receiving</name>
      <name xml:lang="fr">Réception du DID</name>
      <info>Diagnostic service identifier (Received first byte) is 0x62 or 0x6E or 0x6F and less than 3 bytes are defined or value differs from sending value</info>
      <info xml:lang="fr">L'identifiant du service de diagnostic (1er octet reçu) est 0x62 ou 0x6E ou 0x6F et moins de 3 octets sont définis ou la valeur diffère de celle émise</info>
      <version>V1.8</version>
    </rule>
    <rule><!-- AE005 ALLIANCE_ERR_RequestErrorLID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE005</code>
      <impact>I06,I08</impact>
      <critic>error</critic>
      <titleA>LID sending</titleA>
      <titleA xml:lang="fr">Emission du LID</titleA>
      <name>LID sending</name>
      <name xml:lang="fr">Emission du LID</name>
      <info>Diagnostic service identifier (Sent first byte) is 0x21 or 0x3B or 0x30 and less than 2 bytes are defined</info>
      <info xml:lang="fr">L'identifiant du service de diagnostic (1er octet émis) est 0x21 ou 0x3B ou 0x30 et moins de 2 octets sont définis</info>
      <version>V1.8</version>
    </rule>
    <rule><!-- AE006 ALLIANCE_ERR_ResponseErrorLID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE006</code>
      <impact>I06,I08</impact>
      <critic>error</critic>
      <titleA>LID receiving</titleA>
      <titleA xml:lang="fr">Réception du LID</titleA>
      <name>LID receiving</name>
      <name xml:lang="fr">Réception du LID</name>
      <info>Diagnostic service identifier (Received first byte) is 0x61 or 0x7B or 0x70 and less than 2 bytes are defined or value differs from sending value</info>
      <info xml:lang="fr">L'identifiant du service de diagnostic (1er octet reçus) est 0x61 ou 0x7B ou 0x70 et moins de 2 octets sont définis ou la valeur diffère de celle émise</info>
      <version>V1.8</version>
    </rule>
    <rule><!-- AE007 ALLIANCE_ERR_RequestErrorDataItemDID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE007</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Wrong data on DID position (sending)</titleA>
      <titleA xml:lang="fr">Données incorrectes positionnées sur le DID (émission)</titleA>
      <name>Wrong data on DID position (sending)</name>
      <name xml:lang="fr">Données incorrectes positionnées sur le DID (émission)</name>
      <info>Invalid data size or position on DID location</info>
      <info xml:lang="fr">Position ou taille de la donnée incorrect sur l'emplacement du DID</info>
      <version>V1.9</version>
    </rule>
    <rule><!-- AE008 ALLIANCE_ERR_ResponseErrorDataItemDID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE008</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Wrong data on DID position (receiving)</titleA>
      <titleA xml:lang="fr">Données incorrectes positionnées sur le DID (réception)</titleA>
      <name>Wrong data on DID position (receiving)</name>
      <name xml:lang="fr">Données incorrectes positionnées sur le DID (réception)</name>
      <info>Invalid data size or position on DID location</info>
      <info xml:lang="fr">Position ou taille de la donnée incorrect sur l'emplacement du DID</info>
      <version>V1.9</version>
    </rule>
    <rule><!-- AE009 ALLIANCE_ERR_RequestErrorDataItemLID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE009</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Wrong data on LID position (sending)</titleA>
      <titleA xml:lang="fr">Données incorrectes positionnées sur le LID (émission)</titleA>
      <name>Wrong data on LID position (sending)</name>
      <name xml:lang="fr">Données incorrectes positionnées sur le LID (émission)</name>
      <info>Invalid data size or position on LID location</info>
      <info xml:lang="fr">Position ou taille de la donnée incorrect sur l'emplacement du LID</info>
      <version>V1.9</version>
    </rule>
    <rule><!-- AE010 ALLIANCE_ERR_ResponseErrorDataItemLID -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE010</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Wrong data on LID position (receiving)</titleA>
      <titleA xml:lang="fr">Données incorrectes positionnées sur le LID (réception)</titleA>
      <name>Wrong data on LID position (receiving)</name>
      <name xml:lang="fr">Données incorrectes positionnées sur le LID (réception)</name>
      <info>Invalid data size or position on LID location</info>
      <info xml:lang="fr">Position ou taille de la donnée incorrect sur l'emplacement du LID</info>
      <version>V1.9</version>
    </rule>
    <rule><!-- AE011 ALLIANCE_ERR_RequestOverlap -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE011</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Request: Overlap data on sending frame</titleA>
      <titleA xml:lang="fr">Chevauchement de donnée dans la trame d'émission</titleA>
      <name>Request: Sent bytes</name>
      <name xml:lang="fr">Requête: Octets émis</name>
      <info>At least 2 sending data overlap</info>
      <info xml:lang="fr">Au moins 2 données émisent se chevauchent</info>
      <version>V1.9</version>
    </rule>
    <!-- <rule> AE012 ALLIANCE_ERR_NotNumericDataItemLittleEndian REMOVE V1.11 (Replace by AW007)
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE012</code>
      <impact>I04,I08</impact>
      <critic>error</critic>
      <titleA>"Little Endian" format on not numeric data (ASCII or BCD/HEXA)</titleA>
      <titleA xml:lang="fr">Format "Little Endian" sur une donnée non numérique (ASCII ou BCD/HEXA)</titleA>
      <name>Not numeric data with <b>Little Endian</b> format</name>
      <name xml:lang="fr">Donnée non numérique avec le format<b>Little Endian</b></name>
      <info><b>Little Endian</b> format is forbidden for the <b>not numeric</b> data (ASCII or BCD/HEXA)</info>
      <info xml:lang="fr">Le format <b>Little Endian</b> est interdit sur les données <b>non numérique</b> (ASCII ou BCD/HEXA)</info>
      <version>V1.9</version>
    </rule> -->
    <rule><!-- AE013 ALLIANCE_ERR_EmptyList -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE013</code>
      <impact>I04,I08</impact>
      <critic>error</critic>
      <titleA>Numeric list data without any item</titleA>
      <titleA xml:lang="fr">Donnée liste numérique sans aucun élément</titleA>
      <name>Numeric list data</name>
      <name xml:lang="fr">Donnée liste numérique</name>
      <info>Numeric list data should contain at least 1 item</info>
      <info xml:lang="fr">Les données liste numérique doivent contenir au moins 1 élément</info>
      <version>V1.9</version>
    </rule>
    <rule><!-- AE014 ALLIANCE_ERR_DataListItemValue -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE014</code>
      <impact>I04,I08</impact>
      <critic>error</critic>
      <titleA>Values of the list item except limits</titleA>
      <titleA xml:lang="fr">Valeurs hors limites</titleA>
      <name>Numeric list data</name>
      <name xml:lang="fr">Donnée liste numérique</name>
      <info>Authorized  values depend of bit number and sign: function(number of bits ,signed)</info>
      <info xml:lang="fr">Les valeurs autorisées dépendent du nombre de bits et du signe : fonction(nombre de bits ,signe)</info>
      <version>V1.9</version>
    </rule>
    <rule><!-- AE015 ALLIANCE_ERR_DataUnit -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE015</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Unknown data unit</titleA>
      <titleA xml:lang="fr">Unité de la donnée inconue</titleA>
      <name>Data unit information</name>
      <name xml:lang="fr">Donnée information unité</name>
      <info>Authorized  values : value on normalized unit list</info>
      <info xml:lang="fr">Valeurs autorisées : Liste des unités normalisées</info>
      <version>V1.10</version>
    </rule>
    <rule><!-- AE016 ALLIANCE_ERR_RequestTooLong -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE016</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Sending frame error</titleA>
      <titleA xml:lang="fr">Erreur dans la trame d'émission</titleA>
      <name>Data read requests (Send)</name>
      <name xml:lang="fr">Requêtes de lecture de donnée (Envoi)</name>
      <info>Sending frame is too long or there are not allowed data positions</info>
      <info xml:lang="fr">La trame d'émission est trop longue ou il y a des données à des positions non autorisées</info>
      <version>V1.11</version>
    </rule>
    <rule><!-- AE017 ALLIANCE_ERR_ByteBoundary -->
      <chapters>
        <chapter title1="" title2="" />
      </chapters>
      <type>ALLIANCE</type>
      <code>AE017</code>
      <impact>I08</impact>
      <critic>error</critic>
      <titleA>Bad data position in request</titleA>
      <titleA xml:lang="fr">Mauvaise position de la donnée dans la requête</titleA>
      <name>Data position in request</name>
      <name xml:lang="fr">Position de la donnée dans la requête</name>
      <info>For writing requests, <b>not numeric</b> data (ASCII or BCD/HEXA) must have a bit offset to 0</info>
      <info xml:lang="fr"> Pour les requêtes d'écriture, les données <b>non numérique</b> (ASCII ou BCD-HEXA) doivent avoir un décalage de bit à 0</info>
      <version>V1.11</version>
    </rule>
  </xsl:template>
</xsl:stylesheet>
