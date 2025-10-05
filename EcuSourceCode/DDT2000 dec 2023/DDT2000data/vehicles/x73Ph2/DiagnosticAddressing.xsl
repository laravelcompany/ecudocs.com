<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:da="DiagnosticAddressingSchema.xml"
	exclude-result-prefixes="da"
>
<xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>

<xsl:template match="/">
<html>
<head>
<title>Diagnostic Addressing Scheme</title>
<style type="text/css">
body {font-size:1em;}
h2 {color:white;background-color:black;padding:4px;}
table.ECUAddresses {border:3px ridge;border-collapse:collapse;}
td.ColHeader {border: 1px solid black;font-weight:bold;text-align:center;vertical-align:middle;background-color:#f0f0f0;}
td.ECU       {border: 1px solid black;}
td.ECUid     {border: 1px solid black;text-align:center;}
td.ECUaddr   {border: 1px solid black;text-align:center;}
td.ECUempty  {border: 1px solid black;text-align:center;background-color:#ffff00;}
.info        {font-size:xx-small;}
#orderBy-Name     {display:inline}
#orderBy-Address  {display:none}
</style>
<script language="javascript" type="text/javascript" src="setCopyright.js"></script>
<script type="text/javascript" language="javascript">
<![CDATA[
function showDiv(divID) {
	var divIDa = divID.toLowerCase();
	if (!document.styleSheets) return;

	var theRules = new Array();
	if (document.styleSheets[0].cssRules)
		theRules = document.styleSheets[0].cssRules;
	else if (document.styleSheets[0].rules)
		theRules = document.styleSheets[0].rules;
	else return;

	// On recherche la règle css
	// --------------------------------------
	var s = "";
	for (i=0; i<theRules.length; i++) {
		s = theRules[i].selectorText.toLowerCase();
		// #orderBy-
		if (s.length > 7) {
			if (s.substr(0,9) == "#orderby-") {
				if (s == divIDa) {
					theRules[i].style.display = "inline";
				}
				else {
					theRules[i].style.display = "none";
				}
			}
		}
	}
}

function onLoadEvent() {
	setCopyrightToId('copyright');
}
]]>
</script>
</head>
<body onLoad="onLoadEvent()">
<h1>Diagnostic Addressing Scheme</h1>
<h2>Tool</h2>
<xsl:apply-templates select="//da:Tool" />
<br/>
<h2>CANSpy</h2>
Function Name: <xsl:value-of select="//da:Function[@Address = 0]/@Name"/>
<br/>
<h2>Addresses</h2>
<form style="display:inline">
<input type="radio" name="Order" checked="checked" onClick="showDiv('#orderBy-Name')"/> Alphabetical order
<input type="radio" name="Order" onClick="showDiv('#orderBy-Address')"/> Address order
</form>
<br/><br/>
<div id="orderBy-Name">
<table class="ECUAddresses">
 <tr>
  <td class="ColHeader" rowspan="3">Function</td>
  <td class="ColHeader" colspan="4">Address</td>
  <td class="ColHeader" colspan="4">DiagOnCAN</td>
 </tr>
 <tr>
  <td class="ColHeader" width="80" colspan="2">KWP</td>
  <td class="ColHeader" width="80" colspan="2">ISO8</td>
  <td class="ColHeader" width="80" colspan="2">XId<span class="info"><br/>(DTOOL to ECU)</span></td>
  <td class="ColHeader" width="80" colspan="2">RId<span class="info"><br/>(ECU to DTOOL)</span></td>
 </tr>
 <tr>
  <td class="ColHeader" width="40">Hex</td>
  <td class="ColHeader" width="40">Dec</td>
  <td class="ColHeader" width="40">Hex</td>
  <td class="ColHeader" width="40">Dec</td>
  <td class="ColHeader" width="40">Hex</td>
  <td class="ColHeader" width="40">Dec</td>
  <td class="ColHeader" width="40">Hex</td>
  <td class="ColHeader" width="40">Dec</td>
 </tr>
 <xsl:apply-templates select="//da:Function[@Address != 0]">
 <xsl:sort select="@Name"/>
 </xsl:apply-templates>
</table>
</div>
<div id="orderBy-Address">
<table class="ECUAddresses">
 <tr>
  <td class="ColHeader" rowspan="3">Function</td>
  <td class="ColHeader" colspan="4">Address</td>
  <td class="ColHeader" colspan="4">DiagOnCAN</td>
 </tr>
 <tr>
  <td class="ColHeader" width="80" colspan="2">KWP</td>
  <td class="ColHeader" width="80" colspan="2">ISO8</td>
  <td class="ColHeader" width="80" colspan="2">XId<span class="info"><br/>(DTOOL to ECU)</span></td>
  <td class="ColHeader" width="80" colspan="2">RId<span class="info"><br/>(ECU to DTOOL)</span></td>
 </tr>
 <tr>
  <td class="ColHeader" width="40">Hex</td>
  <td class="ColHeader" width="40">Dec</td>
  <td class="ColHeader" width="40">Hex</td>
  <td class="ColHeader" width="40">Dec</td>
  <td class="ColHeader" width="40">Hex</td>
  <td class="ColHeader" width="40">Dec</td>
  <td class="ColHeader" width="40">Hex</td>
  <td class="ColHeader" width="40">Dec</td>
 </tr>
 <xsl:apply-templates select="//da:Function[@Address != 0]">
 <xsl:sort select="@Address" data-type="number"/>
 </xsl:apply-templates>
</table>
</div>
<br/>
<div id="copyright" class="info">&#169; 2004, Renault</div>
</body>
</html>
</xsl:template>

<xsl:template match="da:Function">
<xsl:if test="@Address!=0">
 <tr>
  <td class="ECU">
  <b><xsl:value-of select="@Name"/></b>
  <xsl:if test="da:Name[lang('en')]">
  	<br/><span class="info">English (<b><xsl:value-of select="da:Name[lang('en')]"/></b>)</span>
  </xsl:if>
  <xsl:if test="da:Name[lang('fr')]">
  	<br/><span class="info">Français (<b><xsl:value-of select="da:Name[lang('fr')]"/></b>)</span>
  </xsl:if>
  </td>
  <td class="ECUaddr">
   <xsl:call-template name="toHex">
    <xsl:with-param name="number"><xsl:value-of select="@Address"/></xsl:with-param>
    <xsl:with-param name="digits">2</xsl:with-param>
    <xsl:with-param name="prefix">$</xsl:with-param>
   </xsl:call-template>
  </td>
  <td class="ECUaddr">
   <xsl:value-of select="@Address"/>
  </td>
<xsl:choose>
 <xsl:when test="da:ISO8">
  <td class="ECUaddr">
   <xsl:call-template name="toHex">
    <xsl:with-param name="number"><xsl:value-of select="da:ISO8"/></xsl:with-param>
    <xsl:with-param name="digits">2</xsl:with-param>
    <xsl:with-param name="prefix">$</xsl:with-param>
   </xsl:call-template>
  </td>
  <td class="ECUaddr">
   <xsl:value-of select="da:ISO8"/>
  </td>
 </xsl:when>
 <xsl:otherwise>
  <td class="ECUempty"></td>
  <td class="ECUempty"></td>
 </xsl:otherwise>
</xsl:choose>
<xsl:choose>
 <xsl:when test="da:XId">
  <td class="ECUid"><xsl:apply-templates select="da:XId"/></td>
  <td class="ECUid"><xsl:value-of select="da:XId"/></td>
 </xsl:when>
 <xsl:otherwise>
  <td class="ECUempty"></td>
  <td class="ECUempty"></td>
 </xsl:otherwise>
</xsl:choose>
<xsl:choose>
 <xsl:when test="da:RId">
  <td class="ECUid"><xsl:apply-templates select="da:RId"/></td>
  <td class="ECUid"><xsl:value-of select="da:RId"/></td>
 </xsl:when>
 <xsl:otherwise>
  <td class="ECUempty"></td>
  <td class="ECUempty"></td>
 </xsl:otherwise>
</xsl:choose>
 </tr>
</xsl:if>
</xsl:template>

<xsl:template match="da:Tool">
Address: <xsl:call-template name="toHex">
<xsl:with-param name="number"><xsl:value-of select="@Address"/></xsl:with-param>
<xsl:with-param name="digits">2</xsl:with-param>
<xsl:with-param name="prefix">$</xsl:with-param>
</xsl:call-template>
<xsl:if test="da:XId">
  <br/>DiagOnCAN Broadcast ID: <xsl:apply-templates select="da:XId" />
</xsl:if>
</xsl:template>

<xsl:template match="da:XId">
<xsl:call-template name="toHex">
<xsl:with-param name="number"><xsl:value-of select="."/></xsl:with-param>
<xsl:with-param name="digits">3</xsl:with-param>
<xsl:with-param name="prefix">$</xsl:with-param>
</xsl:call-template>
</xsl:template>

<xsl:template match="da:RId">
<xsl:call-template name="toHex">
<xsl:with-param name="number"><xsl:value-of select="."/></xsl:with-param>
<xsl:with-param name="digits">3</xsl:with-param>
<xsl:with-param name="prefix">$</xsl:with-param>
</xsl:call-template>
</xsl:template>

<xsl:template name="toHex">
<!-- 
* *******************************************************
*
* Template for decimal to hexadecimal display
*
* based on source located at 
* http://www.dpawson.co.uk/xsl/sect2/N5121.html#d6079e181
*
* *******************************************************
*
* Call sample:
*
* <xsl:call-template name="toHex">
*  <xsl:with-param name="number" ><xsl:value-of select="."/></xsl:with-param>
*  <xsl:with-param name="digits" >3</xsl:with-param>
*  <xsl:with-param name="prefix" ></xsl:with-param>
*  <xsl:with-param name="suffix" > H</xsl:with-param>
*  <xsl:with-param name="padchar">0</xsl:with-param>
* </xsl:call-template>
*
* *******************************************************
*
* Default parameters:
*
*    prefix : 0x
*    suffix : (empty)
*    digits : 4         (to disable padding, set digits to 0)
*    padchar: 0
* 
* ******************************************************* 
-->
  <xsl:param name="number" >0</xsl:param>
  <xsl:param name="prefix" >0x</xsl:param>
  <xsl:param name="suffix" ></xsl:param>
  <xsl:param name="digits" >4</xsl:param>
  <xsl:param name="padchar">0</xsl:param>
<!-- 
* *******************************************************
-->

  <xsl:param name="digitCounter">0</xsl:param>
  <xsl:variable name="varDigitCounter">
    <xsl:value-of select="$digitCounter + 1"/>
  </xsl:variable>

  <xsl:variable name="low">
    <xsl:value-of select="$number mod 16"/>
  </xsl:variable>

  <xsl:variable name="high">
    <xsl:value-of select="floor($number div 16)"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$high &gt; 0">
      <xsl:call-template name="toHex">
        <xsl:with-param name="number">
          <xsl:value-of select="$high"/>
        </xsl:with-param>
        <xsl:with-param name="digits" ><xsl:value-of select="$digits" /></xsl:with-param>
        <xsl:with-param name="prefix" ><xsl:value-of select="$prefix" /></xsl:with-param>
        <xsl:with-param name="padchar"><xsl:value-of select="$padchar"/></xsl:with-param>
        <xsl:with-param name="digitCounter"><xsl:value-of select="$varDigitCounter"/></xsl:with-param>
      </xsl:call-template>  
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="digitTemp"><xsl:value-of select="number($digits)-number($varDigitCounter)"/></xsl:variable>
      <xsl:value-of select="$prefix" />
      <xsl:if test="$digitTemp &gt; 0"><xsl:value-of select="$padchar"/></xsl:if>
      <xsl:if test="$digitTemp &gt; 1"><xsl:value-of select="$padchar"/></xsl:if>
      <xsl:if test="$digitTemp &gt; 2"><xsl:value-of select="$padchar"/></xsl:if>
      <xsl:if test="$digitTemp &gt; 3"><xsl:value-of select="$padchar"/></xsl:if>
      <xsl:if test="$digitTemp &gt; 4"><xsl:value-of select="$padchar"/></xsl:if>
      <xsl:if test="$digitTemp &gt; 5"><xsl:value-of select="$padchar"/></xsl:if>
      <xsl:if test="$digitTemp &gt; 6"><xsl:value-of select="$padchar"/></xsl:if>
      <xsl:if test="$digitTemp &gt; 7"><xsl:value-of select="$padchar"/></xsl:if>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="$low &lt; 10">
      <xsl:value-of select="$low"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="temp">
        <xsl:value-of select="$low - 10"/>
      </xsl:variable>
      <xsl:value-of select="translate($temp, '012345', 'ABCDEF')"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="$suffix" />
<!-- 
* *******************************************************
*
*  End of template
*
* *******************************************************
-->
</xsl:template>

</xsl:stylesheet>