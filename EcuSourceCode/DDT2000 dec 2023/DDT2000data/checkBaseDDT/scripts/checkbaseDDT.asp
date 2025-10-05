<%@ Language=VBScript %>
<%
Option Explicit
' ----------------------------------------------------------------------------
' Contrôler la base DDT
' ----------------------------------------------------------------------------

Dim doc

' le document de sortie
Dim xml
dim docOut
dim outRoot
dim lang

' document d'entree
Dim req

Dim identification,identNode


Response.Buffer = True
Response.ContentType ="text/xml"
Response.AddHeader "encoding","UTF-8"

lang = trim("" & Request("lang"))
if len(lang) <> 2 then
	lang = "en"
end if

'**************************
' création du xml de sortie
'**************************
Set docOut= Server.CreateObject("MSXML2.FreeThreadedDomDocument")
docOut.appendChild docOut.createProcessingInstruction ("xml", "version ='1.0' encoding='UTF-8'")
set outRoot = docOut.appendChild(docOut.createElement ("check"))

'**************************
' création du xml d'entree
'**************************
Set req = Server.CreateObject ("MSXML2.FreeThreadedDomDocument")

req.setProperty "SelectionLanguage", "XPath"
req.setProperty "SelectionNamespaces", "xmlns:ddt='http://www-diag.renault.com/2002/ECU'"
req.async = False

'*******************************
' lecture depuis l'objet request
'*******************************
req.load Request
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

'*******************
' Tranformation xslt
'*******************
dim oXsl, xslt, xslProc, oDocCvt,tmpNode

' Chargement de la feuille de style et création du template
set oXsl = CreateObject("MSXML2.FreeThreadedDOMDocument")
oXsl.Async = false

if oXsl.load (server.mappath("checkbaseDDT.xsl")) then
	set xslt = CreateObject("MSXML2.XSLTemplate")
	Set xslt.stylesheet = oXsl
	' Création du Processeur
	Set xslProc = xslt.createProcessor()

	set oDocCvt = server.createObject("MSXML2.FreeThreadedDOMDocument")
	oDocCvt.async = false
	xslProc.input = req
	xslProc.output = oDocCvt
	err.clear
	'xslProc.addParameter "Err",  mode

	xslProc.addParameter "language",  lang

	xslProc.Transform

	set xml = odocCvt
	set outRoot = xml.documentElement

	'outRoot.appendChild odoccvt.documentelement.clonenode(true)
	set tmpNode = oDocCvt.documentelement.appendChild(oDocCvt.createelement("param"))
	tmpNode.appendChild oDocCvt.createtextnode(request.querystring("type"))

	oDocCvt.insertBefore oDocCvt.createProcessingInstruction("xml", "version='1.0' encoding='UTF-8'"), oDocCvt.documentElement
	oDocCvt.insertBefore oDocCvt.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='displayCheckBaseDDT.xsl'"), oDocCvt.documentElement

	' *******************
	' renvoyer la reponse
	' *******************
	oDocCvt.save Response

else
	Response.write "System Error when loading styleSheet : checkbaseDDT.xsl<BR/>Reason = <B>" & oXsl.parseError.reason & "</B><BR/>Line = <B>" & oXsl.parseError.line & "</B><BR/>LinePos = <B>" & oXsl.parseError.linepos & "</B>"
end if




Response.End
%>
