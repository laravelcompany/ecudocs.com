Option Explicit
' ----------------------------------------------------------------------------
' Contrôler la base DDT
' ----------------------------------------------------------------------------
'req.load "C:\Documents and Settings\a190186\Desktop\Depot bases DDT2000\Audio_R2_08_X91_X95\R2_08v2_2_new.xml"
'req.load "C:\DDT2000data\checkBaseDDT\R2_08v2_3_test.xml"
'req.load "C:\DDT2000data\checkBaseDDT\ABS_InitRapide_MonoPoint.xml"
'req.load "C:\DDT2000data\checkBaseDDT\BVR_InitRapide_MultiPoint.xml"
'req.load "C:\DDT2000data\checkBaseDDT\BVR_InitLente_TypeI.xml"
'req.load "C:\DDT2000data\checkBaseDDT\AB70_InitLente_TypeII.xml"
'req.load "C:\DDT2000data\checkBaseDDT\J64_ISO8.xml"
'req.load "C:\DDT2000data\checkBaseDDT\TdB_X73PH2_soft4.x.xml"
'req.load "C:\DDT2000data\checkBaseDDT\X95_CAREG_V2_origine.xml"
'req.load "C:\Depot bases DDT2000\ABS_X95\V2_2\ABS_X95_Version_2.2.xml"
'req.load "C:\Depot bases DDT2000\ESP_X95\V2_2\ESP_X95_Version_2.2.xml"
'req.load "C:\DDT2000data\checkBaseDDT\BCM_X91_SWD-1.0.xml"
'req.load "C:\DDT2000data\checkBaseDDT\BCM_X91_SWA-0.8.0.xml"
'req.load "C:\Depot bases DDT2000\BCM_X95\SW6\BCM95_SW6_V6_2.xml"


Dim fso, fc,fd,f
dim folderspec , folderspecout

folderspec = "C:\DDT2000data\checkBaseDDT\test"
folderspecout = "C:\DDT2000data\checkBaseDDT\test\report"

Set fso = CreateObject("Scripting.FileSystemObject")
Set fd = fso.GetFolder(folderspec)
Set fc = fd.Files
For Each f in fc
	'msgbox "file :" & folderspec & "\" & f.name
	'checkDatabase folderspec & "\" & f.name
	checkDatabase folderspec , f.name , folderspecout
Next

msgbox "The End"

'checkDatabase "C:\DDT2000data\checkBaseDDT\R2_08v2_3_test.xml"

' ----------------------------------------------------------------------------
' Function
' ----------------------------------------------------------------------------
function checkDatabase(folderspec , aFilename, folderspecout)
Dim doc

' le document de sortie
Dim xml
dim docOut
dim outRoot

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

'*******************************
' lecture depuis l'objet request
'*******************************
'req.load aFilename
req.load folderspec & "\" & aFilename

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
	'********************
	' renvoyer la reponse
	'********************
	docOut.save Response
	Response.End
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
	'xslProc.addParameter "Specification",  "B"
	xslProc.Transform

	set xml = odocCvt
	set outRoot = xml.documentElement
	'outRoot.appendChild odoccvt.documentelement.clonenode(true)
' renvoyer la reponse
'oDocCvt.save Response

oDocCvt.insertBefore oDocCvt.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='displayCheckBaseDDT.xsl'"), oDocCvt.documentElement
oDocCvt.insertBefore oDocCvt.createProcessingInstruction("xml", "version='1.0' encoding='UTF-8'"), oDocCvt.documentElement

'xml.save "C:\DDT2000data\checkBaseDDT\showError.xml"
'xml.save aFilename & ".report.xml"
xml.save folderspecout & "\" & aFilename & ".report.xml"

'msgbox "done!"
else
	'Response.write "System Error when loading styleSheet : checkbaseDDT.xsl<BR>Reason = <B>" & oXsl.parseError.reason & "</B><BR>Line = <B>" & oXsl.parseError.line & "</B><BR>LinePos = <B>" & oXsl.parseError.linepos & "</B></P>"
	msgbox "System Error when loading styleSheet : checkbaseDDT.xsl<BR>Reason = <B>" & oXsl.parseError.reason & "</B><BR>Line = <B>" & oXsl.parseError.line & "</B><BR>LinePos = <B>" & oXsl.parseError.linepos & "</B></P>"
end if


end function
