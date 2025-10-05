<?xml version="1.0" encoding="Windows-1252"?>
<!--
    [XSL-XSLT] This stylesheet automatically updated from an IE5-compatible XSL stylesheet to XSLT.
    The following problems which need manual attention may exist in this stylesheet:
    -->
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds local"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions">


  <!-- ******************************************************************* -->
  <!-- ******************************************************************* -->
  <!--                             Check Device                            -->
  <!-- ******************************************************************* -->
  <!-- ******************************************************************* -->
  <xsl:template match="ddt:Devices/ddt:Device">
  
    <!-- ****Déclarations des variables ********* -->
    <xsl:variable name="mMaxDeviceName">100</xsl:variable> <!-- 100 characters -->
    <xsl:variable name="mMaxAllianceDeviceName">255</xsl:variable> <!-- 255 characters -->
    <xsl:variable name="mDeviceName" select="@Name" />
    <xsl:variable name="mDeviceNameNormalize" select="local:NormalizeName(string($mDeviceName))"/>
    <xsl:variable name="mMinDeviceDTC">1</xsl:variable>
    <xsl:variable name="mMaxDeviceDTC">65535</xsl:variable>
    <xsl:variable name="mMinDeviceTestOBD">1</xsl:variable>
    <xsl:variable name="mMaxDeviceTestOBD">65535</xsl:variable>
    <xsl:variable name="mMinDeviceTestType">0</xsl:variable>
    <xsl:variable name="mMaxDeviceTestType">255</xsl:variable>
    <xsl:variable name="mObdStatusNb" select="count(ddt:Test[@OBD])" />
    <xsl:variable name="mCheckInvalidCharDeviceName" select="local:CheckInvalidASCIIChar(string($mDeviceName))"/>

    <xsl:variable name="mBaseDtcValue">
      <xsl:choose>
        <xsl:when test="@DTC">
          <xsl:value-of select="@DTC"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="mObdValue">
      <xsl:choose>
        <xsl:when test="@OBD">
          <xsl:value-of select="@OBD"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="mDtcValue">
      <xsl:choose>
        <xsl:when test="$mBaseDtcValue != 0">
          <xsl:value-of select="$mBaseDtcValue" />
        </xsl:when>
        <xsl:otherwise> <!-- Inutile de tester la valeur de mObdValue car si elle est nulle, on aurait mis 0 -->
          <xsl:value-of select="$mObdValue" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                        Check Device/@Name                         -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <xsl:choose>
      <!-- ************************************ -->
      <!-- Error DE150 : DDT2000_ERR_DeviceName -->
      <!-- ************************************ -->
      <xsl:when test="not(@Name)">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_DeviceName</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/attributeName" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDevice" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- ***************************************************** -->
        <!-- Error DE194 : DDT2000_ERR_DeviceNameInvalidChar_error -->
        <!-- ***************************************************** -->
        <xsl:if test="$mCheckInvalidCharDeviceName != ''">
          <WRONG-DEVICE-CHAR>
            <DEVICE-NAME><xsl:value-of select="$mDeviceName"/></DEVICE-NAME>
            <WRONG-CHAR><xsl:value-of select="$mCheckInvalidCharDeviceName"/></WRONG-CHAR>
            <POSITION><xsl:value-of select="local:GetInvalidASCIIPosition(string($mDeviceName))"/></POSITION>
          </WRONG-DEVICE-CHAR>
        </xsl:if>
        
        <xsl:if test="contains(@Name,'&#10;')"> <!-- character Carriage return/Line feed (CrLf) -->
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_ERR_DeviceNameInvalidChar_error</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidCharacter" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template><br/>
              <b>-&gt; CrLf &lt;-</b>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValidCharacter" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template><br />
              <b> <xsl:value-of select="local:getValidChars($language, 0)" /></b>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
        <!-- ********************************* -->
        <!-- Error CE150 : CPDD_ERR_DeviceName -->
        <!-- ********************************* -->
        <xsl:if test="string-length($mDeviceNameNormalize)&gt; $mMaxDeviceName">
          <xsl:call-template name="error">
            <xsl:with-param name="type">CPDD</xsl:with-param>
            <xsl:with-param name="chapter">CPDD_ERR_DeviceName</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b><br />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <xsl:value-of select="string-length($mDeviceName)" />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoNormalizedName" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mDeviceNameNormalize" /></b><br />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :   <b><xsl:value-of select="string-length($mDeviceNameNormalize)" /></b>
              (&gt; <b><xsl:value-of select="$mMaxDeviceName" /></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              )
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAuthorizedLength" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mMaxDeviceName" /></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
        <!-- ************************************* -->
        <!-- Warning AW004 ALLIANCE_WAR_DeviceName -->
        <!-- ************************************* -->
        <xsl:if test="string-length($mDeviceName)&gt; $mMaxAllianceDeviceName">
          <xsl:call-template name="warning">
            <xsl:with-param name="type">ALLIANCE</xsl:with-param>
            <xsl:with-param name="chapter">ALLIANCE_WAR_DeviceName</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :<br /><b><xsl:value-of select="$mDeviceName" /></b><br />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :  <xsl:value-of select="string-length($mDeviceName)" />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoLength" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> :   <b><xsl:value-of select="string-length($mDeviceName)" /></b><br />
              (&gt; <b><xsl:value-of select="$mMaxAllianceDeviceName" /></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              )
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAuthorizedLength" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : <b><xsl:value-of select="$mMaxAllianceDeviceName" /></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/character" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>

    </xsl:choose>
    
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                         Check Device/@DTC                         -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!-- position du noeud sélectionné -->
    <xsl:variable name="mPosition" select="position()"></xsl:variable>
    <xsl:variable name="mDTC" select="@DTC"></xsl:variable>
    <!-- ******************************** -->
    <!-- Warning CW023 CPDD_WAR_DeviceDTC -->
    <!-- ******************************** -->
    <xsl:if test="not(@DTC)">
      <xsl:call-template name="warning">
        <xsl:with-param name="type">CPDD</xsl:with-param>
        <xsl:with-param name="chapter">CPDD_WAR_DeviceDTC</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b><br />
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/attributeDTC" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- *********************************** -->
    <!-- Error DE151 : DDT2000_ERR_DeviceDTC -->
    <!-- *********************************** -->
    <xsl:if test="(@DTC &lt; $mMinDeviceDTC) or (@DTC &gt; $mMaxDeviceDTC)">
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_DeviceDTC</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b><br />
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/attributeDTC" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> = <b><xsl:value-of select="@DTC" /></b>
          (
          <xsl:call-template name="toHex">
            <xsl:with-param name="number"><xsl:value-of select="@DTC" /></xsl:with-param>
            <xsl:with-param name="digits">3</xsl:with-param>
            <xsl:with-param name="prefix">$</xsl:with-param>
          </xsl:call-template>
          )<br />
          <b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          </b>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b>[<xsl:value-of select="$mMinDeviceDTC" />,<xsl:value-of select="$mMaxDeviceDTC" />]</b>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- ******************************************** -->
    <!-- Error DE155 : DDT2000_ERR_DeviceOBDnoBaseDTC -->
    <!--        OBD without base DTC                  -->
    <!-- ******************************************** -->
    <xsl:if test="$mObdValue !=0 and $mBaseDtcValue = 0">
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_DeviceOBDnoBaseDTC</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> OBD : <b><xsl:value-of select="$mDeviceName" /></b><br />
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/attributeBaseDTC" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionOBDDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$mBaseDtcValue != 0 and $mObdValue != 0 and $mBaseDtcValue != $mObdValue">
      <!-- ***************************************** -->
      <!-- Error DE198 : DDT2000_ERR_DtcObdFaultType -->
      <!-- ***************************************** -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_DtcObdFaultType</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b>
            <ul>
              <li>Base DTC : $<b><xsl:value-of select="local:ToHex(string($mBaseDtcValue),4)" /></b></li>
              <li>OBD : $<b><xsl:value-of select="local:ToHex(string($mObdValue),4)" /></b></li>
            </ul>
        </xsl:with-param>
        <xsl:with-param name="info">
          <b>Base DTC</b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/and" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          <b>OBD</b>:<br />
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValuesNotMatch" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                           Duplicate DTC                           -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <xsl:for-each select="//ddt:Target/ddt:Devices/ddt:Device">
      <!-- On traite un noeud différent de celui en cours -->
      <xsl:if test="position() &gt; $mPosition">
        <!-- ******************************************** -->
        <!-- Error DE152 : DDT2000_ERR_DeviceDuplicateDTC -->
        <!-- ******************************************** -->
        <xsl:if test="$mDTC = @DTC">
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT2000_ERR_DeviceDuplicateDTC</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDuplicateDTC" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/attributeDTC" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> = <b><xsl:value-of select="$mDTC" /></b><br />
              <br />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> N°1 : <b><xsl:value-of select="$mDeviceName" /></b><br />
              <br />
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> N°2 : <b><xsl:value-of select="@Name" /></b><br />
              <br />
              <b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDuplicateDTC" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              </b>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDevice" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <!--                         Check Device/Test                         -->
    <!-- ***************************************************************** -->
    <!-- ***************************************************************** -->
    <xsl:if test="$mObdStatusNb &gt; 1">
      <!-- ***************************************** -->
      <!-- Error DE198 : DDT2000_ERR_DtcObdFaultType -->
      <!-- ***************************************** -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_DtcObdFaultType</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b>
        </xsl:with-param>
        <xsl:with-param name="info">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoTooManyObdStatus" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:for-each select="ddt:Test">
      <!-- *************************************************************** -->
      <!--                     Check Device/Test/@Type                     -->
      <!-- *************************************************************** -->
      <xsl:variable name="mDeviceTestType" select="@Type"></xsl:variable>
      <!-- ************************************* -->
      <!-- Warning CW020 CPDD_WAR_DeviceTestType -->
      <!-- ************************************* -->
      <xsl:if test="not($mDeviceTestType)">
        <xsl:call-template name="warning">
          <xsl:with-param name="type">CPDD</xsl:with-param>
          <xsl:with-param name="chapter">CPDD_WAR_DeviceTestType</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b><br />
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/typeOfFault" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDevice" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- **************************************** -->
      <!-- Error DE153 : DDT2000_ERR_DeviceTestType -->
      <!-- **************************************** -->
      <xsl:if test="($mDeviceTestType &lt; $mMinDeviceTestType) or ($mDeviceTestType&gt; $mMaxDeviceTestType)">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_DeviceTestType</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/typeOfFault" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> = <b><xsl:value-of select="$mDeviceTestType" /></b>
            (
            <xsl:call-template name="toHex">
              <xsl:with-param name="number"><xsl:value-of select="$mDeviceTestType" /></xsl:with-param>
              <xsl:with-param name="digits">3</xsl:with-param>
              <xsl:with-param name="prefix">$</xsl:with-param>
            </xsl:call-template>
            )<br />
            <b>
            <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang">
              <xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            </b>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>[<xsl:value-of select="$mMinDeviceTestType" />,<xsl:value-of select="$mMaxDeviceTestType" />]</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- *************************************************************** -->
      <!--                      Check Device/Test/@OBD                     -->
      <!-- *************************************************************** -->
      <xsl:variable name="mDeviceTestOBD" select="@OBD"></xsl:variable>
      <xsl:if test="($mObdStatusNb = 1) and ($mDtcValue != $mDeviceTestOBD)">
      <!-- ***************************************** -->
      <!-- Error DE198 : DDT2000_ERR_DtcObdFaultType -->
      <!-- ***************************************** -->
      <xsl:call-template name="error">
        <xsl:with-param name="type">DDT2000</xsl:with-param>
        <xsl:with-param name="chapter">DDT2000_ERR_DtcObdFaultType</xsl:with-param>
        <xsl:with-param name="description">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b>
          <ul>
            <li>Base DTC / OBD : $<b><xsl:value-of select="local:ToHex(string($mDtcValue),4)" /></b></li>
            <li>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desObdStatus" />
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template> : $<b><xsl:value-of select="local:ToHex(string($mDeviceTestOBD),4)" /></b> <br />
            </li>
          </ul>
        </xsl:with-param>
        <xsl:with-param name="info">
          <b>Base DTC</b> / <b>OBD</b>
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/and" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
          <b>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desObdStatus" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </b>:<br />
        
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoValuesNotMatch" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="action">
          <xsl:call-template name="getLocalizedText">
            <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDevice" />
            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  
  
      <!-- ************************************ -->
      <!-- Warning CW021 CPDD_WAR_DeviceTestOBD -->
      <!-- ************************************ -->
      <xsl:if test="not($mDeviceTestOBD)">
        <xsl:call-template name="warning">
          <xsl:with-param name="type">CPDD</xsl:with-param>
          <xsl:with-param name="chapter">CPDD_WAR_DeviceTestOBD</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b><br />
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/typeOfFault" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> = <b><xsl:value-of select="$mDeviceTestType" /></b>
            (
            <xsl:call-template name="toHex">
              <xsl:with-param name="number"><xsl:value-of select="$mDeviceTestType" /></xsl:with-param>
              <xsl:with-param name="digits">3</xsl:with-param>
              <xsl:with-param name="prefix">$</xsl:with-param>
            </xsl:call-template>
            )
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/OBDValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionDevice" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <!-- *************************************** -->
      <!-- Error DE154 : DDT2000_ERR_DeviceTestOBD -->
      <!-- *************************************** -->
      <xsl:if test="($mDeviceTestOBD &lt; $mMinDeviceTestOBD) or ($mDeviceTestOBD &gt; $mMaxDeviceTestOBD)">
        <xsl:call-template name="error">
          <xsl:with-param name="type">DDT2000</xsl:with-param>
          <xsl:with-param name="chapter">DDT2000_ERR_DeviceTestOBD</xsl:with-param>
          <xsl:with-param name="description">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desDevice" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b><xsl:value-of select="$mDeviceName" /></b>
          </xsl:with-param>
          <xsl:with-param name="info">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/OBDValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> = <b><xsl:value-of select="$mDeviceTestOBD" /></b>
            (
            <xsl:call-template name="toHex">
              <xsl:with-param name="number"><xsl:value-of select="$mDeviceTestOBD" /></xsl:with-param>
              <xsl:with-param name="digits">3</xsl:with-param>
              <xsl:with-param name="prefix">$</xsl:with-param>
            </xsl:call-template>
            )<br />
            <b>
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoInvalidValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template>
            </b>
          </xsl:with-param>
          <xsl:with-param name="action">
            <xsl:call-template name="getLocalizedText">
              <xsl:with-param name="lang"><xsl:value-of select="$language"/></xsl:with-param>
              <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoAuthorizedValue" />
              <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
            </xsl:call-template> : <b>[<xsl:value-of select="$mMinDeviceTestOBD" />,<xsl:value-of select="$mMaxDeviceTestOBD" />]</b>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>