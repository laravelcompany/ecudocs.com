<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions">

  <!-- Remarque : 
      2 templates définis dans ce fichier :
        + Routine_Generic_ABC : 
            - TODO : A definir car pas de requête générique pour BC
        + Routine_Specific_ABC : 
            - TODO (car pas de requête générique) : Contrôle que le RID de la requête spécifique est présent dans la donnée contenant la liste des RID
            - contrôle du chevauchement
  -->

  <!-- ************************************** -->
  <!-- ************************************** -->
  <!-- **** TEMPLATE Routine_Generic_ABC **** -->
  <!-- ************************************** -->
  <!-- ************************************** -->
  <xsl:template name="Routine_Generic_ABC">
  </xsl:template>

  <!-- *************************************** -->
  <!-- *************************************** -->
  <!-- **** TEMPLATE Routine_Specific_ABC **** -->
  <!-- *************************************** -->
  <!-- *************************************** -->
  <xsl:template name="Routine_Specific_ABC">
    <xsl:param name="request" />
  
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Routines_ABC.xsl: template Routine_Specific_ABC starts')"/></logmsg>
    <xsl:variable name="RID" select="substring($request/ddt:Sent/ddt:SentBytes, 3, 2)"/>

    <xsl:variable name="mIsMaintainabilityReport">
      <xsl:choose>
        <xsl:when test="$request/DossierMaintenabilite">
          <xsl:text>true</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>false</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:if test="$RID != '00'">
      <!-- ***************************************** -->
      <!-- Error AE011 : ALLIANCE_ERR_RequestOverlap -->
      <!-- Error ME023 : DAIMLER_ERR_RequestOverlap  -->
      <!-- ***************************************** -->
      <!-- Vérification overlapping -->
      <for-each select="$request/ddt:Sent/ddt:DataItem">
        <xsl:call-template name="Overlap_Request">
          <xsl:with-param name="serviceName" select="$request/@Name"/>
          <xsl:with-param name="isMaintainabilityReport" select="$mIsMaintainabilityReport"/>
          <xsl:with-param name="currentFrame" select=".."/>
          <xsl:with-param name="currentDataItem" select="."/>
        </xsl:call-template>
      </for-each>
    </xsl:if>
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Routines_ABC.xsl: template Routine_Specific_ABC ends')"/></logmsg>
  </xsl:template>

</xsl:stylesheet>