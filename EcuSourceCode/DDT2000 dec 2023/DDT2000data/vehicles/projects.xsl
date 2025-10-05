<?xml version="1.0" ?>
<!-- xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl" -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:template match="/">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="projects">
<HTML>
<HEAD>
<TITLE>Projects for <xsl:value-of select="Manufacturer"/></TITLE>
<LINK REL="STYLESHEET" HREF="/DDT2000/ddt.css" TYPE="text/css"/>
<STYLE type="text/css">
  body {
    font-family:Arial, Helvetica, sans-serif;
  }

  div.indent {
    margin-left:8px;
  }

  a {
    text-decoration:none;
  }

  TABLE {
    border-collapse : collapse ;
    background-color : lavender ;
  }
  TD {
    border: 1px solid black;
    padding:4px;
  }
  TD.logo {
    text-align:center;
    background-color:white;
  }
  TD.odd {
    background-color:#f0f0ff;
  }
  TD.even {
    background-color:#e0e0ff;
  }
</STYLE>
</HEAD>
<BODY>
<xsl:for-each select="Manufacturer">
<div class="indent">
<table width="300">
<TR>
 <TD class="logo" colspan="2">
  <img>
   <xsl:attribute name="src"><xsl:value-of select="Picture"/></xsl:attribute>
   <xsl:attribute name="alt"></xsl:attribute>
   <xsl:attribute name="title"><xsl:value-of select="name"/></xsl:attribute>
  </img>
 </TD>
</TR>
<xsl:for-each select="project">
 <TR>
   <TD width="65%">
    <xsl:attribute name="class">
     <xsl:choose>
      <xsl:when test="(position() mod 2)">odd</xsl:when>
      <xsl:otherwise>even</xsl:otherwise>
     </xsl:choose>
    </xsl:attribute>
    <A>
     <xsl:attribute name="href"><xsl:value-of select="addressing"/></xsl:attribute>
     <xsl:value-of select="@name"/>
    </A>
   </TD>
   <TD>
    <xsl:attribute name="class">
     <xsl:choose>
      <xsl:when test="(position() mod 2)">odd</xsl:when>
      <xsl:otherwise>even</xsl:otherwise>
     </xsl:choose>
    </xsl:attribute>
    <A>
     <xsl:attribute name="href"><xsl:value-of select="addressing"/></xsl:attribute>
     <xsl:value-of select="@code"/>
    </A>
   </TD>
  </TR>
</xsl:for-each>
</table>
<br/>
</div>
</xsl:for-each>

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
<!-- <TR><TD><BR/><A><xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute><xsl:node-name/></A></TD></TR> -->
<TR><TD><BR/><A><xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute><xsl:value-of select="name()"/></A></TD></TR>
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
