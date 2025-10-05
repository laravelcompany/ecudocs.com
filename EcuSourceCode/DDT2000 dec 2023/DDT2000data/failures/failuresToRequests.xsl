<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl local xql" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
	xmlns:local="#local-functions" 
	xmlns:xql="#xql-functions">
<xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no" cdata-section-elements="Comment"/>

<xsl:param name="filename">Unknown Failures File</xsl:param>
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!--       mode autonome (uniquemement a partir IE6 (gestion native du xslt)               -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="/">
				<xsl:apply-templates select="Identifications | Failures"/>
</xsl:template>


<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!--                      Gestion de la l'affichage des pannes                             -->
<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:template match="Identifications | Failures">
<!-- message global si aucune erreur n'est detectèe -->
<simulator>
	<sourceFile><xsl:value-of select="$filename"></xsl:value-of></sourceFile>
	<xsl:if test="Comment !=''"><xsl:copy-of select="Comment"/></xsl:if>
	<xsl:copy-of select="Date"/>
	<xsl:apply-templates select="Function"/>
</simulator>
</xsl:template>

<xsl:template name="GetUDSReply">
	<xsl:param name="Node"/>
	
	<xsl:choose>
		<xsl:when test="$Node/Error">
			<r><xsl:attribute name="x"><xsl:value-of select="$Node/Error/@Send"/></xsl:attribute>
				<xsl:if test="$Node/Error/Request">
				<s><xsl:value-of select="$Node/Error/Request/@Receive"/></s>
				</xsl:if>
			</r>
		</xsl:when>
		<xsl:otherwise>
			<r><xsl:attribute name="x"><xsl:value-of select="$Node/Request/@Send"/></xsl:attribute>
			<s><xsl:value-of select="$Node/Request/@Receive"/></s></r>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!-- ========================================================================================= -->
<xsl:template match="Function">
<function>
	<xsl:attribute name="Address"><xsl:value-of select="@Address"/></xsl:attribute>
	<xsl:if test="DiagName != ''">
		<xsl:copy-of select="DiagName"/>
	</xsl:if>
	
	
	<xsl:choose>
		<xsl:when test="Identification/Error">
			<r><xsl:attribute name="x"><xsl:value-of select="Identification/Error/Request/@Send"/></xsl:attribute>
			<s><xsl:value-of select="Identification/Error/Request/@Receive"/></s></r>
		</xsl:when>
		<xsl:otherwise>
			<r x="2180"><s>6180<xsl:value-of select="Identification/@Binary"/></s></r>
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:choose>
		<xsl:when test="VIN/Error">
			<r><xsl:attribute name="x"><xsl:value-of select="VIN/Error/Request/@Send"/></xsl:attribute>
			<s><xsl:value-of select="VIN/Error/Request/@Receive"/></s></r>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="IdentificationUDS">
					<r x="22F190"><s>62F190<xsl:value-of select="VIN/@BinaryData"/></s></r>	
				</xsl:when>
				
				<xsl:otherwise>
					<r x="2181"><s>6181<xsl:value-of select="VIN/@BinaryData"/></s></r>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:otherwise>
	</xsl:choose>


	<xsl:choose>
		<xsl:when test="Identification83/Error">
			<r><xsl:attribute name="x"><xsl:value-of select="Identification83/Error/Request/@Send"/></xsl:attribute>
			<s><xsl:value-of select="Identification83/Error/Request/@Receive"/></s></r>
		</xsl:when>
		<xsl:otherwise>
			<r x="2183"><s>6183<xsl:value-of select="Identification83/@Binary"/></s></r>
		</xsl:otherwise>
	</xsl:choose>


	<xsl:if test="IdentificationUDS">
	
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/Supplier"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/Application"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/Version"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/Diagnostic"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/Order"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/Hardware"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/Tuning"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/vehicleManufacturerKitAssemblyPartNumber"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/bootVersion"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/ecuSerialNumber"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/operationalReference"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/vehicleManufacturerSparePartNumber"/>
		</xsl:call-template>
		<xsl:call-template name="GetUDSReply">
			<xsl:with-param name="Node" select="IdentificationUDS/configurationFileReferenceLink"/>
		</xsl:call-template>
		
	</xsl:if>
	

	<r x="21F0"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='0'])">7F2112</xsl:when>
		<xsl:otherwise>61F0<xsl:value-of select="Identification/ProgrammingStamp[@Id='0']/BinaryData/@Part1"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F1"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='0'])">7F2112</xsl:when>
		<xsl:otherwise>61F1<xsl:value-of select="Identification/ProgrammingStamp[@Id='0']/BinaryData/@Part2"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F2"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-6'])">7F2112</xsl:when>
		<xsl:otherwise>61F2<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-6']/BinaryData/@Part1"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F3"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-6'])">7F2112</xsl:when>
		<xsl:otherwise>61F3<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-6']/BinaryData/@Part2"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F4"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-5'])">7F2112</xsl:when>
		<xsl:otherwise>61F4<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-5']/BinaryData/@Part1"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F5"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-5'])">7F2112</xsl:when>
		<xsl:otherwise>61F5<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-5']/BinaryData/@Part2"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F6"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-4'])">7F2112</xsl:when>
		<xsl:otherwise>61F6<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-4']/BinaryData/@Part1"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F7"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-4'])">7F2112</xsl:when>
		<xsl:otherwise>61F7<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-4']/BinaryData/@Part2"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F8"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-3'])">7F2112</xsl:when>
		<xsl:otherwise>61F8<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-3']/BinaryData/@Part1"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21F9"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-3'])">7F2112</xsl:when>
		<xsl:otherwise>61F9<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-3']/BinaryData/@Part2"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21FA"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-2'])">7F2112</xsl:when>
		<xsl:otherwise>61FA<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-2']/BinaryData/@Part1"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21FB"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-2'])">7F2112</xsl:when>
		<xsl:otherwise>61FB<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-2']/BinaryData/@Part2"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21FC"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-1'])">7F2112</xsl:when>
		<xsl:otherwise>61FC<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-1']/BinaryData/@Part1"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21FD"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N-1'])">7F2112</xsl:when>
		<xsl:otherwise>61FD<xsl:value-of select="Identification/ProgrammingStamp[@Id='N-1']/BinaryData/@Part2"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21FE"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N'])">7F2112</xsl:when>
		<xsl:otherwise>61FE<xsl:value-of select="Identification/ProgrammingStamp[@Id='N']/BinaryData/@Part1"/></xsl:otherwise>
	</xsl:choose></s></r>
	<r x="21FF"><s><xsl:choose>
		<xsl:when test="not(Identification/ProgrammingStamp[@Id='N'])">7F2112</xsl:when>
		<xsl:otherwise>61FF<xsl:value-of select="Identification/ProgrammingStamp[@Id='N']/BinaryData/@Part2"/></xsl:otherwise>
	</xsl:choose></s></r>
	<xsl:apply-templates select="InfoRequest[@Send !='2180' and @Send !='2181' and @Send !='2183']"/>
	<xsl:apply-templates select="Requests/Request[@Send !='17FFFF']"/>
	<xsl:if test="Requests/Request[@Send = '17FFFF']">
		<r x="17FFFF">
		<xsl:for-each select="Requests/Request[@Send = '17FFFF']">
			<s><xsl:value-of select="@Receive"/></s>
		</xsl:for-each>	
		</r>
	</xsl:if>
	<xsl:apply-templates select="Devices/Device/DTC/Snapshot | Devices/Device/DTC/ExtendedData | Devices/Device/DTC/FreezeFrame"/>
</function>
</xsl:template>

<xsl:template match="Function[number(@Address) = 0 or number(@Address) = 255]">
<function>
	<xsl:attribute name="Address"><xsl:value-of select="@Address"/></xsl:attribute>
	<xsl:if test="DiagName != ''">
		<xsl:copy-of select="DiagName"/>
	</xsl:if>
</function>
</xsl:template>


<!-- ========================================================================================= -->
<xsl:template match="Function[Error]">
<function><xsl:attribute name="Address"><xsl:value-of select="@Address"/></xsl:attribute>
	<missing/>
</function>
</xsl:template>


<!-- ========================================================================================= -->
<xsl:template match="InfoRequest | Requests/Request | Devices/Device/DTC/Snapshot | Devices/Device/DTC/ExtendedData | Devices/Device/DTC/FreezeFrame">
<r><xsl:attribute name="x"><xsl:value-of select="@Send"/></xsl:attribute><s><xsl:value-of select="@Receive"/></s></r>
</xsl:template>


</xsl:stylesheet>