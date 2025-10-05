' ------------------------------------------------------------
' Create an html report file, by applying XSLT transformation
' on a XML report file
'
' v1.0 - 2007-11-14
' ------------------------------------------------------------
Option Explicit
Dim sh
Dim internetExplorer
Dim scriptPath

Dim sTemp

dim xslDoc
dim xmlDoc
dim xslt
dim xslProc
dim outDoc

dim xmlFilename
dim xslFilename
dim outputFilename

dim oDDT200_info

dim objArgs

dim verbose

verbose = false

set oDDT200_info = createobject("DDT2000utilities.cDDT2000info")

Set objArgs = WScript.Arguments
if (objArgs.Count <> 1) then
	msgbox "Wrong arguments"
	wscript.quit
end if

scriptPath = left(wscript.ScriptFullName, len(wscript.ScriptFullName) - len(wscript.ScriptName))

xmlFilename    = objArgs(0)
xslFilename    = scriptPath  & "displayCheckBaseDDT.xsl"
outputFilename = xmlFilename & ".report.html"

if verbose then
	msgbox " xmlFilename :" & xmlFilename & vbnewline & " xslFilename :" & xslFilename
end if

Set xslDoc = CreateObject("Msxml2.FreeThreadedDOMDocument")
xslDoc.async = false
if not xslDoc.load(xslFilename) then
	msgbox "XSL load error"
	wscript.quit
end if

Set xslt = CreateObject("Msxml2.XSLTemplate")
Set xslt.stylesheet = xslDoc

Set xmlDoc = CreateObject("Msxml2.DOMDocument")
xmlDoc.async = false
if not xmlDoc.load(xmlFilename) then
	msgbox "XML load error"
	wscript.quit
end if

Set xslProc = xslt.createProcessor()

xslProc.addParameter "language",  oDDT200_info.DDT_language

xslProc.input = xmlDoc
if xslProc.Transform then

	sTemp = CStr(xslProc.output)

	if not xmlDoc.loadXML(sTemp) then
		msgbox "Not a valid XML result" & vbnewline & sTemp
		wscript.quit
	end if

	xmlDoc.Save outputFilename
	if verbose then msgbox "Report file has been created."

	on error resume next
	set sh = CreateObject("Wscript.Shell")
	if err = 0 then
		internetExplorer = sh.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\IEXPLORE.EXE\")
		if (err = 0) and (internetExplorer <> "") then
			sh.Run Chr(34) & internetExplorer & Chr(34) & " " & Chr(34) & outputFilename & Chr(34), 1
		else
			sh.Run "start " & Chr(34) & outputFilename & Chr(34), 1
		end if
	end if
end if