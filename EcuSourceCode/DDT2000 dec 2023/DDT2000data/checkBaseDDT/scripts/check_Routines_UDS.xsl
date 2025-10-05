<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions">

  <!-- Remarque : 
      2 templates définis dans ce fichier :
        + Routine_Generic_UDS : 
            - contrôle de la présence (si besoin) et du format de la requête générique 
        + Routine_Specific_UDS : 
            - contrôle que le RID de la requête spécifique est présent dans la donnée contenant la liste des RID
            - contrôle du chevauchement
  -->

  <!-- ************************************** -->
  <!-- ************************************** -->
  <!-- **** TEMPLATE Routine_Generic_UDS **** -->
  <!-- ************************************** -->
  <!-- ************************************** -->
  <!-- ALGORITHME (simplifié) :
          Si le service 'RoutineControl' n'existe pas (test sur le nom, non case sensitive)
            Vérification qu'aucun autre service $31 n'existe
          Sinon
            Vérification de la conformité du service (contrôle des paramètres routineControlType et routineIdentifier
          Fin Si
  -->
  <xsl:template name="Routine_Generic_UDS">
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Routines_UDS.xsl: template Routine_Generic_UDS starts')"/></logmsg>
  
    <!-- Recupération du service générique s'il existe -->
    <xsl:variable name="mRoutineControlGenericService" select="//ddt:Target/ddt:Requests/ddt:Request[local:LowerCase(string(@Name)) = 'routinecontrol']/ddt:Sent[starts-with(ddt:SentBytes,'31')]/.."/>
    <xsl:choose>
      <xsl:when test="string($mRoutineControlGenericService/@Name) = ''">
        <!-- *********************************************************** -->
        <!-- **** LE SERVICE GENERIQUE ROUTINE CONTROL N'EXISTE PAS **** -->
        <!-- *********************************************************** -->
        <!-- Error DE204 : DDT200_ERR_RoutineControlGeneric -->
        <xsl:if test="count(//ddt:Target/ddt:Requests/ddt:Request/ddt:Sent[starts-with(ddt:SentBytes,'31')]) &gt; 0">
          <xsl:call-template name="error">
            <xsl:with-param name="type">DDT2000</xsl:with-param>
            <xsl:with-param name="chapter">DDT200_ERR_RoutineControlGeneric</xsl:with-param>
            <xsl:with-param name="description">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desRequest"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              <b>RoutineControl</b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="info">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoGenericRoutineControlMissing"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="action">
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCopyRequestFromGenericDataBase"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      
      <xsl:otherwise>
        <!-- ***************************************************** -->
        <!-- **** LE SERVICE GENERIQUE ROUTINE CONTROL EXISTE **** -->
        <!-- ***************************************************** -->
        <xsl:variable name="mRoutineControlType" select="$mRoutineControlGenericService/ddt:Sent/ddt:DataItem[local:LowerCase(string(@Name)) = 'routinecontroltype']"/>
        <xsl:variable name="mRoutineIdentifier" select="$mRoutineControlGenericService/ddt:Sent/ddt:DataItem[local:LowerCase(string(@Name)) = 'routineidentifier']"/>
        <xsl:variable name="mRoutineIdentifierList" select="$mRoutineControlGenericService/ddt:Sent/ddt:DataItem[local:LowerCase(string(@Name)) = 'routineidentifierlist']"/>

        <!-- ===================================================== -->
        <!-- ==== Vérification du DataItem RoutineControlType ==== -->
        <!-- ===================================================== -->
        <xsl:choose>
          <xsl:when test="string($mRoutineControlType/@Name) = ''">
            <!-- Error DE205 : DDT200_ERR_RoutineControlType (La donnée n'existe pas) -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT200_ERR_RoutineControlType</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b>RoutineControlType</b>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoRoutineControlTypeMissing"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRoutineControlTypeMissing"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- La donnée existe, contrôle de son format / position -->
            <xsl:variable name="mRoutineControlTypeData" select="//ddt:Target/ddt:Datas/ddt:Data[@Name = string($mRoutineControlType/@Name)]"/>

            <!-- Contrôle de la valeur FirstByte -->
            <xsl:if test="$mRoutineControlType/@FirstByte != 2">
              <!-- Error DE205 : DDT200_ERR_RoutineControlType (FirstByte invalide) -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT200_ERR_RoutineControlType</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$mRoutineControlType/@Name"/></b>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFirstByte"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$mRoutineControlType/@FirstByte"/></b>
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b>2</b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>

            <!-- Contrôle de la valeur BitOffset -->
            <xsl:if test="($mRoutineControlType/@BitOffset) and ($mRoutineControlType/@BitOffset &gt; 0)">
              <!-- Error DE205 : DDT200_ERR_RoutineControlType (BitOffset invalide) -->
              <xsl:call-template name="error">
                <xsl:with-param name="type">DDT2000</xsl:with-param>
                <xsl:with-param name="chapter">DDT200_ERR_RoutineControlType</xsl:with-param>
                <xsl:with-param name="description">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$mRoutineControlType/@Name"/></b>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidBitOffset"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="info">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b><xsl:value-of select="$mRoutineControlType/@BitOffset"/></b>
                  <br/>
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                  <b>0</b>
                </xsl:with-param>
                <xsl:with-param name="action">
                  <xsl:call-template name="getLocalizedText">
                    <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                    <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
            
            <xsl:choose>
              <!-- Contrôle que la donnée n'est pas de type "non numérique" -->
              <xsl:when test="$mRoutineControlTypeData/ddt:Bytes">
                <!-- Error DE205 : DDT200_ERR_RoutineControlType (Donnée de type "non numérique" et non "liste numérique") -->
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DDT2000</xsl:with-param>
                  <xsl:with-param name="chapter">DDT200_ERR_RoutineControlType</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mRoutineControlTypeData/@Name"/></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFormat"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedFormat"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNotNumeric"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </b>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedFormat"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumericList"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectFormat"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>

              <!-- Contrôle que la donnée n'est pas de type "numérique" -->
              <xsl:when test="$mRoutineControlTypeData/ddt:Bits/ddt:Scaled">
                <!-- Error DE205 : DDT200_ERR_RoutineControlType (Donnée de type "numérique" et non "liste numérique") -->
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DDT2000</xsl:with-param>
                  <xsl:with-param name="chapter">DDT200_ERR_RoutineControlType</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mRoutineControlTypeData/@Name"/></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFormat"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedFormat"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumeric"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </b>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedFormat"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumericList"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectFormat"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>

              <xsl:otherwise>
                <!-- La donnée est bien de type "Liste numérique" -->
                <xsl:variable name="mItemNumber" select="count($mRoutineControlTypeData/ddt:Bits/ddt:List/ddt:Item)"/>
                
                <!-- Contrôle de la taille (count) -->
                <xsl:if test="($mRoutineControlTypeData/ddt:Bits/@count) and ($mRoutineControlTypeData/ddt:Bits/@count != 8)">
                  <!-- Error DE205 : DDT200_ERR_RoutineControlType (taille différente de 8 bits) -->
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">DDT2000</xsl:with-param>
                    <xsl:with-param name="chapter">DDT200_ERR_RoutineControlType</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineControlTypeData/@Name"/></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidLenght"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineControlTypeData/ddt:Bits/@count"/></b> bit(s).
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>8</b> bits.
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>

                <!-- Contrôle que 2 items soient au minimum définis (Start et Stop par exemple) -->
                <xsl:if test="$mItemNumber &lt;= 2">
                  <!-- Error DE205 : DDT200_ERR_RoutineControlType (nombre d'item insuffisant) -->
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">DDT2000</xsl:with-param>
                    <xsl:with-param name="chapter">DDT200_ERR_RoutineControlType</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineControlTypeData/@Name"/></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desNumericListDataMissingItem"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mItemNumber"/></b>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>&gt;= 2</b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNumericListAddItem"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExampleStartStop"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>  <!-- Fin du contrôle du DataItem RoutineControlType --> 

        <!-- ================================================================================ -->
        <!-- ==== Vérification du DataItem RoutineIdentifierList et/ou RoutineIdentifier ==== -->
        <!-- ================================================================================ -->
        <!-- ALGORITHME :
                Si RoutineIdentifier ET RoutineIdentifierList n'existe pas
                    Alors ERR DDT
                Sinon
                  Si RoutineIdentifierList existe
                    Contrôle RoutineIdentifierList et ERR DDT si non conforme
                  Fin Si
                  Si RoutineIdentifier n'existe pas
                    ERR DAI
                    WAR DDT
                  Sinon
                    Contrôle RoutineIdentifier et ERR DDT/DAI si non conforme
                  Fin Si
                Fin Si
        -->
        <xsl:choose>
          <!-- RoutineIdentifier ET RoutineIdentifierList n'existe pas --> 
          <xsl:when test="(string($mRoutineIdentifier/@Name) = '') and (string($mRoutineIdentifierList/@Name) = '')">
            <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (Aucune des 2 données RoutineIdentifier et/ou RoutineIdentifierList n'existe) -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="$mRoutineIdentifier/@Name"/></b>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <br/>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="$mRoutineIdentifierList/@Name"/></b>
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="info">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoRoutineIdentifiersMissing"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRoutineIdentifiersMissing"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- Contrôle RoutineIdentifierList si il existe -->
            <xsl:if test="string($mRoutineIdentifierList/@Name) != ''">
              <xsl:variable name="mRoutineIdentifierListData" select="//ddt:Target/ddt:Datas/ddt:Data[@Name = string($mRoutineIdentifierList/@Name)]"/>

              <!-- Contrôle de la valeur FirstByte -->
              <xsl:if test="$mRoutineIdentifierList/@FirstByte != 3">
                <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (FirstByte invalide) -->
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DDT2000</xsl:with-param>
                  <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mRoutineIdentifierList/@Name"/></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFirstByte"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mRoutineIdentifierList/@FirstByte"/></b>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>3</b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:if>
              
              <!-- Contrôle de la valeur BitOffset -->
              <xsl:if test="($mRoutineIdentifierList/@BitOffset) and ($mRoutineIdentifierList/@BitOffset &gt; 0)">
                <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (BitOffset invalide) -->
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DDT2000</xsl:with-param>
                  <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mRoutineIdentifierList/@Name"/></b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidBitOffset"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b><xsl:value-of select="$mRoutineIdentifierList/@BitOffset"/></b>
                    <br/>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>0</b>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:if>

              <xsl:choose>
                <!-- Contrôle que la donnée n'est pas de type "non numérique" -->
                <xsl:when test="$mRoutineIdentifierListData/ddt:Bytes">
                  <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (Donnée de type "non numérique" et non "liste numérique") -->
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">DDT2000</xsl:with-param>
                    <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineIdentifierListData/@Name"/></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFormat"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedFormat"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNotNumeric"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </b>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedFormat"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumericList"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectFormat"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:when>

                <!-- Contrôle que la donnée n'est pas de type "numérique" -->
                <xsl:when test="$mRoutineIdentifierListData/ddt:Bits/ddt:Scaled">
                  <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (Donnée de type "numérique" et non "liste numérique") -->
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">DDT2000</xsl:with-param>
                    <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineIdentifierListData/@Name"/></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFormat"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedFormat"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumeric"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </b>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedFormat"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumericList"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectFormat"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:when>
                
                <xsl:otherwise>
                  <!-- La donnée est bien de type "Liste numérique" -->
                  <xsl:variable name="mItemNumber" select="count($mRoutineIdentifierListData/ddt:Bits/ddt:List/ddt:Item)"/>
                  
                  <!-- Contrôle de la taille (count) -->
                  <xsl:if test="($mRoutineIdentifierListData/ddt:Bits/@count) and ($mRoutineIdentifierListData/ddt:Bits/@count != 16)">
                    <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (taille différente de 16 bits) -->
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DDT2000</xsl:with-param>
                      <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b><xsl:value-of select="$mRoutineIdentifierListData/@Name"/></b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidLenght"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                      <xsl:with-param name="info">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b><xsl:value-of select="$mRoutineIdentifierListData/ddt:Bits/@count"/></b> bit(s).
                        <br/>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b>16</b> bits.
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>
                  
                  <!-- Contrôle qu'au moins 1 item est au minimum définis  -->
                  <xsl:if test="$mItemNumber &lt; 1">
                    <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (nombre d'item insuffisant) -->
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DDT2000</xsl:with-param>
                      <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b><xsl:value-of select="$mRoutineIdentifierListData/@Name"/></b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desNumericListDataMissingItem"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                      <xsl:with-param name="info">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b><xsl:value-of select="$mItemNumber"/></b>
                        <br/>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b>&gt;= 1</b>
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNumericListAddItem"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <br/>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExampleStartStop"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if> <!-- Fin du contrôle RoutineIdentifierList -->
            
            <!-- Contrôle RoutineIdentifier s'il existe  -->
            <xsl:choose>
              <xsl:when test="string($mRoutineIdentifier/@Name) = ''">
                <!-- Error ME020 : DAIMLER_ERR_RoutineIdentifierMissing (La donnée n'existe pas) -->
                <xsl:call-template name="error">
                  <xsl:with-param name="type">DAIMLER</xsl:with-param>
                  <xsl:with-param name="chapter">DAIMLER_ERR_RoutineIdentifierMissing</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>RoutineIdentifier</b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoRoutineIdentifierMustHave"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRoutineIdentifiersMissing"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
                <!-- Warning DW194 : DDT2000_WAR_RoutineIdentifierMissing (La donnée n'existe pas) -->
                <xsl:call-template name="warning">
                  <xsl:with-param name="type">DDT2000</xsl:with-param>
                  <xsl:with-param name="chapter">DDT2000_WAR_RoutineIdentifierMissing</xsl:with-param>
                  <xsl:with-param name="description">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                    <b>RoutineIdentifier</b>
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoIsMissing"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="info">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoRoutineIdentifierShouldHave"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="action">
                    <xsl:call-template name="getLocalizedText">
                      <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                      <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionRoutineIdentifiersMissing"></xsl:with-param>
                      <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>

              <xsl:otherwise>
                <xsl:variable name="mRoutineIdentifierData" select="//ddt:Target/ddt:Datas/ddt:Data[@Name = string($mRoutineIdentifier/@Name)]"/>

                <!-- Contrôle de la valeur FirstByte -->
                <xsl:if test="$mRoutineIdentifier/@FirstByte != 3">
                  <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (FirstByte invalide) -->
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">DDT2000</xsl:with-param>
                    <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineIdentifier/@Name"/></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFirstByte"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineIdentifier/@FirstByte"/></b>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>3</b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>
                
                <!-- Contrôle de la valeur BitOffset -->
                <xsl:if test="($mRoutineIdentifier/@BitOffset) and ($mRoutineIdentifier/@BitOffset &gt; 0)">
                  <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (BitOffset invalide) -->
                  <xsl:call-template name="error">
                    <xsl:with-param name="type">DDT2000</xsl:with-param>
                    <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                    <xsl:with-param name="description">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineIdentifier/@Name"/></b>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidBitOffset"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="info">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b><xsl:value-of select="$mRoutineIdentifier/@BitOffset"/></b>
                      <br/>
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                      <b>0</b>
                    </xsl:with-param>
                    <xsl:with-param name="action">
                      <xsl:call-template name="getLocalizedText">
                        <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                        <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                        <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:if>

                <xsl:choose>
                  <!-- Contrôle que la donnée n'est pas de type "non numérique" -->
                  <xsl:when test="$mRoutineIdentifierData/ddt:Bytes">
                    <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (Donnée de type "non numérique" et non "liste numérique") -->
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DDT2000</xsl:with-param>
                      <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b><xsl:value-of select="$mRoutineIdentifierData/@Name"/></b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFormat"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                      <xsl:with-param name="info">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedFormat"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNotNumeric"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                        </b>
                        <br/>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedFormat"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumericList"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                        </b>
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectFormat"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>

                  <!-- Contrôle que la donnée n'est pas de type "numérique" -->
                  <xsl:when test="$mRoutineIdentifierData/ddt:Bits/ddt:Scaled">
                    <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (Donnée de type "numérique" et non "liste numérique") -->
                    <xsl:call-template name="error">
                      <xsl:with-param name="type">DDT2000</xsl:with-param>
                      <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                      <xsl:with-param name="description">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b><xsl:value-of select="$mRoutineIdentifierData/@Name"/></b>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidFormat"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                      <xsl:with-param name="info">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedFormat"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumeric"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                        </b>
                        <br/>
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedFormat"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                        <b>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/dataFormatNumericList"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                        </b>
                      </xsl:with-param>
                      <xsl:with-param name="action">
                        <xsl:call-template name="getLocalizedText">
                          <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                          <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectFormat"></xsl:with-param>
                          <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                        </xsl:call-template>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                  
                  <xsl:otherwise>
                    <!-- La donnée est bien de type "Liste numérique" -->
                    <xsl:variable name="mItemNumber" select="count($mRoutineIdentifierData/ddt:Bits/ddt:List/ddt:Item)"/>
                    
                    <!-- Contrôle de la taille (count) -->
                    <xsl:if test="($mRoutineIdentifierData/ddt:Bits/@count) and ($mRoutineIdentifierData/ddt:Bits/@count != 16)">
                      <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (taille différente de 16 bits) -->
                      <xsl:call-template name="error">
                        <xsl:with-param name="type">DDT2000</xsl:with-param>
                        <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                        <xsl:with-param name="description">
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                          <b><xsl:value-of select="$mRoutineIdentifierData/@Name"/></b>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoHasInvalidLenght"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                        </xsl:with-param>
                        <xsl:with-param name="info">
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                          <b><xsl:value-of select="$mRoutineIdentifierData/ddt:Bits/@count"/></b> bit(s).
                          <br/>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                          <b>16</b> bits.
                        </xsl:with-param>
                        <xsl:with-param name="action">
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionCorrectValue"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                        </xsl:with-param>
                      </xsl:call-template>
                    </xsl:if>
                    
                    <!-- Contrôle qu'au moins 1 item est au minimum définis  -->
                    <xsl:if test="$mItemNumber &lt; 1">
                      <!-- Error DE206 : DDT200_ERR_RoutineIdentifier (nombre d'item insuffisant) -->
                      <xsl:call-template name="error">
                        <xsl:with-param name="type">DDT2000</xsl:with-param>
                        <xsl:with-param name="chapter">DDT200_ERR_RoutineIdentifier</xsl:with-param>
                        <xsl:with-param name="description">
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desData"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                          <b><xsl:value-of select="$mRoutineIdentifierData/@Name"/></b>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/desNumericListDataMissingItem"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                        </xsl:with-param>
                        <xsl:with-param name="info">
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoDefinedValue"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                          <b><xsl:value-of select="$mItemNumber"/></b>
                          <br/>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoExpectedValue"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                          <b>&gt;= 1</b>
                        </xsl:with-param>
                        <xsl:with-param name="action">
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionNumericListAddItem"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                          <br/>
                          <xsl:call-template name="getLocalizedText">
                            <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                            <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionExampleStartStop"></xsl:with-param>
                            <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                          </xsl:call-template>
                        </xsl:with-param>
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose> <!-- Fin du contrôle du DataItem RoutineIdentifier -->
          </xsl:otherwise>
        </xsl:choose> <!-- Fin Vérification du DataItem RoutineIdentifierList et/ou RoutineIdentifier --> 
      </xsl:otherwise>
    </xsl:choose>
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Routines_UDS.xsl: template Routine_Generic_UDS ends')"/></logmsg>
  </xsl:template>
  

  <!-- *************************************** -->
  <!-- *************************************** -->
  <!-- **** TEMPLATE Routine_Specific_UDS **** -->
  <!-- *************************************** -->
  <!-- *************************************** -->
  <xsl:template name="Routine_Specific_UDS">
    <xsl:param name="request" />

    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Routines_UDS.xsl: template Routine_Specific_UDS starts')"/></logmsg>
    
    <xsl:variable name="RID" select="substring($request/ddt:Sent/ddt:SentBytes, 5, 4)"/>
    <!-- Récupération des DataItem RoutineIdentifier et RoutineIdentifierList depuis le service générique RoutineControl -->
    <xsl:variable name="mRoutineIdentifierDataItem" select="//ddt:Target/ddt:Requests/ddt:Request[local:LowerCase(string(@Name)) = 'routinecontrol']/ddt:Sent/ddt:DataItem[local:LowerCase(string(@Name)) = 'routineidentifier']"/>
    <xsl:variable name="mRoutineIdentifierListDataItem" select="//ddt:Target/ddt:Requests/ddt:Request[local:LowerCase(string(@Name)) = 'routinecontrol']/ddt:Sent/ddt:DataItem[local:LowerCase(string(@Name)) = 'routineidentifierlist']"/>

    <xsl:variable name="mIsMaintainabilityReport">
      <xsl:choose>
        <xsl:when test="$request/DossierMaintenabilite">
          <xsl:text>true</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>false</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <xsl:if test="$RID != '0000'">
      <!-- Vérification de la presence du RID dans la donnée RoutineIdentifier (si la donnée est utilisée par le service générique) -->
      <xsl:if test="$mRoutineIdentifierDataItem/@Name != ''">
        <xsl:variable name="mRoutineIdentifierData" select="//ddt:Target/ddt:Datas/ddt:Data[string(@Name) = string($mRoutineIdentifierDataItem/@Name)]"/>
        <xsl:if test="($mRoutineIdentifierData/@Name != '') and ($mRoutineIdentifierData/ddt:Bits/ddt:List)">
          <xsl:if test="count($mRoutineIdentifierData/ddt:Bits/ddt:List/ddt:Item[@Value = local:ToDec($RID)]) = 0">
            <!-- Error DE207 : DDT200_ERR_RoutineControlMissingRID (RID manquant dans RoutineIdentifier) -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT200_ERR_RoutineControlMissingRID</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="$request/@Name"/></b>
                <br/>
                $<b><xsl:value-of select="$request/ddt:Sent/ddt:SentBytes"/></b>
              </xsl:with-param>
              <xsl:with-param name="info">
              RID $<b><xsl:value-of select="$RID"/></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoRoutineControlIdentifierMissingID"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddRidToRoutineIdentifier"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
      </xsl:if>
      
      <!-- Vérification de la presence du RID dans la donnée RoutineIdentifierList (si la donnée est utilisée par le service générique) -->
      <xsl:if test="$mRoutineIdentifierListDataItem/@Name != ''">
        <xsl:variable name="mRoutineIdentifierListData" select="//ddt:Target/ddt:Datas/ddt:Data[string(@Name) = string($mRoutineIdentifierListDataItem/@Name)]"/>
        <xsl:if test="($mRoutineIdentifierListData/@Name != '') and ($mRoutineIdentifierListData/ddt:Bits/ddt:List)">
          <xsl:if test="count($mRoutineIdentifierListData/ddt:Bits/ddt:List/ddt:Item[@Value = local:ToDec($RID)]) = 0">
            <!-- Error DE207 : DDT200_ERR_RoutineControlMissingRID (RID manquant dans RoutineIdentifier) -->
            <xsl:call-template name="error">
              <xsl:with-param name="type">DDT2000</xsl:with-param>
              <xsl:with-param name="chapter">DDT200_ERR_RoutineControlMissingRID</xsl:with-param>
              <xsl:with-param name="description">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/requests"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
                <b><xsl:value-of select="$request/@Name"/></b>
                <br/>
                $<b><xsl:value-of select="$request/ddt:Sent/ddt:SentBytes"/></b>
              </xsl:with-param>
              <xsl:with-param name="info">
              RID $<b><xsl:value-of select="$RID"/></b>
              <xsl:call-template name="getLocalizedText">
                <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                <xsl:with-param name="aNode" select="document('Translate.xml')/translation/infoRoutineControlIdentifierListMissingID"></xsl:with-param>
                <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
              </xsl:call-template>
              </xsl:with-param>
              <xsl:with-param name="action">
                <xsl:call-template name="getLocalizedText">
                  <xsl:with-param name="lang"><xsl:value-of select="$language"></xsl:value-of></xsl:with-param>
                  <xsl:with-param name="aNode" select="document('Translate.xml')/translation/actionAddRidToRoutineIdentifierList"></xsl:with-param>
                  <xsl:with-param name="defaultText">*non trouvé*</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
      </xsl:if>

      <!-- ***************************************** -->
      <!-- Error AE011 : ALLIANCE_ERR_RequestOverlap -->
      <!-- Error ME023 : DAIMLER_ERR_RequestOverlap  -->
      <!-- ***************************************** -->
      <!-- Vérification overlapping -->
      <for-each select="$request/ddt:Sent/ddt:DataItem">
        <xsl:call-template name="Overlap_Request">
          <xsl:with-param name="serviceName" select="$request/@Name"/>
          <xsl:with-param name="isMaintainabilityReport" select="$mIsMaintainabilityReport"/>
          <xsl:with-param name="currentFrame" select=".."/>
          <xsl:with-param name="currentDataItem" select="."/>
        </xsl:call-template>
      </for-each>
    </xsl:if>
    <logmsg><xsl:value-of select="local:AddMessage($logFileName, 'check_Routines_UDS.xsl: template Routine_Specific_UDS ends')"/></logmsg>
  </xsl:template>
</xsl:stylesheet>