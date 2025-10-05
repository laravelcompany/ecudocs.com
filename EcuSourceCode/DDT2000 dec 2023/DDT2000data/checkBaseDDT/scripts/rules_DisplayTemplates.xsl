<?xml version="1.0" encoding="windows-1252"?>
<!--
[XSL-XSLT] This stylesheet automatically updated from an IE5-compatible XSL stylesheet to XSLT.
The following problems which need manual attention may exist in this stylesheet:
-->
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:ddt="http://www-diag.renault.com/2002/ECU"
xmlns:ds="http://www-diag.renault.com/2002/screens"
xmlns:local="#local-functions">

	<xsl:template name="currentVersion">
		<xsl:value-of select="document('rules_displayCheckBaseDDT.xsl')//span[@id='currentVersion']" />
	</xsl:template>

	<xsl:template name="rules_CSS">
		<style type="text/css">
			<![CDATA[
				body, table, td
				{
					font-family:Verdana, Arial, Helvetica, sans-serif; font-size:8pt;
				}

				td
				{
					padding:2px 2px 2px 2px;
					empty-cells:show;
					vertical-align:top;
				}

				td.item
				{
					/*  border-bottom:1px gray dashed; */
				}

				td.channelTitle
				{
					font-weight:bold;
					font-size:120%;
					border:1px black solid;
					border-left:0px;
					background-color:#f0f0f0;
				}

				td.channelTitle a:hover
				{
					background-color:#f0f0f0;
					text-decoration:underline;
				}

				td.separator
				{
					border-bottom:1px dashed black;
				}

				a:hover
				{
					background-color:#f0f0f0;
				}

				a.imageLink:hover
				{
					background-color:transparent;
				}

				a
				{
					text-decoration:none;
				}

				a.item
				{
					font-weight:bold;
				}

				a.title
				{
					padding:4px;
				}

				a.title:hover
				{
					text-decoration:underline;
				}

				a.whiteLink
				{
					color:white;
				}

				a.whiteLink:hover
				{
					background-color:#808080;
				}

				.date
				{
					font-size:85%;
					font-style:italic;
				}

				.channelTitleImage
				{
					padding:2px;
					border:1px black solid;
					border-right:0px;
					background-color:#f0f0f0;
				}

				.channelDescription, .description, .author
				{
					display:block;
					margin-left:8px;
				}

				.channelDescription
				{
					font-size:105%;
				}

				.copyright, .author
				{
					font-size:80%;
					font-style:italic;
				}

				td, th
				{
					border:1px solid black;
				}

				th
				{
					vertical-align:middle;
					PADDING-RIGHT: 1px;
					PADDING-LEFT: 1px;
					FONT-WEIGHT: bold;
					MARGIN: 2px;
					COLOR: white;
					BORDER-TOP: 1px outset;
					BORDER-RIGHT: 1px outset;
					BORDER-LEFT: 1px outset;
					BORDER-BOTTOM: 1px outset;
					TEXT-ALIGN: center;
					background-color:#000080;
				}

				td.cellule_normale
				{
					text-align:center;
					vertical-align:top;
				}

				table.warning th
				{
					color: black;
					BACKGROUND-COLOR: orange;
				}

				div.warning
				{
					font-weight:bold;
					color: black;
					BACKGROUND-COLOR: orange;
				}

				th.warningTitle, th.warningCount
				{
					font-size:120%;
					padding:8px;
				}

				td.cellule_warning
				{
					font-weight:bold;
					color: black;
					BACKGROUND-COLOR: orange;
					text-align:center;
				}

				td.cellule_currentversion
				{
					color: black;
					BACKGROUND-COLOR:#e0e0e0 ;
				}

				td.cellule_impact_CurrentVersion
				{
					text-align:center;
					color: black;
					BACKGROUND-COLOR:#e0e0e0 ;
				}

				table.error th
				{
					color: white;
					BACKGROUND-COLOR: red;
				}

				div.error
				{
					font-weight:bold;
					color: white;
					BACKGROUND-COLOR: red;
				}

				th.errorTitle, th.errorCount
				{
					font-size:120%;
					padding:8px;
				}

				td.cellule_error
				{
					font-weight:bold;
					color: white;
					BACKGROUND-COLOR: red;
					text-align:center;
				}

				td.cellule_error a
				{
					font-weight:bold;
					color: white;
				}

				td.cellule_error a:hover
				{
					background-color:red;
				}

				td.cellule_OK
				{
					font-weight:bold;
					color: white;
					BACKGROUND-COLOR: green;
					text-align:center;
				}

				td.cellule_OK a
				{
					color: white;
				}

				td.cellule_OK a:hover
				{
					background-color:green;
				}

				form
				{
					display:inline;
				}

				@media print
				{
					/* style sheet for print goes here */
					.pageBreak
					{
						page-break-before:always;
					}
					form
					{
						display:none;
					}
					#topOfPage
					{
						display:none;
					}
				}
			]]>
		</style>
	</xsl:template>

	<xsl:template name="rules_Scripts">
		<script type="text/javascript">
			<xsl:comment>
				<![CDATA[
					function changeFontSize(aStep)
					{
						var fsorg = "";
						var fs = 0;
						var i  = 0;
						var nbRules = document.styleSheets[0].rules.length;
						for (i=0; i < nbRules ; i++)
						{
							fsorg = document.styleSheets[0].rules.item(i).style.fontSize;
							if (fsorg != '')
							{
								if (fsorg.indexOf("%") == -1)
								{
									fs = parseInt(fsorg);
									try
									{
										document.styleSheets[0].rules.item(i).style.fontSize = (fs + aStep) + "pt";
									}
									catch (e)
									{
									}
								}
							}
						}
					}
				]]>
			</xsl:comment>
		</script>
	</xsl:template>

	<xsl:template name="rules_DisplayTemplates">
		<xsl:variable name="CountRulesWarning_DDT2000" select="count(//check/rule[substring(code,1,1)='D' and substring(code,2,1)='W'])" />
		<xsl:variable name="CountRulesError_DDT2000" select="count(//check/rule[substring(code,1,1)='D' and substring(code,2,1)='E'])" />
		<xsl:variable name="CountRulesWarning_CPDD" select="count(//check/rule[substring(code,1,1)='C' and substring(code,2,1)='W'])" />
		<xsl:variable name="CountRulesError_CPDD" select="count(//check/rule[substring(code,1,1)='C' and substring(code,2,1)='E'])" />
		<xsl:variable name="CountRulesWarning_DAIMLER" select="count(//check/rule[substring(code,1,1)='M' and substring(code,2,1)='W'])" />
		<xsl:variable name="CountRulesError_DAIMLER" select="count(//check/rule[substring(code,1,1)='M' and substring(code,2,1)='E'])" />
		<xsl:variable name="CountRulesWarning_ALLIANCE" select="count(//check/rule[substring(code,1,1)='A' and substring(code,2,1)='W'])" />
		<xsl:variable name="CountRulesError_ALLIANCE" select="count(//check/rule[substring(code,1,1)='A' and substring(code,2,1)='E'])" />
		<span id="topOfPage">
			<!-- Afficher la langue DDT2000 -->
			<hr/>
			<xsl:call-template name="getLocalizedText">
				<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
				<xsl:with-param name="aNode" select="document('Translate.xml')/translation/DDTLanguage"></xsl:with-param>
				<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
			</xsl:call-template> : <xsl:value-of select="$language"></xsl:value-of><br/>
			<!-- Afficher la langue du rapport (langue DDT200 au moment de la création du rapport) -->
			<xsl:call-template name="getLocalizedText">
				<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
				<xsl:with-param name="aNode" select="document('Translate.xml')/translation/reportLanguage"></xsl:with-param>
				<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
			</xsl:call-template> : <xsl:value-of select="$reportLanguage"></xsl:value-of>
			<hr/>
		</span>

		<h1><a href="#toc_GENERAL" title="Retour au sommaire">&#9651;</a>
			<xsl:call-template name="getLocalizedText">
				<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
				<xsl:with-param name="aNode" select="document('Translate.xml')/translation/title1"></xsl:with-param>
				<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
			</xsl:call-template>
		</h1>
		<h2>ECU : <xsl:value-of select="/check/message/info" /></h2>
		<h3>
			<xsl:call-template name="getLocalizedText">
				<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
				<xsl:with-param name="aNode" select="document('Translate.xml')/translation/versionTable"></xsl:with-param>
				<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
			</xsl:call-template>
		</h3>
		<b>
			<xsl:call-template name="getLocalizedText">
				<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
				<xsl:with-param name="aNode" select="document('Translate.xml')/translation/currentVersion"></xsl:with-param>
				<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="document('rules_displayCheckBaseDDT.xsl')//span[@id='currentVersion']" />
		</b>
		<br/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>Version</th>
				<th>Date</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/commentaire"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
			</tr>
			<tr> <!-- V1.0 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.0" /><a href="#rDescriptionVersion" />V1.0</td>
				<td class="cellule_normale">19/11/2007</td>
				<td>Original version</td>
			</tr>
			<tr> <!-- V1.1 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.1" /><a href="#rDescriptionVersion" />V1.1</td>
				<td class="cellule_normale">03/12/2007</td>
				<td>
					<ul>
						<li><b>All files</b> : Setting IDs for the rules</li>
						<br/>-----------------<br/>
						<li><b>All files</b> : Adding impacts when errors occur</li>
						<br/>-----------------<br/>
						<li><b>Rule DE019 - DE027</b> : Request: Duplicated received data inside a request<br/>
							Updating check : keeping only duplications count
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE037</b> : Request: Duplicated request<br/>
							Updating check : keeping only duplications count
						</li>
					</ul>
				</td>
			</tr>
			<tr> <!-- V1.2 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.2" /><a href="#rDescriptionVersion" />V1.2</td>
				<td class="cellule_normale">17/01/2008</td>
				<td>
					<ul>
						<li><b>Rule CE032 - CE036</b> : Request: First byte of the sent data &lt;2 or first byte &gt;254 bytes<br/>
							Updating check : updating the limits
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE036</b> : Incoherence between Reply byte  and send bytes<br/>
							Adding check : reply bytes service = send bytes service + $40
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DW009</b> : Request: If ClearDiagnosticInformation.Manual exists, the failure page doesn't erase failure<br/>
							Updating check : adding a warning
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DW009</b> : Request: ReadDTCInformation.ReportDTC<br/>
							Updating check : using $1902 instead of $1902FF
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE001</b> : Undefined diagnostic specifications: 36-00-13/--A or 36-00-13/--B<br/>
							Updating check : using $1902 instead of $1902FF
						</li>
						<br/>-----------------<br/>
					</ul>
				</td>
			</tr>
			<tr> <!-- V1.3 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.3" /><a href="#rDescriptionVersion" />V1.3</td>
				<td class="cellule_normale">30/01/2008</td>
				<td>
					<ul>
						<li><b>Rule CE031</b> : Request: Sent bytes &lt;1 or sent bytes &gt;254 bytes (508 characters)<br/>
							Updating check : 254 characters instead of 254 bytes
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE007</b> : Data: DTCDeviceIdentifier is missing (Specification 36-00-13/--B)<br/>
							Adding check : The data DTCDeviceIdentifier must be defined (Specification 36-00-13/--B
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE008</b> : Data: FirstDTC is missing (Specification 36-00-13/--A)<br/>
							Adding check : The data FirstDTC must be defined (Specification 36-00-13/--A)
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE037</b> : Request: Duplicated request (considering sent bytes) and maintainability report<br/>
							Updating check : requests with maintainability report should not be duplicated
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE160</b> : DTC: Incoherence between the DTC declared in the devices and the DTC declared in the data DTCDeviceIdentifier (Specification 36-00-13/--B)<br/>
							Updating check : The list of DTC declared in the data DTCDeviceIdentifier must be<br/>
							equal to the list of the DTC declared in the devices (Specification 36-00-13/--B)
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE161</b> : DTC: Incoherence between the DTC declared in the devices and the DTC declared in the data FirstDTC (Specification 36-00-13/--A)
							Updating check : The list of DTC declared in the data FirstDTC must be<br/>
							equal to the list of the DTC declared in the devices (Specification 36-00-13/--A)
						</li>
						<br/>-----------------<br/>
						<li><b>Report</b> : English and French are supported for all files
						</li>
					</ul>
				</td>
			</tr>
			<tr> <!-- V1.4 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.4" /><a href="#rDescriptionVersion" />V1.4</td>
				<td class="cellule_normale">22/05/2008</td>
				<td>
					<ul>
						<li><b>General information</b> : Updating displays and information<br/>
							Adding Generic ECU name, displaying ECU Address both in DEC and HEX, puting Auto-Idents in an array
						</li>
						<br/>-----------------<br/>
						<li><b>Communication Protocol</b> : Displaying CAN IDs in an array<br/>
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE005</b> : Data: Format: unsigned 32 bits numeric not supported<br/>
							Updating check : when no unit nor a formula is defined for the Data, suggesting to change Data format to 4 bytes in BCD/HEXA<br/>
							No solution for other cases
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE037</b> : Request: Duplicated request (considering sent bytes) and maintainability report<br/>
							Updating check : applying check only to requests with maintainability report
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE090</b> : Request : ReadDTCInformation.ReportExtendedData
							Adding check : check already exists but included in an other one<br/>
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE091</b> : Request : ($1906000000FF) Invalid resquest name<br/>
							Adding check : check that the exact name is ReadDTCInformation.ReportExtendedData<br/>
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE102</b> : Request : ReadDTCInformation.ReportExtendedData_Mileage<br/>
							Updating check : Number of bytes to be received (MinBytes) equals 6 or 10
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE109 : </b> : Request : ($190600000080) Invalid resquest name<br/>
							Adding check : check that the exact name is ReadDTCInformation.ReportExtendedData.Mileage<br/>
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE127 : </b> : Request : ($1904000000FF) Invalid resquest name<br/>
							Adding check : check that the exact name is ReadDTCInformation.ReportSnapshot<br/>
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE130</b> : Request: DataRead.Identification.RenaultR2<br/>
							Adding check : Check if the request exists
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE146</b> : Request: BreakDown Type: the initialization type of fault and associated id is not correct<br/>
							Adding check : considering all faults types and their IDs
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE170</b> : Address function: Invalid address function (address&lt;1 or address&gt;254)<br/>
							Updating check : CW050 changed to error DE170
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE171</b> : Address function/CanID: Incoherence between the Address function and the CanID<br/>
							Adding check : the authorized values for the addresses and the CanIDs are specified in the GenericAdressing file
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE001</b> : Data: Length of the comment &gt;= 100 characters<br/>
							Updating check : 100 characters instead of 255
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE003</b> : Data: length of name (normalized with CPDD mode) &gt;255 characters<br/>
							Updating check : CW002 changed to error CE003 and 255 characters instead of 70
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE004</b> : Data: length list item text &gt;50 characters<br/>
							Updating check : CW006 changed to error CE004
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE031</b> : Request: Sent bytes &lt;1 or sent bytes &gt;254 bytes (508 characters)<br/>
							Updating check : text changed from 254 characters to 127 bytes
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE150</b> : Device: Length of name &gt;100 characters<br/>
							Updating check : CW022 changed to error CE150
						</li>
						<br/>-----------------<br/>
						<li><b>Report</b> :<br/>
							Adding rules at the end<br/>
							Adding check versions table at the beginning<br/>
							Linking the versions table at the beginning and the rules at the end<br/>
							Linking the each rule trigging an error and the rules at the end
						</li>
						<br/>-----------------<br/>
						<li><b>Other</b> : Updating CPDD Impacts<br/>
						</li>
					</ul>
				</td>
			</tr>
			<tr> <!-- V1.5 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.5" /><a href="#rDescriptionVersion" />V1.5</td>
				<td class="cellule_normale">01/09/2011</td>
				<td>
					<ul>
						<li><b>Rule DW011</b> : Request: Template of the response(ReplyBytes) is missing<br/>
							Adding the check : Template of the response(reply bytes) must start with LID + $40.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DW012</b> Requests: required requests for injector code reading<br/>
							Adding the check : requests $21AD and $22FDC5 are present.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE017</b> : Request: sent data is defined as reference<br/>
							Adding the check : no data defined as reference in the sent bytes of the request.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE038</b> : Request: TesterPresent.WithResponse is missing (Spécification 36-00-013/B) <br/>
							Adding the check : request TesterPresent.WithResponse is present.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE033</b> : Request: checking the number of sent bytes<br/>
							Updating the check : for requests starting with $21XX, only 1 byte is used for LID (XX).
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE037</b> : Request: Duplicated request (considering sent bytes) and maintainability report<br/>
							Updating the check : only one identification request $2180 is used.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE130->DE144</b> : For ECUs of type R2, the request $2180 must contain specific datas at defined positions<br/>
							Updating the check : adding control on PartNumber.BasicPartList (at the 23rd byte), HardwareNumber.BasicPartList (at the 24th byte), ApprovalNumber.BasicPartList(at the 25th byte)
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE130->DE144</b> : For ECUs of type R2, the request $2180 must contain specific datas as lists<br/>
							Updating the check : HardwareNumber.BasicPartList and PartNumber.BasicPartList datas must contain a list of values and texts
						</li>
						<br/>-----------------<br/>
						<li><b>UDS</b> : Identifying diagnostic services used (Spec A, B or UDS)<br/>
							Adding check : identifying that the UDS is used.
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE172</b> : Request: Identification ($22F187) is missing or not as specified by UDS protocol<br/>
							Adding check : vehicleManufacturerSparePartNumber should be of ASCII type and of exact 10 bytes length
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE173</b> : Request: Identification ($22F188) is missing or not as specified by UDS protocol<br/>
							Adding check : vehicleManufacturerECUSoftwareNumber should be of ASCII type and of exact 10 bytes length
						</li>
						<li><b>UDS-Rule DE174</b> : Request: Identification ($22F18A) is missing or not as specified by UDS protocol<br/>
							Adding check : systemSupplierIdentifier should be of UTF-8 type and of maximum 64 bytes length
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE175</b> : Request: Identification ($22F18C) is missing or not as specified by UDS protocol<br/>
							Adding check : ECUSerialNumber should be of ASCII type and of exact 20 bytes length
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE176</b> : Request: Identification ($22F190) is missing or not as specified by UDS protocol<br/>
							Adding check : VIN should be of ASCII type and of exact 17 bytes length
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE177</b> : Request: Identification ($22F191) is missing or not as specified by UDS protocol<br/>
							Adding check : vehicleManufacturerECUHardwareNumber should be of ASCII type and of exact 10 bytes length
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE178</b> : Request: Identification ($22F194) is missing or not as specified by UDS protocol<br/>
							Adding check : systemSupplierECUSoftwareNumber should be of UTF-8 type and of maximum 32 bytes length
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE179</b> : Request: Identification ($22F195) is missing or not as specified by UDS protocol<br/>
							Adding check : systemSupplierECUSoftwareVersionNumber should be of UTF-8 type and of maximum 32 bytes length
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE180</b> : Request: Identification ($22F1A0) is missing or not as specified by UDS protocol<br/>
							Adding check : Alliance specific VDIAG should be of HEX type and of exact 1 bytes length
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE181</b> : Request: StartDiagnosticSession ($10XX) is missing or not as specified by UDS protocol<br/>
							Adding check : at least one request ($10XX) starting with the name StartDiagnosticSession and 2 bytes long must be present
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE182</b> : Request: ClearDiagnosticInformation ($14XXXXXX) is missing or not as specified by UDS protocol<br/>
							Adding check : at least one request ($14XXXXXX) starting with the name ClearDiagnosticInformation must be present
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE183</b> : Request: ReadDTCInformation.ReportNumberOfDTCByStatusMask ($1901XX) is missing or not as specified by UDS protocol<br/>
							Adding check : at least one request ($1901XX) starting with the name ReadDTCInformation.ReportNumberOfDTCByStatusMask must be present
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE184</b> : Request: ReadDTCInformation.ReportDTC ($1902XX) is missing or not as specified by UDS protocol<br/>
							Adding check : at least one request ($1902XX) starting with the name ReadDTCInformation.ReportDTC must be present
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE185</b> : Request: ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX) is missing or not as specified by UDS protocol<br/>
							Adding check : at least one request ($1903XX) starting with the name ReadDTCInformation.ReportDTCSnapshotIdentification must be present
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE186</b> : Request: ReadDTCInformation.ReportSupportedDTC ($190AXX) is missing or not as specified by UDS protocol <br/>
							Adding check : at least one request ($190AXX) starting with the name ReadDTCInformation.ReportSupportedDTC must be present
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DW187</b> : Request: RoutineControl ($31) is not as specified by UDS protocol<br/>
							Adding check : If one request ($31) exists check that its name is starting with RoutineControl
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DW188</b> : Request: OutputControl ($2F) is not as specified by UDS protocol<br/>
							Adding check : If one request ($2F) exists check that its name is starting with OutputControl
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE189</b> : Data: OutputPermanentControlList is not as specified by UDS protocol<br/>
							Adding check : OutputPermanentControlList data used in requests $2F must have the exact name, be 2 bytes long and<br/>
							have a list of values/text with at least one data starting with that text
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE190</b> : Data: OutputControlCommand is not as specified by UDS protocol<br/>
							Adding check : OutputControlCommand data used in requests $2F must have the exact name, be 1 byte long and<br/>
							have a list of values/text with at least one data starting with that text
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CW002</b> : Data: Length of the comment &gt;= 100 characters<br/>
							Updating check : CE001 changed to warning CW002
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE002</b> : Data: Duplicate data name normalized with CPDD mode <br/>
							Updating check : removed as equivalent to DE037
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CW006</b> : Data: length list item text &gt;50 characters<br/>
							Updating check : CE004 changed to warning CW006
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CW022</b> : Device: Length of name &gt;100 characters<br/>
							Updating check : CE150 changed to warning CW022
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER</b> : Adding ODX Controls in the report(for DAIMLER)<br/>
							Creating displays for DAIMLER controls
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule MW001</b> : Data: empty list<br/>
							Adding check : Data of type list should contain at least 2 items
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME001</b> : Request: SID of the template of the response(Reply Bytes) is wrong or missing<br/>
							Adding check : Template of the response(Reply Bytes) must start with SID + $40.
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME002</b> : Request: Byte of the template of the response(Reply Bytes) other than SID is wrong or missing<br/>
							Adding check : Template of the response(Reply Bytes) other than SID must have Sent Bytes equal to specified Reply Bytes
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME003</b> : Request: Byte of the request(Sent Bytes) is missing<br/>
							Adding check : The specified byte should be added to the request(Sent Bytes)
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME004</b> : Auto-identification is missing<br/>
							Adding check : Auto-identification list should at least contain one line
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME005</b> : An auto-identification element is wrong<br/>
							Adding check : Supplier should not be 000 and Soft should not be 0000
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME006</b> : Request: Data outside of the frame (sent or received)<br/>
							Adding check : the data must be included in the request (sent or received)<br/>
							Check the length and the data (first byte, bit offset,...)<br/>
							(Requests with variable reply length are excluded from the check, like $1906...)
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME007</b> : Data: Values of the list item except limits<br/>
							Limite basse et limite haute = fonction(nbre de bits, signe)     <br/>
							Adding check : Low limit and High limit depend on number of bits and signed or not
						</li>
						<br/>-----------------<br/>
						<li><b>Other</b> : Adding BMIR reference in the repport <br/>
						</li>
						<br/>-----------------<br/>
						</ul>
					</td>
			</tr>
			<tr> <!-- V1.6 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.6" /><a href="#rDescriptionVersion" />V1.6</td>
				<td class="cellule_normale">01/10/2012</td>
				<td>
					<ul>
						<li><b>Rule DE037</b> : Duplicated request (considering sent bytes) and maintainability report<br/>
							or Duplicated identification requests with sent bytes $2180<br/>
							IO Control requests $30 in Spec B are no more checked.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE171</b> : Address function/CanID: Incoherence between the Address function and the CanID<br/>
							CAN IDs with 29 bytes are checked.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE185</b> : ReadDTCInformation.ReportDTCSnapshotIdentification ($1903XX) is not as specified by UDS protocol<br/>
							Error is only generated when the request ($1903XX) exists and its name is different from ReadDTCInformation.ReportDTCSnapshotIdentification
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE030</b> : Request: Length of name &gt; 255 characters<br/>
							Checks are done on requests with "aintainability report" checked
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE031</b> : Request: Sent bytes &lt;1 or sent bytes &gt;254 bytes (508 characters)<br/>
							Checks are done on requests with "maintainability report" and "After sales" checked.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE034</b> : Request: Reply bytes &lt;1 or reply bytes &gt;254 bytes (508 characters)<br/>
							Checks are done on requests with "maintainability report" and "After sales" checked.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE035</b> : Request: Number of minimun bytes of the response (MinBytes) &lt;1 or MinBytes &gt;254 bytes (508 characters)<br/>
							Checks are done on requests with "maintainability report" and "After sales" checked.	            </li>
						<br/>-----------------<br/>
						<li><b>Rule CW003</b> : Data: List all the data with littleEndian format<br/>
							Checks are done on requests with "maintainability report" checked.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule CE150</b> : Device: Length of name &gt;100 characters<br/>
							Change the severity of the check from warning(CW022) to error(CE150)
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME006</b> : Request: Data outside of the frame (sent or received) <br/>
							Check that the data must be included in the request (sent or received) and check the length and the data (first byte, bit offset,...)<br/>
							Requests with variable reply length are excluded from the check, like $1906...<br/>
							Checks are done on requests with "maintainability report" checked.
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME008</b> : Idententification request $21EF is missing or with wrong dataitems<br/>
							Checks are done on X07 and X62ph2 projects only
							Idententification request must contain dataitem HardwareNumber positioned at the 3rd byte and dataitem SoftwareNumber positioned at the 13th byte
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME009</b> DAIMLER : Request with no data items and with minimum number of bytes to be received (MinBytes) not as per specification<br/>
							Update the check for services $30, $31, $32 and $14 as per specification A et B
						</li>
						<br/>-----------------<br/>
					</ul>
				</td>
			</tr>
			<tr> <!-- V1.7 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.7" /><a href="#rDescriptionVersion" />V1.7</td>
				<td class="cellule_normale">10/02/2016</td>
				<td>
					<ul>
						<li><b>Rule DE009</b> : Data: Numeric data (Ax+B/C) divided by C = 0<br/>
							The numerical data of type Ax+B/C must have C different from 0.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE153</b> : Type of fault for the device(Type &lt; 0 or Type > 255)<br/>
							The '0' value is now allowed as type of ault.
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE189</b> : Data: OutputPermanentControlList is not as specified by UDS protocol<br/>
							Adding control for maintainability report existence.
							Exclude from contol all requests starting by OutputControl.Start or OutputControl.Stop.
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE190</b> : Data: OutputControlCommand is not as specified by UDS protocol<br/>
							Exclude from contol all requests starting by OutputControl.Start or OutputControl.Stop.
							Adding control for maintainability report existence.
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE191</b> : forbidden request(s) ($21 and/or $3B) as specified by UDS protocol<br/>
							Adding control for requests ($21 and/or $3B), which have to be deleted.
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DE193</b> : DataItem length is different from the length in the autoidentification<br/>
							Adding control for DataItems : Supplier ($22F18A), Soft ($22F194), Version ($22F195) and Diag Version ($22F1A0).
							These Dataitems Should have the same length as the ones declared in the Autoidentification.
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule MW011</b> : Invalid(s) character(s) into the name of the data<br/>
							Adding control for invalid(s) character(s) into the name of the data, control already done in the rule DW003.
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule MW012</b> : Invalid(s) character(s) into the name of the request<br/>
							Adding control for invalid(s) character(s) into the name of the request, control already done in the rule DW010.
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME013</b> : OutputControl Generic Request missing<br/>
							Adding control for the OutputControl Generic Request ($2F for UDS or $30 for Spec B).
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME014</b> : ID missing in the Output Control List<br/>
							Adding control for the ID in the Output Control List ($2F for UDS or $30 for Spec B).
							For UDS (request $2F) : the DID must be in the Output Permanent Control List.
							For Spec B (request $30) : the ID must be in the Output Permanent Control List or the Output Temporary Control List.
						</li>
						<br/>-----------------<br/>
						<li><b>UDS-Rule DW192</b> : no request ($22) has been found for the DID in request ($2F) as specified by UDS protocol<br/>
							Adding control for requests $22 for each DID found in a $2F request.
							Changed from Error first to Warning in final.
						</li>
						<br/>-----------------<br/>
					</ul>
				</td>
			</tr>
			<tr> <!-- V1.8 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.8" /><a href="#rDescriptionVersion" />V1.8</td>
				<td class="cellule_normale">03/01/2018</td>
				<td>
					<ul>
						<li><b>Rule DE155</b> : Device: OBD without Base DTC<br/>
							For fault of type OBD, check that the field base DTC is well declared for a DTC of type OBD.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE171</b> : Address/Name function/CanID: Incoherence between the Address function and its name or the CanID<br/>
							Checking that function name is as referenced in the GenericAddressing assuming to have the same address.
						</li>
						<br/>-----------------<br/>
						<li><b>Rule DE006</b> : Data : Attribute, number of bytes<br/>
							Add a check on the size of Data type : Bytes (Count) is an integer.
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME009</b> : DAIMLER : reply minbytes<br/>
							Remove checking dataitem existence for reply min bytes ($22, $21, reading services).<br/>
							Service $32 - Wait for 3 bytes.
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME014</b> : Output Control : ID missing in the Output Control List ($2F for UDS or $30 for Spec B)<br/>
							Removing $00 LID from the check.
							Remove checking '0000' value in OutputPermanentControlList (UDS Control)
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME015</b> : Output Control : Read request ($22) missing for an ID in the OutputPermanentControlList (spec UDS)<br/>
							All DID defined in OutputPermanentControlList must have a reading request $22. (Maintenability repport or not).
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME016</b> : Data: length of name &gt;127 characters<br/>
							Add in ODX Check error for Name of Data too long Max 127 characters.
						</li>
						<br/>-----------------<br/>
						<li><b>DAIMLER-Rule ME017</b> : Request: Length of name &gt; 127 characters<br/>
							Add in ODX Check error for Name of Resquest too long Max 127 characters.
						</li>
						<br/>-----------------<br/>
						<li><b>ALLIANCE-Rules</b> : Introducing new category of errors for the ALLIANCE ODX<br/>
							Different warnings and errors to be matured.
						</li>
						<br/>-----------------<br/>
					</ul>
				</td>
			</tr>
			<tr> <!-- V1.9 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.9" /><a href="#rDescriptionVersion" />V1.9</td>
				<td class="cellule_normale">28/01/2019</td>
				<td>
					<ul>
						<li>Add <b>DiagOnIp</b> protocol detection</li>
						<li>Add <b>Logical address</b> value if exist</li>
						<li><b>Updating rules</b>
							<ul>
								<li>
									<b>Rule DE003</b> : Detecting Carriage return/Line feed (CrLf) on data name
								</li>
								<li>
									<b>Rule DE031</b> : Detecting Carriage return/Line feed (CrLf) on service name
								</li>
								<li>
									<b>Rule DE024</b> : Allow data on received first byte for security access $27 service
								</li>
								<li>
									<b>Rules CW005, ME007</b> : Wrong invalid limit values for numeric list data
								</li>
								<li>
									<b>Rule AE001</b> : Check the SID value of the request is allowed
								</li>
								<li>
									<b>Rule AE002</b> : Check the SID value coherence between request and response
								</li>
								<li>
									<b>Rule AE003</b> : Check only DID value of request is defined
								</li>
								<li>
									<b>Rule AE004</b> : Check DID value of response is defined and it is the same as the request
								</li>
								<li>
									<b>Rule AE005</b> : Check only LID value of request is defined
								</li>
								<li>
									<b>Rule AE006</b> : Check LID value of response is defined and it is the same as the request
								</li>
							</ul>
						</li>
						<li><b>Add new DDT2000 rules</b>
							<ul>
								<li>
									<b>Rule DE194</b> : Add Carriage return/Line feed (CrLf) control for device names
								</li>
								<li>
									<b>Rule DE195</b> : Values of the list item on numeric list data except limits
								</li>
							</ul>
						</li>
						<li><b>Add new CPPD rules</b>
							<ul>
								<li>
									<b>Rule CE151 / CW024</b> : For writing services ($3B, $2E), check the lenght of the template compare to the value of 'Data lenght'
									<ul>
										<li>CE151 (error) if service is for after sale</li>
										<li>CW024 (warning) otherwise</li>
									</ul>
								</li>
							</ul>
						</li>
						<li><b>Add new ALLIANCE rules</b>
							<ul>
								<li>
									<b>Rule AW002</b> : Check data is not defined as little and big endian
								</li>
								<li>
									<b>Rule AW004</b> : Check device name length is less than 255 characters
								</li>
								<li>
									<b>Rule AE007</b> : On Request, check the data position and size on DID location
								</li>
								<li>
									<b>Rule AE008</b> : On Response, check the data position and size on DID location
								</li>
								<li>
									<b>Rule AE009</b> : On Request, check the data position and size on LID location
								</li>
								<li>
									<b>Rule AE010</b> : On Response, check the data position and size on LID location
								</li>
								<li>
									<b>Rule AE011</b> : On Request, check data are not overlaping
								</li>
								<li>
									<b>Rule AE012</b> : Forbidden little endian on not numeric data (ASCII - BCD/HEXA)
								</li>
								<li>
									<b>Rule AE013</b> : Data of type numeric list should contain at least 1 item
								</li>
								<li>
									<b>Rule AE014</b> : Values of the list item on numeric list data except limits
								</li>
							</ul>
						</li>
					</ul>
				</td>
			</tr>
			<tr> <!-- V1.10 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.10" /><a href="#rDescriptionVersion" />V1.10</td>
				<td class="cellule_normale">18/11/2019</td>
				<td>
					<ul>
						<li><b>Updating rules</b>
							<ul>
								<li>
									<b>Rule ME009 / ME010</b> : Correct rule for routine service for UDS ECU
								</li>
								<li>
									<b>Rule ME013</b> : Check Output Control List data are defined on generic request
								</li>
								<li>
									<b>Rule DE006</b> : Change the max data size for CAN physical layer (CPDD update) and add data max size value for DoIP.
								</li>
								<li>
									<b>Rule DE014</b> : Add the max data sending first byte position for DoIP.
								</li>
								<li>
									<b>Rule DE024</b> : Add the max data receiving first byte position for DoIP.
								</li>
								<li>
									<b>Rule DE033</b> : Add request sent byte max frame size for DoIP.
								</li>
								<li>
									<b>Rule DE034</b> : Add the received min byte max value for DoIP.
								</li>
								<li>
									<b>Rule DE035</b> : Add request reply byte max frame size for DoIP.
								</li>
								<li>
									<b>Rule DE080</b> : Update the MinByte value
								</li>
								<li>
									<b>Rule DE171</b> : Add missing file detection (previoulsy, only a message)
								</li>
              </ul>
						</li>
            <li><b>Add new rules</b>
              <ul>
                <li>
                  <b>Rule DE196</b> : Check function address is $D2 or $D4 for central gateway ECU
                </li>
                <li>
                  <b>Rule DE197</b> : Check CAN identifiers consistency
                </li>
                <li>
                  <b>Rule DE198</b> : Check 'Base DTC'/'OBD' and 'OBD'/'OBD status' consistency
                </li>
                <li>
                  <b>Rule DE199</b> : DDT2000 error when at least one project vehicle on DDT file not exist on central vehicle projects database or central vehicle projects database missing.
                </li>
                <li>
                  <b>Rule DE200</b> : DDT2000 error on not allowed character on ECU Name.
                </li>
								<li>
									<b>Rule DW193</b> : DDT2000 warning if numeric data <b>unit</b> is not defined on normalized unit list
								</li>
                <li>
									<b>Rule ME018</b> : Daimler check the SID value of the request is allowed
                </li>
								<li>
									<b>Rule ME019</b> : Check Daimler UDS identification service <b>Vehicle Manufacturer ECU Hardware Number</b> (DID $<b>F1.11</b>) for <b>UDS</b> ECUs
								</li>
								<li>
									<b>Rule ME020</b> : Check Daimler UDS identification service <b>Vehicle Manufacturer ECU Software Number</b> (DID $<b>F1.21</b>) for <b>UDS</b> ECUs
								</li>
								<li>
									<b>Rule AE015</b> : Alliance error if numeric data <b>unit</b> is not defined on normalized unit list
								</li>
								<li>
									<b>Rule AW005</b> : Alliance warning to check the numeric list data <b>value range</b>
								</li>
              </ul>
            </li>
            <li><b>Removing rules</b>
              <ul>
                <li>
                  <b>Rule CE031</b> : As CPDD is now able working with correct CAN frame size, this test is manage by DDT200 error DE033
                </li>
                <li>
                  <b>Rule CE032</b> : As CPDD is now able working with correct CAN frame size, this test is manage by DDT200 error DE014
                </li>
                <li>
                  <b>Rule CE034</b> : As CPDD is now able working with correct CAN frame size, this test is manage by DDT200 error DE035
                </li>
                <li>
                  <b>Rule CE035</b> : As CPDD is now able working with correct CAN frame size, this test is manage by DDT200 error DE034
                </li>
                <li>
                  <b>Rule CE036</b> : As CPDD is now able working with correct CAN frame size, this test is manage by DDT200 error DE024
                </li>
              </ul>
            </li>
					</ul>
				</td>
			</tr>
      <tr> <!-- v1.11 -->
				<td class="cellule_normale"><a name="DescriptionVersion_V1.11" /><a href="#rDescriptionVersion" />V1.11</td>
				<td class="cellule_normale">30/11/2020</td>
				<td>
          <ul>
            <li><b>Change default web browser to display report.</b> It is no more Internet Explorer but user's default.</li>
            <li><b>Add an information to indicate if database is not for a Daimler vehicle project.</b></li>
            <li><b>Removing rules</b>
              <ul>
                <li>
                  <b>Rule DW187</b> No more naming rule for RoutineControl service. Nevertheless, if at least an $31 service is define, generic OutputControl service need to be define.
                </li>
              </ul>
              <ul>
                <li>
                  <b>Rule DW188</b> No more naming rule for OutputControl service. Nevertheless, if at least an $30 (A/B/C) or $2F (UDS) service is define, generic OutputControl service need to be define.
                </li>
              </ul>
            </li>
						<li><b>Updating rules</b>
              <ul>
                <li>
                  <b>Rule DE196</b> Add new Gateway function address $EB (235)
                </li>
                <li>
                  <b>Rule DE171</b> Remove accessibilty control of GenrericAddresing.xml file (now done on DE201)
                </li>
                <li>
                  <b>Rule DE199</b> Remove accessibilty control of Projects.xml file (now done on DE201)
                </li>
                <li>
                  <b>Rule ME019 / ME020</b> Correct issue for non spec UDS ECUs (both services only mandatory for some Daimler projects UDS ECUs)
                </li>
                <li>
                  <b>Rule AE012</b> Change rule from error to warning (AW007) due to convertor (Daimler and Alliance) convert method
                </li>
                <li>
                  <b>Rule DE189</b> Correction of OutputPermanentControlList minimum number of element number (1 instead 2)
                </li>
              </ul>
            </li>
            <li><b>Add new rules</b>
              <ul>
                <li>
                  <b>Rule DE201</b> : Availability of mandatory external files GenericAddressing.xml, Projects.xml and now Units.xml
                </li>
                <li>
                  <b>Rule DE202</b> : Check forbidden characters present on DDT file.
                </li>
                <li>
                  <b>Rule DE203</b> : Check numeric list item text.
                </li>
                <li>
                  <b>Rule DE204</b> : Check "RoutineControl" generic routine exists if a $31 service is defined
                </li>
                <li>
                  <b>Rule DE205</b> : Check routineControlType information (existence, position and format)
                </li>
                <li>
                  <b>Rule DE206</b> : Check routineIdentifier information (existence, position and format)
                </li>
                <li>
                  <b>Rule DW194</b> : If generic "RoutineControl" service exist, the "RoutineIdentifier" data should be used rather than the "RoutineIdentifierList" data 
                </li>
                <li>
                  <b>Rule ME021</b> : If generic RoutineControl service exist, the "RoutineIdentifier" data must be defined.
                </li>
                <li>
                  <b>Rule ME022</b> : Check data position on writing requests to avoid byte boundaries problems
                </li>
                <li>
                  <b>Rule ME023/ME024</b> : check overlapping data on sending/received frame
                </li>
                <li>
                  <b>Rule AE016</b> : Check the sendig frame for reading service (template length and no data outside)
                </li>
                <li>
                  <b>Rule AE017</b> : Check data position on writing requests to avoid byte boundaries problems
                </li>
                <li>
                  <b>Rule AW006</b> : Use of not official version of Units.xml file
                </li>
                <li>
                  <b>Rule AW007</b> : Change error rule AE012 to warning
                </li>
              </ul>
            </li>
          </ul>
        </td>
      </tr>
    </table>

		<h3 class="pageBreak"><a href="#toc_GENERAL" title="Retour au sommaire">&#9651;</a>
			<xsl:call-template name="getLocalizedText">
				<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
				<xsl:with-param name="aNode" select="document('Translate.xml')/translation/legendes"></xsl:with-param>
				<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
			</xsl:call-template>
		</h3>
		<ul>
			<li>
				<h4>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/legendeNumRegle"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</h4>
			</li>
		</ul>

		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>Code</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/designation"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
			</tr>
			<tr>
				<td>ND</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/des1" />
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td>DWx</td>
				<td><b>D</b>DT2000 <b>W</b>arning N°<b>x</b></td>
			</tr>
			<tr>
				<td>DEx</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/des2" />
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td>CWx</td>
				<td><b>C</b>PDD <b>W</b>arning N°<b>x</b></td>
			</tr>
			<tr>
				<td>CEx</td>
				<!--<td><b>C</b>PDD <b>E</b>rreur N°<b>x</b></td>-->
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/des3" />
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td>MWx</td>
				<td>DAI<b>M</b>LER <b>W</b>arning N°<b>x</b></td>
			</tr>
			<tr>
				<td>MEx</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/des4" />
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td>AWx</td>
				<td><b>A</b>LLIANCE <b>W</b>arning N°<b>x</b></td>
			</tr>
			<tr>
				<td>AEx</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/des5" />
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
		</table>

		<br/>
		<hr/>
		<br/>
		<ul>
			<li>
				<h4>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/legendeImpact"></xsl:with-param>
						<xsl:with-param name="defaultText">*</xsl:with-param>
					</xsl:call-template>
				</h4>
			</li>
		</ul>

		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/designation"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
			</tr>
			<tr> <!-- I01 Diagnostic impossible -->
				<td>I01</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I01"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I02 Forbidden character -->
				<td>I02</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I02"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I03 Unauthorized character -->
				<td>I03</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I03"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I04 Bad data format -->
				<td>I04</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I04"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I05 Bad ECU response -->
				<td>I05</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I05"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I06 Not corresponding Database DDT2000. Nonfunctional tool DDT2000 -->
				<td>I06</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I06"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
						</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I07 Impossible data processing. Nonfunctional diagnostic -->
			<td>I07</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I07"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I08 Not corresponding Database DDT2000 for the future standard ODX -->
				<td>I08</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I08"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I09 CPDD Import impossible -->
				<td>I09</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I09"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*I09*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I10 Bad interpretation of the data -->
				<td>I10</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I10"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I11 Fatal error in the global validation -->
				<td>I11</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I11"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I12 Information necessary to the CMD (Designer Diag) for coding -->
				<td>I12</td>
				<td>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I12"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I14 Problems with the import of the DDT database (ex:Difficulty to choose the correct request) -->
				<td>I14</td>
					<td>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I14"></xsl:with-param>
							<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
						</xsl:call-template>
				</td>
			</tr>
			<tr> <!-- I15 Error during reprog  -->
				<td>I15</td>
					<td>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/I15"></xsl:with-param>
							<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
						</xsl:call-template>
				</td>
			</tr>
		</table>

		<br/>
		<hr/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning pageBreak">
			<tr>
				<th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">&#9651;</a></th>
				<th class="warningTitle">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/warningDDT2000Title"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="warningTitle"><xsl:value-of select="$CountRulesWarning_DDT2000" /></th>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
			<tr>
				<th>Code</th>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle3"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>Version</th>
			</tr>
			<xsl:apply-templates select="check/rule[type='DDT2000' and critic='warning']">
				<xsl:sort select="code"></xsl:sort>
			</xsl:apply-templates>
		</table>

		<br/>
		<br/>
		<hr/>
		<br/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning pagebreak">
			<tr>
				<th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">&#9651;</a></th>
				<th class="warningTitle">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/warningCPDDTitle"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
				</xsl:call-template>
				</th>
				<th class="warningTitle"><xsl:value-of select="$CountRulesWarning_CPDD" /></th>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
			<tr>
				<th>Code</th>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle3"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>Version</th>
			</tr>
			<xsl:apply-templates select="check/rule[type='CPDD' and critic='warning']">
				<xsl:sort select="code"></xsl:sort>
			</xsl:apply-templates>
		</table>

		<br/>
		<br/>
		<hr/>
		<br/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning pageBreak">
			<tr>
				<th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">&#9651;</a></th>
				<th class="warningTitle">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/warningDAIMLERTitle"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
					</th>
				<th class="warningTitle"><xsl:value-of select="$CountRulesWarning_DAIMLER" /></th>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
			<tr>
				<th>Code</th>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle3"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>Version</th>
			</tr>
			<xsl:apply-templates select="check/rule[type='DAIMLER' and critic='warning']">
				<xsl:sort select="code"></xsl:sort>
			</xsl:apply-templates>
		</table>

		<br/>
		<br/>
		<hr/>
		<br/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning pageBreak">
			<tr>
				<th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">&#9651;</a></th>
				<th class="warningTitle">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/warningALLIANCETitle"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="warningTitle"><xsl:value-of select="$CountRulesWarning_ALLIANCE" /></th>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="warning">
			<tr>
				<th>Code</th>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle3"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>Version</th>
			</tr>
			<xsl:apply-templates select="check/rule[type='ALLIANCE' and critic='warning']">
				<xsl:sort select="code"></xsl:sort>
			</xsl:apply-templates>
		</table>

		<br/>
		<br/>
		<hr/>
		<br/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="error pagebreak">
			<tr>
				<th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">&#9651;</a></th>
				<!--<th class="warningTitle">Règles DDT2000 erreur (DEx)</th>-->
				<th class="errorTitle">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/errorDDT2000Title"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="warningTitle"><xsl:value-of select="$CountRulesError_DDT2000" /></th>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
			<tr>
				<th>Code</th>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle3"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>Version</th>
			</tr>
			<xsl:apply-templates select="check/rule[type='DDT2000' and critic='error']">
				<xsl:sort select="code"></xsl:sort>
			</xsl:apply-templates>
		</table>

		<br/>
		<br/>
		<hr/>
		<br/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="error pagebreak">
			<tr>
				<th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">&#9651;</a></th>
				<!--<th class="warningTitle">Règles CPDD erreur (CEx)</th>-->
				<th class="errorTitle">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/errorCPDDTitle"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="errorTitle"><xsl:value-of select="$CountRulesError_CPDD" /></th>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
			<tr>
				<th>Code</th>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle3"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>Version</th>
			</tr>
			<xsl:apply-templates select="check/rule[type='CPDD' and critic='error']">
				<xsl:sort select="code"></xsl:sort>
			</xsl:apply-templates>
		</table>

		<br/>
		<br/>
		<hr/>
		<br/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="error pagebreak">
			<tr>
				<th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">&#9651;</a></th>
				<th class="errorTitle">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/errorDAIMLERTitle"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="warningTitle"><xsl:value-of select="$CountRulesError_DAIMLER" /></th>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
			<tr>
				<th>Code</th>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle3"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>Version</th>
			</tr>
			<xsl:apply-templates select="check/rule[type='DAIMLER' and critic='error']">
				<xsl:sort select="code"></xsl:sort>
			</xsl:apply-templates>
		</table>

		<br/>
		<br/>
		<hr/>
		<br/>
		<br/>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="error pagebreak">
			<tr>
				<th><a href="#toc_GENERAL" title="Retour table des matières générales" class="whiteLink">&#9651;</a></th>
				<th class="errorTitle">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/errorALLIANCETitle"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th class="warningTitle"><xsl:value-of select="$CountRulesError_ALLIANCE" /></th>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="error">
			<tr>
				<th>Code</th>
				<th>Impact</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle3"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/columnTitle4"></xsl:with-param>
						<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
				</th>
				<th>Version</th>
			</tr>
			<xsl:apply-templates select="check/rule[type='ALLIANCE' and critic='error']">
				<xsl:sort select="code"></xsl:sort>
			</xsl:apply-templates>
		</table>
	</xsl:template>


	<!-- ***********************************
	Template rule
	*********************************** -->
	<xsl:template match="/check/rule">
		<!-- =============================  -->
		<!-- Récupérer la version courante stockée dans le fichier lui-même sous la balise <span id="currentVersion">V1.4</span> -->
		<!-- document('') s'ouvre lui même  -->
		<!-- Cela permet de tester la version des tests par rapport à la version courante et de griser les tests dont la version = version courante -->
		<!-- =============================  -->
		<!-- xsl:variable name="mCurrentVersion" select="document('')//span[@id='currentVersion']"></xsl:variable -->
		<xsl:variable name="mCurrentVersion"><xsl:call-template name="currentVersion" /></xsl:variable>
		<tr>
			<xsl:choose>
				<xsl:when test="code">
					<xsl:choose>
						<xsl:when test="version = $mCurrentVersion">
							<td class="cellule_currentversion">
							<a name="{code}">
								<a href="#R{code}">&#160;<b><xsl:copy-of select="code" /></b>&#160;</a>
							</a>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="cellule_normale"><a name="{code}"><a href="#R{code}">&#160;<b><xsl:copy-of select="code" /></b>&#160;</a></a></td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="version = $mCurrentVersion">
							<td class="cellule_currentversion">ND</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="cellule_normale">ND</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="impact">
					<xsl:choose>
						<xsl:when test="version = $mCurrentVersion">
						<td class="cellule_impact_CurrentVersion">&#160;<b><xsl:copy-of select="impact" /></b></td>
						</xsl:when>
						<xsl:otherwise>
							<td class="cellule_normale">&#160;<b><xsl:copy-of select="impact" /></b></td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="version = $mCurrentVersion">
							<td class="cellule_currentversion">ND</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="cellule_normale">ND</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="version = $mCurrentVersion">
					<td class="cellule_currentversion">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="name"></xsl:with-param>
							<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
						</xsl:call-template>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="name"></xsl:with-param>
							<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
					</xsl:call-template>
					</td>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="version = $mCurrentVersion">
					<td class="cellule_currentversion">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="info"></xsl:with-param>
							<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
						</xsl:call-template>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$reportLanguage"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="info"></xsl:with-param>
							<xsl:with-param name="defaultText">non trouvé*</xsl:with-param>
						</xsl:call-template>
					</td>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="version = $mCurrentVersion">
					<td class="cellule_currentversion"><b><xsl:copy-of select="version" /></b></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:copy-of select="version" /></td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>


	<xsl:template name="getLocalizedText">
		<xsl:param name="lang"></xsl:param>
		<xsl:param name="aNode"></xsl:param>
		<xsl:param name="defaultText"></xsl:param>
		<xsl:choose>
			<xsl:when test="$aNode[@xml:lang=$lang]">
				<xsl:copy-of select="$aNode[@xml:lang=$lang]"></xsl:copy-of>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$aNode[not(@xml:lang)]">
						<xsl:copy-of select="$aNode[not(@xml:lang)]"></xsl:copy-of>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$defaultText"></xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>