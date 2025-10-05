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
h8 {color:black;background-color:yellow;padding:2px;}
td {padding:4px;}
table.ECUAddresses {border:3px ridge;border-collapse:collapse;}
td.ColHeader   {border: 1px solid black;font-weight:bold;text-align:center;vertical-align:middle;background-color:#f0f0f0;}
td.ECU         {border: 1px solid black;}
td.ECUCGW      {border: 1px solid red;}
td.ECUid       {border: 1px solid black;text-align:center;}
td.ECUaddr     {border: 1px solid black;text-align:center;}
td.ECUempty    {border: 1px solid black;text-align:center;background-color:#ffff00;}
td.ECUprotocol {border: 1px solid black;text-align:left;}
.info          {font-size:x-small;}
.info2          {font-size:small;font-style:italic}
#orderBy-Name     {display:inline}
#orderBy-Address  {display:none}
</style>
<script type="text/javascript" language="javascript">
<![CDATA[

// *****************************************************
// Copyright functions:
//
//   setCopyright: 
//     set copyright using document.write
//
//   setCopyrightToId:
//     set copyright into a block (such as DIV, or SPAN)
//     using innerHTML
//     This is used in xml stylesheets (xls files), 
//     because document.write crash Mozilla !
// *****************************************************
function getCopyright() {
	var today = new Date();
	return ("&#169; RENAULT 1996-" + today.getFullYear() + ", All rights reserved");
}

function setCopyright() {
	document.write (getCopyright());
}

function setCopyrightToId(divId) {
	if (document.getElementById(divId)) {
		document.getElementById(divId).innerHTML = getCopyright();
	}
}


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
<xsl:apply-templates select="/da:Functions/da:description" />
<h2>Tool</h2>
<xsl:apply-templates select="/da:Functions/da:Tool" />
<h2>Protocol</h2>
<xsl:apply-templates select="/da:Functions/da:ProtocolList" />
<xsl:if test="/da:Functions/da:Function[@Address = 0 or @Address = 255]">
	<h2>CAN</h2>
	<ul>
	<xsl:apply-templates select="/da:Functions/da:Function[@Address = 0 or @Address = 255]" />
	</ul>
</xsl:if>
<h2>Addresses</h2>
<form style="display:inline">
<input type="radio" name="Order" checked="checked" onClick="showDiv('#orderBy-Name')"/> Alphabetical order
<input type="radio" name="Order" onClick="showDiv('#orderBy-Address')"/> Address order
</form>
<br/><br/>
<div id="orderBy-Name">
<table class="ECUAddresses">
 <tr>
  <td class="ColHeader" rowspan="2">Function</td>
  <td class="ColHeader" colspan="3">Address</td>
  <td class="ColHeader" colspan="2">DiagOnCAN11b</td>
  <td class="ColHeader" colspan="2">DiagOnCAN29b</td>
  <td class="ColHeader" colspan="1">DoIP</td>
  <td class="ColHeader" rowspan="2">Searched protocols<br/>[ supported specifications ]</td>
 </tr>
 <tr>
  <td class="ColHeader" width="40" colspan="1">KWP</td>
  <td class="ColHeader" width="40" colspan="1">ISO8</td>
  <td class="ColHeader" width="40" colspan="1">LA</td>
  <td class="ColHeader" width="80" colspan="1">XID</td>
  <td class="ColHeader" width="80" colspan="1">RID</td>
  <td class="ColHeader" width="80" colspan="1">XID</td>
  <td class="ColHeader" width="80" colspan="1">RID</td>
  <td class="ColHeader" width="80" colspan="1">Adr</td>
 </tr>
 <xsl:apply-templates select="/da:Functions/da:Function[@Address != 0 and @Address != 255]">
 	<xsl:sort select="@Name"/>
 </xsl:apply-templates>
</table>
</div>
<div id="orderBy-Address">
<table class="ECUAddresses">
 <tr>
  <td class="ColHeader" rowspan="2">Function</td>
  <td class="ColHeader" colspan="3">Address</td>
  <td class="ColHeader" colspan="2">DiagOnCAN11b</td>
  <td class="ColHeader" colspan="2">DiagOnCAN29b</td>
  <td class="ColHeader" colspan="1">DoIP</td>
  <td class="ColHeader" rowspan="2">Searched protocols<br/>[ supported specifications ]</td>
 </tr>
 <tr>
  <td class="ColHeader" width="40" colspan="1">KWP</td>
  <td class="ColHeader" width="40" colspan="1">ISO8</td>
  <td class="ColHeader" width="40" colspan="1">LA</td>
  <td class="ColHeader" width="80" colspan="1">XID</td>
  <td class="ColHeader" width="80" colspan="1">RID</td>
  <td class="ColHeader" width="80" colspan="1">XID</td>
  <td class="ColHeader" width="80" colspan="1">RID</td>
  <td class="ColHeader" width="80" colspan="1">Adr</td>
 </tr>
 <xsl:apply-templates select="//da:Function[@Address != 0 and @Address != 255]">
 <xsl:sort select="@Address" data-type="number"/>
 </xsl:apply-templates>
</table>
</div>
<br/>
<div id="copyright" class="info">&#169; 2010, Renault</div>
</body>
</html>
</xsl:template>

<!-- Traitement de fonction non CAN  -->
<xsl:template match="da:Function">
<xsl:if test="@Address!=0">
 <tr>
 <td class="ECU">
   <xsl:if test="@Type='CGW'">
     <h8>*Security Gateway*</h8><br/>
  </xsl:if>
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
   </xsl:call-template><br/>
   <span class="info2"><xsl:value-of select="@Address"/></span>
  </td>
<xsl:choose>
 <xsl:when test="da:ISO8">
  <td class="ECUaddr">
   <xsl:call-template name="toHex">
    <xsl:with-param name="number"><xsl:value-of select="da:ISO8"/></xsl:with-param>
    <xsl:with-param name="digits">2</xsl:with-param>
    <xsl:with-param name="prefix">$</xsl:with-param>
   </xsl:call-template>
    <br/>
	<span class="info2"><xsl:value-of select="da:ISO8"/></span>
  </td>
 </xsl:when>
 <xsl:otherwise>
  <td class="ECUempty"></td>
 </xsl:otherwise>
</xsl:choose>


   
<!-- Traitement des LogicalAddress -->
<xsl:choose>
	<xsl:when test="da:XId">
	  <td class="ECUaddr">
	   <xsl:value-of select="da:ProtocolList/da:Protocol/da:LogicalAddress"/>
	   <br/>

  </td>
	</xsl:when>
	<xsl:otherwise>
		<td class="ECUempty"></td>
	</xsl:otherwise>
</xsl:choose>   
     
       

 
       
<!-- Traitement des XId 11b -->
<xsl:choose>
	<xsl:when  test="da:ProtocolList/da:Protocol[@Code='6'] and da:ProtocolList/da:Protocol/da:Address[@Extended='0']">

	  <td class="ECUaddr">
      <!-- Valeur HEXA de XID-->
	   <xsl:value-of select="concat('$',da:ProtocolList/da:Protocol/da:Address[@Extended='0']/@Xid)"/>
	  <!-- Valeur Decimale de XID -->
	   <br/>
	   <span class="info2">
       <xsl:call-template name="hex2dec">
           <xsl:with-param name="num" select="da:ProtocolList/da:Protocol/da:Address[@Extended='0']/@Xid" />
       </xsl:call-template>
	   </span>

     </td>
      <td class="ECUaddr">
         <!-- Valeur HEXA de RID-->
       <xsl:value-of select="concat('$',da:ProtocolList/da:Protocol/da:Address[@Extended='0']/@Rid)"/>
	    <br/>
 	   <span class="info2">
      <xsl:call-template name="hex2dec">
           <xsl:with-param name="num" select="da:ProtocolList/da:Protocol/da:Address[@Extended='0']/@Rid" />
       </xsl:call-template>
	   </span>

      </td>
 
    <!-- <xsl:call-template name="hex2num">
    <xsl:with-param name="hex">   <span class="info2"><xsl:value-of select="da:ProtocolList/da:Protocol/da:Address/@Xid"/></span> </xsl:with-param>
</xsl:call-template>
-->

 </xsl:when>

	<xsl:otherwise>
		<td class="ECUempty"></td>
		<td class="ECUempty"></td>
	</xsl:otherwise>
</xsl:choose>
   
    <!-- Traitement des XId 29b -->
<xsl:choose>
     <xsl:when test="da:ProtocolList/da:Protocol[@Code='6'] and da:ProtocolList/da:Protocol/da:Address[@Extended='1']">

	  <td class="ECUaddr">
	   <xsl:value-of select="concat('$',da:ProtocolList/da:Protocol/da:Address[@Extended='1']/@Xid)"/>
	   <br/>
	   <span class="info2">
       <xsl:call-template name="hex2dec">
           <xsl:with-param name="num" select="da:ProtocolList/da:Protocol/da:Address[@Extended='1']/@Xid" />
       </xsl:call-template>
	   </span>

     </td>
      <td class="ECUaddr">
       <xsl:value-of select="concat('$',da:ProtocolList/da:Protocol/da:Address[@Extended='1']/@Rid)"/>
	    <br/>
	   <span class="info2">
       <xsl:call-template name="hex2dec">
           <xsl:with-param name="num" select="da:ProtocolList/da:Protocol/da:Address[@Extended='1']/@Rid" />
       </xsl:call-template>
	   </span>
      </td>

    <!-- <xsl:call-template name="hex2num">
    <xsl:with-param name="hex">   <span class="info2"><xsl:value-of select="da:ProtocolList/da:Protocol/da:Address/@Xid"/></span> </xsl:with-param>
</xsl:call-template>
-->
   </xsl:when>
  
	<xsl:otherwise>
		<td class="ECUempty"></td>
		<td class="ECUempty"></td>
	</xsl:otherwise>
</xsl:choose>
   

   
     <!-- Traitement des IP address -->
<xsl:choose>
     <xsl:when test="da:ProtocolList/da:Protocol[@Code='8']">

	  <td class="ECUaddr">
	   <xsl:value-of select="da:ProtocolList/da:Protocol/da:Address[@IPAddress]"/>
	   <br/>

     </td>
   </xsl:when>
  
	<xsl:otherwise>
		<td class="ECUempty"></td>
	</xsl:otherwise>
</xsl:choose>
   
   
   
 
  <td class="ECUprotocol"><xsl:apply-templates select="da:ProtocolList"/></td>
 </tr>
</xsl:if>
</xsl:template>

<!-- Traitement des fonctions CAN  -->
<xsl:template match="da:Function[@Address = 0 or @Address = 255]">
<li><b><xsl:value-of select="@Name"/></b> (<xsl:value-of select="da:Name[@xml:lang='en']"/>/<xsl:value-of select="da:Name[@xml:lang='fr']"/>)
 <xsl:if test="da:baudRate">BaudRate=<b><xsl:value-of select="da:baudRate"/></b></xsl:if>
 </li>
</xsl:template>


<!-- Affichage des information de l'outils  -->
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

<!-- Traitement des XId ou RId-->
<xsl:template match="da:XId|da:RId">
<xsl:choose>
	<xsl:when test="starts-with(., '0x')">
		<td class="ECUid"><xsl:value-of select="da:XID"/></td>
		<td class="ECUempty"></td>
	</xsl:when>
	<xsl:otherwise>
		<td class="ECUid">
		<xsl:value-of select="da:XID"/>
		<br/>
		<span class="info2"><xsl:value-of select="."/></span>
		</td>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>



<xsl:template match="da:ProtocolList">
<xsl:apply-templates select="da:Protocol[da:Search]"/>
</xsl:template>

<xsl:template match="da:Protocol">
<xsl:value-of select="@Name"/>
<xsl:if test="@bus != ''">
on bus <xsl:value-of select="@bus"/>
</xsl:if>
<xsl:apply-templates select="da:Specification/da:Supported"/><br/>
</xsl:template>

<xsl:template match="da:Specification/da:Supported">
&#160;[&#160;<xsl:value-of select="."/>&#160;]
</xsl:template>

<xsl:template match="da:description">
  <xsl:if test="da:Name[lang('en')]">
  	<h3><span><b><xsl:value-of select="da:Name[lang('en')]"/></b></span></h3>
  </xsl:if>
  <xsl:if test="da:Name[lang('fr')]">
  	<h3><span><b><xsl:value-of select="da:Name[lang('fr')]"/></b></span></h3>
  </xsl:if>

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
<xsl:template name="hex2dec">
    <xsl:param name="num" />
    <xsl:param name="hex" select="translate($num,'abcdef','ABCDEF')"/>
    <xsl:param name="acc" select="0" />
    <xsl:choose>
        <xsl:when test="string-length($hex)">
            <xsl:call-template name="hex2dec">
                <xsl:with-param name="hex" select="substring($hex,2,string-length($hex))" />
                <xsl:with-param name="acc" select="$acc * 16 + string-length(substring-before('0123456789ABCDEF',substring($hex,1,1)))" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$acc" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
  
<xsl:template name="hex2num">
    <xsl:param name="hex"/>
    <xsl:param name="num" select="0"/>
    <xsl:param name="MSB" select="translate(substring($hex, 1, 1), 'abcdef', 'ABCDEF')"/>
    <xsl:param name="value" select="string-length(substring-before('0123456789ABCDEF', $MSB))"/>
    <xsl:param name="result" select="16 * $num + $value"/>
    <xsl:choose>
        <xsl:when test="string-length($hex) > 1">
            <xsl:call-template name="hex2num">
                <xsl:with-param name="hex" select="substring($hex, 2)"/>
                <xsl:with-param name="num" select="$result"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$result"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>