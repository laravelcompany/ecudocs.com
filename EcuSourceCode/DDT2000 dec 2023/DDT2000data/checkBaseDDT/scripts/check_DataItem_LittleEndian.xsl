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
<!-- ******************************************************************************************
     Check DataItem Little Endian :

       Remarque : Utilisation de la fonction count() pour différencier les éléments traités
     ****************************************************************************************** -->
  <xsl:template name="DataItem_LittleEndian">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DataItem_LittleEndian.xsl: template DataItem_LittleEndian starts')"/></logmsg>

    <xsl:variable name="mRequestsEndian">
      <xsl:choose>
        <xsl:when test="ddt:Requests[not(@Endian)]">Big</xsl:when>
        <xsl:otherwise><xsl:value-of select="ddt:Requests/@Endian" /></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$mRequestsEndian = 'Big'">
        <!-- Default coding : Big -->
        <!-- Only look for attribute Endian="Little" -->
        <xsl:for-each select = "//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent/ddt:DataItem[@Endian='Little'] | //ddt:Target/ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem[@Endian='Little']">
          <xsl:variable name="mCurrentServiceName" select="../../@Name" />
          <xsl:variable name="mCurrentDataItem" select="." />

          <!-- ********************************************************************* -->
          <!-- Warning CW003 CPDD_WAR_DataItemLittleEndian (Default DDT file Big Endian) -->
          <!-- ********************************************************************* -->
          <!-- Check only if Request is DossierMaintenabilite -->
          <xsl:if test="../../ddt:DossierMaintenabilite">
            <xsl:call-template name="warning">
              <xsl:with-param name="type">CPDD</xsl:with-param>
              <xsl:with-param name="chapter">CPDD_WAR_DataItemLittleEndian</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desLittleEndian"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <br/>
                <b><xsl:value-of select="@Name" /></b>
               </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDataInRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>

          <!-- ***************************************************************************************** -->
          <!-- Warning AW006 : ALLIANCE_WAR_NotNumericDataItemLittleEndian (Default DDT file Big Endian) -->
          <!-- ***************************************************************************************** -->
          <!-- Check only if data is numeric -->
          <xsl:if test="key('allDatas',@Name)/ddt:Bytes">
            <xsl:call-template name="warning">
              <xsl:with-param name="type">ALLIANCE</xsl:with-param>
              <xsl:with-param name="chapter">ALLIANCE_WAR_NotNumericDataItemLittleEndian</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desNumericLittleEndian"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <br/>
                <b><xsl:value-of select="@Name" /></b>
               </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDataInRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>

          <!-- *************************************************************************** -->
          <!-- Warning AW002 ALLIANCE_WAR_EndianRedefinition (Default DDT file Big Endian) -->
          <!-- *************************************************************************** -->
          <xsl:for-each select ="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent/ddt:DataItem[@Endian='Big' or not(@Endian)] | //ddt:Target/ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem[@Endian='Big' or not(@Endian)]">
            <xsl:if test="($mCurrentDataItem/@Name = ./@Name) and ($mCurrentServiceName != ../../@Name)">
              <xsl:call-template name="warning">
                <xsl:with-param name="type">ALLIANCE</xsl:with-param>
                <xsl:with-param name="chapter">ALLIANCE_WAR_EndianRedefinition</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> : <br/>
                  <b><xsl:value-of select="@Name" /></b>
                 </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataBigLittle"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> :<br/>
                  <b><xsl:value-of select="$mCurrentServiceName" /></b><br/>
                  <b><xsl:value-of select="../../@Name" /></b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  : <b><xsl:value-of select="$mCurrentServiceName" /></b><br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  : <b><xsl:value-of select="../../@Name" /></b>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <!-- Default coding : Little -->
        <!-- We have to look for attribute Endian="Little" and empty Endian attribute -->
        <xsl:for-each select = "//ddt:Target/ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem[@Endian='Little' or not(@Endian)] | //ddt:Target/ddt:Requests/ddt:Request/ddt:Sent/ddt:DataItem[@Endian='Little' or not(@Endian)]">
          <xsl:variable name="mCurrentServiceName" select="../../@Name" />
          <xsl:variable name="mCurrentDataItem" select="." />

          <!-- ************************************************************************ -->
          <!-- Warning CW003 CPDD_WAR_DataItemLittleEndian (Default DDT file Little Endian) -->
          <!-- ************************************************************************ -->
          <!-- Check only if Request is DossierMaintenabilite -->
          <xsl:if test="../../ddt:DossierMaintenabilite">
            <xsl:call-template name="warning">
              <xsl:with-param name="type">CPDD</xsl:with-param>
              <xsl:with-param name="chapter">CPDD_WAR_DataItemLittleEndian</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desLittleEndian"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <br/>
                <b><xsl:value-of select="@Name" /></b>
               </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDataInRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
          <!-- ******************************************************************************************** -->
          <!-- Warning AW007 : ALLIANCE_WAR_NotNumericDataItemLittleEndian (Default DDT file Little Endian) -->
          <!-- ******************************************************************************************** -->
          <!-- Check only if data is numeric -->
          <xsl:if test="key('allDatas',@Name)/ddt:Bytes">
            <xsl:call-template name="warning">
              <xsl:with-param name="type">ALLIANCE</xsl:with-param>
              <xsl:with-param name="chapter">ALLIANCE_WAR_NotNumericDataItemLittleEndian</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desNumericLittleEndian"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <br/>
                <b><xsl:value-of select="@Name" /></b>
               </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDataInRequest"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>

          <!-- ************************************************************************** -->
          <!-- Warning AW002 ALLIANCE_WAR_EndianRedefinition (Default DDT file Little Endian) -->
          <!-- ************************************************************************** -->
          <xsl:for-each select ="//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent/ddt:DataItem[@Endian='Big'] | //ddt:Target/ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem[@Endian='Big']">
            <xsl:if test="($mCurrentDataItem/@Name = ./@Name) and ($mCurrentServiceName != ../../@Name)">
              <xsl:call-template name="warning">
                <xsl:with-param name="type">ALLIANCE</xsl:with-param>
                <xsl:with-param name="chapter">ALLIANCE_WAR_EndianRedefinition</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> :<br/>
                  <b><xsl:value-of select="@Name" /></b>
                 </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataBigLittle"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template> :<br/>
                  <b><xsl:value-of select="$mCurrentServiceName" /></b><br/>
                  <b><xsl:value-of select="../../@Name" /></b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  : <b><xsl:value-of select="$mCurrentServiceName" /></b><br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/or" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRequest" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  : <b><xsl:value-of select="../../@Name" /></b>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_DataItem_LittleEndian.xsl: template DataItem_LittleEndian ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
