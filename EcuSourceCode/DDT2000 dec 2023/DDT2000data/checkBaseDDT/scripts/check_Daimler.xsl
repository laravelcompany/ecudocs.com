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
	xmlns:local="#local-functions"
	>


<!-- ************************************ -->
<!-- Contrôles Specifiques à Daimler V1.5-->
<!-- ************************************ -->
<xsl:template name="check_Daimler">
	
	<!-- *********************************** -->
	<!--Warning si une liste est vide  -->
	<!-- *********************************** -->
	<xsl:for-each select="//ddt:Target/ddt:Datas/ddt:Data/ddt:Bits/ddt:List">
		<xsl:if test="not(count(ddt:Item)&gt;=1)">
			<xsl:call-template name="warning">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_EMPTYLIST</xsl:with-param>
				<xsl:with-param name="description">	
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="../../@Name"/></b>
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="../../@Name"/></b><br/>
					<b><xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemEmpty"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template></b>				
				</xsl:with-param>
				<xsl:with-param name="action">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddListItems"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>		
		</xsl:if>	
	</xsl:for-each>
	<!-- ***********************************    -->
	<!-- S'il y a au moins une requête          --> 
	<!-- OutputControl, on contrôle l'existence -->
	<!-- de la requete OutputControl (Générique)-->
	<!-- ***********************************    -->
	<!-- -->	
	<xsl:variable name="mOutputControlGenericRequest">
		<xsl:choose>
			<!-- en UDS la trame se nomme extactement OutputControl-->
			<xsl:when test="//ddt:Target/ddt:Requests/ddt:Request[@Name = 'TesterPresent.WithResponse']/ddt:Sent[starts-with(ddt:SentBytes,'3E00')] and
						not(//ddt:Target/ddt:Requests/ddt:Request[@Name='ReadDTC']/ddt:Sent[starts-with(ddt:SentBytes,'17FF00')])">
				<xsl:choose>
					<xsl:when test="//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and @Name = 'OutputControl']/ddt:Sent[starts-with(ddt:SentBytes,'2F')]">1</xsl:when>	
					<xsl:otherwise>0</xsl:otherwise>	
				</xsl:choose>
			</xsl:when>		
			<!-- Pas UDS la trame se nomme OutputControl mais peut avoir des espaces, miniscule...-->			
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and local:LowerSpaceRemove(string(@Name)) = 'outputcontrol']/ddt:Sent[starts-with(ddt:SentBytes,'30')]">1</xsl:when>	
					<xsl:otherwise>0</xsl:otherwise>				
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:if test="count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent[starts-with(ddt:SentBytes,'30') or starts-with(ddt:SentBytes,'2F')])&gt;=1 and $mOutputControlGenericRequest = 0">
		<xsl:call-template name="error">
			<xsl:with-param name="type">DAIMLER</xsl:with-param>
			<xsl:with-param name="chapter">DAIMLER_OutputControl_GenericRequest</xsl:with-param>
			<xsl:with-param name="description">
				<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/genericRequest"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
				</xsl:call-template> OutputControl ($2F / $30)
			</xsl:with-param>
			<xsl:with-param name="info">
				<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="action">
				<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddGenericRequestOutputControl"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
				</xsl:call-template>									
			</xsl:with-param>
		</xsl:call-template>				
	</xsl:if>	
	<!-- *********************************** -->
	<!-- Contrôles relatifs à la spécification 36-00-013/A -->
	<!-- *********************************** -->
	<xsl:if test="ddt:Requests/ddt:Request[@Name = 'ReadDTC']">
		<xsl:for-each select="ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]">
			<xsl:variable name="mRequestName" select="@Name"></xsl:variable>
			<xsl:variable name="mRequestSentBytes" select="ddt:Sent/ddt:SentBytes"></xsl:variable>
			<xsl:variable name="mSend0" select="substring($mRequestSentBytes,1,2)"></xsl:variable>
			<xsl:variable name="mSend1" select="substring($mRequestSentBytes,3,2)"></xsl:variable>
			<xsl:variable name="mSend2" select="substring($mRequestSentBytes,5,2)"></xsl:variable>
			<xsl:variable name="mRequestReceivedReplyBytes" select="ddt:Received/ddt:ReplyBytes"></xsl:variable>
			<xsl:variable name="mRequestMinBytes" select="ddt:Received/@MinBytes"></xsl:variable>			
			<xsl:variable name="mReply0" select="substring($mRequestReceivedReplyBytes,1,2)"></xsl:variable>
			<xsl:variable name="mReply1" select="substring($mRequestReceivedReplyBytes,3,2)"></xsl:variable>
			<xsl:variable name="mReply2" select="substring($mRequestReceivedReplyBytes,5,2)"></xsl:variable>
		<!-- ******************
	         Check that Daimler Identification request $21EF 
	         contains both dataitems HardwareNumber starting at byte 3 
	         and SoftwareNumber starting at byte 13
	         ****************** -->
		<xsl:if test=" ddt:Sent[ddt:SentBytes = '21EF']">	 
			<xsl:if test="not(ddt:Received/ddt:DataItem[@FirstByte = '3']) or not(ddt:Received/ddt:DataItem[@FirstByte = '13'])">
				<xsl:call-template name="error">
					<xsl:with-param name="type">DAIMLER</xsl:with-param>
					<xsl:with-param name="chapter">DAIMLER_IdentRequest</xsl:with-param>
					<xsl:with-param name="description">	
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b>DAIMLER Identification ($21EF)</b>
					</xsl:with-param>
					<xsl:with-param name="info">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b>Hardware and/or Software number </b> 
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>					
					</xsl:with-param>
					<xsl:with-param name="action">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionWrongDaimlerIdent"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> 
					</xsl:with-param>
				</xsl:call-template>			
			</xsl:if>
        </xsl:if>			
			<!-- ************************************************************************************************** -->
			<!-- ***********************************Reply0  = Send0 + 40*************************************** -->
			<xsl:if test="$mSend0 = '10' or
					$mSend0 = '11' or
					$mSend0 = '12' or
					$mSend0 = '14' or
					$mSend0 = '17' or
					$mSend0 = '21' or
					$mSend0 = '23' or
					$mSend0 = '27' or
					$mSend0 = '30' or
					$mSend0 = '31' or
					$mSend0 = '32' or
					$mSend0 = '34' or
					$mSend0 = '35' or
					$mSend0 = '2C' or
					$mSend0 = '3B' or
					$mSend0 = '3D' or
					$mSend0 = '3E'
					">				
				<xsl:if test="$mReply0 != local:ToHex(local:ToDec($mSend0)+64,2)">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_SID</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
						</xsl:with-param>
						<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°1 </b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/or"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>									
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>: 
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°1 </b>										
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> = <b>$<xsl:value-of select="local:ToHex(local:ToDec($mSend0)+64,2)"/></b>							
						</xsl:with-param>
					</xsl:call-template>				
				</xsl:if>					
			</xsl:if>	

			<!-- ***********************************MinBytes = min spec ( 1)if no DataItem********************* -->
			<xsl:if test="$mSend0 = '17' or
					$mSend0 = '23' or
					$mSend0 = '34' or
					$mSend0 = '35' or
					$mSend0 = '3D' or
					$mSend0 = '3E'
					">
					<xsl:if test="not(ddt:Received/ddt:DataItem) and $mRequestMinBytes != '1'">
					<xsl:call-template name="error">
					<xsl:with-param name="type">DAIMLER</xsl:with-param>
					<xsl:with-param name="chapter">DAIMLER_REPLY_MINBYTES</xsl:with-param>
					<xsl:with-param name="description">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> :  <b><xsl:value-of select="$mRequestName"/></b>
						 <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
					</xsl:with-param>
					<xsl:with-param name="info">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> :  <b><xsl:value-of select="ddt:Received/@MinBytes"/></b><br/>
						    <b>
						    <xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>
							</b>
					</xsl:with-param>
					<xsl:with-param name="action">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b>1</b>
					</xsl:with-param>
				</xsl:call-template>					
				</xsl:if>	
				<xsl:if test="(not(ddt:Received/ddt:DataItem) and (string-length($mRequestReceivedReplyBytes) div 2) != 1) or
				  (ddt:Received/ddt:DataItem and (string-length($mRequestReceivedReplyBytes) div 2) &lt; 1)
				">
					<xsl:call-template name="error">
					<xsl:with-param name="type">DAIMLER</xsl:with-param>
					<xsl:with-param name="chapter">DAIMLER_REPLY_BYTES</xsl:with-param>
						<xsl:with-param name="description">
				            <xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/>
				            <xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
						</xsl:with-param>
					<xsl:with-param name="info">
				            <xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b>
				            <xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> :<b><xsl:value-of select="string-length($mRequestReceivedReplyBytes) div 2"/></b>
					</xsl:with-param>
					<xsl:with-param name="action">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <br/>					
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> >= <b>1</b>
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>						
					</xsl:with-param>
				</xsl:call-template>					
			</xsl:if>	

			</xsl:if>					
			<!-- ***********************************Reply1  = Send1*************************************** -->
			<xsl:if test="$mSend0 = '10' or
					$mSend0 = '12' or
					$mSend0 = '14' or
					$mSend0 = '21' or
					$mSend0 = '27' or
					$mSend0 = '30' or
					$mSend0 = '31' or
					$mSend0 = '32' or
					$mSend0 = '2C' or
					$mSend0 = '3B'
					">
				<xsl:if test="$mSend1 = ''">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_REQUEST_BYTE</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b><br/>								
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><b> n°2 </b>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : 
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><b> n°2 </b>	
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:if>									
				<xsl:if test="$mSend1 != '' and $mReply1 != $mSend1">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_REPLY_BYTE</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
						</xsl:with-param>
						<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°2 </b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/or"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>									
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>: 
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°2 </b>										
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> = <b>$<xsl:value-of select="$mSend1"/></b>							
						</xsl:with-param>
					</xsl:call-template>				
				</xsl:if>
			</xsl:if>				
			<!-- ***********************************MinBytes = min spec (2) if no DataItem********************* -->			
				<xsl:if test="$mSend0 = '10' or
					$mSend0 = '11' or				
					$mSend0 = '12' or
					$mSend0 = '21' or
					$mSend0 = '27' or
					$mSend0 = '31' or
					$mSend0 = '2C' or
					$mSend0 = '3B'
					">
				<xsl:if test="not(ddt:Received/ddt:DataItem) and $mRequestMinBytes != '2'">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_MINBYTES</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="$mRequestName"/></b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>					
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="ddt:Received/@MinBytes"/></b><br/>
					    <b>
					    <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
						</b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b>2</b>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
				<xsl:if test="(not(ddt:Received/ddt:DataItem) and (string-length($mRequestReceivedReplyBytes) div 2) != 2) or
							  (ddt:Received/ddt:DataItem and (string-length($mRequestReceivedReplyBytes) div 2) &lt; 2)
				">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_BYTES</xsl:with-param>
					<xsl:with-param name="description">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
					</xsl:with-param>
				<xsl:with-param name="info">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> :<b><xsl:value-of select="string-length($mRequestReceivedReplyBytes) div 2"/></b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <br/>					
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> >= <b>2</b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>					
				</xsl:with-param>
			</xsl:call-template>					
			</xsl:if>				
		</xsl:if>
			<!-- ***********************************Reply2 = Send2*************************************** -->
			<xsl:if test="$mSend0 = '14'">
				<xsl:if test="$mSend2 = ''">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_REQUEST_BYTE</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b><br/>								
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><b> n°3 </b>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : 
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><b> n°3 </b>	
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:if>					
				<xsl:if test="$mSend2 != '' and $mReply2 != $mSend2">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_REPLY_BYTE</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
						</xsl:with-param>
						<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°3 </b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/or"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>									
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>: 
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°3 </b>										
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> = <b>$<xsl:value-of select="$mSend2"/></b>							
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:if>
			</xsl:if>	
			<!-- ***********************************MinBytes = min spec (3) if no DataItem********************* -->			
			<xsl:if test="$mSend0 = '14' or $mSend0 = '30' or $mSend0 = '32'">
				<xsl:if test="not(ddt:Received/ddt:DataItem) and $mRequestMinBytes != '3'">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_MINBYTES</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="$mRequestName"/></b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>					
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="ddt:Received/@MinBytes"/></b><br/>
					    <b>
					    <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
						</b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b>3</b>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
							<xsl:if test="(not(ddt:Received/ddt:DataItem) and (string-length($mRequestReceivedReplyBytes) div 2) != 3) or
							  (ddt:Received/ddt:DataItem and (string-length($mRequestReceivedReplyBytes) div 2) &lt; 3)
				">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_BYTES</xsl:with-param>
					<xsl:with-param name="description">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
					</xsl:with-param>
				<xsl:with-param name="info">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> :<b><xsl:value-of select="string-length($mRequestReceivedReplyBytes) div 2"/></b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <br/>					
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> >= <b>3</b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>					
				</xsl:with-param>
			</xsl:call-template>					
			</xsl:if>	

		</xsl:if>			
		</xsl:for-each>
	</xsl:if>		
<!-- ************************************************************************************************** -->	
	<!-- *********************************** -->
	<!-- Contrôles relatifs à la spécification 36-00-013/B -->
	<!-- *********************************** -->
	<xsl:if test="ddt:Requests/ddt:Request[@Name = 'ReadDTCInformation.ReportDTC']">
		<xsl:for-each select="ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]">
			<xsl:variable name="mRequestName" select="@Name"></xsl:variable>
			<xsl:variable name="mRequestSentBytes" select="ddt:Sent/ddt:SentBytes"></xsl:variable>
			<xsl:variable name="mSend0" select="substring($mRequestSentBytes,1,2)"></xsl:variable>
			<xsl:variable name="mSend1" select="substring($mRequestSentBytes,3,2)"></xsl:variable>
			<xsl:variable name="mSend2" select="substring($mRequestSentBytes,5,2)"></xsl:variable>
			<xsl:variable name="mRequestReceivedReplyBytes" select="ddt:Received/ddt:ReplyBytes"></xsl:variable>
			<xsl:variable name="mRequestMinBytes" select="ddt:Received/@MinBytes"></xsl:variable>
			<xsl:variable name="mReply0" select="substring($mRequestReceivedReplyBytes,1,2)"></xsl:variable>
			<xsl:variable name="mReply1" select="substring($mRequestReceivedReplyBytes,3,2)"></xsl:variable>
			<xsl:variable name="mReply2" select="substring($mRequestReceivedReplyBytes,5,2)"></xsl:variable>
		<!-- ******************
	         Check that Daimler Identification request $21EF 
	         contains both dataitems HardwareNumber starting at byte 3 
	         and SoftwareNumber starting at byte 13
	         ****************** -->
		<xsl:if test=" ddt:Sent[ddt:SentBytes = '21EF']">	 
			<xsl:if test="not(ddt:Received/ddt:DataItem[@FirstByte = '3']) or not(ddt:Received/ddt:DataItem[@FirstByte = '13'])">
				<xsl:call-template name="error">
					<xsl:with-param name="type">DAIMLER</xsl:with-param>
					<xsl:with-param name="chapter">DAIMLER_IdentRequest</xsl:with-param>
					<xsl:with-param name="description">	
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b>DAIMLER Identification ($21EF)</b>
					</xsl:with-param>
					<xsl:with-param name="info">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b>Hardware and/or Software number </b> 
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>					
					</xsl:with-param>
					<xsl:with-param name="action">
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionWrongDaimlerIdent"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> 
					</xsl:with-param>
				</xsl:call-template>			
			</xsl:if>
        </xsl:if>			
			<!-- ************************************************************************************************** -->
			<!-- ***********************************Reply0  = Send0 + 40*************************************** -->
			<xsl:if test="$mSend0 = '10' or
					$mSend0 = '11' or
					$mSend0 = '14' or
					$mSend0 = '19' or				
					$mSend0 = '21' or
					$mSend0 = '22' or					
					$mSend0 = '23' or
					$mSend0 = '24' or					
					$mSend0 = '27' or
					$mSend0 = '28' or
					$mSend0 = '30' or
					$mSend0 = '31' or
					$mSend0 = '32' or
					$mSend0 = '34' or
					$mSend0 = '35' or
					$mSend0 = '36' or
					$mSend0 = '37' or
					$mSend0 = '2C' or
					$mSend0 = '2E' or					
					$mSend0 = '3B' or
					$mSend0 = '3D' or
					$mSend0 = '3E'
					">					
				<xsl:if test="$mReply0 != local:ToHex(local:ToDec($mSend0)+64,2)">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_SID</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
						</xsl:with-param>
						<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°1 </b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/or"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>									
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>: 
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°1 </b>										
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> = <b>$<xsl:value-of select="local:ToHex(local:ToDec($mSend0)+64,2)"/></b>							
						</xsl:with-param>
					</xsl:call-template>				
				</xsl:if>					
			</xsl:if>	
			<!-- ***********************************MinBytes = min spec ( 1)if no DataItem********************* -->
			<xsl:if test="$mSend0 = '14' or					
					$mSend0 = '23' or
					$mSend0 = '3D' or
					$mSend0 = '3E'
					">
				<xsl:if test="not(ddt:Received/ddt:DataItem) and $mRequestMinBytes != '1'">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_MINBYTES</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="$mRequestName"/></b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>					
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="ddt:Received/@MinBytes"/></b><br/>
					    <b>
					    <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
						</b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b>1</b>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>	
						<xsl:if test="(not(ddt:Received/ddt:DataItem) and (string-length($mRequestReceivedReplyBytes) div 2) != 1) or
							  (ddt:Received/ddt:DataItem and (string-length($mRequestReceivedReplyBytes) div 2) &lt;= 1)
				">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_BYTES</xsl:with-param>
					<xsl:with-param name="description">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
					</xsl:with-param>
				<xsl:with-param name="info">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> :<b><xsl:value-of select="string-length($mRequestReceivedReplyBytes) div 2"/></b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <br/>					
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> >= <b>1</b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>					
				</xsl:with-param>
			</xsl:call-template>					
			</xsl:if>	

		</xsl:if>			
			<!-- ***********************************Reply1  = Send1*************************************** -->
			<xsl:if test="$mSend0 = '10' or
					$mSend0 = '11' or
					$mSend0 = '19' or				
					$mSend0 = '21' or
					$mSend0 = '22' or					
					$mSend0 = '24' or					
					$mSend0 = '27' or
					$mSend0 = '28' or
					$mSend0 = '30' or
					$mSend0 = '31' or
					$mSend0 = '32' or
					$mSend0 = '34' or
					$mSend0 = '35' or
					$mSend0 = '36' or
					$mSend0 = '37' or
					$mSend0 = '2C' or
					$mSend0 = '2E' or					
					$mSend0 = '3B'
					">
				<xsl:if test="$mSend1 = ''">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_REQUEST_BYTE</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b><br/>								
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><b> n°2 </b>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : 
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><b> n°2 </b>	
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:if>									
				<xsl:if test="$mSend1 != '' and $mReply1 != $mSend1">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_REPLY_BYTE</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
						</xsl:with-param>
						<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°2 </b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/or"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>									
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>: 
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°2 </b>										
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> = <b>$<xsl:value-of select="$mSend1"/></b>							
						</xsl:with-param>
					</xsl:call-template>				
				</xsl:if>
			</xsl:if>				
						<!-- ***********************************MinBytes = min spec (2) if no DataItem********************* -->			
				<xsl:if test="$mSend0 = '10' or
					$mSend0 = '11' or
					$mSend0 = '19' or				
					$mSend0 = '21' or					
					$mSend0 = '27' or
					$mSend0 = '28' or
					$mSend0 = '34' or
					$mSend0 = '35' or
					$mSend0 = '36' or
					$mSend0 = '37' or
					$mSend0 = '2C' or					
					$mSend0 = '3B'
					">
					<xsl:if test="not(ddt:Received/ddt:DataItem) and $mRequestMinBytes != '2'">
					<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_MINBYTES</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="$mRequestName"/></b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>					
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="ddt:Received/@MinBytes"/></b><br/>
					    <b>
					    <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
						</b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b>2</b>
				</xsl:with-param>
				</xsl:call-template>
				</xsl:if>	
								<xsl:if test="(not(ddt:Received/ddt:DataItem) and (string-length($mRequestReceivedReplyBytes) div 2) != 2) or
							  (ddt:Received/ddt:DataItem and (string-length($mRequestReceivedReplyBytes) div 2) &lt; 2)
				">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_BYTES</xsl:with-param>
					<xsl:with-param name="description">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
					</xsl:with-param>
				<xsl:with-param name="info">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> :<b><xsl:value-of select="string-length($mRequestReceivedReplyBytes) div 2"/></b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <br/>					
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> >= <b>2</b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>					
				</xsl:with-param>
			</xsl:call-template>					
			</xsl:if>	

			</xsl:if>			
			<!-- ***********************************Reply2 = Send2*************************************** -->
			<xsl:if test="$mSend0 = '22' or					
					$mSend0 = '24' or					
					$mSend0 = '2E'
					">
				<xsl:if test="$mSend2 = ''">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_REQUEST_BYTE</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 
						</xsl:with-param>
						<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b><br/>								
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><b> n°3 </b>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><br/>
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : 
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template><b> n°3 </b>	
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:if>					
				<xsl:if test="$mSend2 != '' and $mReply2 != $mSend2">
					<xsl:call-template name="error">
						<xsl:with-param name="type">DAIMLER</xsl:with-param>
						<xsl:with-param name="chapter">DAIMLER_REPLY_BYTE</xsl:with-param>
						<xsl:with-param name="description">	
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/> 						
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
						</xsl:with-param>
						<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°3 </b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/or"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>									
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>										
						</xsl:with-param>
						<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>: 
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><b> n°3 </b>										
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> = <b>$<xsl:value-of select="$mSend2"/></b>							
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:if>
			</xsl:if>				
			<!-- ***********************************MinBytes = min spec (3) if no DataItem********************* -->			
			<xsl:if test="$mSend0 = '22' or					
					$mSend0 = '24' or					
					$mSend0 = '2E' or
					$mSend0 = '30' or
					$mSend0 = '31' or
					$mSend0 = '32' 
				">
				<xsl:if test="not(ddt:Received/ddt:DataItem) and $mRequestMinBytes != '3'">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_MINBYTES</xsl:with-param>
				<xsl:with-param name="description">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="$mRequestName"/></b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>												
				</xsl:with-param>
				<xsl:with-param name="info">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> :  <b><xsl:value-of select="ddt:Received/@MinBytes"/></b><br/>
					    <b>
					    <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>
						</b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template><br/>
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <b>3</b>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="(not(ddt:Received/ddt:DataItem) and (string-length($mRequestReceivedReplyBytes) div 2) != 3) or
						 (ddt:Received/ddt:DataItem and (string-length($mRequestReceivedReplyBytes) div 2) &lt; 3)
			">
				<xsl:call-template name="error">
				<xsl:with-param name="type">DAIMLER</xsl:with-param>
				<xsl:with-param name="chapter">DAIMLER_REPLY_BYTES</xsl:with-param>
					<xsl:with-param name="description">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mRequestName"/></b><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre></b>
					</xsl:with-param>
				<xsl:with-param name="info">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestReceivedReplyBytes),32)"/></pre></b>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbByte1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> :<b><xsl:value-of select="string-length($mRequestReceivedReplyBytes) div 2"/></b>
				</xsl:with-param>
				<xsl:with-param name="action">
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> : <br/>					
		            <xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/replyBytes"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template> >= <b>3</b>
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>					
				</xsl:with-param>
			</xsl:call-template>					
			</xsl:if>	
		</xsl:if>
		
			<!-- Contrôles des IDs des OutputControl $30 dans la trame générique-->			
				<xsl:if test="not(local:LowerSpaceRemove(string($mRequestName))= 'outputcontrol') and $mOutputControlGenericRequest = 1 and substring($mRequestSentBytes,1,2) = '30' and not(substring($mRequestSentBytes,3,2) = '00')"> 
					<!-- -tout ID déclaré dans une 30, doit être contenu dans la liste da la 30 Generique ?-->
					<xsl:variable name="mId" select="substring($mRequestSentBytes,3,2)"></xsl:variable>	
					<xsl:if test="
								(not(count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and local:LowerSpaceRemove(string(@Name)) = 'outputcontrol']/ddt:Sent/ddt:DataItem[local:LowerSpaceRemove(string(@Name))='outputpermanentcontrollist' and @FirstByte = '2' ])&gt;=1) or								not(count(//ddt:Target/ddt:Datas/ddt:Data[local:LowerSpaceRemove(string(@Name))='outputpermanentcontrollist']/ddt:Bits/ddt:List/ddt:Item[@Value = local:ToDec($mId)])&gt;=1))
								and
								(not(count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and local:LowerSpaceRemove(string(@Name)) = 'outputcontrol']/ddt:Sent/ddt:DataItem[local:LowerSpaceRemove(string(@Name))='outputtemporarycontrollist' and @FirstByte = '2' ])&gt;=1) or								not(count(//ddt:Target/ddt:Datas/ddt:Data[local:LowerSpaceRemove(string(@Name))='outputtemporarycontrollist']/ddt:Bits/ddt:List/ddt:Item[@Value = local:ToDec($mId)])&gt;=1))
							">
								<xsl:call-template name="error">
								<xsl:with-param name="type">DAIMLER</xsl:with-param>
								<xsl:with-param name="chapter">DAIMLER_OutputControlList_MissingID</xsl:with-param>
								<xsl:with-param name="description">	
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template> : <xsl:value-of select="$mRequestName"/> $<xsl:value-of select="$mRequestSentBytes"/>
								</xsl:with-param>
								<xsl:with-param name="info">LID: <b><xsl:value-of select="$mId"/></b>,																
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoOutputControlMissingID"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template> : OutputPermanentControlList / OutputTemporaryControlList
								</xsl:with-param>
								<xsl:with-param name="action">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddOutputControlID"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template> 
								</xsl:with-param>
							</xsl:call-template>			
					</xsl:if>					
				</xsl:if>
		</xsl:for-each>
	</xsl:if>	

	<!-- ************************************************************************************************** -->	
	<!-- *********************************** -->
	<!-- Contrôles relatifs à la spécification UDS notamment les DIDs -->
	<!-- *********************************** -->
	<xsl:if test="//ddt:Target/ddt:Requests/ddt:Request[@Name = 'TesterPresent.WithResponse']/ddt:Sent[starts-with(ddt:SentBytes,'3E00')] and
		not(//ddt:Target/ddt:Requests/ddt:Request[@Name='ReadDTC']/ddt:Sent[starts-with(ddt:SentBytes,'17FF00')])">
		<xsl:for-each select="ddt:Requests/ddt:Request">
		    <xsl:variable name="mRequestName" select="@Name"></xsl:variable>
			<xsl:variable name="mRequestSentBytes" select="ddt:Sent/ddt:SentBytes"></xsl:variable>
			<xsl:if test="not($mRequestName = 'OutputControl') and $mOutputControlGenericRequest = 1 and substring($mRequestSentBytes,1,2) = '2F' and not(substring($mRequestSentBytes,3,4) = '0000')"> 
				<!-- -tout DID déclaré dans une 2F, doit être contenu dans la liste de la 2F Generique ?-->
				<xsl:variable name="mDid" select="substring($mRequestSentBytes,3,4)"></xsl:variable>
					<xsl:if test="
								not(count(//ddt:Target/ddt:Requests/ddt:Request[ddt:DossierMaintenabilite and local:LowerSpaceRemove(string(@Name)) = 'outputcontrol']/ddt:Sent/ddt:DataItem[local:LowerSpaceRemove(string(@Name))='outputpermanentcontrollist' and @FirstByte = '2' ])&gt;=1) or 
								not(count(//ddt:Target/ddt:Datas/ddt:Data[local:LowerSpaceRemove(string(@Name))='outputpermanentcontrollist']/ddt:Bits/ddt:List/ddt:Item[@Value = local:ToDec($mDid)])&gt;=1)								
							">
							<xsl:call-template name="error">
								<xsl:with-param name="type">DAIMLER</xsl:with-param>
								<xsl:with-param name="chapter">DAIMLER_OutputControlList_MissingID</xsl:with-param>
								<xsl:with-param name="description">	
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template> : <xsl:value-of select="$mRequestName"/> $<xsl:value-of select="$mRequestSentBytes"/>
								</xsl:with-param>
								<xsl:with-param name="info">DID: <b><xsl:value-of select="$mDid"/></b>,																	
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoOutputControlMissingID"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template> : OutputPermanentControlList
								</xsl:with-param>
								<xsl:with-param name="action">
									<xsl:call-template name="getLocalizedText">
										<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddOutputControlID"></xsl:with-param>
										<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
									</xsl:call-template> 
								</xsl:with-param>
							</xsl:call-template>			
					</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:if>
	<!-- ************************************************************************************************** -->		
	<!-- *********************************** -->
	<!-- Contrôles relatifs a la requeste d identification $21EF -->
	<!-- *********************************** -->		
	<xsl:if test="not(//ddt:Target/ddt:Requests/ddt:Request[@Name = 'TesterPresent.WithResponse']/ddt:Sent[starts-with(ddt:SentBytes,'3E00')]) and 	    Projects[x07 or x61Ph2] and 
	count(ddt:Requests/ddt:Request/ddt:Sent[ddt:SentBytes = '21EF'])&lt;=0">
		<xsl:call-template name="error">
			<xsl:with-param name="type">DAIMLER</xsl:with-param>
			<xsl:with-param name="chapter">DAIMLER_IdentRequest</xsl:with-param>
			<xsl:with-param name="description">	
				<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
				</xsl:call-template> : <b>DAIMLER Identification ($21EF)</b>
			</xsl:with-param>
			<xsl:with-param name="info">
				<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
				</xsl:call-template>					
			</xsl:with-param>
			<xsl:with-param name="action">
				<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
				</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>			
	</xsl:if>
<!-- ************************************************************************************************** -->
	<!-- *********************************** -->
	<!-- Contrôles relatifs aux <AutoIdents> -->
	<!-- *********************************** -->	
	<xsl:choose>
		<xsl:when test="not(count(//ddt:Target/ddt:AutoIdents/ddt:AutoIdent)&gt;0)">
			<xsl:call-template name="error">
			<xsl:with-param name="type">DAIMLER</xsl:with-param>
			<xsl:with-param name="chapter">DAIMLER_MISSING_AUTOIDENT</xsl:with-param>
			<xsl:with-param name="description">	
				<xsl:call-template name="getLocalizedText">
					<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
					<xsl:with-param name="aNode" select="document('Translate.xml')/translation/autoident"></xsl:with-param>
					<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
				</xsl:call-template>						
			</xsl:with-param>
			<xsl:with-param name="info">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>										
			</xsl:with-param>
			<xsl:with-param name="action">
					<xsl:call-template name="getLocalizedText">
						<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
						<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionMissingAutoident"></xsl:with-param>
						<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
					</xsl:call-template>					
			</xsl:with-param>
		</xsl:call-template>								
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="//ddt:Target/ddt:AutoIdents/ddt:AutoIdent">
				<xsl:if test="@Supplier='000' or @Soft='0000'">
					<xsl:call-template name="error">
					<xsl:with-param name="type">DAIMLER</xsl:with-param>
					<xsl:with-param name="chapter">DAIMLER_WRONG_AUTOIDENT</xsl:with-param>
					<xsl:with-param name="description">	
						<xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/autoident"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template>						
					</xsl:with-param>
					<xsl:with-param name="info">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>: Supplier = <b><xsl:value-of select="@Supplier"/></b>, Soft = <b><xsl:value-of select="@Soft"/></b>										
					</xsl:with-param>
					<xsl:with-param name="action">
							<xsl:call-template name="getLocalizedText">
								<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
								<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionWrongAutoident"></xsl:with-param>
								<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
							</xsl:call-template>					
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
<!-- ************************************************************************************************** -->	
	<!-- *********************************** -->
	<!-- Contrôles relatifs aux dataitems en dehors de la trame en réception et en émission -->
	<!-- *********************************** -->		
	<xsl:for-each select="ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Received/ddt:DataItem">

	<!-- *************************************************************
         Déclarations des variables liées à la boucle sur les DataItem
         ************************************************************** -->
		<xsl:variable name="mRequestName" select="../../@Name"></xsl:variable>
		<xsl:variable name="mRequestSentBytes" select="../../ddt:Sent/ddt:SentBytes"></xsl:variable>

		<xsl:if test="@Name">	
			<xsl:variable name="mName" select="@Name"/>	
				<xsl:if test="key('allDatas',$mName)">
					<xsl:variable name="mdataLength">
							<xsl:choose>
								<xsl:when test="key('allDatas',$mName)/ddt:Bytes">
									<xsl:value-of select="key('allDatas',$mName)/ddt:Bytes/@count"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="key('allDatas',$mName)/ddt:Bits/@count">
											<xsl:value-of select="key('allDatas',$mName)/ddt:Bits/@count"/>
										</xsl:when>
										<xsl:otherwise>8</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
					</xsl:variable>

					<xsl:variable name="mdataLengthInBits">
							<xsl:choose>
								<xsl:when test="key('allDatas',$mName)/ddt:Bytes">
									<xsl:value-of select="key('allDatas',$mName)/ddt:Bytes/@count*8"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="key('allDatas',$mName)/ddt:Bits/@count">
											<xsl:value-of select="key('allDatas',$mName)/ddt:Bits/@count"/>
										</xsl:when>
										<xsl:otherwise>8</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
					</xsl:variable>

					<xsl:variable name="mRequestMinBytes" select="../../ddt:Received/@MinBytes"></xsl:variable>

					<xsl:variable name="mRequestShiftBytesCount">
						<xsl:choose>
							<xsl:when test="../ddt:ShiftBytesCount"><xsl:value-of select="../ddt:ShiftBytesCount"></xsl:value-of></xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<xsl:variable name="mBitOffset">
						<xsl:choose>
							<xsl:when test="@BitOffset">
								<xsl:value-of select="@BitOffset"></xsl:value-of>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<xsl:choose>
						<!-- ********************************************************************************
							 Filtrer la requête $1906.... dont les données sont hors requête mais c'est normal
							 Ne réaliser le test que si l'attribut FirstByte existe sinon plantage
							 ********************************************************************************* -->
						<xsl:when test="substring($mRequestSentBytes,1,4) != '1906' and @FirstByte">
						 <xsl:choose>
							<xsl:when test="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))&gt; $mRequestMinBytes + $mRequestShiftBytesCount">
								<xsl:call-template name="error">
									<xsl:with-param name="type">DAIMLER</xsl:with-param>
									<xsl:with-param name="chapter">DAIMLER_DATAITEM_OUTSIDE_FRAME</xsl:with-param>
									<xsl:with-param name="description">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <b><xsl:value-of select="../../@Name"/></b><br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre><br/>
									</xsl:with-param>
									<xsl:with-param name="info">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <b><xsl:value-of select="$mName"/></b><br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsOutside"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template><br/>--------------------<br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataEndBytePosition"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <b><xsl:value-of select="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))"/></b>
											<br/>--------------------<br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <b><xsl:value-of select="$mRequestMinBytes + $mRequestShiftBytesCount"/></b>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
									</xsl:with-param>
									<xsl:with-param name="action">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckAll"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits)) =  local:GeneralErrorCode()">
								<xsl:call-template name="error">
									<xsl:with-param name="type">DAIMLER</xsl:with-param>
									<xsl:with-param name="chapter">DAIMLER_DATAITEM_OUTSIDE_FRAME</xsl:with-param>
									<xsl:with-param name="description">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <b><xsl:value-of select="../../@Name"/></b><br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre><br/>
									</xsl:with-param>
									<xsl:with-param name="info">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <b><xsl:value-of select="$mName"/></b><br/>
											<br/>--------------------<br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <pre><b><xsl:value-of select="@FirstByte"/></b>
											<b>
											<xsl:if test="string(number(@FirstByte))='NaN'">
												<span class="redText"> &lt;- Not a valid number</span>
											</xsl:if>
											</b><br/>--------------------<br/></pre><br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <pre><b><xsl:value-of select="$mBitOffset"/></b>
											<b>
											<xsl:if test="string(number($mBitOffset))='NaN'">
												<span class="redText"> &lt;- Not a valid number</span>
											</xsl:if>
											</b><br/>--------------------<br/></pre><br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <pre><b><xsl:value-of select="$mdataLengthInBits"/></b>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/bit"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
											<b>
											<xsl:if test="string(number($mdataLengthInBits))='NaN'">
												<span class="redText"> &lt;- Not a valid number</span>
											</xsl:if>
											</b><br/>--------------------<br/></pre><br/>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template> : <pre><b><xsl:value-of select="$mRequestMinBytes + $mRequestShiftBytesCount"/></b>
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
											<b>
											<xsl:if test="string(number($mRequestMinBytes + $mRequestShiftBytesCount))='NaN'">
												<span class="redText"> &lt;- Not a valid number</span>
											</xsl:if>
											</b></pre>
									</xsl:with-param>
									<xsl:with-param name="action">
											<xsl:call-template name="getLocalizedText">
												<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
												<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckAll"></xsl:with-param>
												<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
											</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
						  </xsl:choose>
						</xsl:when>
					</xsl:choose>

				</xsl:if>
								
		</xsl:if>	
	</xsl:for-each>	
	<xsl:for-each select="ddt:Requests/ddt:Request[ddt:DossierMaintenabilite]/ddt:Sent/ddt:DataItem">

		<xsl:variable name="mRequestName" select="../../@Name"></xsl:variable>
		<xsl:variable name="mRequestSentBytes" select="../ddt:SentBytes"></xsl:variable>
		<xsl:variable name="mName" select="@Name"/>
		<xsl:if test="key('allDatas',$mName)">
			<xsl:variable name="mdataLength">
								<xsl:choose>
									<xsl:when test="key('allDatas',$mName)/ddt:Bytes">
										<xsl:value-of select="key('allDatas',$mName)/ddt:Bytes/@count"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="key('allDatas',$mName)/ddt:Bits/@count">
												<xsl:value-of select="key('allDatas',$mName)/ddt:Bits/@count"/>
											</xsl:when>
											<xsl:otherwise>8</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
						</xsl:variable>

			<xsl:variable name="mdataLengthInBits">
							<xsl:choose>
								<xsl:when test="key('allDatas',$mName)/ddt:Bytes">
									<xsl:value-of select="key('allDatas',$mName)/ddt:Bytes/@count*8"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="key('allDatas',$mName)/ddt:Bits/@count">
											<xsl:value-of select="key('allDatas',$mName)/ddt:Bits/@count"/>
										</xsl:when>
										<xsl:otherwise>8</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

			<xsl:variable name="mBitOffset">
							<xsl:choose>
								<xsl:when test="@BitOffset">
									<xsl:value-of select="@BitOffset"></xsl:value-of>
								</xsl:when>
								<xsl:otherwise>0</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

			<!-- *********************************************************************
				 Ne réaliser le test que si l'attribut FirstByte existe sinon plantage
				 ********************************************************************** -->
			<xsl:if test="@FirstByte">
				<xsl:choose>
					<xsl:when test="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))&gt; (string-length($mRequestSentBytes) div 2) ">
						<xsl:call-template name="error">
							<xsl:with-param name="type">DAIMLER</xsl:with-param>
							<xsl:with-param name="chapter">DAIMLER_DATAITEM_OUTSIDE_FRAME</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><xsl:value-of select="../../@Name"/></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre><br/>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><xsl:value-of select="$mName"/></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsOutside"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template><br/>--------------------<br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataEndBytePosition"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><xsl:value-of select="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))"/></b>
								<br/>--------------------<br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><xsl:value-of select="string-length($mRequestSentBytes) div 2"/> bytes</b>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckAll"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits)) =  local:GeneralErrorCode()">
						<xsl:call-template name="error">
							<xsl:with-param name="type">DAIMLER</xsl:with-param>
							<xsl:with-param name="chapter">DAIMLER_DATAITEM_OUTSIDE_FRAME</xsl:with-param>
							<xsl:with-param name="description">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><xsl:value-of select="../../@Name"/></b><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)"/></pre><br/>
							</xsl:with-param>
							<xsl:with-param name="info">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <b><xsl:value-of select="$mName"/></b><br/>
								<br/>--------------------<br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <pre><b><xsl:value-of select="@FirstByte"/></b>
								<b>
								<xsl:if test="string(number(@FirstByte))='NaN'">
									<span class="redText"> &lt;- Not a valid number</span>
								</xsl:if>
								</b><br/>--------------------<br/></pre><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <pre><b><xsl:value-of select="$mBitOffset"/></b>
								<b>
								<xsl:if test="string(number($mBitOffset))='NaN'">
									<span class="redText"> &lt;- Not a valid number</span>
								</xsl:if>
								</b><br/>--------------------<br/></pre><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <pre><b><xsl:value-of select="$mdataLengthInBits"/></b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/bit"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<b>
								<xsl:if test="string(number($mdataLengthInBits))='NaN'">
									<span class="redText"> &lt;- Not a valid number</span>
								</xsl:if>
								</b><br/>--------------------<br/></pre><br/>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/request"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template> : <pre><b><xsl:value-of select="string-length($mRequestSentBytes) div 2"/></b>
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/byte"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
								<b>
								<xsl:if test="string(number(string-length($mRequestSentBytes) div 2))='NaN'">
									<span class="redText"> &lt;- Not a valid number</span>
								</xsl:if>
								</b></pre>
							</xsl:with-param>
							<xsl:with-param name="action">
								<xsl:call-template name="getLocalizedText">
									<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
									<xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCheckAll"></xsl:with-param>
									<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:for-each>


	
	<!-- ************************************************************************************************** -->		
	<!-- ******************************************************************************************
	     Check List Item @value
	     ****************************************************************************************** -->
	<xsl:for-each select="//ddt:Target/ddt:Datas/ddt:Data/ddt:Bits/ddt:List/ddt:Item">
		<xsl:variable name="mBitsListItemValue" select="@Value"></xsl:variable>
		<xsl:variable name="mBitsCount">
			<xsl:choose>
				<xsl:when test="../../@count"><xsl:value-of select="../../@count"/></xsl:when>
				<xsl:otherwise>8</xsl:otherwise>
				</xsl:choose>
		</xsl:variable>
		<xsl:variable name="mBitsSigned">
			<xsl:choose>
				<xsl:when test="../../@signed"><xsl:value-of select="../../@signed"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Calcul des bornes Min et Max en fonction du nombre de bit et de l'attribut Signed -->
		<xsl:variable name="mMaxValue" select="local:MaxValue(number($mBitsCount),number($mBitsSigned))"></xsl:variable>
		<xsl:variable name="mMinValue" select="local:MinValue(number($mBitsCount),number($mBitsSigned))"></xsl:variable>
		
		<xsl:if test="$mBitsListItemValue&lt;$mMinValue or $mBitsListItemValue&gt;$mMaxValue">
				<xsl:call-template name="error">
					<xsl:with-param name="type">DAIMLER</xsl:with-param>
					<xsl:with-param name="chapter">DAIMLER_DataListItemValue</xsl:with-param>
					<xsl:with-param name="description">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="../../../@Name"/></b>
					</xsl:with-param>
					<xsl:with-param name="info">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNbBit1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mBitsCount"/></b><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitSigned1"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b><xsl:value-of select="$mBitsSigned"/></b><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b>[<xsl:value-of select="$mMinValue "/>,<xsl:value-of select="$mMaxValue "/>]</b><br/>
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoListItemValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> = <b><xsl:value-of select="$mBitsListItemValue"/></b>
					</xsl:with-param>
					<xsl:with-param name="action">
			            <xsl:call-template name="getLocalizedText">
							<xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue"></xsl:with-param>
							<xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
						</xsl:call-template> : <b>[<xsl:value-of select="$mMinValue"/> , <xsl:value-of select="$mMaxValue"/>]</b>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
	</xsl:for-each>	
</xsl:template>
</xsl:stylesheet>