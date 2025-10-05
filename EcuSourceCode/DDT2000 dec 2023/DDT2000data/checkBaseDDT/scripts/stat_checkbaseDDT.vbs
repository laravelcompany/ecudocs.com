Option Explicit
Const STAT_FILE = "C:\DDT2000data\checkBaseDDT\stat.xml"

' ----------------------------------------------------------------------------
' Contrôler la base DDT

' ----------------------------------------------------------------------------
' Appel function checkDatabase
' ----------------------------------------------------------------------------
'checkDatabase "C:\DDT2000data\checkBaseDDT\R2_08v2_3_test.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\R2_08 v2_6.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\BCM95_SW6_V6_2.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\Ecu_RE7_CheckBase.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\4RD_X91_V4.3_modif.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\EMS3110_RD9_610_F4RT_M4R_Liv_9.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\PREMIUM_v1_2.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\PREMIUM_v1_2_modif-traite.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\EDC16CP33- W94c - X83_V1.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\R1_08_V0.6.xml"
checkDatabase "R1_08_V0.6.xml", "v11", "29/11/07", 77, 88, 99, 4589


' ----------------------------------------------------------------------------
' Function checkDatabase
' ----------------------------------------------------------------------------
function checkDatabase(databaseName, version, date, ddt2000w, ddt2000e, cpddw, cpdde)
dim docOut
dim outRoot
dim elt
dim elt2




'**************************
' création du xml de sortie
'**************************
Set docOut= CreateObject("MSXML2.DomDocument")
docOut.setProperty "SelectionLanguage", "XPath"
docOut.async = False

'********************************
' Documenter le fichier de sortie
'********************************
if docOut.load (STAT_FILE) then
	set outRoot = docOut.selectSingleNode("/quality")

	set elt = docOut.selectSingleNode("/quality/base[@name='" & databaseName & "']")
	if elt is nothing then
		'*********************************
		' Les stat de la base n'existe pas
		'*********************************
		with outRoot
			With .appendChild(docOut.createElement ("base"))
				.setAttribute "name", databaseName
				.appendChild docOut.createTextNode(vbcrlf)
				With .appendChild(docOut.createElement ("control"))
					.setAttribute "version",version
					.setAttribute "date",date
					.appendChild docOut.createTextNode(vbcrlf)
					With .appendChild(docOut.createElement ("ddt2000"))
						.appendChild docOut.createTextNode(vbcrlf)
						With .appendChild(docOut.createElement ("warnings"))
							.appendChild docOut.createTextNode(ddt2000w)
						end with
						.appendChild docOut.createTextNode(vbcrlf)
						With .appendChild(docOut.createElement ("errors"))
							.appendChild docOut.createTextNode(ddt2000e)
						end with
						.appendChild docOut.createTextNode(vbcrlf)
					end with
					.appendChild docOut.createTextNode(vbcrlf)
					With .appendChild(docOut.createElement ("cpdd"))
						.appendChild docOut.createTextNode(vbcrlf)
						With .appendChild(docOut.createElement ("warnings"))
							.appendChild docOut.createTextNode(cpddw)
						end with
						.appendChild docOut.createTextNode(vbcrlf)
						With .appendChild(docOut.createElement ("errors"))
							.appendChild docOut.createTextNode(cpdde)
						end with
						.appendChild docOut.createTextNode(vbcrlf)
					end with
				end with
			End With
		end with

	else
		'********************************
		' Les stat de la base existe déjà
		' Mise à jour des données
		'*********************************
		elt.selectSingleNode("control/@version").Text = version
		elt.selectSingleNode("control/@date").Text = date
		elt.selectSingleNode("control/ddt2000/warnings").Text = ddt2000w
		elt.selectSingleNode("control/ddt2000/errors").Text   = ddt2000e
		elt.selectSingleNode("control/cpdd/warnings").Text    = cpddw
		elt.selectSingleNode("control/cpdd/errors").Text      = cpdde
	end if

	docOut.save STAT_FILE

end if




end function
