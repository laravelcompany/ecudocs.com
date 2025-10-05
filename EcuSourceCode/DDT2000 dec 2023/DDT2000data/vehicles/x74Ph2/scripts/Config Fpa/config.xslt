<?xml version="1.0" encoding="windows-1252" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://schemas.microsoft.com/intellisense/ie5" >
<xsl:output method="html"/>

<xsl:template match="/">
<html>
<head>

<link rel="stylesheet" href ="config.css"/>
<script language="vbscript" src="config.vbs" >
</script>
<title><xsl:value-of select="/*/@title"/></title>
</head>
<body>
<h1><xsl:value-of select="/*/@title"/></h1>
<p>Sélectionnez une valeur dans chaque liste puis cliquez sur le bouton</p>
<xsl:apply-templates select="*"/>
<input type="button" onclick="SendRequest" value="Send" />
<p id="StatusText" class="data">&#xA0;</p>
</body>
</html>
</xsl:template>

<xsl:template match="config">
<table>
<tr><th>Choix</th><th>Liste de valeurs</th></tr>
<xsl:for-each select="select">
<tr><td><xsl:value-of select="@name"/></td><td><select id="Params">
	<xsl:if test="count(choice) = 1">
		<xsl:attribute name="disabled">true</xsl:attribute>
	</xsl:if>
	<xsl:for-each select="choice">
	<option value="{text()}"><xsl:value-of select="@text"/></option>
	</xsl:for-each>
</select>
</td></tr>
</xsl:for-each>
</table>
<p id="RequestText" class="data">&#xA0;</p>
</xsl:template>

</xsl:stylesheet>

  