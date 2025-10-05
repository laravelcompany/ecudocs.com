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

<!-- ******************************************************************************************
     Check Duplicate Request :
       Check data  : SentBytes
       Check data : RequestName

       Remarque : Utilisation de la fonction position() pour différencier les éléments traités
     ****************************************************************************************** -->
  <xsl:template name="DuplicateRequest">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Duplicate_Request.xsl: template DuplicateRequest starts')"/></logmsg>

    <!-- boucle n°1 -->
    <xsl:for-each select = "ddt:Requests/ddt:Request/ddt:Sent/ddt:SentBytes">

      <!-- Définition des variables -->
      <xsl:variable name="mSentBytes" select="../ddt:SentBytes"></xsl:variable>
      <xsl:variable name="mRequestName" select="../../@Name"></xsl:variable>
      <!-- position du noeud sélectionné -->
      <xsl:variable name="mposition"  select="position()"></xsl:variable>
      <xsl:variable name="mDossierMaintenabilite_1">
        <xsl:choose>
          <xsl:when test="../../ddt:DossierMaintenabilite">
            YES
          </xsl:when>
          <xsl:otherwise>
            NO
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
  <!--
      <xsl:if test="count(key('allRequestSentBytes',$mSentBytes))&gt;1">
        <xsl:call-template name="error">
          <xsl:with-param name="type">CPDD</xsl:with-param>
          <xsl:with-param name="chapter">CPDD_DuplicateRequestSentByteOnly</xsl:with-param>
          <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <br/>
              <b><xsl:value-of select="../../@Name" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <pre><b>$<xsl:value-of select="local:WriteMultiLineEx(string($mSentBytes),32)" /></b></pre><br/>
                  <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desMaintainabilityReport"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mDossierMaintenabilite_1" /></b>
           </xsl:with-param>
          <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/duplicate"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
                  <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="count(key('allRequestSentBytes',$mSentBytes))" /></b>
                  <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/time"></xsl:with-param>
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
  -->
      <!-- *********************************************************************************
             Existence de plusieur rêquetes d'identification 2180
             Si plusieurs requêtes existent alors erreur
             ********************************************************************************* -->
      <xsl:if test="($mSentBytes = '2180') and (count(key('allRequestSentBytes',$mSentBytes))&gt;1)">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport</xsl:with-param>
          <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <br/>
              <b><xsl:value-of select="../../@Name" /></b><br/>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <pre><b>$<xsl:value-of select="local:WriteMultiLineEx(string($mSentBytes),32)" /></b></pre><br/>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desMaintainabilityReport"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mDossierMaintenabilite_1" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/duplicate"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="count(key('allRequestSentBytes',$mSentBytes))" /></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/time"></xsl:with-param>
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


      <xsl:if test="count(key('allRequestSentBytesWithMaintenabilityReport',$mSentBytes))&gt;1">
          <!--
          <h98><pre>SentBytes: <b>$<xsl:value-of select="local:WriteMultiLineEx(string($mSentBytes),32)" /></b></pre> </h98>
          <h98>Request: <b><xsl:value-of select="../../@Name" /></b></h98>
          <h98>count: <b><xsl:value-of select="count(key('allRequestSentBytes',$mSentBytes))" /></b> duplicate SentBytes</h98>
          <h98>maintenabilityReport: <xsl:value-of select="$mDossierMaintenabilite_1"></xsl:value-of></h98>
          <h98>Count maintenabilityReport: <xsl:value-of select="count(key('allRequestSentBytesWithMaintenabilityReport',$mSentBytes))"></xsl:value-of></h98>
          -->
          <xsl:if test="(../../ddt:DossierMaintenabilite)">
            <!-- pas d'erreur de duplication de sentBytes pour les requettes 30xxx pour les specB-->
            <xsl:if test="not(//ddt:Target/ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportDTC'] and substring($mSentBytes,1,2) = '30')">
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_DuplicateRequestSentByteOnlyWithMaintainabilityReport</xsl:with-param>
                <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <br/>
                    <b><xsl:value-of select="../../@Name" /></b><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> :  <pre><b>$<xsl:value-of select="local:WriteMultiLineEx(string($mSentBytes),32)" /></b></pre><br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desMaintainabilityReport"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b><xsl:value-of select="$mDossierMaintenabilite_1" /></b>
                 </xsl:with-param>
                <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/duplicate"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytesWithMaintenabilityReport"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b><xsl:value-of select="count(key('allRequestSentBytesWithMaintenabilityReport',$mSentBytes))" /></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/time"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <ul>
                    <li>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </li>
                    <li>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionOnlyOneMaintenabilityReport" />
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </li>
                  </ul>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:if>
      </xsl:if>

    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Duplicate_Request.xsl: template DuplicateRequest ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
