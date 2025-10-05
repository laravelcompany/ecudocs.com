'2154  Read_A_AC_Learning_BCM_Input/Output
'        IMMO_STATUS_CID_PAIRING_SA_UNLOCKED
'
'
'2157  Read_A_AC_General_Identifiers_Learning_Status_(bits)_BCM_Input/Output
'        BCM_IS_BLANK_S
'        VSC Status Bin Présence
'
'
'2158  Read_General_Identifiers_Learning_Status_(bytes)_BCM_Input/Output
'        VSC Code_IDE
'        IMMO_NB_CID_PAIRED_S
'
'
'2168  Read_Feature_Activ._Logic_BCM_Input/Output_Status
'        ALIM_NIVEAU_3_CS :
'


' ===============================================================
' Diagnostic related functions for script
'
' ===============================================================
Option explicit

Const ECUS_ROOT_URL = "c:\ddt2000data\ecus\"

Const ECU_BCM  = 0
Const ECU_BCM_ADDR  = &h26

Const REQ_3E   = 0
Const REQ_2154 = 1
Const REQ_2157 = 2
Const REQ_2158 = 3
Const REQ_2168 = 4

Const REQ_310A00 = 5
Const REQ_310A01 = 6

Const REQ_310B0000 = 7
Const REQ_310B01   = 8

Const REQ_2711 = 9
Const REQ_2712 = 10

Const STATUS_NOT_STARTED  = 0
Const STATUS_IN_PROGRESS  = 1
Const STATUS_OK           = 2

dim abortDiagnostic

dim converter
dim diagContext '/* diag context object */
dim diagSession '/* diag session object */
dim pECUS(0)    '/* array of ECU protocol objects */
dim req(0,20)   '/* array request for each ECU */

dim reqRefreshData

Dim Idents(3)

function diagInitScript()
	dim i
	on error resume next
	set diagContext = CreateObject("DiagnosticContext.Context")
	'if diagContext.object Is Nothing then
		'diagContext.abandon
		diagRefreshDataSetLabels

		' -------------------------------------------
		' Backward compatibility code
		' -------------------------------------------
		set converter = CreateObject("DDT2000Helper.Converter")
		if err then
			err.clear
			set converter = CreateObject("DDT2000HelperV2.Converter")
			if err then
				err.clear
				showWarning "CreateObject DDT2000HelperV2.Converter failed", "color:red"
				diagInitScript = false
				exit function
			end if
		end if

		set diagSession = CreateObject("KWP2000Diag3.DiagSession")
		if err then
			err.clear
			set diagSession = CreateObject("KWP2000Diag4.DiagSession")
			if err then
				err.clear
				showWarning "CreateObject KWP2000Diag4.DiagSession failed", "color:red"
				diagInitScript = false
				exit function
			end if
		end if
		
		' -------------------------------------------
		' End of backward compatibility code
		' -------------------------------------------

		set diagSession = diagContext.Object

		'diagSession.lang = "fr"   ' display message in french

		diagSession.commport = diagSession.defaultPort

		'diagSession.AddProtocols "c:\ddt2000data\ecus\CAN_500_kbds.xml"
		diagSession.AddProtocols extractLocationPath(location.pathname) & "CAN_500_kbds.xml"
		'diagSession.AddProtocols ECUS_ROOT_URL & "Clim_X84_SERIE.xml"
		'diagSession.AddProtocols ECUS_ROOT_URL & "BCMX95_4_2_b.xml"
		'diagSession.AddProtocols "C:\temp\html\ddt2000\script\BCMX95_4_2_f_script.xml"
		'diagSession.AddProtocols "C:\Mes documents\Bribri2\script\BCMX95_4_2_f_script.xml"
		diagSession.AddProtocols extractLocationPath(location.pathname) & "BCMX95_4_2_f_script.xml"

		' ------------------------------------
		' Define diag protocols for each ECUs
		' ------------------------------------
		set pECUS(ECU_BCM) = converter.ToDiagProtocol(diagSession.GetProtocolByAddress(ECU_BCM_ADDR))
		if pECUS(ECU_BCM) is nothing then
			showWarning "ECU not found", "color:red"
			diagInitScript = false
		else
			showWarning "ECU found", ""

			' ------------------------------------
			' Requests definitions for further use
			' ------------------------------------
			set req(ECU_BCM,REQ_3E)       = pECUS(ECU_BCM)("TesterPresent.WithResponse")
			set req(ECU_BCM,REQ_2154)     = pECUS(ECU_BCM)("Read_A_AC_Learning_BCM_Input/Output")
			set req(ECU_BCM,REQ_2157)     = pECUS(ECU_BCM)("Read_A_AC_General_Identifiers_Learning_Status_(bits)_BCM_Input/Output")
			set req(ECU_BCM,REQ_2158)     = pECUS(ECU_BCM)("Read_General_Identifiers_Learning_Status_(bytes)_BCM_Input/Output")
			set req(ECU_BCM,REQ_2168)     = pECUS(ECU_BCM)("Read_Feature_Activ._Logic_BCM_Input/Output_Status")
			set req(ECU_BCM,REQ_310A00)   = pECUS(ECU_BCM)("SR_ANALYSE_CUSTOMER_ID")
			set req(ECU_BCM,REQ_310A01)   = pECUS(ECU_BCM)("SR_ANALYSE_CUSTOMER_ID_Status")
			set req(ECU_BCM,REQ_310B0000) = pECUS(ECU_BCM)("SR_CID_PAIRING_AFTER_SALES")
			set req(ECU_BCM,REQ_310B01)   = pECUS(ECU_BCM)("SR_CID_PAIRING_AFTER_SALES_Status")
			set req(ECU_BCM,REQ_2711)     = pECUS(ECU_BCM)("SA_Request_Seed_After_Sales_CID_Pairing")
			set req(ECU_BCM,REQ_2712)     = pECUS(ECU_BCM)("SA_Send_Key_After_Sales_CID_Pairing")

			diagRefreshDataSetLabels
			for i = 1 to 28
				setDisplayDataValue "var" & trim(i), "n/a"
			next

			diagInitScript = true
		end if
	'end if
end function

function diagStartDiagSession()
	on error resume next
	if abortDiagnostic then exit function
	pECUS(ECU_BCM).init
	if err <> 0 then
		showWarning "Init failed - " & err.description, "color:red"
		diagStartDiagSession = false
		err.clear
	else
		showWarning "Init success", ""
		diagStartDiagSession = true
	end if
end function

function diagStopDiagSession()
	on error resume next
	if abortDiagnosticAsked() then exit function
	pECUS(ECU_BCM).init
	if (err <> 0) then
		showWarning "Init failed - " & err.description, "color:red"
		diagStartDiagSession = false
		err.clear
	else
		showWarning "Init success", ""
		diagStartDiagSession = true
	end if
	if abortDiagnosticAsked() then exit function
end function

function diagPhysicalTesterPresent()
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_3E).send
	if abortDiagnosticAsked() then exit function
	if err then err.clear
end function

function diagRoutineCardAnalyzingStart()
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_310A00).send
	diagRoutineCardAnalyzingStart = req(ECU_BCM,REQ_310A00)("RoutineEntryStatus").Value
	if abortDiagnosticAsked() then exit function
end function

function diagRoutineCardAnalyzing()
	dim v
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_310A00).send
	v = req(ECU_BCM,REQ_310A00)("RoutineEntryStatus").Value
	v = STATUS_IN_PROGRESS
	do while (v = STATUS_IN_PROGRESS)
		req(ECU_BCM,REQ_310A01).send
		v = req(ECU_BCM,REQ_310A01)("RoutineEntryStatus").Value
		if abortDiagnosticAsked() then exit function
	loop
	if (v = STATUS_OK) then
		diagRoutineCardAnalyzing = true
	else
		diagRoutineCardAnalyzing = false
	end if
	if abortDiagnosticAsked() then exit function
end function

function diagRoutineCardPairingStart()
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_310B0000).Item("VSC_ValetIDLearning").Value = 0
	req(ECU_BCM,REQ_310B0000).Send
	if (err <> 0) then
		szLastErrorMessage = err.description
		err.clear
	end if
	diagRoutineCardPairingStart = req(ECU_BCM,REQ_310B0000)("RoutineEntryStatus").Value
	if err then err.clear
	if abortDiagnosticAsked() then exit function
end function
function diagRoutineValetCardPairingStart()
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_310B0000).Item("VSC_ValetIDLearning").Value = 1
	req(ECU_BCM,REQ_310B0000).Send
	if (err <> 0) then
		szLastErrorMessage = err.description
	end if
	diagRoutineValetCardPairingStart = req(ECU_BCM,REQ_310B0000)("RoutineEntryStatus").Value
	if err then err.clear
	if abortDiagnosticAsked() then exit function
end function
function diagRoutineCardPairingStatus()
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_310B01).Send
	if (err <> 0) then
		szLastErrorMessage = err.description
	else
		szLastErrorMessage = req(ECU_BCM,REQ_310B01)("RoutineEntryStatus").Text & " (" & req(ECU_BCM,REQ_310B01)("RoutineEntryStatus").Value & ")"
	end if
	diagRoutineCardPairingStatus = req(ECU_BCM,REQ_310B01)("RoutineEntryStatus").Value
	if err then err.clear
	if abortDiagnosticAsked() then exit function
end function

function diagIsBlankBCM()
	dim v
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_2157).send
	v = req(ECU_BCM,1)("BCM_IS_BLANK_S").Value
	if (v = 0) then
		BCM_IS_BLANK_S = false
	else
		BCM_IS_BLANK_S = true
	end if
	if abortDiagnosticAsked() then exit function
end function

function diagIsBlankCard()
	dim v
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_2157).Send
	v = Clng(req(ECU_BCM,REQ_2157)("VSC Status Bin Présence").Value)
	if (v and 64) then
		diagIsBlankCard = true
	else
		diagIsBlankCard = false
	end if
	if abortDiagnosticAsked() then exit function
end function

function diagCardPresent()
	dim v
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_2157).Send
	v = req(ECU_BCM,REQ_2157)("VSC Status Bin Présence").Value
	if (v and 80) then
		diagCardPresent = true
	else
		diagCardPresent = false
	end if
	if abortDiagnosticAsked() then exit function
end function

function diagReadCardIdentification()
	dim v
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_2158).Send
	v = req(ECU_BCM,REQ_2158)("VSC Code_IDE").Text
	Idents(nbBlankCards) = v
'window.status = "Ident carte: " + v
	diagReadCardIdentification = true
	if abortDiagnosticAsked() then exit function
end function

function diagAPCoff()
	dim v
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_2168).Send
	v = req(ECU_BCM,REQ_2168)("ALIM_NIVEAU_3_CS").Value
	if (v = 1) then
		diagAPCoff = true
	else
		diagAPCoff = false
	end if
	if abortDiagnosticAsked() then exit function
end function

function diagSendSA11()
	dim v
	dim s
	dim i
	on error resume next
	if abortDiagnosticAsked() then exit function
	if (nbBlankCards > 0) then
		s = ""
		for i = 1 to (nbBlankCards)
			s = s & Idents(i)
		next
	end if
	s = s & "0000000000000000"
	s = Left(s, 16)
'window.status =  "Debug: PARAMETER_CID_PAIRING = " & s ' for debug
	req(ECU_BCM,REQ_2711).Item("PARAMETER_CID_PAIRING").Text = s
	req(ECU_BCM,REQ_2711).Send

	v = req(ECU_BCM,REQ_2711)("IMMO_BCM_SEED").Text
	if (err = 0) then
		setDisplayDataValue "BCMdata", "6711" & v
	else
		setDisplayDataValue "BCMdata", err.description
		err.clear
	end if
	diagSendSA11 = true
	if abortDiagnosticAsked() then exit function
end function

function diagSendSA12()
	dim s
	if abortDiagnosticAsked() then exit function
	s = getUserObject("SERVERdata").Value
'window.status = "Debug: SERVERdata = (" & len(s) & ")" & s
	on error resume next
	req(ECU_BCM,REQ_2712).Item("SERVER ANSWER").Text = Left(s, 32)
	req(ECU_BCM,REQ_2712).Send
	if (err = 0) then
		diagSendSA12 = true
	else
		diagSendSA12 = false
		szLastErrorMessage = err.description
window.status = "SA12 error: " & err.description
		err.clear
	end if
	if abortDiagnosticAsked() then exit function
end function

function diagRefreshDataSetLabels()

	setInnerHTMLEx "labelVar1" , "ST_CID_SA_EXIT"      , "IMMO_STATUS_CID_SA_EXIT"
	setInnerHTMLEx "labelVar2" , "STATE_SA"            , "IMMO_STATE_SA"
	setInnerHTMLEx "labelVar3" , "SENDKEY_CTRL_NOK"    , "IMMO_FLAG_SENDKEY_CONTENT_CONTROL_NOK"
	setInnerHTMLEx "labelVar4" , "ANTI_SCANNING"       , "IMMO_FLAG_ANTI_SCANNING_LAUNCHED_S"
	setInnerHTMLEx "labelVar5" , "NB_APV_PAIRING"      , "IMMO_COUNTER_AFTER_SALES_PAIRING_S"
	setInnerHTMLEx "labelVar6" , "SA_PAIRING_TYPE"     , "IMMO_STATUS_SA_PAIRING_TYPE"
	setInnerHTMLEx "labelVar29", "SA_UNLOCKED_CID"     , "IMMO_STATUS_CID_PAIRING_SA_UNLOCKED"
	setInnerHTMLEx "labelVar28", "IN CUSTOMER MODE"    , "IMMO_FLAG_CUSTOMER_MODE_LAUNCHED"

	setInnerHTMLEx "labelVar15", "Blank BCM"          , "BCM_IS_BLANK_S"
	setInnerHTMLEx "labelVar16", "NB_CID_PAIRED"      , "IMMO_NB_CID_PAIRED_S"
	setInnerHTMLEx "labelVar7" , "Last Config Error"  , "Get_last_Configuration_Error"
	setInnerHTMLEx "labelVar8" , "Learning_Step"      , "VSC_Learning_Step"
	setInnerHTMLEx "labelVar9" , "NbBadge_SC2_Appris" , "VSC NbTotalDeBadge_SC2_Appris"
	setInnerHTMLEx "labelVar10", "NbBadge_868_Appris" , "VSC NbTotalDeBadge_868_Appris"
	setInnerHTMLEx "labelVar11", "NbBadge_433_Appris" , "VSC NbTotalDeBadge_433_Appris"
	setInnerHTMLEx "labelVar12", "NbBadge_315_Appris" , "VSC NbTotalDeBadge_315_Appris"
	setInnerHTMLEx "labelVar13", "NbBadge_315R_Appris", "VSC NbTotalDeBadge_315R_Appris"
	setInnerHTMLEx "labelVar14", "VSC_Servant_ID"     , "VSC_Servant_ID"

	setInnerHTMLEx "labelVar17" , "Badge_SC1"             , "VSC Badge_SC1"
	setInnerHTMLEx "labelVar18" , "Badge_SC2"             , "VSC Badge_SC2"
	setInnerHTMLEx "labelVar19" , "BadgeFreq_433"         , "VSC BadgeFreq_433"
	setInnerHTMLEx "labelVar20" , "BadgeFreq_315N"        , "VSC BadgeFreq_315N"
	setInnerHTMLEx "labelVar21" , "BadgeFreq_315R"        , "VSC BadgeFreq_315R"
	setInnerHTMLEx "labelVar22" , "Status_d'Authent"      , "VSC Status_d'Authent"
	setInnerHTMLEx "labelVar23" , "PP_BadgeDéjaAppris"    , "VSC_PP_BadgeDéjaAppris"
	setInnerHTMLEx "labelVar24" , "IDE_reçu_TRP"          , "VSC IDE_reçu_par_tranpondeur"
	setInnerHTMLEx "labelVar25" , "IDE_Valid_reçu"        , "VSC IDE_Valid_reçu_par_transpondeur_1"
	setInnerHTMLEx "labelVar26" , "PSW_ReçuDernièreAuth"  , "VSC PSW_ReçuSurDernièreAuthent"
	setInnerHTMLEx "labelVar27" , "PSW_ValidDernièreAuth" , "VSC PSW_ValidSurDernièreAuthent"

end function

function diagRefreshData()
	dim value
	on error resume next
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_2154).send
	if err then err.clear
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_2157).send
	if err then err.clear
	if abortDiagnosticAsked() then exit function
	req(ECU_BCM,REQ_2158).send
	if err then err.clear

	setDisplayDataValue "var1" , req(ECU_BCM,REQ_2154)("IMMO_STATUS_CID_SA_EXIT").Text
	setDisplayDataValue "var2" , req(ECU_BCM,REQ_2154)("IMMO_STATE_SA").Text
	setDisplayDataValue "var3" , req(ECU_BCM,REQ_2154)("IMMO_FLAG_SENDKEY_CONTENT_CONTROL_NOK").Text
	setDisplayDataValue "var4" , req(ECU_BCM,REQ_2154)("IMMO_FLAG_ANTI_SCANNING_LAUNCHED_S").Text
	setDisplayDataValue "var5" , req(ECU_BCM,REQ_2154)("IMMO_COUNTER_AFTER_SALES_PAIRING_S").Value
	setDisplayDataValue "var6" , req(ECU_BCM,REQ_2154)("IMMO_STATUS_SA_PAIRING_TYPE").Text
	setDisplayDataValue "var29", req(ECU_BCM,REQ_2154)("IMMO_STATUS_CID_PAIRING_SA_UNLOCKED").Text
	setDisplayDataValue "var28", req(ECU_BCM,REQ_2154)("IMMO_FLAG_CUSTOMER_MODE_LAUNCHED").Text

	setDisplayDataValue "var15", req(ECU_BCM,REQ_2157)("BCM_IS_BLANK_S").Text
	setDisplayDataValue "var16", req(ECU_BCM,REQ_2158)("IMMO_NB_CID_PAIRED_S").Value
	setDisplayDataValue "var7" , req(ECU_BCM,REQ_2157)("Get_Last_Configuration_Error").Text
	setDisplayDataValue "var8" , req(ECU_BCM,REQ_2154)("VSC_Learning_Step sur (5 bits).").Text
	setDisplayDataValue "var9" , req(ECU_BCM,REQ_2158)("VSC NbTotalDeBadge_SC2_Appris").Value
	setDisplayDataValue "var10", req(ECU_BCM,REQ_2158)("VSC NbTotalDeBadge_868_Appris").Value
	setDisplayDataValue "var11", req(ECU_BCM,REQ_2158)("VSC NbTotalDeBadge_433_Appris").Value
	setDisplayDataValue "var12", req(ECU_BCM,REQ_2158)("VSC NbTotalDeBadge_315_Appris").Value
	setDisplayDataValue "var13", req(ECU_BCM,REQ_2158)("VSC NbTotalDeBadge_315R_Appris").Value
	setDisplayDataValue "var14", req(ECU_BCM,REQ_2158)("VSC_Servant_ID").Text

	setDisplayDataValue "var17", req(ECU_BCM,REQ_2157)("VSC Badge_SC1").Text
	setDisplayDataValue "var18", req(ECU_BCM,REQ_2157)("VSC Badge_SC2").Text
	setDisplayDataValue "var19", req(ECU_BCM,REQ_2157)("VSC BadgeFreq_433").Text
	setDisplayDataValue "var20", req(ECU_BCM,REQ_2157)("VSC BadgeFreq_315N").Text
	setDisplayDataValue "var21", req(ECU_BCM,REQ_2157)("VSC BadgeFreq_315R").Text
	setDisplayDataValue "var22", req(ECU_BCM,REQ_2157)("VSC Status_d'Authent").Text
	setDisplayDataValue "var23", req(ECU_BCM,REQ_2157)("VSC_PP_BadgeDéjaAppris").Text
	setDisplayDataValue "var24", req(ECU_BCM,REQ_2157)("VSC IDE_reçu_par_tranpondeur").Text
	setDisplayDataValue "var25", req(ECU_BCM,REQ_2157)("VSC IDE_Valid_reçu_par_transpondeur_1").Text
	setDisplayDataValue "var26", req(ECU_BCM,REQ_2157)("VSC PSW_ReçuSurDernièreAuthent").Text
	setDisplayDataValue "var27", req(ECU_BCM,REQ_2157)("VSC PSW_ValidSurDernièreAuthent").Text

	if err then err.clear

	'setDisplayDataValue "var8", counter
	'counter = counter +1

'	value = req(0,1)("Tension +Batt").Value
'	voltageGraph.value = value
'	voltageGraph.title = "VBat : " & round(value,2) & " V"
'	voltageGraph.draw
'	batteryIndicator.value = value
	' batteryIndicator.title = voltageGraph.title
'	batteryIndicator.draw
'	setDisplayDataValue "var5", req(0,1)("Température extérieure").Text
'	setDisplayDataValue "var6", req(0,2)("Vitesse véhicule").Text
	if abortDiagnosticAsked() then exit function
end function

function abortDiagnosticAsked()
	on error resume next
	if abortDiagnostic = true then
		abortDiagnosticAsked = true
		diagSession.clear
		diagSession.commport = ""
	end if
end function

function Window_OnBeforeUnload()
	on error resume next
	abortDiagnostic = true
	if diagSession.busy = true then
		abortDiagnosticAsked
		Window_OnBeforeUnload = "Busy, try later " & err.description
	end if
	err.clear
end function

function Window_OnUnload()
	abortDiagnosticAsked
end function
