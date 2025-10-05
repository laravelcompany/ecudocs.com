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
     Check Duplicate Request :

       Remarque : Utilisation de la fonction position() pour différencier les éléments traités
     ****************************************************************************************** -->
  <xsl:template name="DuplicateData">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Duplicate_Data.xsl: template DuplicateData starts')"/></logmsg>

    <!-- boucle n°1 -->
    <!--xsl:for-each select = "ddt:Datas/ddt:Data"-->

      <!-- Définition des variables -->
      <xsl:variable name="mDataName1" select="@Name"></xsl:variable>
      <xsl:variable name="mMnemonic1" select="ddt:Mnemonic"></xsl:variable>
      <xsl:variable name="mDataName1Normalized" select="local:NormalizeName(string($mDataName1))"></xsl:variable>
      <!--<xsl:variable name="mDataName1Normalized" select="key('allDataNameNormalized',$mDataName1)"></xsl:variable>-->
      <!-- position du noeud sélectionné -->
      <xsl:variable name="mposition"  select="position()"></xsl:variable>


      <!-- boucle n°2 -->
      <!--
      <xsl:for-each select = "//ddt:Target/ddt:Datas/ddt:Data">
        <xsl:variable name="mDataName2" select="@Name"></xsl:variable>
        <xsl:variable name="mMnemonic2" select="ddt:Mnemonic"></xsl:variable>
        <xsl:if test="position() &gt; $mposition">
          <xsl:if test="local:isSameNormalizedName(string($mDataName1), string(@Name)) = 1">
            <xsl:call-template name="error">
              <xsl:with-param name="type">CPDD</xsl:with-param>
              <xsl:with-param name="chapter">CPDD_ERR_DuplicateNormalizedDataName</xsl:with-param>
              <xsl:with-param name="description">Duplicate normalized data name<br/>
              Dataname: <b><xsl:value-of select="$mDataName1" /></b><br/>
              Normalized name: <xsl:value-of select="local:NormalizeName(string($mDataName1))" />
              </xsl:with-param>
              <xsl:with-param name="info">Other data with same normalized data name:<br/>
              <b><xsl:value-of select="@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">Change the data name</xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
      </xsl:for-each>
      -->
      <!--
      <xsl:if test="count(key('allDataNameNormalized',$mDataName1Normalized))&gt;1">
        <xsl:for-each select = "key('allDataNameNormalized',$mDataName1Normalized)">
            <xsl:call-template name="error">
              <xsl:with-param name="type">CPDD</xsl:with-param>
              <xsl:with-param name="chapter">CPDD_ERR_DuplicateNormalizedDataName</xsl:with-param>
              <xsl:with-param name="description">Duplicate normalized data name<br/>
              Dataname: <b><xsl:value-of select="$mDataName1" /></b><br/>
              Normalized name: <xsl:value-of select="$mDataName1Normalized" />
              </xsl:with-param>

              <xsl:with-param name="info">Other data with same normalized data name:<br/>
              <b><xsl:value-of select="@Name" /></b>
              </xsl:with-param>

              <xsl:with-param name="action">Change the data name</xsl:with-param>
            </xsl:call-template>


        </xsl:for-each>
      </xsl:if>
      -->
             <!-- debug : la clé allDataNameNormalized ne fonctionne pas ??? mais le count oui ??????
             <h98>*coz*mDataName1:<xsl:value-of select="$mDataName1"></xsl:value-of></h98>
             <h98>*coz*mDataName1Normalized:<xsl:value-of select="$mDataName1Normalized"></xsl:value-of></h98>
             <h98>*coz*mDataName1Normalized2:<xsl:value-of select="local:NormalizeName(string($mDataName1))"></xsl:value-of></h98>
             <h98>================</h98>
        -->
     <!-- Mise en commentaire lors de la version 1.5
      <xsl:if test="count(key('allDataNameNormalized',$mDataName1Normalized))&gt;1">

        <xsl:for-each select = "//ddt:Target/ddt:Datas/ddt:Data">
            <xsl:if test="position() &gt; $mposition">
              <xsl:if test="local:isSameNormalizedName(string($mDataName1), string(@Name)) = 1">
                <xsl:call-template name="error">
                  <xsl:with-param name="type">CPDD</xsl:with-param>
                  <xsl:with-param name="chapter">CPDD_ERR_DuplicateNormalizedDataName</xsl:with-param>
                  <xsl:with-param name="description">Duplicate normalized data name<br/>
                  Dataname: <b><xsl:value-of select="$mDataName1" /></b><br/>
                  Normalized name: <xsl:value-of select="$mDataName1Normalized" />
                  </xsl:with-param>

                  <xsl:with-param name="info">Other data with same normalized data name:<br/>
                  <b><xsl:value-of select="@Name" /></b>
                  </xsl:with-param>

                  <xsl:with-param name="action">Change the data name</xsl:with-param>
                </xsl:call-template>
              </xsl:if>
            </xsl:if>
        </xsl:for-each>

      </xsl:if>
    -->
    <!--/xsl:for-each-->

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Duplicate_Data.xsl: template DuplicateData ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
