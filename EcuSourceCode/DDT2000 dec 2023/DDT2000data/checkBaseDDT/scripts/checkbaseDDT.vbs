'Option Explicit

dim oDDT200_info
set oDDT200_info = createobject("DDT2000utilities.cDDT2000info")

' ----------------------------------------------------------------------------
' Contrôler la base DDT
' ----------------------------------------------------------------------------
'req.load "C:\Documents and Settings\a190186\Desktop\Depot bases DDT2000\Audio_R2_08_X91_X95\R2_08v2_2_new.xml"
'req.load "C:\DDT2000data\checkBaseDDT\R2_08v2_3_test.xml"

' ----------------------------------------------------------------------------
' Appel function checkDatabase
' ----------------------------------------------------------------------------
'checkDatabase "C:\DDT2000data\checkBaseDDT\TdB_B95_V3.0.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\ITMP2_31.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\4RD_W91_V2.4_TEST.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\New_ECU_TEST.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\Monitool-Bibliotheque_generique.xml"
checkDatabase "C:\DDT2000data\checkBaseDDT\Ecu_RE7_CheckBase.xml"
'checkDatabase "C:\DDT2000data\checkBaseDDT\EDC16C36 - A42-V3(DiagOnCAN).xml"

' ----------------------------------------------------------------------------
' Function checkDatabase
' ----------------------------------------------------------------------------
function checkDatabase(aFilename)
Dim doc

' le document de sortie
Dim xml
dim docOut
dim outRoot

dim i
dim filePath
dim fileName
dim reportFilePath
dim reportFileName


' document d'entree
Dim req

Dim identification,identNode


'Response.Buffer = True
'Response.ContentType ="text/xml"
'Response.AddHeader "encoding","UTF-8"

'**************************
' création du xml de sortie
'**************************
'Set docOut= Server.CreateObject("MSXML2.DomDocument")
Set docOut= CreateObject("MSXML2.DomDocument")
docOut.appendChild docOut.createProcessingInstruction ("xml", "version ='1.0' encoding='UTF-8'")
set outRoot = docOut.appendChild(docOut.createElement ("check"))

'**************************
' création du xml d'entree
'**************************
'Set req = Server.CreateObject ("MSXML2.DomDocument")
Set req = CreateObject ("MSXML2.DomDocument")

req.setProperty "SelectionLanguage", "XPath"
req.setProperty "SelectionNamespaces", "xmlns:ddt='http://www-diag.renault.com/2002/ECU'"
req.async = False

'**************************
' Chargement de la base DDT
'**************************
req.load aFilename

if req.parseError then
	with outRoot
		With .appendChild(docOut.createElement ("error"))
			With .appendChild(docOut.createElement ("action"))
				.appendChild docOut.createTextNode ("Load xml request")
			end with
			With .appendChild(docOut.createElement ("reason"))
				.appendChild docOut.createTextNode (req.parseError.reason)
			end with
		End With
	end with
	'*****************************
	' Erreur : renvoyer la reponse
	'*****************************
'	docOut.save Response
'	Response.End
end if



'************************
' Tranformation xslt
'************************
dim oXsl, xslt, xslProc, oDocCvt

' Chargement de la feuille de style et création du template
set oXsl = CreateObject("MSXML2.FreeThreadedDOMDocument")
oXsl.Async = false

'if oXsl.load (server.mappath("checkbaseDDT.xsl")) then
if oXsl.load ("checkbaseDDT.xsl") then

	set xslt = CreateObject("MSXML2.XSLTemplate")
	Set xslt.stylesheet = oXsl
	' Création du Processeur
	Set xslProc = xslt.createProcessor()

	'set oDocCvt = server.createObject("MSXML2.FreeThreadedDOMDocument")
	set oDocCvt = createObject("MSXML2.DOMDocument")
	oDocCvt.async = false
	xslProc.input = req
	xslProc.output = oDocCvt
	err.clear
	xslProc.addParameter "language",  oDDT200_info.DDT_language
	'xslProc.addParameter "Specification",  "B"
	xslProc.Transform

	set xml = odocCvt
	set outRoot = xml.documentElement
	'outRoot.appendChild odoccvt.documentelement.clonenode(true)

	' renvoyer la reponse
	'oDocCvt.save Response

	oDocCvt.insertBefore oDocCvt.createProcessingInstruction("xml", "version='1.0' encoding='UTF-8'"), oDocCvt.documentElement
	oDocCvt.insertBefore oDocCvt.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='displayCheckBaseDDT.xsl'"), oDocCvt.documentElement

	'******************************
	' Sauvegarder le fichier report
	'******************************
	i = InStrRev(aFilename, "\")
	If i <> 0 Then
		filePath = Mid(aFilename, 1, i)
		fileName = Mid(aFilename, i + 1, Len(aFilename))
	End If

	'msgbox "filePath : " & filePath
	'msgbox "fileName : " & fileName

	reportFilePath = filePath & "report\"
	reportFileName = reportFilePath & fileName & ".report.xml"

	'msgbox "reportFilePath : " & reportFilePath
	'msgbox "reportFileName : " & reportFileName

	'xml.save "C:\DDT2000data\checkBaseDDT\showError.xml"
	'xml.save aFilename & ".report.xml"
	xml.save reportFileName

	msgbox reportFileName & "   done!"

else
	'Response.write "System Error when loading styleSheet : checkbaseDDT.xsl<BR>Reason = <B>" & oXsl.parseError.reason & "</B><BR>Line = <B>" & oXsl.parseError.line & "</B><BR>LinePos = <B>" & oXsl.parseError.linepos & "</B></P>"
	msgbox "System Error when loading styleSheet : checkbaseDDT.xsl<BR>Reason = <B>" & oXsl.parseError.reason & "</B><BR>Line = <B>" & oXsl.parseError.line & "</B><BR>LinePos = <B>" & oXsl.parseError.linepos & "</B></P>"
end if


end function
