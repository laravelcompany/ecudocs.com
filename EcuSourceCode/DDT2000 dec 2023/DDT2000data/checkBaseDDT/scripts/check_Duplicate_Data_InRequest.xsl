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
     Check used Data in a request only
     ****************************************************************************************** -->
  <xsl:template name="DuplicateDataInRequest">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Duplicate_Data_InRequest.xsl: template DuplicateDataInRequest starts')"/></logmsg>

  <!-- ************************************************************************************
       on traite chaque DataItem (Sent) de la base, donc on balaye toutes les requêtes
       qui ont au moins un DataItem en émission.
     (<xsl:for-each select="ddt:Requests/ddt:Request/ddt:Sent/ddt:DataItem">)
         Pour chaque itération, on mémorise
          Le nom du DataItem : $mSentDataItemName
          Le nom de la requête : $mRequestName

         Quand on trouve un nombre de Received/DataItem > 1
       (<xsl:if test="count(key('allSentDataItem',$mSentDataItemName))&gt;1">)

         on vérifie si les données de l'itération en cours, cad la requête et le DataItem, traitées
         dans l'itération sont en défauts :
          (<xsl:if test="count(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName]/ddt:Sent/ddt:DataItem[@Name=$mSentDataItemName])&gt;1">)

       ************************************************************************************  -->

    <xsl:for-each select="ddt:Requests/ddt:Request/ddt:Sent/ddt:DataItem">

      <xsl:variable name="mSentDataItemName" select="@Name"></xsl:variable>
      <xsl:variable name="mRequestName" select="../../@Name"></xsl:variable>
      <xsl:variable name="mRequestSentBytes" select="../../ddt:Sent/ddt:SentBytes"></xsl:variable>
      <xsl:variable name="mDossierMaintenabilite">
        <xsl:choose>
          <xsl:when test="../../ddt:DossierMaintenabilite">
            YES
          </xsl:when>
          <xsl:otherwise>
            NO
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <!-- ***debug***
      <h2>*** Sent/DataItem ***</h2>
      <h2>***mSentDataItemName: <xsl:value-of select="$mSentDataItemName"></xsl:value-of></h2>
      <h2>***mRequestName: <xsl:value-of select="$mRequestName"></xsl:value-of></h2>
      <h2>***counter: <xsl:value-of select="count(key('allSentDataItem',$mSentDataItemName))"></xsl:value-of></h2>
      -->
      <xsl:if test="count(key('allSentDataItem',$mSentDataItemName))&gt;1">
          <xsl:if test="count(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName]/ddt:Sent/ddt:DataItem[@Name=$mSentDataItemName])&gt;1">
            <!-- ***debug***
            <h3>       </h3>
            <h3>*****counter: <xsl:value-of select="count(../ddt:DataItem[@Name=$mSentDataItemName])"></xsl:value-of></h3>
            <h3>*****mSentDataItemName: <xsl:value-of select="$mSentDataItemName"></xsl:value-of></h3>
            <h3>*****mRequestName: <xsl:value-of select="$mRequestName"></xsl:value-of></h3>
            -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_DuplicateSentDataItemInRequest</xsl:with-param>
              <xsl:with-param name="description">Duplicate Sent DataItem:<br/>
              <b><xsl:value-of select="$mSentDataItemName" /></b><br/>
              (FirstByte:<xsl:value-of select="@FirstByte" />)</xsl:with-param>
              <xsl:with-param name="info">Request:<br/>
              <b><xsl:value-of select="../../@Name" /></b></xsl:with-param>
              <xsl:with-param name="action">Check the Request and the Sent DataItem</xsl:with-param>
            </xsl:call-template>

            <!-- ***************************************** -->
            <!-- erreur déjà traitée par DDT voi ci-dessus -->
            <!-- ***************************************** -->
            <!--
            <xsl:call-template name="error">
              <xsl:with-param name="type">CPDD</xsl:with-param>
              <xsl:with-param name="chapter">CPDD_DuplicateSentDataItemInRequest</xsl:with-param>
              <xsl:with-param name="description">Duplicate Sent DataItem:<br/>
              <b><xsl:value-of select="$mSentDataItemName" /></b><br/>
              (FirstByte:<xsl:value-of select="@FirstByte" />)</xsl:with-param>
              <xsl:with-param name="info">Request:<br/>
              <b><xsl:value-of select="../../@Name" /></b></xsl:with-param>
              <xsl:with-param name="action">Check the Request and the Sent DataItem</xsl:with-param>
            </xsl:call-template>
            -->
          </xsl:if>
            <!-- ***************************************** -->
            <!-- erreur  Tradconf: pour les service d'ecriture  $2E et $3B
              si une donnée est dans plusieurs requêtes, il n'existe
              qu'une seule de ces requêtes qui est déclarée en dossier
              de maintenabilité, si aucune erreur, si plusieurs erreur -->
            <!-- *****************************************
          <xsl:if test="(
                (substring($mRequestSentBytes,1,2) = '2E'
                 or
                 substring($mRequestSentBytes,1,2) = '3B')
                and
                ((count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent[starts-with(ddt:SentBytes,'2E')]/ddt:DataItem[@Name=$mSentDataItemName])+
                count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent[starts-with(ddt:SentBytes,'3B')]/ddt:DataItem[@Name=$mSentDataItemName]))&gt;1
                or
                (count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent[starts-with(ddt:SentBytes,'2E')]/ddt:DataItem[@Name=$mSentDataItemName])+
                count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent[starts-with(ddt:SentBytes,'3B')]/ddt:DataItem[@Name=$mSentDataItemName]))=0)
                )
            ">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_DuplicateSentDataItemInRequestsWithMaintenabilityReport</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataItemInRequestsWithMaintenabilityReport"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>:<br/>
                <b><xsl:value-of select="$mSentDataItemName" /></b><br/>
                (FirstByte:<xsl:value-of select="@FirstByte" />)</xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <br/>
                  <b><xsl:value-of select="../../@Name" /></b><br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desMaintainabilityReport"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <b><xsl:value-of select="$mDossierMaintenabilite" /></b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actiondataItemInRequestsWithMaintenabilityReport"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
          </xsl:if>
          -->
      </xsl:if>
    </xsl:for-each>

  <!-- ************************************************************************************
       on traite chaque DataItem (Received) de la base, donc on balaye toutes les requêtes
       qui ont au moins un DataItem en réception.
       (<xsl:for-each select="ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem">)
         Pour chaque itération, on mémorise
          Le nom du DataItem : $mReceivedDataItemName
          Le nom de la requête : $mRequestName

         Quand on trouve un nombre de Received/DataItem > 1 :
         (<xsl:if test="count(key('allReceivedDataItem',$mReceivedDataItemName))&gt;1">)

         on vérifie si les données de l'itération en cours, cad la requête et le DataItem, traitées
         dans l'itération sont en défauts :
          (<xsl:if test="count(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName]/ddt:Received/ddt:DataItem[@Name=$mReceivedDataItemName])&gt;1">)

       ************************************************************************************  -->
    <xsl:for-each select="ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem">

      <xsl:variable name="mReceivedDataItemName" select="@Name"></xsl:variable>
      <xsl:variable name="mRequestName" select="../../@Name"></xsl:variable>
      <xsl:variable name="mRequestSentBytes" select="../../ddt:Sent/ddt:SentBytes"></xsl:variable>
      <xsl:variable name="mDossierMaintenabilite">
        <xsl:choose>
          <xsl:when test="../../ddt:DossierMaintenabilite">
            YES
          </xsl:when>
          <xsl:otherwise>
            NO
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <!-- ***debug***
      <h4>++++ Received/DataItem ++++</h4>
      <h4>++++mReceivedDataItemName: <xsl:value-of select="$mReceivedDataItemName"></xsl:value-of></h4>
      <h4>++++FirstByte: <xsl:value-of select="@FirstByte"></xsl:value-of></h4>
      <h4>++++mRequestName: <xsl:value-of select="$mRequestName"></xsl:value-of></h4>
      <h4>++++counter: <xsl:value-of select="count(key('allReceivedDataItem',$mReceivedDataItemName))"></xsl:value-of></h4>
      -->
      <xsl:if test="count(key('allReceivedDataItem',$mReceivedDataItemName))&gt;1">

          <xsl:if test="count(//ddt:Target/ddt:Requests/ddt:Request[@Name=$mRequestName]/ddt:Received/ddt:DataItem[@Name=$mReceivedDataItemName])&gt;1">
            <!-- ***debug***
            <h5>=============</h5>
            <h5>++Request: <xsl:value-of select="../../@Name" /></h5>
            <h5>++counter: <xsl:value-of select="count(../ddt:DataItem[@Name=$mReceivedDataItemName])"></xsl:value-of></h5>
            <h5>++mReceivedDataItemName: <xsl:value-of select="$mReceivedDataItemName"></xsl:value-of></h5>
            <h5>++mRequestName: <xsl:value-of select="$mRequestName"></xsl:value-of></h5>
            -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_ERR_DuplicateReceivedDataInRequest</xsl:with-param>
              <xsl:with-param name="description">Duplicate Received DataItem:<br/>
              <b><xsl:value-of select="$mReceivedDataItemName" /></b><br/>
              (FirstByte:<xsl:value-of select="@FirstByte" />)</xsl:with-param>
              <xsl:with-param name="info">Request:<br/>
              <b><xsl:value-of select="../../@Name" /></b></xsl:with-param>
              <xsl:with-param name="action">Check the Request and the Received DataItem</xsl:with-param>
            </xsl:call-template>

            <!-- ***************************************** -->
            <!-- erreur déjà traitée par DDT voi ci-dessus -->
            <!-- ***************************************** -->
            <!--
            <xsl:call-template name="error">
              <xsl:with-param name="type">CPDD</xsl:with-param>
              <xsl:with-param name="chapter">CPDD_DuplicateReceivedDataInRequest</xsl:with-param>
              <xsl:with-param name="description">Duplicate Received DataItem:<br/>
              <b><xsl:value-of select="$mReceivedDataItemName" /></b><br/>
              (FirstByte:<xsl:value-of select="@FirstByte" />)</xsl:with-param>
              <xsl:with-param name="info">Request:<br/>
              <b><xsl:value-of select="../../@Name" /></b></xsl:with-param>
              <xsl:with-param name="action">Check the Request and the Received DataItem</xsl:with-param>
            </xsl:call-template>
            -->
          </xsl:if>
            <!-- ***************************************** -->
            <!-- erreur  Tradconf: pour les service de lecture $21, $22
              si une donnée est dans plusieurs requêtes, il n'existe
              qu'une seule de ces requêtes qui est déclarée en dossier
              de maintenabilité, si aucune erreur, si plusieurs erreur -->
            <!-- ***************************************** -->
          <!--
        <xsl:if test="(
                (substring($mRequestSentBytes,1,2) = '21'
                or
                substring($mRequestSentBytes,1,2) = '22')
                and
                (
                (count(//ddt:Target/ddt:Requests/ddt:Request[(ddt:DossierMaintenabilite) and (ddt:Sent[starts-with(ddt:SentBytes,'21')])]/ddt:Received/ddt:DataItem[@Name=$mReceivedDataItemName])+
                count(//ddt:Target/ddt:Requests/ddt:Request[(ddt:DossierMaintenabilite) and (ddt:Sent[starts-with(ddt:SentBytes,'22')])]/ddt:Received/ddt:DataItem[@Name=$mReceivedDataItemName]))&gt;1
                or
                (count(//ddt:Target/ddt:Requests/ddt:Request[(ddt:DossierMaintenabilite) and (ddt:Sent[starts-with(ddt:SentBytes,'21')])]/ddt:Received/ddt:DataItem[@Name=$mReceivedDataItemName])+
                count(//ddt:Target/ddt:Requests/ddt:Request[(ddt:DossierMaintenabilite) and (ddt:Sent[starts-with(ddt:SentBytes,'22')])]/ddt:Received/ddt:DataItem[@Name=$mReceivedDataItemName]))=0
                )
              )
          ">
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT2000_DuplicateReceivedDataItemInRequestsWithMaintenabilityReport</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataItemInRequestsWithMaintenabilityReport"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>:<br/>
              <b><xsl:value-of select="$mReceivedDataItemName" /></b><br/>
              (FirstByte:<xsl:value-of select="@FirstByte" />)</xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <br/>
                <b><xsl:value-of select="../../@Name" /></b><br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desMaintainabilityReport"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="$mDossierMaintenabilite" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actiondataItemInRequestsWithMaintenabilityReport"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        -->
      </xsl:if>
    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Duplicate_Data_InRequest.xsl: template DuplicateDataInRequest ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
