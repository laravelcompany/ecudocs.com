<?xml version="1.0"?>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="windows-1252" indent="yes" omit-xml-declaration="yes"/>
  <xsl:template match="/">
    
<html>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
<head>

<title><xsl:value-of select="/*/@title"/></title>

<script src="System/ScriptFunctions.inc" language="vbscript"></script>

<xsl:for-each select="/*/step">
  <script src="Steps/{@name}/Script.inc" language="vbscript"></script>
</xsl:for-each>

<xsl:variable name="steps"><xsl:for-each select="/*/step"><xsl:if test="not(position()=1)">,</xsl:if><xsl:value-of select="@name"/></xsl:for-each></xsl:variable>
<xsl:variable name="FirstStep"><xsl:value-of select="/*/step[1]/@name"/></xsl:variable>

<script language="vbscript">
option explicit

Sub Window_OnLoad()
<xsl:value-of select="$FirstStep"/>.style.display=""
Steps=array(<xsl:value-of select="$steps"/>)
Step<xsl:value-of select="$FirstStep"/>
DebugMode=false
GetSession
InitScript
TitlePage.ScriptTitle=document.title
end sub
</script>

</head>

<body topmargin="30" leftmargin="10" scroll="yes" bgcolor="#0080C0">
<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
  
  <tr Id="Title" height=" 32">
  <td colspan="9"><object Id="TitlePage" DATA="System/Title/Default.htm" width="100%" height="100%" TYPE="text/x-scriptlet"></object></td></tr>

<xsl:for-each select="/*/step">
  <tr Id="{@name}" style="display:none">
  <td colspan="9"><object Id="{@name}Page" DATA="Steps/{@name}/Default.htm" width="100%" height="100%" TYPE="text/x-scriptlet"></object></td></tr>
</xsl:for-each>

  <tr Id="Message" style="display:none" height="20%">
  <td colspan="9"><object Id="MessagePage" DATA="System/Message/Default.htm" width="100%" height="100%" TYPE="text/x-scriptlet"></object></td></tr>

  <tr Id="Ticket" style="display:none">
  <td colspan="9"><object Id="TicketPage" DATA="System/Ticket/Default.htm" width="100%" height="100%" TYPE="text/x-scriptlet"></object></td></tr>

  <tr Id="ButtonBar" height="53">
  <td colspan="9"><object Id="ButtonsPage" DATA="System/Buttons/Default.htm" width="100%" height="100%" TYPE="text/x-scriptlet"></object></td></tr>

  <tr Id="Bottom" height="30"> 
  <td colspan="9"><object Id="BottomPage" DATA="System/Bottom/Default.htm" width="100%" height="100%" TYPE="text/x-scriptlet"></object></td></tr>


</table>
</body>
</html>

  </xsl:template>
</xsl:stylesheet>

