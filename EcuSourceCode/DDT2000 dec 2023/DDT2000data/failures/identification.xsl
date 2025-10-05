<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl local xql verb"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:local="#local-functions"
  xmlns:verb="#verb"
	xmlns:xql="#xql-functions">
<xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>

<xsl:param name="lang"/>
<xsl:param name="scriptDisabled"/>
<xsl:param name="urlbank"/>

<!-- Set this parameter to simulate setting a start mode -->
<xsl:param name="start-mode" select="''"/>

<!-- param used to display xml source code (raw data) -->
<xsl:param name="indent-elements" select="true()" />

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
        <!-- Switch mode according to the value of $start-mode -->
        <xsl:choose>
            <xsl:when test="$start-mode='all'">
                <xsl:apply-templates select="/" mode="all"/>
            </xsl:when>
            <xsl:when test="$start-mode='identifications'">
                <xsl:apply-templates select="/" mode="identifications"/>
            </xsl:when>
          <xsl:when test="$start-mode='raw'">
            <xsl:apply-templates select="/" mode="raw" />
          </xsl:when>
          <xsl:when test="$start-mode='historic'">
                <xsl:apply-templates select="/" mode="historic"/>
            </xsl:when>
            <xsl:when test="$start-mode='SpecificIdent'">
                <xsl:apply-templates select="/" mode="SpecificIdent"/>
            </xsl:when>
        <xsl:otherwise>

		<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
		<!--       mode autonome (uniquemement a partir IE6 (gestion native du xslt)               -->
		<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
		<html>
		  <head>
		  <xsl:call-template name="cssstyle"/>
		  </head>
		  <body topmargin="0" leftmargin="0" bgcolor="#C6C3BD" text="#000000" link="#FFFFFF" vlink="#FFFFFF" alink="#00CC66">
			<xsl:choose>

				<xsl:when test="Identifications">
					<div>
						<xsl:apply-templates select="Identifications"/>
					</div>
				</xsl:when>

			</xsl:choose>
		  </body>
		</html>
		
            </xsl:otherwise>
        </xsl:choose>
        
</xsl:template>

<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- ===================== Display XML source (raw data)  ================================ -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="/" mode="raw">
  <div>
    <xsl:call-template name="cssstyle"/>
    <xsl:apply-templates select="." mode="xmlverb" />
  </div>
</xsl:template>
  
  
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- ===================== Affichage des organes en panne ================================ -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="/" mode="identifications">
<xsl:choose>
	<xsl:when test="Identifications | Failures">
		<div>
			<a name="top" style="display:none;">&#160;</a>
			<xsl:call-template name="cssstyle"/>
			<xsl:apply-templates select="Identifications | Failures"/>
		</div>
	</xsl:when>
</xsl:choose>
</xsl:template>

  
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- ===================== Affichage de tous les organes  ================================ -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="/" mode="all">
<xsl:choose>
	<xsl:when test="Identifications | Failures">
		<div>
			<a name="top" style="display:none;">&#160;</a>
			<xsl:call-template name="cssstyle"/>
			<xsl:apply-templates select="Identifications | Failures" mode="all"/>
		</div>
	</xsl:when>
</xsl:choose>
</xsl:template>


<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- ===================== Affichage de tous les organes  ================================ -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="/" mode="historic">
<xsl:choose>
	<xsl:when test="Identifications | Failures">
		<div>
			<a name="top" style="display:none;">&#160;</a>
			<xsl:call-template name="cssstyle"/>
			<xsl:apply-templates select="Identifications | Failures" mode="historic"/>
		</div>
	</xsl:when>
</xsl:choose>
</xsl:template>



<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- ===================== Affichage de tous les organes  ================================ -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="/" mode="SpecificIdent">
<xsl:choose>
	<xsl:when test="Identifications | Failures">
		<div>
			<a name="top" style="display:none;">&#160;</a>
			<xsl:call-template name="cssstyle"/>
			<xsl:apply-templates select="Identifications | Failures" mode="SpecificIdent"/>
		</div>
	</xsl:when>
</xsl:choose>
</xsl:template>


<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!--                      Gestion de la l'affichage des identifications                             -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="Identifications | Failures">
<!-- message global si aucune erreur n'est detectèe -->

<!-- Affichage du detail de chaque calculateur -->
<table class="identification" width="100%">

	<xsl:apply-templates select="Function[@Address!= 0 and @Address != 255]" mode="identifications"/>

</table>
<xsl:call-template name="legend"/>
</xsl:template>


<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!--                                         Legende                                       -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template name="legend">
<script type="text/javascript" language="javascript">

function toggleLegendView() {
  try {
    if (document.getElementById("idLegend")) {
      var o     = document.getElementById("idLegend");
      var oLink = document.getElementById("idLegendLink");
      if ((o.style.display == "inline") || (o.style.display == "")) {
        o.style.display = "none";
        oLink.innerHTML = "Show legend";
      }
      else {
        o.style.display = "inline";
        oLink.innerHTML = "Hide legend";
      }
    }
  }
  catch(e) {
  }
}

</script>
<br/>
<xsl:variable name="displayType">
<xsl:choose>
	<xsl:when test="$scriptDisabled='1'">inline</xsl:when>
	<xsl:otherwise>none</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:choose>
	<xsl:when test="$scriptDisabled='1'">
<b><u>Legend</u></b><br/>
	</xsl:when>
	<xsl:otherwise>
<b><a href="#" onClick="javascript:toggleLegendView()" id="idLegendLink">Show legend:</a></b><br/>
	</xsl:otherwise>
</xsl:choose>

<div id="idLegend" style="display:{$displayType};">
<table width="100%" style="border:1px dotted black;">
 <tr>
  <td valign="top">
<table class="legend">
<tr><th class="legend" colspan="2">ECU column</th></tr>
<tr><td class="legendFctName" width="20">&#160;</td><td>Init OK</td></tr>
<tr><td class="legendInitError" width="20">&#160;</td><td>Init or communication error</td></tr>
</table>
  </td>
  <td width="20">&#160;</td>
  <td valign="top">
<table class="legend">
 <tr><th class="legend" colspan="2">R/N column</th></tr>
 <tr><td class="legendIdentOk"    width="20">&#160;</td><td>Identification (2180) OK</td></tr>
 <tr><td class="legendNidentOk"   width="20">&#160;</td><td>Identification (2183) OK</td></tr>
 <tr><td class="legendIdentUDSOk" width="20">&#160;</td><td>Identification UDS (22F1xx) OK</td></tr>
 <tr><td class="legendHistoO"     width="20">&#160;</td><td>Initial logzone</td></tr>
 <tr><td class="legendBoot"       width="20">&#160;</td><td>ECU is in boot</td></tr>
 <tr><td class="legendNotReprogrammable" width="20">&#160;</td><td>ECU is not reprogrammable</td></tr>
</table>
  </td>
  <td width="20">&#160;</td>
  <td valign="top">
<table class="legend">
<tr><th class="legend" colspan="2">Format column</th></tr>
<tr><td class="legendIdentOk"    width="20">&#160;</td><td>Identification (2180) known format</td></tr>
<tr><td class="legendNidentOk"   width="20">&#160;</td><td>Identification (2183) known format</td></tr>
<tr><td class="legendidentNOk"   width="20">&#160;</td><td>Unknow format</td></tr>
</table>
  </td>
 </tr>
 <tr>
  <td valign="top">
<table class="legend">
<tr><th class="legend" colspan="2">CRC column</th></tr>
<tr><td class="legendCrcOK"   width="20">&#160;</td><td>CRC OK</td></tr>
<tr><td class="legendCrcNOk"  width="20">&#160;</td><td>CRC not OK</td></tr>
</table>
  </td>
  <td width="20" colspan="4">&#160;</td>
 </tr>
</table>
<br/>
<xsl:choose>
	<xsl:when test="$lang='fr'">
		Vous pouvez placer le curseur de la souris au dessus du code fournisseur d'un calculateur,
		pour afficher le nom de celui-ci (si il est connu).
	</xsl:when>
	<xsl:otherwise>
		You may move the mouse cursor over the ECU's supplier code,
		to view its name (if known).
	</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>

<!-- ========================================================================================= -->
<xsl:template match="Function" mode="identifications">
<xsl:variable name="toclink">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:variable>
<xsl:choose>
	  <xsl:when test="IdentificationUDS">
		<tr>
			<th rowspan="4">
				<xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
				<xsl:value-of select="@Name"/>
			</th>
			<xsl:call-template name="UDSIdentHeader1"/>
		</tr>
		<xsl:apply-templates select="IdentificationUDS"/>
	  </xsl:when>
	  <xsl:when test="Identification">
		<tr>
			<th rowspan="3">
				<xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
				<xsl:value-of select="@Name"/>
			</th>
			<xsl:call-template name="IdentHeader"/>
		</tr>
		<tr>
		  <xsl:apply-templates select="Identification"/>
		</tr>
	  </xsl:when>
	  <xsl:otherwise>
		<tr>
			<th>
				<xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
				<xsl:value-of select="@Name"/>
			</th>
			<xsl:call-template name="IdentHeader"/>
		</tr>
		<tr>
			<td colspan="10" class="commError">
				Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
				</b>&#xA0;Description : <b>'<xsl:value-of select="Error/@Msg"/>'</b>
				<xsl:if test="Error/Request">
					Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive : <xsl:value-of select="Error/Request/@Receive"/>
				</xsl:if>
			</td>
		</tr>
	  </xsl:otherwise>
  </xsl:choose>

<xsl:if test="Identification/ProgrammingStamp[@Id='0']">
	<tr>
		<!-- <th>&#xA0;</th> -->
		<!-- Afficher les trames d'identification -->
		<xsl:apply-templates select="Identification/ProgrammingStamp[@Id='0']/Identification">
			<xsl:with-param name="dmode">histo</xsl:with-param>
		</xsl:apply-templates>
	</tr>
</xsl:if>
<xsl:if test="Identification83[not(Error)]">
	<tr>
		<th>&#xA0;</th>
		<!-- Afficher les trames d'identification -->
		<xsl:apply-templates select="Identification83[not(Error)]">
			<xsl:with-param name="dmode">nissan</xsl:with-param>
		</xsl:apply-templates>
	</tr>
</xsl:if>
<tr>
	<td colspan="20">
		<xsl:text >&#160;</xsl:text>
	</td>
</tr>
</xsl:template>

<!-- ========================================================================================= -->
<!-- -->
<!-- ========================================================================================= -->
<xsl:template match="Identifications | Failures" mode="all">
<!-- Affichage du detail de chaque calculateur -->
<table class="identification" width="100%">
	<xsl:apply-templates select="Function[@Address!= 0 and @Address != 255]" mode="all"/>
</table>
<xsl:call-template name="legend"/>
</xsl:template>


<!-- ========================================================================================= -->
<!--        affichage du detail des fonctions avec toutes les infos                            -->
<!-- ========================================================================================= -->
<xsl:template match="Function" mode="all">
<!-- Affichage du detail de chaque calculateur -->
<tr>
  <th class="fctname" >
  Function: <font size="+1"><xsl:value-of select="@Name"/></font>
  <xsl:if test="DiagName">
  	&#xA0;&#xA0;- Name: <font size="+1"><xsl:value-of select="DiagName"/></font>
  </xsl:if>
  </th>
  <th class="fctname" ><xsl:if test="VIN[not(Error)]">VIN : <font size="+1"><xsl:value-of select="VIN/@Number"/></font></xsl:if></th>
</tr>
<tr>
<td colspan="2">
<table class="identification" width="100%">
<xsl:choose>
	<xsl:when test="Error">
	  <tr>
		<td colspan="10" class="commError">
			Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
			</b>&#xA0;Description : <b>'<xsl:value-of select="Error/@Msg"/>'</b>
			<xsl:if test="Error/Request">
				Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive : <xsl:value-of select="Error/Request/@Receive"/>
			</xsl:if>
		</td>
	  </tr>
	</xsl:when>
	<xsl:otherwise>
	  <tr>
	    <th>Request</th>
		<xsl:if  test="IdentificationUDS"> 
			<xsl:call-template name="ReprogCommonHeaderUDS"/>
		</xsl:if>
		<xsl:if  test="Identification"> 
			<xsl:call-template name="ReprogCommonHeader"/>
		</xsl:if>

	  </tr>
		<tr>
		  <th>Renault (2180)</th>
		  <xsl:apply-templates select="Identification"/>
		</tr>
		<tr>
		  <th>Nissan (2183)</th>
		  <xsl:apply-templates select="Identification83"/>
		</tr>
		<xsl:if test="IdentificationUDS">
		<tr>
		  <th rowspan="4">UDS (22F1xx)</th>
		  <xsl:apply-templates select="IdentificationUDS"/>
		</tr>
		</xsl:if>
		<xsl:if test="Identification/ProgrammingStamp">
			<xsl:apply-templates select="Identification/ProgrammingStamp" mode="all"/>
		</xsl:if>
	</xsl:otherwise>
</xsl:choose>
</table>
</td>
</tr>
</xsl:template>


<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!--                      Gestion des idents spécifiques                             -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="Identifications" mode="SpecificIdent" >


	<table class="identification" width="100%">

		<xsl:if test="Function[@Address!= 0 and @Address != 255]/Identification">
			<xsl:call-template name = "SpecificIdentHeader"></xsl:call-template>
			<xsl:apply-templates select="Function[@Address!= 0 and @Address != 255]/Identification" mode="SpecificIdent"/>
		</xsl:if>

		<tr><td colspan="9" height="10px"></td></tr>

		<xsl:if test="Function[@Address!= 0 and @Address != 255]/IdentificationUDS">
			<xsl:call-template name = "SpecificIdentHeaderUDS"></xsl:call-template>
			<xsl:apply-templates select="Function[@Address!= 0 and @Address != 255]/IdentificationUDS" mode="SpecificIdent"/>
		</xsl:if>

		<xsl:if test="Function[@Address!= 0 and @Address != 255]">
			<xsl:call-template name = "SpecificIdentHeaderOnError"></xsl:call-template>
			<xsl:apply-templates select="Function[@Address!= 0 and @Address != 255]/Error" mode="SpecificIdent"/>

		</xsl:if>


	</table>

<xsl:call-template name="legend"/>

</xsl:template>

<xsl:template match="Function/Error" mode="SpecificIdent">

	<tr>

		<th>
			<xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
			<xsl:value-of select="../@Name"/>
		</th>
		<td colspan="10" class="commError">
			Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=
			<xsl:value-of select="@Code"/></xsl:attribute><xsl:value-of select="@Code"/></a>
			</b>&#xA0;Description : <b>'<xsl:value-of select="@Msg"/>'</b>
			<!--Request : <xsl:value-of select="Request/@Send"/>&#xA0;Receive :
			<xsl:value-of select="Request/@Receive"/>-->
		</td>


	</tr>
</xsl:template>

<xsl:template match="Function/Identification" mode="SpecificIdent">

	<xsl:if test="not(../IdentificationUDS)">

	<tr>

		<th>
			<xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
			<xsl:value-of select="../@Name"/>
		</th>
		<xsl:choose>
			<xsl:when test="Error" >
				<td colspan="1" class="identUDSError">

					Request : <xsl:value-of select="Error/Request/@Send"/><br/>
					<xsl:if test="Error/Request">
						Receive : <xsl:value-of select="Error/Request/@Receive"/>
					</xsl:if>
					<xsl:if test="not(Error/Request)">
						Receive : No Reply
					</xsl:if>

				</td>



				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="ProgrammingStamp[@Id = '0']/Identification/Hardware"/>
				</xsl:call-template>
				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="ProgrammingStamp[@Id = 'N']/Identification/Order"/>
				</xsl:call-template>

				<xsl:if test="AssemblyKitIdentification">
					<xsl:call-template name="GetReply">
						<xsl:with-param name="Node" select="AssemblyKitIdentification"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(AssemblyKitIdentification)">
					<td>
					</td>
				</xsl:if>

				<xsl:if test="VehiculeManufacturerSparPartNumber">
					<xsl:call-template name="GetReply">
						<xsl:with-param name="Node" select="VehiculeManufacturerSparPartNumber"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(VehiculeManufacturerSparPartNumber)">
					<td>
					</td>
				</xsl:if>

				<td> </td>

				<xsl:if test="Traca">
					<xsl:call-template name="GetReply">
						<xsl:with-param name="Node" select="Traca"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(Traca)">
					<td>
					</td>
				</xsl:if>

				<xsl:if test="Daimler">
					<xsl:call-template name="GetReply">
						<xsl:with-param name="Node" select="Daimler"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(Daimler)">
					<td>
					</td>
				</xsl:if>

			</xsl:when>
			<xsl:otherwise>

				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="Order"/>
				</xsl:call-template>
				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="ProgrammingStamp[@Id = '0']/Identification/Hardware"/>
				</xsl:call-template>
				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="ProgrammingStamp[@Id = 'N']/Identification/Order"/>
				</xsl:call-template>
				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="AssemblyKitIdentification"/>
				</xsl:call-template>
				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="VehiculeManufacturerSparPartNumber"/>
				</xsl:call-template>
				<td> </td>
				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="Traca"/>
				</xsl:call-template>
				<xsl:call-template name="GetReply">
					<xsl:with-param name="Node" select="Daimler"/>
				</xsl:call-template>


			</xsl:otherwise>
		</xsl:choose>


	</tr>

	</xsl:if>

</xsl:template>

<xsl:template match="Function/IdentificationUDS" mode="SpecificIdent">

	<tr>

		<th>
			<xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
			<xsl:value-of select="../@Name"/>
		</th>
		<xsl:choose>
			<xsl:when test="Error" >
				<td colspan="10" class="commError">
					Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=
					<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
					</b>&#xA0;Description : <b>'<xsl:value-of select="Error/@Msg"/>'</b>
					<!--Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive :
					<xsl:value-of select="Error/Request/@Receive"/>-->
				</td>
			</xsl:when>

			<xsl:otherwise>
				<xsl:call-template name="GetUDSReply">
					<xsl:with-param name="Node" select="configurationFileReferenceLink"/>
				</xsl:call-template>
				<td colspan="4"> </td>
				<td > </td>

						<xsl:call-template name="GetUDSReply">
									<xsl:with-param name="Node" select="ecuSerialNumber "/>
						</xsl:call-template>

				<td > </td>
			</xsl:otherwise>
		</xsl:choose>


	</tr>
	<td colspan="30">
		<xsl:text >&#160;</xsl:text>
	</td>

</xsl:template>



<xsl:template name="SpecificIdentHeader">
	<tr>
		<td> </td>
		<th colspan="5">RUC Specification C<br/>Ident</th>
		<td > </td>
		<th colspan="2">Others<br/>Ident </th>
	</tr>

	<tr>
		<th>ECU</th>
		<th>Part Number Ref<br/><i>2180</i></th>
		<th>Hardware Number Ref<br/><i>21F0</i></th>
		<th>Part Number Ref<br/><i>21FE</i></th>
		<th>Assembly Kit <br/>Identification<br/><i>22F18E</i></th>
		<th>Vehicule Manufacturer <br/>Spar Part Number<br/><i>22F187</i></th>

		<td width="5px" > </td>
		<th>Traca<br/>2184</th>
		<th>Partners Number<br/>21EF</th>
	</tr>
	<tr></tr>
</xsl:template>

<xsl:template name="SpecificIdentHeaderOnError">
	<tr>
		<td> </td>
		<th colspan="15">No responding ECU</th>
	</tr>

</xsl:template>

<xsl:template name="SpecificIdentHeaderUDS">
	<tr>
		<td> </td>
		<th colspan="5"> RUC UDS<br/>Ident</th>
		<td > </td>
		<th colspan="2">Others<br/>Ident </th>

	</tr>

	<tr>
		<th>ECU</th>
		<th>Config Ref <br/>(or Operationnal Ref) <br/><i>22F188</i></th>
		<th colspan="4"/>

		<td width="5px" > </td>
		<th>Ecu Serial Number <br/>22F18C</th>
		<th></th>

	</tr>
	<tr></tr>
</xsl:template>
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<!-- ========================================================================================= -->
<!-- -->
<!-- ========================================================================================= -->
<xsl:template match="Identifications | Failures" mode="historic">
<!-- Affichage du detail de chaque calculateur -->
<table class="identification" width="100%">
	  <tr>
	    <th>Ecu</th>
	    <th>History</th>
	    <xsl:call-template name="ReprogCommonHeader"/>
	  </tr>
	<xsl:apply-templates select="Function[@Address!= 0 and @Address != 255]" mode="historic"/>
</table>
<xsl:call-template name="legend"/>
</xsl:template>

<xsl:template name="ReprogCommonHeader">
	    <th>R/N</th>
	    <th>Part<br/>Number</th>
	    <th>Diag.<br/>Version</th>
	    <th>Supplier</th>
	    <th>Hardware<br/>Number</th>
	    <th>Soft</th>
	    <th>Version</th>
	    <th>Calibration</th>
	    <th>Reserved/<br/>Basic Part list</th>
	    <th>Format</th>
	    <th>&#xA0;</th>
	    <th>Approval<br/>Number</th>
	    <th>Site</th>
	    <th>Tool</th>
	    <th>Nb</th>
	    <th>Date</th>
	    <th>Res.</th>
	    <th>Mark</th>
	    <th>CRC</th>
	    <th>Check<br/>CRC</th>
</xsl:template>

<xsl:template name="ReprogCommonHeaderUDS">
	<th>R/N</th>
	<th>Part Number Ref<br/>(F187)</th>
	<th>Diag. Version<br/>(F1A0)</th>
	<th>Supplier<br/>(F18A)</th>
	<th>Hardware Ref<br/>(F191)</th>
	<th>Soft<br/>(F194)</th>
	<th>Version<br/>(F195)</th>
	<th>Calibration Ref<br/>(F182)</th>
	<th>Reserved</th>
	<th>Format</th>
	<th>&#xA0;</th>
	<th>Approval<br/>Number</th>
	<th>Site</th>
	<th>Tool</th>
	<th>Nb</th>
	<th>Date</th>
	<th>Res.</th>
	<th>Mark</th>
	<th>CRC</th>
	<th>Check<br/>CRC</th>
		

</xsl:template>


<!-- ========================================================================================= -->
<!--    Affichage des historiques      -->
<!-- ========================================================================================= -->
<xsl:template match="Function" mode="historic">
<!-- Affichage du detail de chaque calculateur -->
<xsl:choose>
	<xsl:when test="Error">
		<tr>
                        <th><xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
                               <xsl:value-of select="@Name"/>
                        </th>
			<td colspan="21" class="commError">
				Error: <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
				</b>&#xA0;Description : <b>'<xsl:value-of select="Error/@Msg"/>'</b>
				<xsl:if test="Error/Request">
					Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive : <xsl:value-of select="Error/Request/@Receive"/>
				</xsl:if>
			</td>
		</tr>
	</xsl:when>
	<xsl:when test="Identification/ProgrammingStamp">
		<tr>
			<xsl:apply-templates select="Identification/ProgrammingStamp" mode="all">
				<xsl:with-param name="fname"><xsl:value-of select="@Name"/></xsl:with-param>
				<xsl:with-param name="pp"><xsl:value-of select="count(Identification/ProgrammingStamp)"/></xsl:with-param>
			</xsl:apply-templates>
		</tr>
	</xsl:when>
	<xsl:when test="IdentificationUDS">
		<tr>
			<th><xsl:value-of select="@Name"/></th>
			<td colspan="21" class="notReprogrammable">ECU has no historic</td>
		</tr>
	</xsl:when>
	<xsl:otherwise>
		<tr>
			<th><xsl:value-of select="@Name"/></th>
			<td colspan="21" class="notReprogrammable">ECU is not reprogrammable</td>
		</tr>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ==================================================================================== -->
<!--                       Affichage d'une ligne d'histotique                             -->
<!-- ==================================================================================== -->
<xsl:template match="ProgrammingStamp" mode="all">
<xsl:param name="fname"/>
<xsl:param name="pp"/>
<TR>
	<xsl:if test="$fname!=''">
		<xsl:if test="position()=1"><th><xsl:attribute name="rowspan"><xsl:value-of select="$pp"/></xsl:attribute><xsl:value-of select="$fname"/></th></xsl:if>
	</xsl:if>
	<TH class="histoId"><xsl:value-of select="@Id"/></TH>
	<xsl:apply-templates select="Identification">
		<xsl:with-param name="dmode">histo</xsl:with-param>
	</xsl:apply-templates>
	<TD class="histoO"></TD>
	<TD class="histoO"><xsl:value-of select="Approval/@Number"/></TD>
	<TD class="histoO"><xsl:value-of select="Tool/@Location"/></TD>
	<TD class="histoO"><xsl:value-of select="Tool/@Name"/></TD>
	<TD class="histoO">$<xsl:value-of select="@Number"/></TD>
	<TD class="histoO"><xsl:value-of select="Tool/@Date"/></TD>
	<TD class="histoO"><xsl:value-of select="SpecificData/@Number"/></TD>
	<TD class="histoO">$<xsl:value-of select="@Marker"/></TD>
	<TD class="histoO"><xsl:value-of select="@CRC"/></TD>
	<TD>
		<xsl:choose>
			<xsl:when test="@checkCRC='OK' or @checkCRC='Ok'"><xsl:attribute name="class">crcOk</xsl:attribute>Ok</xsl:when>
			<xsl:otherwise><xsl:attribute name="class">crcNOk</xsl:attribute><xsl:value-of select="@checkCRC"/></xsl:otherwise>
		</xsl:choose>
	</TD>
</TR>
</xsl:template>


<xsl:template match="Error">
<tr>
	<td>Code</td>
	<td ALIGN="CENTER">
	<a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="@Code"/></xsl:attribute><xsl:value-of select="@Code"/></a></td>
</tr>
<tr>
	<td>Message</td>
	<td ALIGN="CENTER"><xsl:value-of select="@Msg"/></td>
</tr>
</xsl:template>



<!-- ==================================================================================== -->
<!--                       Affichage identification                                       -->
<!-- ==================================================================================== -->
<xsl:template match="Identification[not(Error)] | Identification83[not(Error)]">
<xsl:param name="dmode"/>
<xsl:variable name="tdclass">
	<xsl:choose>
		<xsl:when test="$dmode='histo'">histoO</xsl:when>
		<xsl:when test="@Coding='5DIGITS' and substring(Order/@Number,6,5)='00000'">boot</xsl:when>
		<xsl:when test="Order/@Number='0000000000'">boot</xsl:when>
		<xsl:when test="$dmode='nissan' and @Coding">NidentOk</xsl:when>
		<xsl:when test="$dmode='nissan' and not(@Coding)">NidentOk</xsl:when>
		<xsl:when test="@Coding">identOk</xsl:when>
		<xsl:otherwise>identOk</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="tdclassfmt">
	<xsl:choose>
		<xsl:when test="$dmode='histo'">histoO</xsl:when>
		<xsl:when test="@Coding='5DIGITS' and substring(Order/@Number,6,5)='00000'">boot</xsl:when>
		<xsl:when test="Order/@Number='0000000000'">boot</xsl:when>
		<xsl:when test="$dmode='nissan' and @Coding">NidentOk</xsl:when>
		<xsl:when test="$dmode='nissan' and not(@Coding)">NidentNOk</xsl:when>
		<xsl:when test="@Coding">identOk</xsl:when>
		<xsl:otherwise>identNOk</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="ecuFunction"  select="(../@Address | ../../../@Address)" />
<xsl:variable name="itgHex"       select="substring(@Binary | ../BinaryData/@Part1, 13, 6)" />
<xsl:variable name="supplierName" select="document('./ITG_Codes.xml')/ITG/supplier[number(@function)=$ecuFunction and @hex=$itgHex]/@name" />

<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute><xsl:value-of select="@Coding"/></td>
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute><xsl:value-of select="Order/@Number"/></td>
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute>$<xsl:value-of select="@Diagnostic"/></td>
<xsl:choose>
	<xsl:when test="$supplierName!=''">
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute>
<xsl:attribute name="title"><xsl:value-of select="$supplierName" /></xsl:attribute>
<xsl:attribute name="style">cursor:pointer;</xsl:attribute>
<xsl:value-of select="@Supplier"/>
</td>
	</xsl:when>
	<xsl:otherwise>
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute>
<xsl:value-of select="@Supplier"/>
</td>
	</xsl:otherwise>
</xsl:choose>
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute><xsl:value-of select="Hardware/@Number"/></td>
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute>$<xsl:value-of select="@Application"/></td>
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute>$<xsl:value-of select="@Version"/></td>
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute>$<xsl:value-of select="Tuning/@Number"/></td>
<td><xsl:attribute name="class"><xsl:value-of select="$tdclass"/></xsl:attribute>
	<xsl:choose>
		<xsl:when test="OtherSystemFeatures/@Number"><xsl:value-of select="OtherSystemFeatures/@Number"/></xsl:when>
		<xsl:when test="BomcPartNumber">
			<xsl:if test="BomcPartNumber/@BasicPartList"><span title="Part Number Basic List index">Pn <xsl:value-of select="BomcPartNumber/@BasicPartList"/></span></xsl:if>
			<xsl:if test="BomcHardwareNumber/@BasicPartList">&#xA0;<span title="Hardware Number Basic List index">Hn <xsl:value-of select="BomcHardwareNumber/@BasicPartList"/></span></xsl:if>
			<xsl:if test="BomcApprovalNumber/@BasicPartList">&#xA0;<span title="Approval Number Basic List index">An <xsl:value-of select="BomcApprovalNumber/@BasicPartList"/></span></xsl:if>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="SpecificData/@Number"/></xsl:otherwise>
	</xsl:choose>
</td>
<td>
	<xsl:attribute name="class"><xsl:value-of select="$tdclassfmt"/></xsl:attribute>
	$<xsl:value-of select="ManufacturerIdCode/@Number"/>
</td>
</xsl:template>

<!-- ==================================================================================== -->
<!--                                          UDS                                         -->
<!-- ==================================================================================== -->
<xsl:template match="IdentificationUDS">
	<tr>
		<td class="identUDSOk">UDS</td>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="Order"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="Diagnostic"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="Supplier"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="Hardware"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="Application"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="Version"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="Tuning"/>
		</xsl:call-template>
    <xsl:call-template name="GetUDSReply">
      <xsl:with-param name="Node" select="ConfigurationDataReferenceAfterConfigurationProcess"/>
    </xsl:call-template>
    <td><xsl:attribute name="class">identUDSOk</xsl:attribute>&#160;</td>
		<td><xsl:attribute name="class">identUDSOk</xsl:attribute>&#160;</td>
	</tr>
	<tr>
		<xsl:call-template name="UDSIdentHeader2"/>
	</tr>
	<tr>
		<td class="identUDSOk">UDS</td>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="vehicleManufacturerKitAssemblyPartNumber"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="bootVersion"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="ecuSerialNumber"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="operationalReference"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="SecondaryOperationalReference"/>
		</xsl:call-template>

		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="vehicleManufacturerSparePartNumber"/>
		</xsl:call-template>
    <xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="configurationFileReferenceLink"/>
		</xsl:call-template>
    <td><xsl:attribute name="class">identUDSOk</xsl:attribute>&#160;</td>
    <td><xsl:attribute name="class">identUDSOk</xsl:attribute>&#160;</td>
    <td><xsl:attribute name="class">identUDSOk</xsl:attribute>&#160;</td>
	</tr>
</xsl:template>

<!-- ==================================================================================== -->
<xsl:template name="GetUDSReply">
	<xsl:param name="Node"/>


	<td>
		<xsl:choose>
			<xsl:when test="$Node/Error">

				<xsl:attribute name="style">cursor:pointer</xsl:attribute>
				<xsl:attribute name="class">identUDSError</xsl:attribute>
				<xsl:attribute name="title">Error code: <xsl:value-of select="$Node/Error/@Code"/>, <xsl:value-of select="$Node/Error/@Msg"/></xsl:attribute>

				Request : <xsl:value-of select="$Node/Error/@Send"/><br/>
				<xsl:if test="$Node/Error/Request">
					Receive : <xsl:value-of select="$Node/Error/Request/@Receive"/>
				</xsl:if>
				<xsl:if test="not($Node/Error/Request)">
					Receive : No Reply
				</xsl:if>

			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">identUDSOk</xsl:attribute>
				<xsl:value-of select="$Node/@Number"/>
			</xsl:otherwise>
		</xsl:choose>


	</td>


</xsl:template>

<!-- ==================================================================================== -->
<xsl:template name="GetReply">
	<xsl:param name="Node"/>


	<td>
		<xsl:choose>
			<xsl:when test="$Node/Error">

				<xsl:attribute name="style">cursor:pointer</xsl:attribute>
				<xsl:attribute name="class">identUDSError</xsl:attribute>
				<xsl:attribute name="title">Error code: <xsl:value-of select="$Node/Error/@Code"/>, <xsl:value-of select="$Node/Error/@Msg"/></xsl:attribute>

				Request : <xsl:value-of select="$Node/Error/Request/@Send"/><br/>
				<xsl:if test="$Node/Error/Request">
					Receive : <xsl:value-of select="$Node/Error/Request/@Receive"/>
				</xsl:if>
				<xsl:if test="not($Node/Error/Request)">
					Receive : No Reply
				</xsl:if>

			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">identOk</xsl:attribute>
				<xsl:value-of select="$Node/@Number"/>
			</xsl:otherwise>
		</xsl:choose>


	</td>


</xsl:template>

<!-- ==================================================================================== -->




<xsl:template match="Identification[Error]|Identification83[Error]">
<td colspan="10" class="commError">
	Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
	</b>&#xA0;Description : <b>'<xsl:value-of select="Error/@Msg"/>'</b>
	Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive : <xsl:value-of select="Error/Request/@Receive"/>
</td>
</xsl:template>


<xsl:template name="msgcomerror">
<FONT COLOR="#FF0000" SIZE="3"><b><xsl:choose>
	<xsl:when test="$lang='fr'">Erreur de communication</xsl:when>
	<xsl:otherwise>Com error</xsl:otherwise>
</xsl:choose></b></FONT>
</xsl:template>

<xsl:template name="IdentHeader">
	<!-- <th>ECUs</th> -->
	<th>R/N</th>
	<th>Part Number Ref</th>
	<th>Diag.<br/>Version</th>
	<th>Supplier</th>
	<th>Hardware Ref</th>
	<th>Soft</th>
	<th>Version</th>
	<th>Calibration Ref</th>
	<th>Reserved</th>
	<th>Format</th>
</xsl:template>
<xsl:template name="UDSIdentHeader1">
	<!-- <th>ECUs</th> -->
	<th>R/N</th>
	<th>Part Number Ref<br/>(F187)</th>
	<th>Diag. Version<br/>(F1A0)</th>
	<th>Supplier<br/>(F18A)</th>
	<th>Hardware Ref<br/>(F191)</th>
	<th>Soft<br/>(F194)</th>
	<th>Version<br/>(F195)</th>
	<th>Calibration Ref<br/>(F182)</th>
  <th>Config Data Ref After Config Process<br/>(F1A2)</th>
  <th>Reserved</th>
	<th>Format</th>
</xsl:template>
<xsl:template name="UDSIdentHeader2">
	<!-- <th>ECUs</th> -->
	<th>R/N</th>
	<th>KitAssembly Ref<br/>(F18E)</th>
	<th>Boot Version<br/>(F180)</th>
	<th>Serial Number<br/>(F18C)</th>
	<th>Operationnal Ref<br/>(F012)</th>
	<th>Secondary Operationnal Ref<br/>(F013)</th>
	<th>Nissan P Number<br/>(F1A1)</th>
  <th>RUC<br/>(F188)</th>
	<th> </th>
  <th> </th>
  <th> </th>
</xsl:template>

<xsl:template name="cssstyle">
<style id="failurecss" type="text/css">
  A       {color: white}
  A:hover	{TEXT-DECORATION: underline}
  A:active{TEXT-DECORATION: underline}
  DIV	{BACKGROUND-COLOR: #c6c3bd;MARGIN: 1px}
  H2	{PADDING-RIGHT: 4pt;PADDING-LEFT: 5pt;PADDING-BOTTOM: 4pt;COLOR: white;PADDING-TOP: 4pt;BACKGROUND-COLOR: black}
  H2 A	{COLOR: ivory}
  PRE	{FONT-SIZE: 8pt;display:inline}

  .error	{ font-size: 12pt; color: #FF0000; text-align: center; font-weight: bold }

  TABLE.identification			{BORDER-COLLAPSE: collapse;FONT-SIZE: 10pt}
  TABLE.identification TH			{BACKGROUND-COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px}
  TABLE.identification TH.fctname		{BACKGROUND-COLOR: #444444;COLOR:White;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: left}
  TABLE.identification TH.InitError	{BACKGROUND-COLOR: #c00000;COLOR:White;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px}
  TABLE.identification TH.histoId		{BACKGROUND-COLOR: orange;COLOR:black;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px}

  TABLE.identification TD			{BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.identOk		{BACKGROUND-COLOR: #508A50;COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.NidentOk	{BACKGROUND-COLOR: darkgreen;COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.identNOk	{BACKGROUND-COLOR: orange;COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.NidentNOk	{BACKGROUND-COLOR: orange;COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.histoO		{BACKGROUND-COLOR: #E0E0E0;COLOR: black;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.boot		{BACKGROUND-COLOR: red;COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.crcOK		{BACKGROUND-COLOR: green;COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.crcNOK		{BACKGROUND-COLOR: red;COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: center}
  TABLE.identification TD.notReprogrammable {BACKGROUND-COLOR: #C0C0FF;COLOR: black;BORDER-RIGHT:1px solid black;font-style:italic;}
  TABLE.identification TD.commError	{BACKGROUND-COLOR: #c00000;COLOR: white;BORDER-RIGHT:1px solid black;font-style:italic;}
  TABLE.identification TD.identUDSOk	{BACKGROUND-COLOR: #0080ff;COLOR: white;border:1px solid black;TEXT-ALIGN: center}
  TABLE.identification TD.identUDSError	{BACKGROUND-COLOR: #FF0000  ;COLOR: white;text-align:left !important;font-size:85% !important;padding-left:2px;}

  TABLE.legend			{BORDER-COLLAPSE: collapse;FONT-SIZE: 10pt}
  TH.legend			{text-align:left}
  TD.legendFctName		{BACKGROUND-COLOR: white    ;COLOR: black;BORDER:1px solid black;}
  TD.legendInitError		{BACKGROUND-COLOR: #c00000  ;COLOR: white;BORDER:1px solid black;}
  TD.legendIdentOk		{BACKGROUND-COLOR: #508A50  ;COLOR: white;BORDER:1px solid black;}
  TD.legendNIdentOk		{BACKGROUND-COLOR: darkgreen;COLOR: white;BORDER:1px solid black;}
  TD.legendIdentNOk		{BACKGROUND-COLOR: orange   ;COLOR: white;BORDER:1px solid black;}
  TD.legendNIdentNOk		{BACKGROUND-COLOR: orange   ;COLOR: white;BORDER:1px solid black;}
  TD.legendHistoO			{BACKGROUND-COLOR: #E0E0E0  ;COLOR: black;BORDER:1px solid black;}
  TD.legendBoot			{BACKGROUND-COLOR: red      ;COLOR: white;BORDER:1px solid black;}
  TD.legendCrcOK			{BACKGROUND-COLOR: green    ;COLOR: white;BORDER:1px solid black;}
  TD.legendCrcNOK			{BACKGROUND-COLOR: red      ;COLOR: white;BORDER:1px solid black;}
  TD.legendNotReprogrammable	{BACKGROUND-COLOR: #C0C0FF  ;COLOR: black;BORDER:1px solid black;}
  TD.legendIdentUDSOk             {BACKGROUND-COLOR: #0080ff  ;COLOR: white;BORDER:1px solid black;}

  <!-- https://github.com/gbv/lbs2daia/blob/master/daia.css -->
  /* xmlverbatim */
  .xmlverb-default          { color: #333; font-family: monospace;
  font-size: medium; padding-left: 1em; border-left: 2px solid #D5D5D5; }
  .xmlverb-element-name     { color: #900 }
  .xmlverb-element-nsprefix { color: #660 }
  .xmlverb-attr-name        { color: #600 }
  .xmlverb-attr-content     { color: #009; font-weight: bold }
  .xmlverb-ns-name          { color: #660 }
  .xmlverb-ns-uri           { color: #309 }
  .xmlverb-text             { color: #000; font-weight: bold }
  .xmlverb-comment          { color: #060; font-style: italic }
  .xmlverb-pi-name          { color: #060; font-style: italic }
  .xmlverb-pi-content       { color: #066; font-style: italic }

</style>
</xsl:template>


  <!-- part inspired by https://github.com/gbv/lbs2daia/blob/master/xmlverbatim.xsl to display xml source code in HTML (raw data) -->
  <!--
    XML to HTML Verbatim Formatter with Syntax Highlighting
    Version 1.1
    Contributors: Doug Dicks, added auto-indent (parameter indent-elements)
                  for pretty-print
    Copyright 2002 Oliver Becker
    ob@obqo.de
 
    Licensed under the Apache License, Version 2.0 (the "License"); 
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
    Unless required by applicable law or agreed to in writing, software distributed
    under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
    CONDITIONS OF ANY KIND, either express or implied. See the License for the
    specific language governing permissions and limitations under the License.
    Alternatively, this software may be used under the terms of the 
    GNU Lesser General Public License (LGPL).
  -->

  <!-- root -->
  <xsl:template match="/" mode="xmlverb">
    <xsl:text>&#xA;</xsl:text>
    <xsl:comment>
      <xsl:text> converted by xmlverbatim.xsl 1.1, (c) O. Becker </xsl:text>
    </xsl:comment>
    <xsl:text>&#xA;</xsl:text>
    <div class="xmlverb-default">
      <xsl:apply-templates mode="xmlverb">
        <xsl:with-param name="indent-elements" select="$indent-elements" />
      </xsl:apply-templates>
    </div>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <!-- wrapper -->
  <xsl:template match="verb:wrapper">
    <xsl:apply-templates mode="xmlverb">
      <xsl:with-param name="indent-elements" select="$indent-elements" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="verb:wrapper" mode="xmlverb">
    <xsl:apply-templates mode="xmlverb">
      <xsl:with-param name="indent-elements" select="$indent-elements" />
    </xsl:apply-templates>
  </xsl:template>

  <!-- element nodes -->
  <xsl:template match="*" mode="xmlverb">
    <xsl:param name="indent-elements" select="false()" />
    <xsl:param name="indent" select="''" />
    <xsl:param name="indent-increment" select="'&#xA0;&#xA0;&#xA0;'" />
    <xsl:if test="$indent-elements">
      <br/>
      <xsl:value-of select="$indent" />
    </xsl:if>
    <xsl:text>&lt;</xsl:text>
    <xsl:variable name="ns-prefix"
                  select="substring-before(name(),':')" />
    <xsl:if test="$ns-prefix != ''">
      <span class="xmlverb-element-nsprefix">
        <xsl:value-of select="$ns-prefix"/>
      </span>
      <xsl:text>:</xsl:text>
    </xsl:if>
    <span class="xmlverb-element-name">
      <xsl:value-of select="local-name()"/>
    </span>
    <xsl:variable name="pns" select="../namespace::*"/>
    <xsl:if test="$pns[name()=''] and not(namespace::*[name()=''])">
      <span class="xmlverb-ns-name">
        <xsl:text> xmlns</xsl:text>
      </span>
      <xsl:text>=&quot;&quot;</xsl:text>
    </xsl:if>
    <xsl:for-each select="namespace::*">
      <xsl:if test="not($pns[name()=name(current()) and 
                           .=current()])">
        <xsl:call-template name="xmlverb-ns" />
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="@*">
      <xsl:call-template name="xmlverb-attrs" />
    </xsl:for-each>
    <xsl:choose>
      <xsl:when test="node()">
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates mode="xmlverb">
          <xsl:with-param name="indent-elements"
                          select="$indent-elements"/>
          <xsl:with-param name="indent"
                          select="concat($indent, $indent-increment)"/>
          <xsl:with-param name="indent-increment"
                          select="$indent-increment"/>
        </xsl:apply-templates>
        <xsl:if test="* and $indent-elements">
          <br/>
          <xsl:value-of select="$indent" />
        </xsl:if>
        <xsl:text>&lt;/</xsl:text>
        <xsl:if test="$ns-prefix != ''">
          <span class="xmlverb-element-nsprefix">
            <xsl:value-of select="$ns-prefix"/>
          </span>
          <xsl:text>:</xsl:text>
        </xsl:if>
        <span class="xmlverb-element-name">
          <xsl:value-of select="local-name()"/>
        </span>
        <xsl:text>&gt;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> /&gt;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="not(parent::*)">
      <br />
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- attribute nodes -->
  <xsl:template name="xmlverb-attrs">
    &#160; <!-- &nbsp; -->
    <span class="xmlverb-attr-name">
      <xsl:value-of select="name()"/>
    </span>
    <xsl:text>=&quot;</xsl:text>
    <span class="xmlverb-attr-content">
      <xsl:call-template name="html-replace-entities">
        <xsl:with-param name="text" select="normalize-space(.)" />
        <xsl:with-param name="attrs" select="true()" />
      </xsl:call-template>
    </span>
    <xsl:text>&quot;</xsl:text>
  </xsl:template>

  <!-- namespace nodes -->
  <xsl:template name="xmlverb-ns">
    <xsl:if test="name()!='xml'">
      <span class="xmlverb-ns-name">
        <xsl:text> xmlns</xsl:text>
        <xsl:if test="name()!=''">
          <xsl:text>:</xsl:text>
        </xsl:if>
        <xsl:value-of select="name()"/>
      </span>
      <xsl:text>=&quot;</xsl:text>
      <span class="xmlverb-ns-uri">
        <xsl:value-of select="."/>
      </span>
      <xsl:text>&quot;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- text nodes -->
  <xsl:template match="text()" mode="xmlverb">
    <span class="xmlverb-text">
      <xsl:call-template name="preformatted-output">
        <xsl:with-param name="text">
          <xsl:call-template name="html-replace-entities">
            <xsl:with-param name="text" select="." />
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </span>
  </xsl:template>

  <!-- comments -->
  <xsl:template match="comment()" mode="xmlverb">
    <xsl:text>&lt;!--</xsl:text>
    <span class="xmlverb-comment">
      <xsl:call-template name="preformatted-output">
        <xsl:with-param name="text" select="." />
      </xsl:call-template>
    </span>
    <xsl:text>--&gt;</xsl:text>
    <xsl:if test="not(parent::*)">
      <br />
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- processing instructions -->
  <xsl:template match="processing-instruction()" mode="xmlverb">
    <xsl:text>&lt;?</xsl:text>
    <span class="xmlverb-pi-name">
      <xsl:value-of select="name()"/>
    </span>
    <xsl:if test=".!=''">
      &#160; <!-- &nbsp; -->
      <span class="xmlverb-pi-content">
        <xsl:value-of select="."/>
      </span>
    </xsl:if>
    <xsl:text>?&gt;</xsl:text>
    <xsl:if test="not(parent::*)">
      <br />
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>


  <!-- =========================================================== -->
  <!--                    Procedures / Functions                   -->
  <!-- =========================================================== -->

  <!-- generate entities by replacing &, ", < and > in $text -->
  <xsl:template name="html-replace-entities">
    <xsl:param name="text" />
    <xsl:param name="attrs" />
    <xsl:variable name="tmp">
      <xsl:call-template name="replace-substring">
        <xsl:with-param name="from" select="'&gt;'" />
        <xsl:with-param name="to" select="'&amp;gt;'" />
        <xsl:with-param name="value">
          <xsl:call-template name="replace-substring">
            <xsl:with-param name="from" select="'&lt;'" />
            <xsl:with-param name="to" select="'&amp;lt;'" />
            <xsl:with-param name="value">
              <xsl:call-template name="replace-substring">
                <xsl:with-param name="from"
                                select="'&amp;'" />
                <xsl:with-param name="to"
                                select="'&amp;amp;'" />
                <xsl:with-param name="value"
                                select="$text" />
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <!-- $text is an attribute value -->
      <xsl:when test="$attrs">
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="from" select="'&#xA;'" />
          <xsl:with-param name="to" select="'&amp;#xA;'" />
          <xsl:with-param name="value">
            <xsl:call-template name="replace-substring">
              <xsl:with-param name="from"
                              select="'&quot;'" />
              <xsl:with-param name="to"
                              select="'&amp;quot;'" />
              <xsl:with-param name="value" select="$tmp" />
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$tmp" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- replace in $value substring $from with $to -->
  <xsl:template name="replace-substring">
    <xsl:param name="value" />
    <xsl:param name="from" />
    <xsl:param name="to" />
    <xsl:choose>
      <xsl:when test="contains($value,$from)">
        <xsl:value-of select="substring-before($value,$from)" />
        <xsl:value-of select="$to" />
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="value"
                          select="substring-after($value,$from)" />
          <xsl:with-param name="from" select="$from" />
          <xsl:with-param name="to" select="$to" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$value" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- preformatted output: space as &nbsp;, tab as 8 &nbsp;
                             nl as <br> -->
  <xsl:template name="preformatted-output">
    <xsl:param name="text" />
    <xsl:call-template name="output-nl">
      <xsl:with-param name="text">
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="value"
                          select="translate($text,' ','&#xA0;')" />
          <xsl:with-param name="from" select="'&#9;'" />
          <xsl:with-param name="to"
                          select="'&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;'" />
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- output nl as <br> -->
  <xsl:template name="output-nl">
    <xsl:param name="text" />
    <xsl:choose>
      <xsl:when test="contains($text,'&#xA;')">
        <xsl:value-of select="substring-before($text,'&#xA;')" />
        <br />
        <xsl:text>&#xA;</xsl:text>
        <xsl:call-template name="output-nl">
          <xsl:with-param name="text"
                          select="substring-after($text,'&#xA;')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>