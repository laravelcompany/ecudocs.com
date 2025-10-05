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


<!-- ************************************ -->
<!-- Contrôles Specifications 36-00-013/B -->
<!-- ************************************ -->
  <xsl:template name="check_SpecB">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_SpecB.xsl: template check_SpecB starts')"/></logmsg>

    <!-- *********************** -->
    <!-- Contrôles requête $2180 -->
    <!-- *********************** -->
    <xsl:call-template name="DataRead.Identification.Renault" />

    <!-- ************************ -->
    <!-- Contrôles des requêtes : -->
    <!--				$1902FF			      -->
    <!--				$1904000000FF	    -->
    <!--				$190600000080	    -->
    <!--				$1906000000FF	    -->
    <!-- ****************************** -->
    <xsl:call-template name="ReadDTCInformation_BC" />

    <!-- *********************** -->
    <!-- Contrôles requête TesterPresent.WithResponse $3E01 -->
    <!-- *********************** -->
    <xsl:call-template name="TesterPresent.WithResponse" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_SpecB.xsl: template check_SpecB ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
