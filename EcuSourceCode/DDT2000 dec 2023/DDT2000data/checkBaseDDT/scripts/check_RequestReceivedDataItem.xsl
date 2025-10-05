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
     Check Request/Received/DataItem
     		* @Name
     		* @FirstByte
     		* @BitOffset
     ****************************************************************************************** -->
  <xsl:template name="RequestReceivedDataItem">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_RequestReceivedDataItem.xsl: template RequestReceivedDataItem starts')"/></logmsg>

    <!-- **********************************************************************
           Déclarations des variables indépendantes de la boucle sur les DataItem
           ********************************************************************** -->
    <xsl:variable name="mMinFirstByte">2</xsl:variable><!-- 2 -->

    <xsl:variable name="mMaxFirstByteDDT2000">
      <xsl:choose>
        <xsl:when test="//ddt:Target/ddt:K">255</xsl:when>
        <xsl:when test="//ddt:Target/ddt:CAN">4095</xsl:when>
        <xsl:when test="//ddt:Target/ddt:IP">4095</xsl:when>
        <xsl:otherwise>255</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="mMinBitOffset">0</xsl:variable><!-- 0 -->
    <xsl:variable name="mMaxBitOffset">7</xsl:variable><!-- 7 -->
    <!-- ***************************************************  -->

    <xsl:for-each select="ddt:Requests/ddt:Request/ddt:Received/ddt:DataItem">

    <!-- *************************************************************
           Déclarations des variables liées à la boucle sur les DataItem
           ************************************************************** -->
      <xsl:variable name="mRequestName" select="../../@Name"></xsl:variable>
      <xsl:variable name="mRequestSentBytes" select="../../ddt:Sent/ddt:SentBytes"></xsl:variable>
    <!-- ************************************************************* -->

      <xsl:choose>
      <!-- ************************************************************
           Checking  @Name (DDT2000 error)
           ************************************************************ -->
        <xsl:when test="not(@Name)">
        <!-- l'attribut Name n'existe pas -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedDataItemName</xsl:with-param>
            <xsl:with-param name="description">Request:  <b><xsl:value-of select="../../@Name" /></b><br/>
            <pre>SentBytes : $<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre></xsl:with-param>
            <xsl:with-param name="info">In DataBase:<b>Name attribute missing</b></xsl:with-param>
            <xsl:with-param name="action">Check Name Attribute</xsl:with-param>
          </xsl:call-template>
        </xsl:when>

        <xsl:otherwise>
        <!-- ********************** -->
        <!-- l'attribut Name existe -->
        <!-- ********************** -->
          <xsl:variable name="mName" select="@Name" />
          <xsl:choose>
            <xsl:when test="key('allDatas',$mName)">
              <!-- **********************************************************************************
                       OK la donnée existe :
                       Déclarations des variables pour rechercher si la donnée est en dehors de la requête
                       variables : mdataLengthInBits
                             mRequestMinBytes
                             mRequestShiftBytesCount
                             mBitOffset
                       *********************************************************************************** -->
              <xsl:variable name="mdataLengthInBits">
                <xsl:call-template name ="GetDataBitLength">
                  <xsl:with-param name="data" select="key('allDatas',$mName)" />
                </xsl:call-template>
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

                <!--
                 <h99>Rcoz*data:<xsl:value-of select="$mName" /></h99>
                 <h99>Rcoz*SentBytes:<xsl:value-of select="$mRequestSentBytes" /></h99>
                 <h99>Rcoz*FirstByte:<xsl:value-of select="@FirstByte" /></h99>
                 <h99>Rcoz*mBitOffset:<xsl:value-of select="$mBitOffset" /></h99>
                 <h99>Rcoz*mdataLengthInBits:<xsl:value-of select="$mdataLengthInBits" /></h99>
                 <h99>Rcoz*$mRequestMinBytes:<xsl:value-of select="$mRequestMinBytes" /></h99>
                 <h99>Rcoz*$mRequestShiftBytesCount:<xsl:value-of select="$mRequestShiftBytesCount" /></h99>
                 <h99>Rcoz*Data End Byte position:<xsl:value-of select="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))" /></h99>
                -->
                 <xsl:choose>
                  <xsl:when test="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))&gt; $mRequestMinBytes + $mRequestShiftBytesCount">
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DDT2000</xsl:with-param>
                      <xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedDataOutSideOfRequest</xsl:with-param>
                      <xsl:with-param name="description">
                      <!--Request:<br/>
                      <b><xsl:value-of select="../../@Name" /></b><br/>
                      <pre>SentBytes: $<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre>
                      -->
                              <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b><br/>
                                <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre><br/>
                      </xsl:with-param>
                      <xsl:with-param name="info">
                      <!--
                      In DataBase:<br/>
                      Data (received)= <b><xsl:value-of select="$mName" /></b><br/> is outside of the request<br/>
                      Data End Byte position:<b><xsl:value-of select="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))" /></b><br/>
                      Request length:<b><xsl:value-of select="$mRequestMinBytes + $mRequestShiftBytesCount" /> bytes</b>
                      -->
                              <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <b><xsl:value-of select="$mName" /></b><br/>
                              <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsOutside"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template><br/>--------------------<br/>
                              <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDataEndBytePosition"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <b><xsl:value-of select="local:ComputeEndByte(number(@FirstByte), number($mBitOffset) , number($mdataLengthInBits))" /></b>
                          <br/>--------------------<br/>
                              <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                              <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <b><xsl:value-of select="$mRequestMinBytes + $mRequestShiftBytesCount" /></b>
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
                      <xsl:with-param name="type">DDT2000</xsl:with-param>
                      <xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedDataOutSideOfRequest</xsl:with-param>
                      <xsl:with-param name="description">
                      <!--
                      Request:<br/>
                      <b><xsl:value-of select="../../@Name" /></b><br/>
                      <pre>SentBytes: $<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre>
                      -->
                              <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b><br/>
                                <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre><br/>
                      </xsl:with-param>
                      <xsl:with-param name="info">
                              <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <b><xsl:value-of select="$mName" /></b><br/>
                          <br/>--------------------<br/>
                                <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <pre><b><xsl:value-of select="@FirstByte" /></b>
                          <b>
                          <xsl:if test="string(number(@FirstByte))='NaN'">
                            <span class="redText"> &lt;- Not a valid number</span>
                          </xsl:if>
                          </b><br/>--------------------<br/></pre><br/>
                                <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <pre><b><xsl:value-of select="$mBitOffset" /></b>
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
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <pre><b><xsl:value-of select="$mdataLengthInBits" /></b>
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
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template> : <pre><b><xsl:value-of select="$mRequestMinBytes + $mRequestShiftBytesCount" /></b>
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

            </xsl:when>
            <xsl:otherwise>
            <!--  ***************************************
                la définition de la donnée n'existe pas
                *************************************** -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedDataItemName</xsl:with-param>
                <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b><br/>
                          <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre><br/>
                </xsl:with-param>
                <xsl:with-param name="info">
                        <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template> : <b><xsl:value-of select="$mName" /></b><br/>
                        <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionData" />
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>

      </xsl:choose>

      <!-- ************************************************************
           Missing FirstByte attribute in Sent/DataItem (DDT2000 error)
           ************************************************************ -->
      <xsl:if test="not(@FirstByte)">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedDataItemFirstByte</xsl:with-param>
          <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b><br/>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre><br/>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
          </xsl:with-param>
          <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template><br/>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>[<xsl:value-of select="$mMinFirstByte" />,<xsl:value-of select="$mMaxFirstByteDDT2000" /> ]</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <!-- **************************************************************
           Missing BitOffset attribute in Received/DataItem (CPDD warning)
           *************************************************************** -->
           <!--
      <xsl:if test="not(@BitOffset)">
        <xsl:call-template name="warning">
          <xsl:with-param name="type">CPDD</xsl:with-param>
          <xsl:with-param name="chapter">CPDD_RequestReceivedDataItemBitOffset</xsl:with-param>
          <xsl:with-param name="description">Request:  <b><xsl:value-of select="../../@Name" /></b><br/>
          ($<xsl:value-of select="../../ddt:Sent/ddt:SentBytes" />)<br/>
          Data (Received): <b><xsl:value-of select="@Name" /></b></xsl:with-param>
          <xsl:with-param name="info">In DataBase:<b>BitOffset attribute missing.</b><br/>
          (BitOffset=0 for DDT2000)</xsl:with-param>
          <xsl:with-param name="action">Check DataItem</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      -->
      <!-- *******************************
               FirstByte except DDT2000 limits
               ******************************** -->
      <xsl:if test="
              (
                (@FirstByte &lt; $mMinFirstByte)
                and
                (substring($mRequestSentBytes,1,2) != '27')
              )
              or (@FirstByte &gt; $mMaxFirstByteDDT2000)">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedDataItemFirstByte</xsl:with-param>
          <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b><br/>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre><br/>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
          </xsl:with-param>
          <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="@FirstByte" /></b><br/>
            <b>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            </b>
          </xsl:with-param>
          <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template><br/>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoStartByte"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>[<xsl:value-of select="$mMinFirstByte" />,<xsl:value-of select="$mMaxFirstByteDDT2000" /> ]</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <!-- ************************************
               BitOffset except limits DDT2000/CPDD
               ************************************ -->
      <xsl:if test="(@BitOffset &lt; $mMinBitOffset) or (@BitOffset &gt; $mMaxBitOffset)">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_RequestReceivedDataItemBitOffset</xsl:with-param>
          <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="../../@Name" /></b><br/>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/sentBytes" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> :  <pre>$<xsl:value-of select="local:WriteMultiLineEx(string($mRequestSentBytes),32)" /></pre><br/>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDatas" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="@Name" /></b><br/>
          </xsl:with-param>
          <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset"></xsl:with-param>
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="@BitOffset" /></b><br/>
            <b>
                  <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            </b>
          </xsl:with-param>
          <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExpectedValue" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template><br/>
                    <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoBitOffset"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> in <b>[<xsl:value-of select="$mMinBitOffset" />,<xsl:value-of select="$mMaxBitOffset" /> ]</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>


    </xsl:for-each>

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_RequestReceivedDataItem.xsl: template RequestReceivedDataItem ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>
