<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens" >

  <xsl:output method="xml" encoding="utf-8" indent="no" cdata-section-elements="ddt:Description ddt:Comment"/>
  <!-- Identity template : copy all text nodes, elements and attributes -->   
  <xsl:template match="@*|node()">
      <xsl:copy>
          <xsl:apply-templates select="@*|node()" />
      </xsl:copy>
  </xsl:template>

  <xsl:template match="Projects" >
    <xsl:element name="{local-name()}" >
      <xsl:for-each select="node()">
        <xsl:element name="{name(.)}" />
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

<!--
  <xsl:template match="ddt:Description">
    <xsl:element name="Description" namespace="http://www-diag.renault.com/2002/ECU">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="ddt:Comment">
    <xsl:element name="Comment" namespace="http://www-diag.renault.com/2002/ECU">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
-->

  <!-- Sort DataItem by @Value -->
  <xsl:template match="ddt:Data/ddt:Bits/ddt:List" >
    <xsl:element name="List" namespace="http://www-diag.renault.com/2002/ECU">
      <xsl:for-each select="ddt:Item ">
        <xsl:sort select="@Value" data-type="number" order="ascending"/>
        <xsl:copy-of select="." />
      </xsl:for-each >
    </xsl:element>
  </xsl:template>


  <xsl:template match="ds:Categories" >
  </xsl:template>
  
</xsl:stylesheet>
