<?xml version="1.0" encoding="windows-1252" ?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl local"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:local="#local-functions">
<xsl:output method="html" encoding="windows-1252" indent="yes" omit-xml-declaration="yes"/>

<!-- extension en vbscript -->
<msxsl:script
  language = "VBScript"
  implements-prefix = "local">
<![CDATA[
  Function ToHex4(n)
  ToHex4 = Right("000" & Hex(CLng(n)), 4)
  End Function

  Function ToHex2(n)
  ToHex2 = Right("0" & Hex(CLng(n)), 2)
  End Function

  function ToDec(t)
   ToDec = clng("&h" & t )
  end function

  Function encodeurl(url)
	  If url="" Then
		  encodeurl=""
		  exit function
	  end if
	  myurl = url
	  myurl=replace(myurl, " ","%20")
	  myurl=replace(myurl, "à","%C3%A0")
	  myurl=replace(myurl, "è","%C3%A8")
	  myurl=replace(myurl, "é","%C3%A9")
	  encodeurl = myurl
  End Function
]]>
</msxsl:script>


<xsl:template match="/">
<html>
	<head>
	<xsl:call-template name="cssstyle"/>
	</head>
  	<body topmargin="0" leftmargin="0" bgcolor="#C6C3BD" text="#000000" link="#FFFFFF" vlink="#FFFFFF" alink="#00CC66">
		<xsl:apply-templates select="Failures"/>
  	</body>
</html>
</xsl:template>


<xsl:template match="Failures">
<!-- message global si aucune erreur n'est detectée -->
<div>
<xsl:call-template name="cssstyle"/>
<!--
<h1>Failure file</h1>
<p>Date : <b><xsl:value-of select="Failures/Date"/></b></p>
-->
</div>
<xsl:choose>
	<xsl:when test="Function/Devices/Device/DTC">
	</xsl:when>
	<xsl:otherwise>
  	<h2>No failure detected</h2>
	</xsl:otherwise>
</xsl:choose>

<!-- Affichage du detail de chaque calculateur -->
<table class="Functions">
	<xsl:apply-templates select="Function"/>
</table>
</xsl:template>

<!-- Gestion calculateur en Spec A -->
<xsl:template match="Function[not(DTCStatusAvailabilityMask)]">
        <tr>
        	<td class="functionname"><a><xsl:attribute name="name"><xsl:value-of select="@Name"/></xsl:attribute>Function : <b><xsl:value-of select="@Name"/></b> - Name : <b><xsl:value-of select="DiagName"/></b></a></td>
        </tr>
        <tr>
        	<td>
	   		<xsl:choose>
	        	<xsl:when test="Error">
	        		<H2>Error : <B><xsl:value-of select="Error/@Code"/></B> Msg : <B><xsl:value-of select="Error/@Msg"/></B></H2>
	        	</xsl:when>
	        	<xsl:otherwise>
		          <xsl:choose>
			            <xsl:when test="Devices/Device/DTC | Unknown/DTC">
			            	<xsl:if test="Devices/Device/DTC">
						<table class="Function">
							<tr>
							  <th>Device</th>
							  <xsl:apply-templates select="DTCSchema"/>
							</tr>
							<xsl:for-each select="Devices/Device[DTC]">
							<tr><a><xsl:attribute name="NAME"><xsl:value-of select="@Name"/></xsl:attribute></a>
							    <td class="cellDevicename"><h2><a><xsl:attribute name="target">_blank</xsl:attribute><xsl:attribute name="title">click for device documentation</xsl:attribute><xsl:attribute name="href">http://gauvain.ruc.tcr.renault.fr/DDT2000 Databank/ecus/<xsl:value-of select="../../@Name"/>/<xsl:value-of select="../../DiagName"/>/<xsl:value-of select="@Name"/>.htm</xsl:attribute><xsl:value-of select="@Name"/></a></h2></td>
							    <xsl:apply-templates select="DTC[not(@Last)]"/>
							</tr>
							</xsl:for-each>
						</table>
			            	</xsl:if>
					<xsl:if test="Unknown/DTC">
						<table  class="Function">
							<tr>
							  <th>Device</th>
							  <th>Freeze Frame</th>
							</tr>
						<xsl:for-each select="Unknown/DTC">
							<tr><a><xsl:attribute name="name"><xsl:value-of select="@Name"/></xsl:attribute></a>
							<td colspan="2" class="cellDevicename"><h2>Unknown DTC : <xsl:value-of select="@Name"/></h2></td>
							<xsl:apply-templates select="."/>
							</tr>
						</xsl:for-each>
						</table>
					</xsl:if>
			            </xsl:when>
		            <xsl:otherwise>
				<h3>No failures</h3>
		            </xsl:otherwise>
		            </xsl:choose>

	        	</xsl:otherwise>
	        </xsl:choose>
          </td>
        </tr>

</xsl:template>


<!-- Gestion calculateur en Spec B -->
<xsl:template match="Function[DTCStatusAvailabilityMask]">
        <tr>
          <td class="functionname"><A><xsl:attribute name="NAME"><xsl:value-of select="@Name"/></xsl:attribute>Function : <B><xsl:value-of select="@Name"/></B> - Name : <B><xsl:value-of select="DiagName"/></B></A></td>
        </tr>
        <tr>
          <td>
   		<xsl:choose>
	        	<xsl:when test="Error">
	        		<h2>Error : <b><xsl:value-of select="Error/@Code"/></b> Msg : <b><xsl:value-of select="Error/@Msg"/></b></h2>
	        	</xsl:when>
	        	<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="Devices/Device/DTC | Unknown/DTC">
				        	<xsl:if test="Devices/Device/DTC">
					            <table class="Function">
					            	<tr>
					            	  <th>Device</th>
					            	  <th>Failure Type</th>
					            	  <th>Failure Type Category</th>
					            	  <xsl:apply-templates select="DTCStatusAvailabilityMask/StatusBit"/>
					            	</tr>
					          	<xsl:for-each select="Devices/Device[DTC]">
					          	  <tr><a><xsl:attribute name="name"><xsl:value-of select="@Name"/></xsl:attribute></a>
					          	    <td class="cellDevicename"><h2><a><xsl:attribute name="target">_blank</xsl:attribute><xsl:attribute name="title">click for device documentation</xsl:attribute><xsl:attribute name="href">http://gauvain.ruc.tcr.renault.fr/DDT2000 Databank/ecus/<xsl:value-of select="../../@Name"/>/<xsl:value-of select="../../DiagName"/>/<xsl:value-of select="@Name"/>.htm</xsl:attribute><xsl:value-of select="@Name"/></a></h2></td>
							    <xsl:apply-templates select="DTC[not(@Last)]" mode="SpecB"/>
					           	  </tr>
					          	</xsl:for-each>
					            </table>
			            		</xsl:if>
						<xsl:if test="Unknown/DTC">
							<table class="Function">
								<tr>
									<th>Device</th>
									<th>Freeze Frame</th>
								</tr>
								<xsl:for-each select="Unknown/DTC">
								<tr><a><xsl:attribute name="name"><xsl:value-of select="@Name"/></xsl:attribute></a>
								    	<td colspan="2" class="cellDevicename"><h2>Unknown DTC : <xsl:value-of select="@Name"/></h2></td>
									<xsl:apply-templates select="."/>
								</tr>
								</xsl:for-each>
							</table>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<h3>No failures</h3>
					</xsl:otherwise>
		            </xsl:choose>
	        	</xsl:otherwise>
		</xsl:choose>
          </td>
        </tr>
</xsl:template>

<xsl:template match="DTC">
	<xsl:apply-templates select="Param|Data">
	<xsl:sort select="@Name"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="DTC" mode="SpecB">
	<xsl:apply-templates select="Data[@Name='FailureType']"/>
	<xsl:apply-templates select="Data[@Name='FailureTypeCategory']"/>
	<xsl:apply-templates select="Data[@Name='DTCStatus.testFailed']"/>
	<xsl:apply-templates select="Data[@Name='DTCStatus.testFailedThisMonitoringCycle']"/>
	<xsl:apply-templates select="Data[@Name='DTCStatus.pendingDTC']"/>
	<xsl:apply-templates select="Data[@Name='DTCStatus.confirmedDTC']"/>
	<xsl:apply-templates select="Data[@Name='DTCStatus.testNotCompletedSinceLastClear']"/>
	<xsl:apply-templates select="Data[@Name='DTCStatus.testFailedSinceLastClear']"/>
	<xsl:apply-templates select="Data[@Name='DTCStatus.testNotCompletedThisMonitoringCycle']"/>
	<xsl:apply-templates select="Data[@Name='DTCStatus.warningIndicatorRequested']"/>
</xsl:template>


<xsl:template match="Param|Data">
	<td align="center">
		<xsl:if test="@Mod">
			<xsl:attribute name="bgcolor">Red</xsl:attribute>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="@Text">
				<xsl:value-of select="@Text"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@Value"/>
			</xsl:otherwise>
		</xsl:choose>
	</td>
</xsl:template>

<xsl:template match="DTCSchema">
<xsl:for-each select="Param[not(@Name = 'FirstDTC' or @Name = 'NDTC' or @Name = 'MoreDTC')]">
	<xsl:sort select="@Name"/>
	<th align="center"><xsl:value-of select="@Name"/></th>
</xsl:for-each>
</xsl:template>

<xsl:template match="StatusBit">
	<th align="center"><xsl:value-of select="@Name"/></th>
</xsl:template>


<xsl:template match="Comment">
<pre>
<xsl:value-of select="."/>
</pre>
</xsl:template>

<xsl:template name="cssstyle">
<style id="failurecss">
body     {
  font-size: smaller;
  font-family: Verdana, Arial, Helvetica, sans-serif;
}

table, th, td {
  font-family: Verdana, Arial, Helvetica, sans-serif;
}

a {
  text-decoration: none;
  color: #000000;
}

a:hover, a:active {
  text-decoration: underline;
}

div {
  background-color: #c6c3bd;
  margin: 1px;
}

h2       {
  padding: 4pt;
  color: white;
  background-color: black;
}

h2 a {
  color: ivory;
}

pre {
  font-size: 8pt;
  display:inline
}

ul.tdm {
  font-size: 12pt;
  font-weight: bold;
}

.tdmecu {
  font-size: 12pt;
  font-weight: normal;
  margin-top:12px;
}

.tdmdev {
  font-size: 10pt;
  font-weight: normal;
}

.tdmecuall {
  font-size: 10pt;
  font-weight: normal;
  margin-top:8px;
}

.tdmdevall {
  font-size: 8pt;
  font-weight: normal;
}

.tdmerror {
  font-size: 8pt;
  font-weight: bold;
  color: #FF0000;
}

.tdmwithinfo {
  font-size: 8pt;
  font-weight: bold;
  color: #008000;
}

.tdmnodiag {
  color: #FF6600;
  font-style: italic;
  font-weight: bold;
}

.error {
  font-size: 12pt;
  color: #FF0000;
  text-align: center;
  font-weight: bold;
}

.withinfo {
  font-size: 12pt;
  color: #008000;
  text-align: center;
  font-weight: bold;
}

.devicename  {
  font-size: 12pt;
  color: #000000;
  text-align: center;
  font-weight: bold;
  background-color: #82D7FF;
  border-style: ridge;
  border-width: 2px;
}

.nodiagdevicename {
  font-size: 12pt;
  font-style: italic;
  font-weight: bold;
  color: #000000;
  text-align: center;
  background-color: #FF6600;
  border-style: ridge;
  border-width: 2px;
}

.devicetype {
  font-size: 12pt;
  font-weight: normal;
}

.deviceunknown {
  font-size: 12pt;
  color: #000000;
  text-align: center;
  font-weight: bold;
  background-color: #E69B9B;
  border-style: ridge;
  border-width: 2px;
}

.noinfo {
  color: #CC6600;
  font-size: 12pt;
  font-style: italic;
  font-weight: bold;
}

.nodiag {
  color: #FF6600;
  font-size: 12pt;
  font-style: italic;
  font-weight: bold;
}

.nofailure {
  color: #009933;
  font-size: 12pt;
  font-weight: bold;
}

.fctname {
  font-size: 14pt;
  border-style: solid;
  border-width: 1px;
}

table.list {
  padding: 1px;
  border-collapse: collapse;
}

table.list th {
  padding-right: 1px;
  padding-left: 1px;
  font-weight: bold;
  font-size: x-small;
  margin: 2px;
  vertical-align: baseline;
  text-align: left;
  color: white;
  border: 1px outset;
  background-color: darkblue;
}

table.list th.elements {
  background-color: darkblue;
}

table.list th.attributes {
  background-color: darkred;
}

table.list th a	{
  color: white;
}

td.functionname a {
  width:100%;
  color:yellow;
  background-color: darkblue;
  padding:4px;
}

table.list td {
  padding: 1px;
  border: 1px inset;
  font-size: x-small;
  margin: 2px;
  vertical-align: baseline;
}

table.list td a	{
  color: darkblue;
}

table.list td.elements {
  border: 2px inset darkblue;
}

table.list td.attributes {
  border: 2px inset darkred;
}

table.identification {
  border-collapse: collapse;
}

table.identification th	{
  background-color: white;
  border:1px solid black;
  font-size: 8pt;
}

table.identification td	{
  border:1px solid black;
  font-size: 8pt;
  text-align: center;
}

table.StatusDTC	{
  border: 1px solid black;
  width: 100%;
  font-family: arial;
  font-size: 8pt;
  border-collapse: collapse;
}

table.StatusDTC tr td {
  border: 1px solid black;
  padding-left: 5px;
  padding-right: 5px;
}

table.StatusDTC th {
  border: 1px solid black;
  padding-left: 5px;
  padding-right: 5px;
}

table.Function {
  border: 1px solid black;
}

table.Function TD {
  border: 1px solid black;
}

table.Functions {
  border: 0px solid black;
}

table.Functions TH {
  background-color: #f0f000; /*khaki;*/
}

table.Functions td.cellDevicename {
  padding: 5px;
  margin: 0px;
  color: lightgoldenrodyellow;
  font-weight: bolder;
  font-size: 10pt;
  font-style: italic;
  background-color: gray;
  text-align: center;
}

table.Functions td.cellDevicename H2 {
  color: lightgoldenrodyellow;
  background-color: gray;
  font-weight: bolder;
  font-size: 10pt;
  font-style: italic;
  text-align: center;
/*
  padding: 5px;
  margin: 0px;
*/
}

table.ExtendedData {
  font-size: 8pt;
  font-family: arial;
  width: 100%;
  border: 1px solid black;
  border-collapse: collapse;
}

table.ExtendedData th {
  padding-right: 2em;
  padding-left: 2em;
  padding-top: 0px;
  padding-bottom: 0px;
  font-weight: bold;
  margin: 0px;
  vertical-align: baseline;
  background-color: #00cc66;
  text-align: center;
}

table.ExtendedData tr td {
  border: 1px solid black;
  padding-right: 5px;
  padding-left: 5px;
}

table.FreezeF {
  width: 100%;
  font-size: 8pt;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  border: 1px solid black;
  border-collapse: collapse;
}

table.FreezeF th {
  padding-right: 2em;
  padding-left: 2em;
  padding-top: 0px;
  padding-bottom: 0px;
  font-weight: bold;
  margin: 0px;
  vertical-align: baseline;
  background-color: #6699ff;
  text-align: center;
}

table.FreezeF tr td {
  padding-right: 5px;
  padding-left: 5px;
  border: 1px solid black;
}

table.DTCName {
  border: 0px solid black;
  font-size: 10pt;
  width: 100%;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  border-collapse: collapse;
}

table.DTCName tr td {
  border: 0px solid black;
  padding-right: 3px;
  padding-left: 3px;
  background-color: #4bf1f1;
  text-align: center;
}

table.tbComment {
  padding: 1px;
  border-collapse: collapse;
}

table.tbComment th {
  padding-right: 1px;
  padding-left: 1px;
  font-weight: bold;
  font-size: x-small;
  margin: 2px;
  vertical-align: baseline;
  color: white;
  border: 1px outset;
  background-color: darkblue;
  text-align: left;
}

table.tbComment td {
  padding: 1px;
  border: 1px inset;
  font-size: x-small;
  margin: 2px;
  vertical-align: baseline;
}


</style>
</xsl:template>

</xsl:stylesheet>