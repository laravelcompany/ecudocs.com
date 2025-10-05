<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU">
  <xsl:output method="xml" encoding="utf-8" indent="no" />
  
    <xsl:template match="@*|node()">
      <xsl:copy>
          <xsl:apply-templates select="@*|node()" />
      </xsl:copy>
  </xsl:template>


 </xsl:stylesheet>