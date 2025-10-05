<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl local xql verb"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:local="#local-functions"
  xmlns:verb="#verb"
	xmlns:xql="#xql-functions"
>
<xsl:output method="html" encoding="windows-1252" indent="yes" omit-xml-declaration="yes"/>

<xsl:param name="lang"/>
<xsl:param name="scriptDisabled"/>
<xsl:param name="urlbank"/>

<!-- Updates:-->
  <!-- 20190517 - JDAM - Fix ident part in failures mode -->
  
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

  Function ToDec(t)
   ToDec = clng("&h" & t )
  End Function

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

  function WriteMultiLine(nodeList)
    dim s,s1
    dim i
    on error resume next
    nodeList.MoveNext()
    s1 = nodeList.Current.Value
    s = ""
    for i = 1 to len(s1) step 64
	    s = s + mid(s1,i,64) + "<br/>"
    next
    WriteMultiLine = s
  end function

]]>
</msxsl:script>


<xsl:template match="/">

        <!-- Switch mode according to the value of $start-mode -->
        <xsl:choose>
            <xsl:when test="$start-mode='all'">
                <xsl:apply-templates select="/" mode="all"/>
            </xsl:when>
            <xsl:when test="$start-mode='failures'">
                <xsl:apply-templates select="/" mode="failures"/>
            </xsl:when>
            <xsl:when test="$start-mode='raw'">
                <xsl:apply-templates select="/" mode="raw" />
            </xsl:when>

            <xsl:when test="$start-mode='identifications'">
                <xsl:apply-templates select="/" mode="identifications"/>
            </xsl:when>            
            <xsl:when test="$start-mode='all_identifications'">
                <xsl:apply-templates select="/" mode="all_identifications"/>
            </xsl:when>            


              
            <xsl:otherwise>
		<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
		<!--       mode autonome (uniquemement a partir IE6 (gestion native du xslt)               -->
		<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
		<html>
			<head>
			<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
			<xsl:call-template name="cssstyle"/>
			</head>
		  <body topmargin="0" leftmargin="0" bgcolor="#C6C3BD" text="#000000" link="#FFFFFF" vlink="#FFFFFF" alink="#00CC66">
		  <!--<span id="fontSizeSelector">
		  <a href="javascript:fontSize(+2)"><img alt="[Increase font size]" src="$$$_ddt2000path_$$$/images/zoom-in.gif" style="border:1" /></a>
		  <a href="javascript:fontSize(0)" ><img alt="[Default font size]"  src="$$$_ddt2000path_$$$/images/zoom-original.gif" style="border:1" /></a>
		  <a href="javascript:fontSize(-2)"><img alt="[Decrease font size]" src="$$$_ddt2000path_$$$/images/zoom-out.gif" style="border:1" /></a>
		  </span>-->
			<xsl:choose>
				<xsl:when test="Failures">
					<div>
						<h3><a name="top"><xsl:call-template name="msgtitlefailure"/></a></h3>
						<xsl:apply-templates select="Failures"/>
					</div>
				</xsl:when>
				<xsl:when test="RazFailures">
					<xsl:apply-templates select="RazFailures"/>
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
<xsl:template match="/" mode="failures">
<xsl:choose>
	<xsl:when test="Failures">
		<div>
<!--<span id="fontSizeSelector">
  <a href="javascript:fontSize(+2)"><img alt="[Increase font size]" src="$$$_ddt2000path_$$$/images/zoom-in.gif" style="border:1" /></a>
  <a href="javascript:fontSize(0)" ><img alt="[Default font size]"  src="$$$_ddt2000path_$$$/images/zoom-original.gif" style="border:1" /></a>
  <a href="javascript:fontSize(-2)"><img alt="[Decrease font size]" src="$$$_ddt2000path_$$$/images/zoom-out.gif" style="border:1" /></a>
</span>-->
			<h3><a name="top"><xsl:call-template name="msgtitlefailure"/></a></h3>
			<xsl:call-template name="cssstyle"/>
			<xsl:apply-templates select="Failures" mode="failures"/>
		</div>
	</xsl:when>
	<xsl:when test="RazFailures">
		<xsl:apply-templates select="RazFailures"/>
	</xsl:when>
</xsl:choose>
</xsl:template>

<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- ===================== Affichage de tous les organes  ================================ -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="/" mode="all">
<xsl:choose>
	<xsl:when test="Failures">
			<table width="100%" border="0">
			<tr><td>
			<h3><a name="top"><xsl:call-template name="msgtitlealldevice"/></a></h3>
			<xsl:call-template name="cssstyle"/>
			<xsl:apply-templates select="Failures" mode="all"/>
			</td></tr>
			</table>
	</xsl:when>
	<xsl:when test="RazFailures">
		<xsl:apply-templates select="RazFailures"/>
	</xsl:when>
</xsl:choose>
</xsl:template>

<xsl:template match="/" mode="all_identifications">
<xsl:choose>
	<xsl:when test="Identifications | Failures">
		<div>
			<a name="top" style="display:none;">&#160;</a>
			<xsl:call-template name="cssstyle"/>
			<xsl:apply-templates select="Identifications | Failures" mode="all_identifications"/>
		</div>
	</xsl:when>
</xsl:choose>
</xsl:template>
  
<xsl:template match="Identifications | Failures" mode="all_identifications">
<!-- Affichage du detail de chaque calculateur -->
<table class="identification" width="100%">
	<xsl:apply-templates select="Function[@Address!= 0 and @Address != 255]" mode="all_identifications"/>
</table>
<xsl:call-template name="legend"/>
</xsl:template>

<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- ========= Gestion de la l'affichage du resultat de l'effacement des pannes ========== -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="RazFailures">
	<div>
  	<a name="top"><H3>Clear Diagnostic info</H3></a>
	<xsl:call-template name="cssstyle"/>
	<table class="list" border="0">
	  <xsl:for-each select="Function">
		<tr>
			<td><xsl:value-of select="@Name"/></td>
			<td><b><xsl:value-of select="DiagName"/></b><br/>
				<ul>
					<xsl:apply-templates select="ClearRequest"/>
					<xsl:choose>
						<xsl:when test="Error">
							<li class="error">
								Error : <b>
								<a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
								</b>
								&#xA0;Description : <b><xsl:value-of select="Error/@Msg"/></b>
							</li>
						</xsl:when>
						<xsl:when test="ClearRequest/Error">
							<li class="error">
								Error : <b>
								<a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="ClearRequest/Error/@Code"/></xsl:attribute><xsl:value-of select="ClearRequest/Error/@Code"/></a>
								</b>
								&#xA0;Description : <b><xsl:value-of select="ClearRequest/Error/@Msg"/></b>
							</li>
						</xsl:when>
						<xsl:otherwise>
					  		<font color="green"><b>OK</b></font>
						</xsl:otherwise>
					</xsl:choose>
				</ul>
			</td>
		</tr>
	  </xsl:for-each>
	</table>
	</div>
</xsl:template>

<xsl:template match="ClearRequest">
<li>
<xsl:choose>
	<xsl:when test="@Name">
		Name : <b><xsl:value-of select="@Name"/></b>
	</xsl:when>
	<xsl:otherwise>
  		Erase failure request
	</xsl:otherwise>
</xsl:choose>
&#xA0;Send : <b><xsl:value-of select="@Send"/></b>
&#xA0;Received : <b><xsl:value-of select="@Receive"/></b>
<xsl:if test="Data">
	<br/>
		<table class="list" align="center" border="0">
			<tr><th>Data Name</th><th>Value</th></tr>
			<xsl:for-each select="Data">
			<tr>
				<td><xsl:value-of select="@Name"/></td>
				<td><xsl:value-of select="@Text"/></td>
			</tr>
			</xsl:for-each>
		</table>
</xsl:if>

</li>
</xsl:template>

<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!--                        Gestion de l'affichage des pannes                              -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="Failures"  mode="failures">

<!-- message global si aucune erreur n'est detectée -->
<xsl:apply-templates select="Date"/>
<xsl:if test="Comment != ''">
	<xsl:apply-templates select="Comment"/>
</xsl:if>
<xsl:choose>
	<xsl:when test="Function/Devices/Device/DTC | Function/Unknown/DTC">
		<h3 id="summary"><xsl:call-template name="nbfailures">
			<xsl:with-param name="nb"     select="count(Function/Devices/Device[DTC[not(@Failure='TestNotCompleted')]] | Function/Unknown/DTC)"/>
			<xsl:with-param name="nbFc"   select="count(Function/Devices/Device[DTC/@Failure='Current'] | Function/Devices/Device[DTC/@Failure='TestNotCompleted Current'])"/>
			<xsl:with-param name="nbFh"   select="count(Function/Devices/Device[DTC/@Failure='Historical'] | Function/Devices/Device[DTC/@Failure='TestNotCompleted Historical'])"/>
			<xsl:with-param name="nbFtnc" select="count(Function/Devices/Device[DTC/@Failure='TestNotCompleted'])"/>
			<xsl:with-param name="nbFinco" select="count(Function/Devices/Device[DTC/@Failure='StatusIncoherent'])"/>
			<xsl:with-param name="nbUnknow" select="count(Function/Unknown/DTC)"/>
		</xsl:call-template></h3>
	</xsl:when>
	<xsl:otherwise>
		 <xsl:choose>
			<xsl:when test="Function/Requests/Request[(@Name='ReadDTC' or @Name='ReadDTCInformation.ReportDTC') and Error]">
			 	<H3 style="color:red;" id="summary"><xsl:call-template name="readDtcError"/></H3>
			</xsl:when>
			<xsl:otherwise>
			 	<H3 id="summary"><xsl:call-template name="nofailure"/></H3>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:otherwise>
</xsl:choose>

<!-- Afficher la table des matieres -->

  <ul class="tdm">
  <!-- en premier les calculateurs ayant des pannes -->
  <!-- xsl:for-each select="Function[Devices/Device/DTC[not(@Failure='TestNotCompleted')]] | Function[Unknown/DTC]" -->
  <xsl:for-each select="Function[Devices/Device/DTC] | Function[Unknown/DTC]">
  	<li class="tdmecu">
  	<A><xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
  		<xsl:attribute name="name">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
  		<xsl:value-of select="@Name"/> -
  		<B><xsl:value-of select="DiagName"/></B></A>&#xA0;
  		<xsl:if test="Devices/Device/DTC[not(@Failure='TestNotCompleted')] | Unknown/DTC">
			<xsl:call-template name="msgfctfailures"/>
		</xsl:if>
  		<xsl:if test="Devices/Device/DTC[@Failure='TestNotCompleted']">
			<xsl:call-template name="msgtestnotcompleted"/>
		</xsl:if>
    <xsl:if test="Devices/Device/DTC[not(@Failure='TestNotCompleted')] | Unknown/DTC">
		  	<ul>
		        <xsl:for-each select="Devices/Device[DTC[not(@Failure='TestNotCompleted')]]">
		  				<li class="tdmdev">
		  					<A>
  								<xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
  								<xsl:value-of select="@Name"/>
  							</A>
							<xsl:if test="DTC">
								<font size="-1">
									&#xA0;<xsl:call-template name="msgfailure">
										<xsl:with-param name="tpanne" select="DTC/@Failure"/>
									</xsl:call-template>
								</font>
							</xsl:if>
  							<xsl:if test="DTCorder">
  								order = <xsl:value-of select="@DTCorder"/>
  							</xsl:if>
		          </li>
		  			</xsl:for-each>
		        <xsl:for-each select="Unknown/DTC">
		  				<li class="tdmdev">
		  					<xsl:call-template name="lbunknown"/> : <A>
  								<xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
  								<xsl:value-of select="@Name"/></A>
                  <!-- QC457: Display DTC status (failures mode)-->
                  <font size="-1">
                    &#xA0;
                    <xsl:call-template name="msgfailure">
                      <xsl:with-param name="tpanne" select="@Failure"/>
                    </xsl:call-template>
                  </font>
		          </li>
		  			</xsl:for-each>
		      </ul>
		</xsl:if>
  	</li>
  </xsl:for-each>

  <!-- en second les calculateurs ayant une erreur de communication -->
  <xsl:for-each select="Function[Error]">
  	<li class="tdmecu">
  		<A><xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
  		<xsl:attribute name="name">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
  		<xsl:value-of select="@Name"/> -
  		<B><xsl:value-of select="DiagName"/></B></A><font COLOR="Red">&#xA0;<xsl:call-template name="msgcomerror"/>&#xA0;(<B><xsl:value-of select="Error/@Msg"/></B>)</font>
  		<xsl:choose>
  			<xsl:when test="not(Devices/Device)">
  				<BR/><xsl:call-template name="noinfo"/>
  			</xsl:when>
	  	</xsl:choose>
  	</li>
  </xsl:for-each>

  <!-- en dernier les calculateurs sans panne et sans erreur de com -->
  <xsl:for-each select="Function[@Name != 'CAN' and @Name != 'CAN2' and not(Devices/Device/DTC | Error | Unknown/DTC)]">
  	<li class="tdmecu"><A>
  	<xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
  		<xsl:attribute name="name">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:attribute><xsl:value-of select="@Name"/> -
  		<B><xsl:value-of select="DiagName"/></B></A>&#xA0;
  		<xsl:choose>
  			<xsl:when test="not(Devices/Device)">
  				<xsl:call-template name="noinfo"/>
  			</xsl:when>
  			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="Requests/Request[(@Name='ReadDTC' or @Name='ReadDTCInformation.ReportDTC') and Error]">
						<span class="errfailure">
					 	<xsl:call-template name="readDtcError"/>
					 	</span>
					</xsl:when>
					<xsl:otherwise>
						<span class="nofailure">
					 	<xsl:call-template name="nofailure"/>
					 	</span>
					</xsl:otherwise>
				</xsl:choose>
  			</xsl:otherwise>
	  	</xsl:choose>
  	</li>
  </xsl:for-each>
  </ul>

<hr/>

  <!-- Affichage du detail de chaque calculateur -->
    <table class="identification" border="0">
    	<xsl:apply-templates select="Function[@Name != 'CAN' and @Name != 'CAN2']" mode="failures"/>
    </table>
</xsl:template>


<!-- ========================================================================================= -->
<xsl:template match="Function" mode="failures">
<xsl:variable name="toclink">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:variable>

<tr>

  <th class="fctname" colspan="4">
		<A name="{generate-id(@Name)}"></A>
	  Function: <font size="+1"><xsl:value-of select="@Name"/></font>
	  <xsl:if test="DiagName">
		&#xA0;&#xA0;- Name: <font size="+1"><xsl:value-of select="DiagName"/></font>
	  </xsl:if>
  </th>
  <th class="fctname" colspan="6" >
  		<xsl:if test="VIN[not(Error)]">VIN: <font size="+1"><xsl:value-of select="VIN/@Number"/></font></xsl:if>&#160; <!-- &nbsp; -->
  </th>


</tr>

	<!-- Afficher les trames d'identification -->
  <xsl:if test="Identification[not(Error)]">
    <tr>
      <xsl:call-template name="IdentHeader"/>
    </tr>
	  <xsl:apply-templates select="Identification[not(Error)]"/>
  </xsl:if>
  <xsl:if test="Identification83[not(Error)]">
    <tr>
      <xsl:call-template name="IdentHeader83"/>
    </tr>
	  <xsl:apply-templates select="Identification83[not(Error)]"/>
  </xsl:if>
	<xsl:apply-templates select="IdentificationUDS[not(Error)]"/>
	<!-- Afficher les approval  -->
	<xsl:apply-templates select="Identification/ProgrammingStamp[@Id = 'N']/Approval"/>

<tr>
  <td colspan="10"> <!-- ## ## -->
  <xsl:choose>
        <xsl:when test="Devices/Device/DTC[not(@Failure='TestNotCompleted')] | Unknown/DTC">
        	<xsl:if test="Devices/Device/DTC[not(@Failure='TestNotCompleted')]">
	            <table class="Function" width="100%" border="0">
	          	<xsl:for-each select="Devices/Device[DTC[not(@Failure='TestNotCompleted')]]">
	          	  <tr>
	          	    <td colspan="2">
						<A name="{generate-id(@Name)}"></A>	
						<table border="0" cellspacing="0" cellpadding="1" width="100%" class="DTCName">
							<tr>
							<td width="10"><a><xsl:attribute name="href"><xsl:value-of select="$toclink"/></xsl:attribute>^</a></td>
							<td width="*%" class="devicename">
							<xsl:call-template name="devicetype"><xsl:with-param name="t" select="number(@Type)"/></xsl:call-template>&#xA0;
	          				<a>
								<xsl:attribute name="TARGET">_blank</xsl:attribute>
								<xsl:attribute name="TITLE">click for device documentation</xsl:attribute>
								<xsl:attribute name="HREF"><xsl:value-of select="$urlbank"/>/fct<xsl:value-of select="../../@Address"/>/<xsl:value-of select="local:encodeurl(string(../../DiagName))"/>/Devices/<xsl:value-of select="local:encodeurl(string(@Name))"/>.htm</xsl:attribute>
								<xsl:value-of select="@Name"/>
							</a>
							&#160; <!-- &nbsp; -->
							<font size="-1">
								<xsl:call-template name="msgfailure">
											<xsl:with-param name="tpanne" select="DTC/@Failure"/>
								</xsl:call-template>
							</font>
							</td>
							<xsl:if test="@DTC">
								<td width="5%">
									$<xsl:value-of select="local:ToHex4(number(@DTC))"/>
								</td>
						 	</xsl:if>
							</tr>
						</table>
	           			</td>
	           		</tr>
			   		<xsl:apply-templates select="DTC[not(@Failure='TestNotCompleted')]" mode="failures"/>
	          	</xsl:for-each>
	            </table>
        	</xsl:if>
			<xsl:if test="Unknown/DTC">
				<table class="Function" width="100%" border="0">
					<tr>
						<td width="10"><a><xsl:attribute name="href"><xsl:value-of select="$toclink"/></xsl:attribute>^</a></td>
						<th>Devices Unknown (Missing database definition)</th>
					</tr>
					<tr>
					<td colspan="2">
					<table class="Function" width="100%" border="0">
						<xsl:for-each select="Unknown/DTC">
						  	<tr>
						    	<td colspan="2" class="deviceunknown">
										<A name="{generate-id(@Name)}"></A>
										<xsl:call-template name="lbunknown"/> : <xsl:value-of select="@Name"/>
								</td>
							</tr>
							<xsl:apply-templates select="." mode="failures"/>
						</xsl:for-each>
					</table>
					</td>
					</tr>
				</table>
			</xsl:if>
        </xsl:when>
        <xsl:otherwise>
       		<xsl:choose>
            	<xsl:when test="Error">
            		<H2>Error : <B><xsl:value-of select="Error/@Code"/></B> Msg : <B><xsl:value-of select="Error/@Msg"/></B></H2>
            	</xsl:when>
            	<xsl:when test="not(Devices/Device)">
            		<xsl:call-template name="noinfo"/>
            	</xsl:when>
            	<xsl:otherwise>
            		<xsl:choose>
				<xsl:when test="Requests/Request[(@Name='ReadDTC' or @Name='ReadDTCInformation.ReportDTC')  and Error]">
					<span class="errfailure">
					<xsl:call-template name="readDtcError"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<span class="nofailure">
					<xsl:call-template name="nofailure"/>
					</span>
				</xsl:otherwise>
			</xsl:choose>
            	</xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
  </td>
</tr>

</xsl:template>

<xsl:template match="Identification[Error]|Identification83[Error]">
  <td colspan="10" class="commError">
	Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
	</b>&#xA0;Description : <b>'<xsl:value-of select="Error/@Msg"/>'</b>
	Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive : <xsl:value-of select="Error/Request/@Receive"/>
  </td>
</xsl:template>
  
  
<!-- ========================================================================================= -->
<!-- -->
<!-- ========================================================================================= -->
<xsl:template match="Failures" mode="all">
<!-- message global si aucune erreur n'est detectee -->
<xsl:apply-templates select="Date"/>
<xsl:if test="Comment != ''">
	<xsl:apply-templates select="Comment"/>
</xsl:if>
<xsl:choose>
	<xsl:when test="Function/Devices/Device/DTC | Function/Unknown/DTC">
		<H3><xsl:call-template name="nbfailures">
			<xsl:with-param name="nb" select="count(Function/Devices/Device[DTC[not(@Failure='TestNotCompleted')]] | Function/Unknown/DTC)"/>
			<xsl:with-param name="nbFc"   select="count(Function/Devices/Device[DTC/@Failure='Current'] | Function/Devices/Device[DTC/@Failure='TestNotCompleted Current'])"/>
			<xsl:with-param name="nbFh"   select="count(Function/Devices/Device[DTC/@Failure='Historical'] | Function/Devices/Device[DTC/@Failure='TestNotCompleted Historical'])"/>
			<xsl:with-param name="nbFtnc" select="count(Function/Devices/Device[DTC/@Failure='TestNotCompleted'])"/>
			<xsl:with-param name="nbFinco" select="count(Function/Devices/Device[DTC/@Failure='StatusIncoherent'])"/>
			<xsl:with-param name="nbUnknow" select="count(Function/Unknown/DTC)"/>
		</xsl:call-template></H3>
	</xsl:when>
	<xsl:otherwise>
		 <xsl:choose>
			<xsl:when test="Function/Requests/Request[(@Name='ReadDTC' or @Name='ReadDTCInformation.ReportDTC') and Error]">
			 	<H3><xsl:call-template name="readDtcError"/></H3>
			</xsl:when>
			<xsl:otherwise>
			 	<H3><xsl:call-template name="nofailure"/></H3>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:otherwise>
</xsl:choose>

<!-- Global index function -->
<p><font size="1"><xsl:call-template name="supportedFcts"/>
	<xsl:for-each select="Function">
		<A>
			<xsl:attribute name="HREF">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
			<xsl:value-of select="@Name"/>
		</A>&#xA0;
	</xsl:for-each>
</font></p>
	<!-- Afficher la table des matieres -->
<table border="0">
<tr><td>
	<ul>
		<!-- en premier les calculateurs ayant des pannes -->
		<!-- <xsl:for-each select="Function[Devices/Device] | Function[Unknown/DTC]">-->
		<xsl:for-each select="Function">
			<xsl:choose>
				<xsl:when test="not(Devices/Device | NoDiagDevices/Device)">
					<LI class="tdmecuall">
						<A>
							<xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
							<xsl:attribute name="NAME">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
							<xsl:value-of select="@Name"/> :
							<B> <xsl:value-of select="DiagName"/></B>
						</A>
						<xsl:if test="Error">
							<FONT COLOR="red">
								<B>&#xA0;<xsl:value-of select="Error/@Msg"/></B>
							</FONT>
						</xsl:if>
						&#xA0;<xsl:call-template name="noinfo"/>
					</LI>
				</xsl:when>
				<xsl:otherwise>
					<LI class="tdmecuall">
						<A>
							<xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
							<xsl:attribute name="NAME">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
							<xsl:value-of select="@Name"/> :
  							<B>
								<xsl:value-of select="DiagName"/>
							</B>
						</A>
						<xsl:if test="Error">
							<FONT COLOR="red">
								<B>&#xA0;<xsl:value-of select="Error/@Msg"/></B>
							</FONT>
						</xsl:if>
						<!--<xsl:if test="Devices/Device/DTC | Devices/Device/Info | Unknown/DTC">-->
						<UL>
							<LI><xsl:call-template name="lbinput"/>
                <xsl:if test="Devices/Device[@Type = '1'] | NoDiagDevices/Device[@Type = '1']">
								  <ul>
									  <xsl:apply-templates select="Devices/Device[@Type = '1'] | NoDiagDevices/Device[@Type = '1']" mode="tdm">
										  <xsl:sort select="@Name" />
									  </xsl:apply-templates>
								  </ul>
                </xsl:if>
							</LI>
							<LI><xsl:call-template name="lboutput"/>
                <xsl:if test="Devices/Device[@Type = '3'] | NoDiagDevices/Device[@Type = '3']">
			  					<UL>
									  <xsl:apply-templates select="Devices/Device[@Type = '3'] | NoDiagDevices/Device[@Type = '3']" mode="tdm">
										  <xsl:sort select="@Name" />
									  </xsl:apply-templates>
								  </UL>
                </xsl:if>
							</LI>
							<LI><xsl:call-template name="lbinternal"/>
                <xsl:if test="Devices/Device[@Type = '2'] | NoDiagDevices/Device[@Type = '2']">
			  					<UL>
									  <xsl:apply-templates select="Devices/Device[@Type = '2'] | NoDiagDevices/Device[@Type = '2']" mode="tdm">
										  <xsl:sort select="@Name" />
									  </xsl:apply-templates>
								  </UL>
                </xsl:if>
							</LI>
							<LI><xsl:call-template name="lbother"/>
                <xsl:if test="Devices/Device[@Type = '4'] | NoDiagDevices/Device[@Type = '4']">
			  					<UL>
									  <xsl:apply-templates select="Devices/Device[@Type = '4'] | NoDiagDevices/Device[@Type = '4']" mode="tdm">
										  <xsl:sort select="@Name" />
									  </xsl:apply-templates>
								  </UL>
                </xsl:if>
							</LI>
							<xsl:if test="Unknown/DTC">
								<LI><xsl:call-template name="lbunknown"/>
				  					<UL>
										<xsl:for-each select="Unknown/DTC">
											<LI>
												<A>
													<xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
													<xsl:value-of select="@Name"/>
												</A>
                        <!-- QC457: Display DTC status (all devices mode)-->
                        <font size="-1">
                          &#xA0;
                          <xsl:call-template name="msgfailure">
                            <xsl:with-param name="tpanne" select="@Failure"/>
                          </xsl:call-template>
                        </font>
											</LI>
										</xsl:for-each>
									</UL>
								</LI>
							</xsl:if>
						</UL>
						<!--</xsl:if>-->
					</LI>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</ul>
</td></tr>
</table>
<hr/>
  <!-- Affichage du detail de chaque calculateur -->
    <table class="Functions" border="0">
    	<xsl:apply-templates select="Function" mode="all"/>
    </table>

</xsl:template>

<!-- ========================================================================================= -->
<!--        affichage du detail des fonctions avec toutes les infos                            -->
<!-- ========================================================================================= -->
<xsl:template match="Devices/Device" mode="tdm">
<li class="tdmdevall">
	<a>
		<xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
		<xsl:value-of select="@Name"/>
	</a>
	<xsl:if test="DTC">
		&#xA0;<xsl:call-template name="msgfailure">
			<xsl:with-param name="tpanne" select="DTC/@Failure"/>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="Info">
		&#xA0;<xsl:call-template name="msgdata"/>
	</xsl:if>
</li>
</xsl:template>

<xsl:template match="NoDiagDevices/Device" mode="tdm">
<li class="tdmdev">
	<a>
		<xsl:attribute name="HREF">#<xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
		<xsl:value-of select="@Name"/>
	</a>&#xA0;<xsl:call-template name="nodiag"/>
	<xsl:if test="Info">
		&#xA0;<xsl:call-template name="msgdata"/>
	</xsl:if>
</li>
</xsl:template>


<!-- ========================================================================================= -->
<!--        affichage du detail des fonctions avec toutes les infos                            -->
<!-- ========================================================================================= -->
<xsl:template match="Function" mode="all">
<!-- Affichage du detail de chaque calculateur -->
<xsl:variable name="toclink">#toc<xsl:value-of select="generate-id(@Name)"/></xsl:variable>

<tr>

	<th class="fctname" colspan="4">
		Function: <font size="+1"><xsl:value-of select="@Name"/></font>
		<xsl:if test="DiagName">
		&#xA0;&#xA0;- Name: <font size="+1"><xsl:value-of select="DiagName"/></font>
		</xsl:if>
	</th>
	<th class="fctname" colspan="6" >
		<xsl:if test="VIN[not(Error)]">VIN: <font size="+1"><xsl:value-of select="VIN/@Number"/></font></xsl:if>
	</th>

</tr>

	<!-- Afficher les trames d'identification -->
	<xsl:apply-templates select="Identification" mode="all"/>
	<xsl:apply-templates select="Identification83" mode="all"/>
	<xsl:apply-templates select="IdentificationUDS" mode="all"/>

	<!-- Afficher l'erreur sur la requete ReadDTC -->
	<xsl:apply-templates select="Requests/Request[(@Name='ReadDTC' or @Name='ReadDTCInformation.ReportDTC') and Error]"/>

<tr>
	<td colspan="10">
		<xsl:if test="Error">
			<H2>Error : <B>
					<xsl:value-of select="Error/@Code"/>
				</B> Msg : <B>
					<xsl:value-of select="Error/@Msg"/>
				</B>
			</H2>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="Devices/Device | NoDiagDevices/Device | Unknown/DTC">
				<xsl:if test="Devices/Device">
					<table class="Function" width="100%"  border="0">
						<xsl:for-each select="Devices/Device">
							<xsl:sort select="@Name" />
							<TR>
								<TD colspan="2">
								<A>
									<xsl:attribute name="NAME"><xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
								</A>
								<table border="0" cellspacing="0" cellpading="0" width="100%" class="DTCName">
									<tr>
									<td width="10"><a><xsl:attribute name="href"><xsl:value-of select="$toclink"/></xsl:attribute>^</a></td>
									<td width="*%" class="devicename">
					          			<a>
											<xsl:attribute name="TARGET">_blank</xsl:attribute>
											<xsl:attribute name="TITLE">click for device documentation</xsl:attribute>
											<xsl:attribute name="HREF"><xsl:value-of select="$urlbank"/>/fct<xsl:value-of select="../../@Address"/>/<xsl:value-of select="local:encodeurl(string(../../DiagName))"/>/Devices/<xsl:value-of select="local:encodeurl(string(@Name))"/>.htm</xsl:attribute>
											<xsl:value-of select="@Name"/>
										</a>
										&#160; <!-- &nbsp; -->
										<font size="-1">
											<xsl:call-template name="msgfailure">
														<xsl:with-param name="tpanne" select="DTC/@Failure"/>
											</xsl:call-template>
										</font>
									</td>
									<xsl:if test="@DTC">
										<td width="5%">
												$<xsl:value-of select="local:ToHex4(number(@DTC))"/>
										</td>
								 	</xsl:if>
									</tr>
								</table>
								</TD>
							</TR>
							<xsl:apply-templates select="DTC" mode="all"/>
							<xsl:apply-templates select="Info"/>
						</xsl:for-each>
					</table>
				</xsl:if>
				<xsl:if test="NoDiagDevices/Device">
					<table class="Function" border="0">
						<xsl:for-each select="NoDiagDevices/Device">
							<tr>
								<A>
									<xsl:attribute name="NAME"><xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
								</A>
								<TD colspan="2">
								<table border="0" cellspacing="0" cellpading="0" width="100%">
									<tr>
									<td width="10"><a><xsl:attribute name="href"><xsl:value-of select="$toclink"/></xsl:attribute>^</a></td>
									<td width="*%" class="nodiagdevicename">
					          			<a>
											<xsl:attribute name="TARGET">_blank</xsl:attribute>
											<xsl:attribute name="TITLE">click for device documentation</xsl:attribute>
											<xsl:attribute name="HREF"><xsl:value-of select="$urlbank"/>/fct<xsl:value-of select="../../@Address"/>/<xsl:value-of select="local:encodeurl(string(../../DiagName))"/>/Devices/<xsl:value-of select="local:encodeurl(string(@Name))"/>.htm</xsl:attribute>
											<xsl:value-of select="@Name"/>
										</a>
									</td>
									</tr>
								</table>
								</TD>
							</tr>
							<tr>
								<td><xsl:call-template name="msgnodiagtool"/></td>
							</tr>
							<xsl:apply-templates select="Info"/>
						</xsl:for-each>
					</table>
				</xsl:if>
				<xsl:if test="Unknown/DTC">
					<table class="Function" width="100%" border="0">
						<tr>
							<td width="10"><a><xsl:attribute name="href"><xsl:value-of select="$toclink"/></xsl:attribute>^</a></td>
							<th>Devices Unknown (Missing database definition)</th>
						</tr>
						<tr>
						<td colspan="2">
						<table class="Function" width="100%" border="0">
						<xsl:for-each select="Unknown/DTC">
							<tr>
								<a>
									<xsl:attribute name="NAME"><xsl:value-of select="generate-id(@Name)"/></xsl:attribute>
								</a>
								<td colspan="2" class="deviceunknown">
										<xsl:call-template name="lbunknown"/> : <xsl:value-of select="@Name"/>
								</td>
							</tr>
							<xsl:apply-templates select="." mode="all"/>
						</xsl:for-each>
						</table>
						</td>
						</tr>
					</table>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="noinfo"/>
			</xsl:otherwise>
		</xsl:choose>
	</td>
</tr>
</xsl:template>


<!-- ========================================================================================= -->
<!--        affichage de la freeze Frame -->
<!-- ========================================================================================= -->
<xsl:template match="FreezeFrame">
<xsl:choose>
	<xsl:when test="Error">
		<table width="100%" class="FreezeF" border="0">
		<tr><td colspan="2" class="error">Freeze Frame Error</td></tr>
		<tr>
			<td>Request</td>
			<td ALIGN="CENTER"><xsl:value-of select="Error/Request/@Name"/></td>
		</tr>
		<tr>
			<td>Send</td>
			<td ALIGN="CENTER"><xsl:value-of select="Error/Request/@Send"/></td>
		</tr>
		<tr>
			<td>Receive</td>
			<td ALIGN="CENTER"><xsl:value-of select="Error/Request/@Receive"/></td>
		</tr>
		<tr>
			<td>Code</td>
			<td ALIGN="CENTER"><xsl:value-of select="Error/@Code"/></td>
		</tr>
		<tr>
			<td>Message</td>
			<td ALIGN="CENTER"><xsl:value-of select="Error/@Msg"/></td>
		</tr>

		</table>
	</xsl:when>
  <xsl:otherwise>
		<table width="100%" class="FreezeF" border="0">
			<tr><th colspan="2">Freeze Frame</th></tr>
			<tr><th>Name</th><th>Value</th></tr>
			<xsl:apply-templates select="Param"/>
		</table>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- ========================================================================================= -->
<!--        affichage des SnapShot -->
<!-- ========================================================================================= -->
<xsl:template match="Snapshot[Record]" mode="failures">
<table width="100%" class="FreezeF" border="0">
	<tr><th colspan="2">Snapshot</th></tr>
	<xsl:apply-templates select="Record"/>
	<xsl:if test="not(Record)">
		<tr>
			<td colspan="2">
				<xsl:call-template name="noSnapshotRecord"/>
			</td>
		</tr>
	</xsl:if>
</table>
</xsl:template>

<xsl:template match="Snapshot[Error]" mode="failures">
<table width="100%" class="FreezeF" border="0">
<tr><td colspan="2" class="error">Snapshot</td></tr>
<xsl:apply-templates select="Record"/>
<xsl:apply-templates select="Error"/>
</table>
</xsl:template>

<xsl:template match="Snapshot" mode="all">
<table width="100%" class="FreezeF" border="0">
	<tr><th colspan="2">Snapshot</th></tr>
	<tr><td>Send</td><td><xsl:value-of select="@Send"/></td></tr>
	<tr><td>Received</td><td><xsl:value-of disable-output-escaping="yes" select="local:WriteMultiLine(@Receive)"/></td></tr>
	<xsl:if test="Data">
		<tr>
			<td colspan="2">
				<table width="100%" class="FreezeF" border="0">
					<xsl:apply-templates select="Data">
					 <xsl:sort select="@Name"/>
					</xsl:apply-templates>
				</table>
			</td>
		</tr>
	</xsl:if>
	<xsl:apply-templates select="Record"/>
	<xsl:if test="not(Record)">
		<tr>
			<td colspan="2">
				<xsl:call-template name="noSnapshotRecord"/>
			</td>
		</tr>
	</xsl:if>
</table>
</xsl:template>

<xsl:template match="Snapshot[Error]" mode="all">
<table width="100%" class="FreezeF" border="0">
<tr><td colspan="2" class="error">Snapshot</td></tr>
<tr><td>Send</td><td><xsl:value-of select="@Send"/></td></tr>
<tr><td>Received</td><td><xsl:value-of disable-output-escaping="yes" select="local:WriteMultiLine(@Receive)"/></td></tr>
<xsl:apply-templates select="Record"/>
<xsl:apply-templates select="Error"/>
</table>
</xsl:template>

<!-- ========================================================================================= -->
<!--        affichage des ExtendedData -->
<!-- ========================================================================================= -->
<xsl:template match="ExtendedData[Record]" mode="failures">
<table width="100%" class="ExtendedData" border="0">
	<tr><th colspan="2">Extended Data</th></tr>
	<xsl:apply-templates select="Record"/>
	<xsl:if test="not(Record)">
		<tr>
			<td colspan="2">
				<xsl:call-template name="noExtDataRecord"/>
			</td>
		</tr>
	</xsl:if>
</table>
</xsl:template>

<xsl:template match="ExtendedData" mode="all">
<table width="100%" class="ExtendedData" border="0">
	<tr><th colspan="2">Extended Data</th></tr>
	<tr><td>Send</td><td><xsl:value-of select="@Send"/></td></tr>
	<tr><td>Received</td><td><xsl:value-of disable-output-escaping="yes" select="local:WriteMultiLine(@Receive)"/></td></tr>
	<xsl:if test="Data">
		<tr>
			<td colspan="2">
				<table width="100%" class="FreezeF" border="0">
					<xsl:apply-templates select="Data">
					 <xsl:sort select="@Name"/>
					</xsl:apply-templates>
				</table>
			</td>
		</tr>
	</xsl:if>
	<xsl:apply-templates select="Record"/>
	<xsl:if test="not(Record)">
		<tr>
			<td colspan="2">
				<xsl:call-template name="noExtDataRecord"/>
			</td>
		</tr>
	</xsl:if>
</table>
</xsl:template>

<xsl:template match="ExtendedData[Error]" mode="all">
<table width="100%" class="ExtendedData" border="0">
<tr><td colspan="2" class="error">Extended Data</td></tr>
<tr><td>Send</td><td><xsl:value-of select="@Send"/></td></tr>
<tr><td>Received</td><td><xsl:value-of disable-output-escaping="yes" select="local:WriteMultiLine(@Receive)"/></td></tr>
<xsl:apply-templates select="Error"/>
</table>
</xsl:template>


<!-- ==================================================================================== -->
<!--                       affichage d'un Record (SnapShot or ExtendedData)                                             -->
<!-- ==================================================================================== -->
<xsl:template match="Record">
<tr>
	<th colspan="2">Record : <xsl:value-of select="@number"/>
	<xsl:choose>
		<xsl:when test="(number(@number) &gt;= 0) and (number(@number) &lt;= 255)">
		&#160;($<xsl:value-of select="local:ToHex2(number(@number))"/>)
		</xsl:when>
		<xsl:otherwise />
	</xsl:choose>
	<xsl:if test="@name">&#xA0;Name : <xsl:value-of select="@name"/></xsl:if>
	<xsl:if test="@nbDataId">&#xA0;Number of Data Id : <xsl:value-of select="@nbDataId"/></xsl:if>
	</th>
</tr>
<xsl:apply-templates select="DataId"/>
<xsl:if test="Data">
	<tr>
		<td colspan="2">
			<table width="100%" class="FreezeF" border="0">
				<xsl:apply-templates select="Data">
				 <xsl:sort select="@Name"/>
				</xsl:apply-templates>
			</table>
		</td>
	</tr>
</xsl:if>
</xsl:template>

<xsl:template match="DataId">
<tr><td colspan="2">
<table width="100%" class="FreezeF" border="0">
<tr><th width="30%">Data identifier</th><td width="30%"><xsl:value-of select="@name"/></td><td width="*%">$<xsl:value-of select="local:ToHex4(number(@id))"/></td></tr>
<xsl:apply-templates select="Data">
 <xsl:sort select="@Name"/>
</xsl:apply-templates>
</table>
</td></tr>
</xsl:template>



<!-- ==================================================================================== -->
<!--                       affichage des information d'erreur                             -->
<!-- ==================================================================================== -->
<xsl:template match="Request[@Name!='' and Error]">
		<tr>
			<td></td>
			<td>
				<span class="error">
					<xsl:choose>
						<xsl:when test="$lang='fr'">Erreur de lecture de la trame '<xsl:value-of select="@Name"/>'</xsl:when>
						<xsl:otherwise>ReadDTC error</xsl:otherwise>
					</xsl:choose>
				</span><br/>
				<span><font size="1">
					Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
					</b>&#xA0;Description : <b><xsl:value-of select="Error/@Msg"/></b><br/>
					Request : <xsl:value-of select="@Send"/>&#xA0;Receive : <xsl:value-of select="@Receive"/>
				</font></span>
			</td>
		</tr>
</xsl:template>


<xsl:template match="Error[Request]">
<xsl:if test="Request/@Name">
	<tr>
		<td>Name</td>
		<td ALIGN="CENTER"><xsl:value-of select="Request/@Name"/></td>
	</tr>
</xsl:if>
<xsl:if test="Request/@Send">
	<tr>
		<td>Send</td>
		<td ALIGN="CENTER"><xsl:value-of select="Request/@Send"/></td>
	</tr>
</xsl:if>
<xsl:if test="not(Request/@Receive = '')">
	<tr>
		<td>Receive</td>
		<td ALIGN="CENTER"><xsl:value-of select="Request/@Receive"/></td>
	</tr>
</xsl:if>
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

<xsl:template match="Error">
<tr>
	<td colspan="2">
		<table class="Error" width="100%">
			<tr>
				<th colspan="2">ERROR</th>
			</tr>
			<tr>
				<td>Code</td>
				<td ALIGN="CENTER">
				<a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="@Code"/></xsl:attribute><xsl:value-of select="@Code"/></a></td>
			</tr>
			<tr>
				<td>Message</td>
				<td ALIGN="CENTER"><xsl:value-of select="@Msg"/></td>
			</tr>
		</table>
	</td>
</tr>
</xsl:template>



<!-- ==================================================================================== -->
<!--                       affichage d'un DTC                                             -->
<!-- ==================================================================================== -->
<xsl:template match="DTC" mode="all">
<tr>
	<td>
		<table class="StatusDTC" border="0">
			<xsl:if test="@DTCorder">
				<tr><td bgcolor="white" colspan="3" align="center">
				<xsl:if test="@Failure">
					<b><xsl:value-of select="@Failure"/></b>&#xA0;&#xA0;
				</xsl:if>
				DTC order = <xsl:value-of select="@DTCorder"/>&#xA0;&#xA0;Availability mask =
								<xsl:choose>
					<xsl:when test="../../../DTCStatusAvailabilityMask/Value">
						<xsl:value-of select="../../../DTCStatusAvailabilityMask/Value"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="../../DTCStatusAvailabilityMask/Value">
							<xsl:value-of select="../../DTCStatusAvailabilityMask/Value"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="@Unspecified">
					&#xA0;<xsl:call-template name="UnspecifiedFtype"/>
				</xsl:if>

				</td></tr>
			</xsl:if>
			<xsl:apply-templates select="Param | Data">
				<!--xsl:sort select="@Name"/-->
			</xsl:apply-templates>
		</table>
	</td>
	<xsl:if test="FreezeFrame">
		<td>
	   		<xsl:apply-templates select="FreezeFrame"/>
	  	</td>
  	</xsl:if>
	<xsl:if test="Snapshot | ExtendedData">
		<td>
	   		<xsl:apply-templates select="ExtendedData" mode="all"/>
	   		<xsl:apply-templates select="Snapshot" mode="all"/>
	  	</td>
  	</xsl:if>
</tr>
</xsl:template>

<xsl:template match="DTC" mode="failures">
<tr>
	<td>
		<table class="StatusDTC" border="0">
			<xsl:if test="@DTCorder">
				<tr><td bgcolor="white" colspan="3" align="center">
				<xsl:if test="@Failure">
					<b><xsl:value-of select="@Failure"/></b>&#xA0;&#xA0;
				</xsl:if>
				DTC order = <xsl:value-of select="@DTCorder"/>&#xA0;&#xA0;Availability mask =
				<xsl:choose>
					<xsl:when test="../../../DTCStatusAvailabilityMask/Value">
						<xsl:value-of select="../../../DTCStatusAvailabilityMask/Value"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="../../DTCStatusAvailabilityMask/Value">
							<xsl:value-of select="../../DTCStatusAvailabilityMask/Value"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="@Unspecified">
					&#xA0;<xsl:call-template name="UnspecifiedFtype"/>
				</xsl:if>
				</td></tr>
			</xsl:if>
			<xsl:apply-templates select="Param | Data">
				<!--xsl:sort select="@Name"/-->
			</xsl:apply-templates>
		</table>
	</td>
	<xsl:if test="FreezeFrame[not(Error)]">
		<td>
	   		<xsl:apply-templates select="FreezeFrame"/>
	  	</td>
  	</xsl:if>
	<xsl:if test="Snapshot | ExtendedData[not(Error)]">
		<td>
	   		<xsl:apply-templates select="ExtendedData" mode="failures"/>
	   		<xsl:apply-templates select="Snapshot" mode="failures"/>
	  	</td>
  	</xsl:if>
</tr>
</xsl:template>


<xsl:template match="Info">
<tr>
	<td colspan="2">
		<table class="StatusDTC" border="0">
			<tr>
				<TH>Info data name</TH>
				<TH>Value</TH>
				<TH>Text</TH>
			</tr>
			<xsl:apply-templates select="Param"/>
		</table>
	</td>
</tr>
</xsl:template>


<!-- ==================================================================================== -->
<!--                       affichage d'une donnée d'information                           -->
<!-- ==================================================================================== -->
<xsl:template match="Param">
<tr>
	<td><xsl:value-of select="@Name" /></td>
	<td ALIGN="CENTER" class="hexa"><xsl:value-of disable-output-escaping="yes" select="local:WriteMultiLine(@Value)"/>
		<xsl:if test="not(@Text) and @Unit">&#xA0;<xsl:value-of select="@Unit"/></xsl:if></td>
	<xsl:if test="@Text">
		<td ALIGN="CENTER"><B><xsl:value-of disable-output-escaping="yes" select="local:WriteMultiLine(@Text)"/></B>&#xA0;<xsl:value-of select="@Unit"/></td>
	</xsl:if>
	<xsl:if test="@Failure">
		<td ALIGN="CENTER"><xsl:call-template name="msgFailureType">
			<xsl:with-param name="t" select="@Failure"/>
		</xsl:call-template></td>
	</xsl:if>
</tr>
</xsl:template>

<xsl:template match="Data">
<xsl:variable name="mStatusBitName" select="@Name"></xsl:variable>
<tr>
	<td>
		<xsl:choose>
			<xsl:when test="../../../../DTCStatusAvailabilityMask/StatusBit[@Name = $mStatusBitName]/@Bit">
				B<xsl:value-of select="../../../../DTCStatusAvailabilityMask/StatusBit[@Name = $mStatusBitName]/@Bit"/>_
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="../../../DTCStatusAvailabilityMask/StatusBit[@Name = $mStatusBitName]/@Bit">
					B<xsl:value-of select="../../../DTCStatusAvailabilityMask/StatusBit[@Name = $mStatusBitName]/@Bit"/>_
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="@Name" />
	</td>
	<xsl:if test="@Value">
		<td align="CENTER">
		<xsl:if test="not(@Text)"><xsl:attribute name="colspan">2</xsl:attribute></xsl:if>
		<xsl:value-of select="@Value"/>
		<!-- Cas particulier pour FailureType : affichage en décimal et hexa -->
		<xsl:if test="@Name = 'FailureType'">
		<xsl:choose>
			<xsl:when test="(number(@Value) &gt;= 0) and (number(@Value) &lt;= 255)">
				&#160;($<xsl:value-of select="local:ToHex2(number(@Value))"/>)
			</xsl:when>
			<xsl:otherwise />
		</xsl:choose>
		</xsl:if>
		</td>
	</xsl:if>
	<xsl:if test="@Text">
		<td align="CENTER"><xsl:if test="not(@Value)"><xsl:attribute name="colspan">2</xsl:attribute></xsl:if><B><xsl:value-of select="@Text"/></B>&#xA0;<xsl:value-of select="@Unit"/></td>
	</xsl:if>
</tr>
</xsl:template>


<!-- ==================================================================================== -->
<!--                       Affichage identification                                       -->
<!-- ==================================================================================== -->
<xsl:template match="Identification[not(Error)]">

		<!-- ##<table class="identification"> ## -->
			  <th>R/N</th>
			  <th>Part Number</th>
			  <th>Diag. Version</th>
			  <th>Supplier</th>
			  <th>Hardware</th>
			  <th>Soft</th>
			  <th>Version</th>
			  <th>Calibration</th>
			  <xsl:if test="OtherSystemFeatures/@Number"><th>Features</th></xsl:if>
			  <xsl:if test="ManufacturerIdCode/@Number"><th>Ident Format</th></xsl:if>
  
			  <tr>
			  	<td><xsl:value-of select="@Coding"/></td>
			    <td><xsl:value-of select="Order/@Number"/></td>
			    <td>$<xsl:value-of select="@Diagnostic"/></td>
			    <td><xsl:value-of select="@Supplier"/></td>
			    <td><xsl:value-of select="Hardware/@Number"/></td>
			    <td><xsl:value-of select="@Application"/></td>
			    <td><xsl:value-of select="@Version"/></td>
			    <td><xsl:value-of select="Tuning/@Number"/></td>
			    <xsl:if test="OtherSystemFeatures/@Number"><td><xsl:value-of select="OtherSystemFeatures/@Number"/></td></xsl:if>
			    <xsl:if test="ManufacturerIdCode/@Number"><td><xsl:value-of select="ManufacturerIdCode/@Number"/></td></xsl:if>
			  </tr>
		<!-- ##</table> ## -->

</xsl:template>

  
<!-- ==================================================================================== -->
<!--                       Affichage identification                                       -->
<!-- ==================================================================================== -->
  <xsl:template match="Identification[not(Error)] | Identification83[not(Error)]">
  <xsl:param name="dmode"/>
    <!--<tr>
      <xsl:call-template name="IdentHeader"/>
    </tr>-->
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
  <xsl:variable name="supplierName" select="@Supplier" /> <!--ITG_Codes-->

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
<!--                       Affichage identification                                       -->
<!-- ==================================================================================== -->
<xsl:template match="IdentificationUDS[not(Error)]">

  <xsl:call-template name="UDSIdentHeader1"/>

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
	</tr>

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
<xsl:template name="IdentHeader83">
	<!-- <th>ECUs</th> -->
	<th>Coding</th>
	<th>Part Number</th>
	<th>Diag. Version</th>
	<th>Supplier</th>
	<th>Hardware</th>
	<th>Soft</th>
	<th>Version</th>
	<th>Calibration</th>
	<th>Features</th>
	<th>Ident Format</th>
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
	<th>Config Ref<br/><span style="font-size:8pt">(or Operationnal Ref)</span><br/>(F188)</th>
	<th> </th>
</xsl:template>

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
<!--                       Affichage ident et historique                                  -->
<!-- ==================================================================================== -->
<xsl:template match="Identification" mode="all">
<xsl:choose>
	<xsl:when test="not(Error)">
		<tr>
			<td colspan="12">
				<table width="100%" class="identification">
					  <tr>
					    <th>R/N</th>
					    <th>Part Number</th>
					    <th>Diag. Version</th>
					    <th>Supplier</th>
					    <th>Hardware</th>
					    <th>Soft</th>
					    <th>Version</th>
					    <th>Calibration</th>
					    <xsl:if test="OtherSystemFeatures/@Number"><th>Features</th></xsl:if>
					    <xsl:if test="ManufacturerIdCode/@Number"><th>Ident Format</th></xsl:if>
					  </tr>
					  <tr>
					    <td/>
					    <td><xsl:value-of select="Order/@Number"/></td>
					    <td>$<xsl:value-of select="@Diagnostic"/></td>
					    <td><xsl:value-of select="@Supplier"/></td>
					    <td><xsl:value-of select="Hardware/@Number"/></td>
					    <td><xsl:value-of select="@Application"/></td>
					    <td><xsl:value-of select="@Version"/></td>
					    <td><xsl:value-of select="Tuning/@Number"/></td>
					    <xsl:if test="OtherSystemFeatures/@Number"><td><xsl:value-of select="OtherSystemFeatures/@Number"/></td></xsl:if>
					    <xsl:if test="ManufacturerIdCode/@Number"><td><xsl:value-of select="ManufacturerIdCode/@Number"/></td></xsl:if>
					  </tr>
				</table>
			</td>
		</tr>
	</xsl:when>
	<xsl:when test="Error">
		<tr>
			<!--<td colspan="12">-->
			<!--<table width="100%" class="identification">-->
			<TH>Renault (2180)</TH>
			<td>
				<span class="error">
					<xsl:choose>
						<xsl:when test="$lang='fr'">L'identification Renault n'est pas supportée par ce calculateur</xsl:when>
						<xsl:otherwise>Identification Renault not supported</xsl:otherwise>
					</xsl:choose>
				</span><br/>
				<span><font size="1">
					Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
					</b>&#xA0;Description : <b><xsl:value-of select="Error/@Msg"/></b><br/>
					Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive : <xsl:value-of select="Error/Request/@Receive"/>
				</font></span>
			</td>
			<!--</table>-->
			<!--</td>-->
		</tr>
	</xsl:when>
</xsl:choose>
<xsl:if test="ProgrammingStamp">
	<tr>
		<td colspan="12">
			<table width="100%" class="identification" border="0">
				<TR>
					<TH/>
					<TH>Part Number</TH>
					<TH>Diag. Version</TH>
					<TH>Supplier</TH>
					<TH>Hardware</TH>
					<TH>Soft</TH>
					<TH>Version</TH>
					<TH>Calibration</TH>
					<TH>Approval</TH>
					<TH>Tool</TH>
					<TH>Location</TH>
					<TH>Date</TH>
				</TR>
				<xsl:apply-templates select="ProgrammingStamp"/>
			</table>
		</td>
	</tr>
</xsl:if>
</xsl:template>

<!-- ==================================================================================== -->
<!--                       Affichage ident et historique                                  -->
<!-- ==================================================================================== -->
<xsl:template match="Identification83" mode="all">
<xsl:choose>
	<xsl:when test="not(Error)">

  <td></td>
			<td colspan="12">
				<table width="100%" class="identification">
					  <tr>
					    <xsl:if test="@Coding"><th>Coding</th></xsl:if>
					    <th>Part Number</th>
					    <th>Diag. Version</th>
					    <th>Supplier</th>
					    <th>Hardware</th>
					    <th>Soft</th>
					    <th>Version</th>
					    <th>Calibration</th>
					    <xsl:if test="OtherSystemFeatures/@Number"><th>Features</th></xsl:if>
					    <xsl:if test="ManufacturerIdCode/@Number"><th>Ident Format</th></xsl:if>
					  </tr>
					  <tr>
					  	<xsl:if test="@Coding"><td><xsl:value-of select="@Coding"/></td></xsl:if>
					    <td><xsl:value-of select="Order/@Number"/></td>
					    <td>$<xsl:value-of select="@Diagnostic"/></td>
					    <td><xsl:value-of select="@Supplier"/></td>
					    <td><xsl:value-of select="Hardware/@Number"/></td>
					    <td><xsl:value-of select="@Application"/></td>
					    <td><xsl:value-of select="@Version"/></td>
					    <td><xsl:value-of select="Tuning/@Number"/></td>
					    <xsl:if test="OtherSystemFeatures/@Number"><td><xsl:value-of select="OtherSystemFeatures/@Number"/></td></xsl:if>
					    <xsl:if test="ManufacturerIdCode/@Number"><td><xsl:value-of select="ManufacturerIdCode/@Number"/></td></xsl:if>
					  </tr>
				</table>
			</td>

  </xsl:when>
	<xsl:when test="Error">

      <TH>Nissan (2183)</TH>
			<td>
				<span class="error">
					<xsl:choose>
						<xsl:when test="$lang='fr'">L'identification Nissan n'est pas supportée par ce calculateur</xsl:when>
						<xsl:otherwise>Identification Nissan not supported</xsl:otherwise>
					</xsl:choose>
				</span><br/>
				<span><font size="1">
					Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
					</b>&#xA0;Description : <b><xsl:value-of select="Error/@Msg"/></b><br/>
					Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive : <xsl:value-of select="Error/Request/@Receive"/>
				</font></span>
			</td>

  </xsl:when>
</xsl:choose>
<xsl:if test="ProgrammingStamp">

  <td>
			<!-- <table class="identification" border="0"> -->
				<TR>
					<TH/>
					<TH>Part Number</TH>
					<TH>Diag. Version</TH>
					<TH>Supplier</TH>
					<TH>Hardware</TH>
					<TH>Soft</TH>
					<TH>Version</TH>
					<TH>Calibration</TH>
					<TH>Approval</TH>
					<TH>Tool</TH>
					<TH>Location</TH>
					<TH>Date</TH>
				</TR>
				<xsl:apply-templates select="ProgrammingStamp"/>
			<!-- </table>-->
		</td>

</xsl:if>
</xsl:template>


<!-- ==================================================================================== -->
<!--                       Affichage ident et historique                                  -->
<!-- ==================================================================================== -->
<xsl:template match="IdentificationUDS" mode="all">
<xsl:choose>
	<xsl:when test="not(Error)">
		<tr>

			<td colspan="12">

			<table class="identification" width="100%">

			<tr>
				<xsl:call-template name="UDSIdentHeader1"/>
			</tr>

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
			</tr>

			</table>
			</td>
		</tr>
	</xsl:when>
	<xsl:when test="Error">
		<tr>
			<TH></TH>
			<td>
				<span class="error">
					<xsl:choose>
						<xsl:when test="$lang='fr'">L'identification UDS n'est pas supportée par ce calculateur</xsl:when>
						<xsl:otherwise>Identification UDS not supported</xsl:otherwise>
					</xsl:choose>
				</span><br/>
				<span><font size="1">
					Error : <b><a target="error"><xsl:attribute name="HREF">errors.htm?includeAll=1&amp;includeform=0&amp;err=<xsl:value-of select="Error/@Code"/></xsl:attribute><xsl:value-of select="Error/@Code"/></a>
					</b>&#xA0;Description : <b><xsl:value-of select="Error/@Msg"/></b><br/>
					Request : <xsl:value-of select="Error/Request/@Send"/>&#xA0;Receive : <xsl:value-of select="Error/Request/@Receive"/>
				</font></span>
			</td>
		</tr>
	</xsl:when>
</xsl:choose>
<xsl:if test="ProgrammingStamp">
	<tr>
		<td>
			<!-- <table class="identification" border="0">-->
				<TR>
					<TH/>
					<TH>Part Number</TH>
					<TH>Diag. Version</TH>
					<TH>Supplier</TH>
					<TH>Hardware</TH>
					<TH>Soft</TH>
					<TH>Version</TH>
					<TH>Calibration</TH>
					<TH>Approval</TH>
					<TH>Tool</TH>
					<TH>Location</TH>
					<TH>Date</TH>
				</TR>
				<xsl:apply-templates select="ProgrammingStamp"/>
			<!--</table>-->
		</td>
	</tr>
</xsl:if>
</xsl:template>

<!-- ==================================================================================== -->
<!--                       Affichage d'une ligne d'histotique                             -->
<!-- ==================================================================================== -->
<xsl:template match="ProgrammingStamp">
<TR>
	<TH>
		<xsl:value-of select="@Id"/>
	</TH>
	<TD>
		<xsl:value-of select="Identification/Order/@Number"/>
	</TD>
	<TD>
		$<xsl:value-of select="Identification/@Diagnostic"/> (<xsl:value-of select="local:ToDec(string(Identification/@Diagnostic))"/>)
	</TD>
	<TD>
		<xsl:value-of select="Identification/@Supplier"/>
	</TD>
	<TD>
		<xsl:value-of select="Identification/Hardware/@Number"/>
	</TD>
	<TD>
		<xsl:value-of select="Identification/@Application"/>
	</TD>
	<TD>
		<xsl:value-of select="Identification/@Version"/>
	</TD>
	<TD>
		<xsl:value-of select="Identification/Tuning/@Number"/>
	</TD>
	<TD>
		<xsl:value-of select="Approval/@Number"/>
	</TD>
	<TD>
		<xsl:value-of select="Tool/@Name"/>
	</TD>
	<TD>
		<xsl:value-of select="Tool/@Location"/>
	</TD>
	<TD>
		<xsl:value-of select="Tool/@Date"/>
	</TD>
</TR>
</xsl:template>

  
  <xsl:template match="ProgrammingStamp" mode="all_identifications">
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

<!-- ==================================================================================== -->
<!--                       Affichage numero de VIN                                        -->
<!-- ==================================================================================== -->
<!--
<xsl:template match="VIN">
<tr>
	<td></td>
	<td>
		<table class="identification">
			  <tr>
			    <th>VIN</th>
			    <th>CRC</th>
			    <th>Check</th>
			  </tr>
			  <tr>
			    <td><xsl:value-of select="@Number"/></td>
			    <td><xsl:value-of select="@CRC"/></td>
			    <td><xsl:value-of select="@checkCRC"/></td>
			  </tr>
		</table>
	</td>
</tr>
</xsl:template>
-->

<!-- ==================================================================================== -->
<!--                       Affichage numero d'homologation                                -->
<!-- ==================================================================================== -->
<xsl:template match="Approval">
<tr>
	<td></td>
	<td>
		<!--  ## <table class="identification"> ## -->
			  <tr>
			   <th> </th>
			    <th>Approval</th>
			  </tr>
			  <tr>
			  <td> </td>
			    <td><xsl:value-of select="@Number"/></td>
			  </tr>
		<!--  ##  </table> ## -->
	</td>
</tr>
</xsl:template>

<xsl:template match="Comment">
<table class="tbComment">
<tr>
<th>Comment</th>
</tr>
<tr>
<td>
<PRE>
<xsl:value-of select="."/>
</PRE>
</td>
</tr>
</table>
</xsl:template>


<xsl:template match="Date">
<table class="tbComment">
 <tr>
  <th></th><th>GMT</th><th><xsl:value-of select="@TimeZone"/></th>
 </tr>
 <tr>
  <th>Date</th>
  <td><xsl:value-of select="."/></td>
  <td><xsl:value-of select="@LocalTime"/></td>
 </tr>
</table>
</xsl:template>


<!-- ==================================================================================== -->
<!-- affichage des messages en fonction de la langue -->
<!-- ==================================================================================== -->

<xsl:template name="lbinput">
<xsl:choose>
	<xsl:when test="$lang='fr'">Entrée</xsl:when>
	<xsl:otherwise>Input</xsl:otherwise>
</xsl:choose>
</xsl:template>
<xsl:template name="lboutput">
<xsl:choose>
	<xsl:when test="$lang='fr'">Sorties</xsl:when>
	<xsl:otherwise>Output</xsl:otherwise>
</xsl:choose>
</xsl:template>
<xsl:template name="lbinternal">
<xsl:choose>
	<xsl:when test="$lang='fr'">Internes</xsl:when>
	<xsl:otherwise>Internal</xsl:otherwise>
</xsl:choose>
</xsl:template>
<xsl:template name="lbother">
<xsl:choose>
	<xsl:when test="$lang='fr'">Autres</xsl:when>
	<xsl:otherwise>Other</xsl:otherwise>
</xsl:choose>
</xsl:template>
<xsl:template name="lbunknown">
<xsl:choose>
	<xsl:when test="$lang='fr'">DTC inconnu</xsl:when>
	<xsl:otherwise>Unknown DTC</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--  affichage du message 'No failure detected' -->
<xsl:template name="nofailure">
<xsl:choose>
	<xsl:when test="$lang='fr'">Aucune panne détectée</xsl:when>
	<xsl:otherwise>No failure detected</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="readDtcError">
<xsl:choose>
	<xsl:when test="$lang='fr'">Erreur : Réponse négative reçue en réponse à une requête de lecture des pannes (ReadDTC)</xsl:when>
	<xsl:otherwise>Error: Negative response is received for request ReadDTC</xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template name="nbfailures">
<xsl:param name="nb" />
<xsl:param name="nbFc" select="0"/>
<xsl:param name="nbFh" select="0"/>
<xsl:param name="nbFtnc" select="0"/>
<xsl:param name="nbFinco" select="0"/>
<xsl:param name="nbUnknow" select="0"/>
<xsl:choose>
	<xsl:when test="$lang='fr'">Véhicule avec <xsl:value-of select="$nb"/> pannes<font size="-1">
	<xsl:if test="$nbFc!=0 or $nbFh!=0"><br/>&#xA0;&#xA0;dont <xsl:value-of select="$nbFc"/> panne(s) présente(s), <xsl:value-of select="$nbFh"/> panne(s) mémorisée(s)</xsl:if>
	<xsl:if test="$nbFinco!=0">,&#xA0;<xsl:value-of select="$nbFinco"/> panne(s) non classée(s)</xsl:if>
	<xsl:if test="$nbUnknow!=0">,&#xA0;<xsl:value-of select="$nbUnknow"/> panne(s) inconnue(s)</xsl:if>
	<xsl:if test="$nbFtnc!=0"><br/>&#xA0;&#xA0;<xsl:value-of select="$nbFtnc"/> DTC en cours de test</xsl:if></font>
	</xsl:when>
	<xsl:otherwise>Vehicle with <xsl:value-of select="$nb"/> failures<font size="-1">
		<xsl:if test="$nbFc!=0 or $nbFh!=0"><br/>&#xA0;&#xA0;<xsl:value-of select="$nbFc"/> Current Failure, <xsl:value-of select="$nbFh"/> Historical Failure</xsl:if>
		<xsl:if test="$nbFinco!=0">,&#xA0;<xsl:value-of select="$nbFinco"/> unclassified failures</xsl:if>
		<xsl:if test="$nbUnknow!=0">,&#xA0;<xsl:value-of select="$nbUnknow"/> unknown failures</xsl:if>
		<xsl:if test="$nbFtnc!=0"><br/>&#xA0;&#xA0;<xsl:value-of select="$nbFtnc"/> DTC with test not completed</xsl:if></font>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="msgfailure">
<xsl:param name="tpanne" select="0"/>
<xsl:choose>
	<xsl:when test="$lang='fr'"><xsl:choose>
		<xsl:when test="$tpanne='Current'"><span class="tdmerror"> Panne présente</span></xsl:when>
		<xsl:when test="$tpanne='Historical'"><span class="tdmwarning"> Panne mémorisée</span></xsl:when>
		<xsl:when test="$tpanne='TestNotCompleted Current'"><span class="tdmerror"> Panne présente</span></xsl:when>
		<xsl:when test="$tpanne='TestNotCompleted Historical'"><span class="tdmwarning"> Panne mémorisée</span></xsl:when>
		<xsl:when test="$tpanne='TestNotCompleted'"><span class="tdmNotCompleted"> Test non terminé</span></xsl:when>
		<xsl:otherwise><span class="tdmerror"> Panne</span></xsl:otherwise>
	</xsl:choose></xsl:when>
	<xsl:otherwise><xsl:choose>
		<xsl:when test="$tpanne='Current'"><span class="tdmerror"> Current Failure</span></xsl:when>
		<xsl:when test="$tpanne='Historical'"><span class="tdmwarning"> Historical Failure</span></xsl:when>
		<xsl:when test="$tpanne='TestNotCompleted Current'"><span class="tdmerror"> Current Failure</span></xsl:when>
		<xsl:when test="$tpanne='TestNotCompleted Historical'"><span class="tdmwarning"> Historical Failure</span></xsl:when>
		<xsl:when test="$tpanne='TestNotCompleted'"><span class="tdmNotCompleted"> Test not completed</span></xsl:when>
		<xsl:otherwise><span class="tdmerror"> Failure</span></xsl:otherwise>
	</xsl:choose></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="msgdata">
<span class="tdmwithinfo"><xsl:choose>
	<xsl:when test="$lang='fr'">avec données associées</xsl:when>
	<xsl:otherwise>with Data</xsl:otherwise>
</xsl:choose></span>
</xsl:template>


<!--  affichage du message 'No info' -->
<xsl:template name="noinfo">
<span class="noinfo"><xsl:choose>
	<xsl:when test="$lang='fr'">&#xA0;Pas de définition des pannes dans la base, impossible de détecter les pannes</xsl:when>
	<xsl:otherwise>&#xA0;No device definition in database, unable to detect failures</xsl:otherwise>
</xsl:choose></span>
</xsl:template>

<!--  affichage du message 'No info' -->
<xsl:template name="nodiag">
<span class="tdmnodiag"><xsl:choose>
	<xsl:when test="$lang='fr'">Organe sans détection de panne</xsl:when>
	<xsl:otherwise>Device without failure detection</xsl:otherwise>
</xsl:choose></span>
</xsl:template>

<xsl:template name="devicetype">
<xsl:param name="t"/>
<xsl:choose>
	<xsl:when test="$lang='fr'"><span class="devicetype"><xsl:choose>
	<xsl:when test="$t=1">Organes d'entrées : </xsl:when>
	<xsl:when test="$t=2">Organes internes : </xsl:when>
	<xsl:when test="$t=3">Organes de sorties : </xsl:when>
	<xsl:otherwise>Autres organes : </xsl:otherwise>
</xsl:choose></span></xsl:when>
	<xsl:otherwise><span class="devicetype"><xsl:choose>
	<xsl:when test="$t=1">Output device : </xsl:when>
	<xsl:when test="$t=2">Internal device : </xsl:when>
	<xsl:when test="$t=3">Input device : </xsl:when>
	<xsl:otherwise>Other device : </xsl:otherwise>
</xsl:choose></span></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="msgnodiagtool">
<span class="nodiag"><xsl:choose>
	<xsl:when test="$lang='fr'">L'outil ne peut pas détecter de panne, cette organe n'est pas diagnostiqué par le calculateur</xsl:when>
	<xsl:otherwise>Tool can't detect failure, No device diagnosis implemented in ECU</xsl:otherwise>
</xsl:choose></span>
</xsl:template>

<xsl:template name="msgtitlefailure">
<xsl:choose>
	<xsl:when test="$lang='fr'">Liste des organes en panne</xsl:when>
	<xsl:otherwise>Devices with failures</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="msgtitlealldevice">
<xsl:choose>
	<xsl:when test="$lang='fr'">Liste de tous les organes</xsl:when>
	<xsl:otherwise>All Devices</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="msgfctfailures">
&#160;
<span class="hasfailure"><xsl:choose>
<xsl:when test="$lang='fr'">Pannes détectées sur ce calculateur</xsl:when>
<xsl:otherwise>Failures detected</xsl:otherwise>
</xsl:choose></span>
</xsl:template>

<xsl:template name="msgtestnotcompleted">
&#160;
<span class="underTest"><xsl:choose>
<xsl:when test="$lang='fr'">Certains organes sont en cours de test</xsl:when>
<xsl:otherwise>Some devices are still under test</xsl:otherwise>
</xsl:choose></span>
</xsl:template>

<xsl:template name="msgcomerror">
<FONT COLOR="#FF0000" SIZE="3"><b><xsl:choose>
	<xsl:when test="$lang='fr'">Erreur de communication</xsl:when>
	<xsl:otherwise>Com error</xsl:otherwise>
</xsl:choose></b></FONT>
</xsl:template>

<xsl:template name="UnspecifiedFtype">
<FONT COLOR="#FF0000"><b><xsl:choose>
	<xsl:when test="$lang='fr'">Type de panne non spécifié</xsl:when>
	<xsl:otherwise>Unspecified Failure type</xsl:otherwise>
</xsl:choose></b></FONT>
</xsl:template>

<xsl:template name="msgFailureType">
<xsl:param name="t"/>
<xsl:choose>
	<xsl:when test="$lang='fr'"><xsl:choose>
	<xsl:when test="$t='Present'">Panne présente</xsl:when>
	<xsl:when test="$t='Stored'">Panne mémorisée</xsl:when>
	<xsl:otherwise>Panne <xsl:value-of select="$t"/> </xsl:otherwise>
</xsl:choose></xsl:when>
	<xsl:otherwise><xsl:choose>
	<xsl:when test="$t='Present'">Present Failure</xsl:when>
	<xsl:when test="$t='Stored'">Stored Failure</xsl:when>
	<xsl:otherwise>Failure : <xsl:value-of select="$t"/></xsl:otherwise>
</xsl:choose></xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template name="noSnapshotRecord">
<b><xsl:choose>
	<xsl:when test="$lang='fr'">Aucun Snapshot pour ce DTC ou décodage impossible</xsl:when>
	<xsl:otherwise>No snapshot for this DTC or decoding data missing in database</xsl:otherwise>
</xsl:choose></b>
</xsl:template>

<xsl:template name="noExtDataRecord">
<b><xsl:choose>
	<xsl:when test="$lang='fr'">Aucune donnée étendue pour ce DTC ou décodage impossible</xsl:when>
	<xsl:otherwise>No Extended Data for this DTC or decoding data missing in database</xsl:otherwise>
</xsl:choose></b>
</xsl:template>

<xsl:template name="supportedFcts">
<xsl:choose>
	<xsl:when test="$lang='fr'">Fonctions analysées : </xsl:when>
	<xsl:otherwise>Functions : </xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template name="cssstyle">
<style id="failurecss">
BODY {FONT-SIZE: 100%;FONT-FAMILY: Arial}
TABLE {FONT-SIZE: 100%;FONT-FAMILY: Arial}
A            { text-decoration: none; color: #000000 }
A:hover	{    TEXT-DECORATION: underline}
A:active{    TEXT-DECORATION: underline}
DIV		{BACKGROUND-COLOR: #c6c3bd; MARGIN: 1px; color:black}
H2		{PADDING-RIGHT: 4pt;PADDING-LEFT: 5pt;PADDING-BOTTOM: 4pt;COLOR: white;PADDING-TOP: 4pt;BACKGROUND-COLOR: black}
H2 A	{COLOR: ivory}
PRE		{FONT-SIZE: 85%;display:inline}

#fontSizeSelector {font-size:12pt !important;}

ul.tdm       { font-size: 100%; font-weight: bold }
.tdmecu    { font-size: 100%; font-weight: normal; margin-top:12px;}
.tdmdev 	{ font-size: 90%; font-weight: normal }
.tdmecuall    { font-size: 90%; font-weight: normal; margin-top:8px;}
.tdmdevall 	{ font-size: 85%; font-weight: normal; }
.tdmerror		{ font-size: 100%; font-weight: bold ; color: #FF0000;}
.tdmwarning		{ font-size: 100%; font-weight: bold ; color: #FF7F00;}
.tdmNotCompleted		{ font-size: 100%; font-weight: bold ; color: #808080;}
.tdmwithinfo		{ font-size: 85%; font-weight: bold ; color: #008000;}
.tdmnodiag      { color: #FF6600; font-style: italic; font-weight: bold }
.error       { font-size: 100%; color: #FF0000; text-align: center; font-weight: bold }

li.error       { font-size: 100%; color: #FF0000; text-align:left; font-weight: bold }

.withinfo    { font-size: 100%; color: #008000; text-align: center; font-weight: bold }
.devicename  { font-size: 100%; color: #000000; text-align: center; font-weight: bold;
               background-color: #82D7FF; border-style: ridge; border-width: 2px }
.nodiagdevicename { font-size: 100%; color: #000000; text-align: center; background-color:
               #FF6600; font-style: italic; font-weight: bold; border-style:
               ridge; border-width: 2px }
.devicetype  { font-size: 100%; font-weight: normal }

.deviceunknown { font-size: 100%; color: #000000; text-align: center; font-weight: bold;
               background-color: #E69B9B; border-style: ridge; border-width: 2px }
.noinfo      { color: #CC6600; font-size: 100%; font-style: italic; font-weight: bold }
.nodiag      { color: #FF6600; font-size: 100%; font-style: italic; font-weight: bold }
.nofailure   { color: #009933; background-color: white; font-size: 100%; font-weight: bold; border:1px solid #009933; padding-left:4px; padding-right:4px;}
.errfailure  { color: #FF0000; background-color: white; font-size: 100%; font-weight: bold; border:1px solid #FF0000; padding-left:4px; padding-right:4px;}
.hasfailure  { color: #ff0000; background-color: white; font-size: 100%; font-weight: bold; border:1px solid #ff0000; padding-left:4px; padding-right:4px;}
.underTest   { color: #6080d0; background-color: white; font-size: 100%; font-weight: bold; border:1px solid #6080d0; padding-left:4px; padding-right:4px;}
.fctname     { font-size: 110%; border-style: solid; border-width: 1px }

TABLE.list 		{PADDING-RIGHT: 1px;PADDING-LEFT: 1px;PADDING-BOTTOM: 1px;PADDING-TOP: 1px;BORDER-COLLAPSE: collapse}
TABLE.list TH	{PADDING-RIGHT: 1px;PADDING-LEFT: 1px;FONT-WEIGHT: bold;FONT-SIZE: x-small;MARGIN: 2px;VERTICAL-ALIGN: baseline;TEXT-ALIGN: left;
			    COLOR: white;BORDER-TOP: 1px outset;BORDER-RIGHT: 1px outset;BORDER-LEFT: 1px outset;BORDER-BOTTOM: 1px outset;BACKGROUND-COLOR: darkblue}
TABLE.list TH.elements		{BACKGROUND-COLOR: darkblue}
TABLE.list TH.attributes	{BACKGROUND-COLOR: darkred}
TABLE.list TH A	{COLOR: white}
TABLE.list TD	{PADDING-RIGHT: 1px;PADDING-LEFT: 1px;PADDING-BOTTOM: 1px;PADDING-TOP: 1px;BORDER-TOP: 1px inset;BORDER-RIGHT: 1px inset;
			    BORDER-LEFT: 1px inset;BORDER-BOTTOM: 1px inset;MARGIN: 2px;VERTICAL-ALIGN: baseline;}
TABLE.list TD A	{COLOR: darkblue}
TABLE.list TD.elements	{BORDER-RIGHT: darkblue 2px inset;BORDER-TOP: darkblue 2px inset;BORDER-LEFT: darkblue 2px inset;BORDER-BOTTOM: darkblue 2px inset;}
TABLE.list TD.attributes{BORDER-RIGHT: darkred 2px inset;BORDER-TOP: darkred 2px inset;BORDER-LEFT: darkred 2px inset;BORDER-BOTTOM: darkred 2px inset;}


<!-- Identifications table -->
TABLE.identification			{BORDER-COLLAPSE: collapse;FONT-SIZE: 10pt}
TABLE.identification TH			{BACKGROUND-COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px}
TABLE.identification TH.fctname		{BACKGROUND-COLOR: #444444;COLOR:White;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: left}
TABLE.identification TH.fctname	A	{BACKGROUND-COLOR: #444444;COLOR:White;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:0px;TEXT-ALIGN: left}
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
TABLE.identification TD.commError	{BACKGROUND-COLOR: #c00000;COLOR: white;BORDER-RIGHT:0px;font-style:italic;}
TABLE.identification TD.identUDSOk	{BACKGROUND-COLOR: #0080ff;COLOR: white;border:1px solid black;TEXT-ALIGN: center}
TABLE.identification TD.identUDSError	{BACKGROUND-COLOR: #FF0000  ;COLOR: white;text-align:left !important;font-size:85% !important;padding-left:2px;}


TABLE.StatusDTC			{BORDER-RIGHT: black 1px solid;BORDER-TOP: black 1px solid;font-size: 90%;BORDER-LEFT: black 1px solid;
    					WIDTH: 100%;BORDER-BOTTOM: black 1px solid;FONT-FAMILY: Arial;BORDER-COLLAPSE: collapse;}
TABLE.StatusDTC TR TD	{BORDER-RIGHT: black 1px solid;PADDING-RIGHT: 5px;BORDER-TOP: black 1px solid;PADDING-LEFT: 5px;
					    BORDER-LEFT: black 1px solid;BORDER-BOTTOM: black 1px solid}
TABLE.StatusDTC TH		{BORDER-RIGHT: black 1px solid;PADDING-RIGHT: 5px;BORDER-TOP: black 1px solid;PADDING-LEFT: 5px;
    					BORDER-LEFT: black 1px solid;BORDER-BOTTOM: black 1px solid}
TABLE.StatusDTC TD.hexa {font-family: monospace}              

TABLE.Function		{BORDER-RIGHT: black 1px solid;BORDER-TOP: black 1px solid;BORDER-LEFT: black 1px solid;BORDER-BOTTOM: black 1px solid}
TABLE.Function TD	{BORDER-RIGHT: black 1px solid;BORDER-TOP: black 1px solid;BORDER-LEFT: black 1px solid;BORDER-BOTTOM: black 1px solid}

TABLE.Functions				{BORDER-RIGHT: black 0px solid;BORDER-TOP: black 0px solid;BORDER-LEFT: black 0px solid;BORDER-BOTTOM: black 0px solid}
TABLE.Functions TH		{BACKGROUND-COLOR: white;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;FONT-SIZE: 100%}
TABLE.Functions TH.fctname		{BACKGROUND-COLOR: #444444;COLOR:White;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;TEXT-ALIGN: left}
TABLE.Functions TD H2		{PADDING-RIGHT: 5px;PADDING-LEFT: 5px;FONT-WEIGHT: bolder;font-size: 100%;PADDING-BOTTOM: 5px;
    						MARGIN: 0px;COLOR: lightgoldenrodyellow;PADDING-TOP: 5px;FONT-STYLE: italic;BACKGROUND-COLOR: gray;TEXT-ALIGN: center}

TABLE.ExtendedData			{BORDER-RIGHT: black 1px solid;BORDER-TOP: black 1px solid;font-size: 90%;BORDER-LEFT: black 1px solid;
    						WIDTH: 100%;BORDER-BOTTOM: black 1px solid;FONT-FAMILY: Arial;BORDER-COLLAPSE: collapse}
TABLE.ExtendedData TH		{PADDING-RIGHT: 2em;PADDING-LEFT: 2em;PADDING-TOP: 0px;PADDING-BOTTOM: 0px;
							FONT-WEIGHT: bold;MARGIN: 0px;VERTICAL-ALIGN: baseline;BACKGROUND-COLOR: #00CC66;TEXT-ALIGN: center}
TABLE.ExtendedData TR TD  	{BORDER-RIGHT: black 1px solid;PADDING-RIGHT: 5px;BORDER-TOP: black 1px solid;
							PADDING-LEFT: 5px;BORDER-LEFT: black 1px solid;BORDER-BOTTOM: black 1px solid}
TABLE.FreezeF		{BORDER-RIGHT: black 1px solid;BORDER-TOP: black 1px solid;FONT-SIZE: 90%;BORDER-LEFT: black 1px solid;
				    WIDTH: 100%;BORDER-BOTTOM: black 1px solid;FONT-FAMILY: Arial;BORDER-COLLAPSE: collapse;}
TABLE.FreezeF TH	{PADDING-RIGHT: 2em;PADDING-LEFT: 2em;PADDING-TOP: 0px;PADDING-BOTTOM: 0px;
				    FONT-WEIGHT: bold;MARGIN: 0px;VERTICAL-ALIGN: baseline;BACKGROUND-COLOR: #6699FF;TEXT-ALIGN: center}
TABLE.FreezeF TR TD	{BORDER-RIGHT: black 1px solid;PADDING-RIGHT: 5px;BORDER-TOP: black 1px solid;PADDING-LEFT: 5px;
				    BORDER-LEFT: black 1px solid;BORDER-BOTTOM: black 1px solid}

TABLE.DTCName		{BORDER-RIGHT: black 0px solid;BORDER-LEFT: black 0px solid;BORDER-TOP: black 0px solid;BORDER-BOTTOM: black 0px solid;
					font-size: 100%;WIDTH: 100%;FONT-FAMILY: Arial;BORDER-COLLAPSE: collapse;}
TABLE.DTCName TR TD	{BORDER-RIGHT: black 0px solid;BORDER-LEFT: black 0px solid;BORDER-TOP: black 0px solid;BORDER-BOTTOM: black 0px solid;
					PADDING-RIGHT: 3px;PADDING-LEFT: 3px;BACKGROUND-COLOR: #4BF1F1;TEXT-ALIGN: center}

TABLE.tbComment		{PADDING-RIGHT: 1px;PADDING-LEFT: 1px;PADDING-BOTTOM: 1px;PADDING-TOP: 1px;BORDER-COLLAPSE: collapse;}
TABLE.tbComment TH	{PADDING-RIGHT: 1px;PADDING-LEFT: 1px;FONT-WEIGHT: bold;FONT-SIZE: x-small;MARGIN: 2px;VERTICAL-ALIGN: baseline;
    				COLOR: white;BORDER-TOP: 1px outset;BORDER-RIGHT: 1px outset;BORDER-LEFT: 1px outset;BORDER-BOTTOM: 1px outset;BACKGROUND-COLOR: darkblue;TEXT-ALIGN: left;}
TABLE.tbComment TD	{PADDING-RIGHT: 1px;PADDING-LEFT: 1px;PADDING-BOTTOM: 1px;PADDING-TOP: 1px;BORDER-TOP: 1px inset;BORDER-RIGHT: 1px inset;
				    BORDER-LEFT: 1px inset;BORDER-BOTTOM: 1px inset;FONT-SIZE: x-small;MARGIN: 2px;VERTICAL-ALIGN: baseline;}

TABLE.Error			{PADDING: 0px;BORDER-COLLAPSE: collapse}
TABLE.Error TH		{BACKGROUND-COLOR: red;BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;FONT-SIZE: 100%;COLOR: white;FONT-WEIGHT: bold}
TABLE.Error TD A	{COLOR: red}
TABLE.Error TD		{BORDER-STYLE:solid;BORDER-COLOR:black;BORDER-WIDTH:1px;FONT-SIZE: 100%;TEXT-ALIGN: center; COLOR:red;FONT-WEIGHT: normal}



  
<!-- Identifications legend -->
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
  
  
  <!-- Identification-->
  

  

  
  
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
  <!--                      Gestion de la l'affichage des identifications                    -->
  <!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <xsl:template match="Identifications | Failures">
    <!-- message global si aucune erreur n'est detectèe -->

    <!-- Affichage du detail de chaque calculateur -->
    <table class="identification" width="100%">

	    <xsl:apply-templates select="Function[@Address!= 0 and @Address != 255]" mode="identifications"/>

    </table>
    <xsl:call-template name="legend"/>
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
			  <!--<xsl:call-template name="UDSIdentHeader1"/>-->
		    <xsl:apply-templates select="IdentificationUDS"/>
		  </tr>
	    </xsl:when>
    
	    <xsl:when test="Identification">
		  <tr>
			  <th rowspan="3">
				  <xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
				  <xsl:value-of select="@Name"/>
			  </th>
			  <xsl:call-template name="IdentHeader"/>
		  </tr>
		    <xsl:apply-templates select="Identification"/>
	    </xsl:when>
    
	    <xsl:otherwise>
		  <tr>
			  <th>
				  <xsl:if test="Error"><xsl:attribute name="class">InitError</xsl:attribute></xsl:if>
				  <xsl:value-of select="@Name"/>
			  </th>
			  <!--<xsl:call-template name="IdentHeader"/>-->
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
<!--        affichage du detail des fonctions avec toutes les infos                            -->
<!-- ========================================================================================= -->
<xsl:template match="Function" mode="all_identifications">
<!-- Affichage du detail de chaque calculateur -->
<tr>
  <th class="fctname" >
  Function: <font size="+1"><xsl:value-of select="@Name"/></font>
  <xsl:if test="DiagName">
  	&#xA0;&#xA0;- Name: <font size="+1"><xsl:value-of select="DiagName"/></font>
  </xsl:if>
  </th>
  <th class="fctname" ><xsl:if test="VIN[not(Error)]">VIN: <font size="+1"><xsl:value-of select="VIN/@Number"/></font></xsl:if></th>
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
			<xsl:apply-templates select="Identification/ProgrammingStamp" mode="all_identifications"/>
		</xsl:if>
	</xsl:otherwise>
</xsl:choose>
</table>
</td>
</tr>
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
      <xsl:if test="not(parent::*)"><br /><xsl:text>&#xA;</xsl:text></xsl:if>
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
      <xsl:if test="not(parent::*)"><br /><xsl:text>&#xA;</xsl:text></xsl:if>
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
      <xsl:if test="not(parent::*)"><br /><xsl:text>&#xA;</xsl:text></xsl:if>
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