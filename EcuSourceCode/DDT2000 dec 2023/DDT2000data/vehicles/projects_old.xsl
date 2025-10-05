<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl">

<xsl:template match="/">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="projects">
<HTML>
<HEAD>
<TITLE>Projects for <xsl:value-of select="Manufacturer"/></TITLE>
<LINK REL="STYLESHEET" HREF="/DDT2000/ddt.css" TYPE="text/css"/>
<STYLE>
	TABLE {
	border-collapse : collapse ;
	background-color : lavender ;
	border-color : gold ;
	border-width : 5 ;
	}
	TD {
	border-style : outset ;
	}
</STYLE>
</HEAD>
<BODY>
<table><TR><TD><img><xsl:attribute name="src"><xsl:value-of select="Picture"/></xsl:attribute></img></TD></TR>
<xsl:for-each select="project"><TR><TD><A><xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute><xsl:value-of select="@name"/></A></TD></TR></xsl:for-each>
</table>
</BODY>
</HTML>
</xsl:template>

<xsl:template match="models">
<HTML>
<HEAD>
<LINK REL="STYLESHEET" HREF="/DDT2000/ddt.css" TYPE="text/css"/>
<STYLE>
	TABLE {
	border-collapse : collapse ;
	background-color : lavender ;
	border-color : gold ;
	border-width : 5 ;
	}
	TD {
	border-style : outset ;
	}
</STYLE>
</HEAD>
<BODY>
<TABLE>
<xsl:for-each select="model">
<TR>
<TD><A><xsl:attribute name="href"><xsl:value-of select="url"/></xsl:attribute><xsl:value-of select="@name"/></A></TD>
<TD><xsl:apply-templates select="Docs"/></TD>
</TR>
</xsl:for-each>
</TABLE>
</BODY>
</HTML>
</xsl:template>

<xsl:template match="Docs">
<TABLE>
<xsl:for-each select="*">
<TR><TD><BR/><A><xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute><xsl:node-name/></A></TD></TR>
</xsl:for-each>
</TABLE>
</xsl:template>

<xsl:template match="project">
<HTML>
<HEAD>
<TITLE>Project <xsl:value-of select="ProductName"/></TITLE>
<LINK REL="STYLESHEET" HREF="/DDT2000/ddt.css" TYPE="text/css"/>
</HEAD>
<BODY>
<table><tr><img><xsl:attribute name="src"><xsl:value-of select="Picture"/></xsl:attribute></img><td></td></tr><tr><td>
<xsl:for-each select="version"><A><xsl:attribute name="href"><xsl:value-of select="url"/></xsl:attribute><xsl:value-of select="@name"/></A><BR/></xsl:for-each>
</td></tr></table>
</BODY>
</HTML>
</xsl:template>

</xsl:stylesheet>
