' ------------------------------------------------------------
' Create an html report file, by applying XSLT transformation
' on a XML report file
'
' v1.0 - 2007-11-14
' v1.1 - 2008-04-14 - Copy stylesheets and other files in the report folder
' v1.2 - 2020-23-10 - Replace Internet Explorer html file opening by user default web browser
' ------------------------------------------------------------
Option Explicit
On error resume next

Const TOOL_NAME = "HTML report file generator"
Const SOURCE_PATH = "C:\DDT2000data\checkBaseDDT\scripts\"
Const REPORT_PATH = "DDT2000\checkBase_report\"

Const FILES_1 = "Translate.xml"
Const FILES_2 = "rules_displayCheckBaseDDT.xsl"
Const FILES_3 = "displayCheckBaseDDT.xsl"
Const FILES_4 = "rules_DisplayTemplates.xsl"

Dim objArgs

Dim oDDT2000_cFilesAndFolders
Dim oDDT2000_cDDT2000info

Dim shell
Dim fso

Dim targetPath
Dim xmlFilename
Dim xslFilename
Dim outputFilename

Dim xslDoc
Dim xmlDoc
Dim outDoc

Dim xslt
Dim xslProc

Dim verbose
verbose = false

'Check arguments
Set objArgs = WScript.Arguments
If (objArgs.Count <> 1) Then
	msgbox "Wrong arguments number"
	wscript.quit
End If

'*****************************
'Set files and directory names
'*****************************
targetPath = oDDT2000_cFilesAndFolders.pathAddBackslash(oDDT2000_cFilesAndFolders.getFolder_PERSONAL) & REPORT_PATH

xmlFilename    = objArgs(0)
xslFilename    = SOURCE_PATH  & "displayCheckBaseDDT.xsl"
  'remove ".xml" from input parameter 1 (objArgs(0)) given by builder
outputFilename = left(objArgs(0), len(objArgs(0)) - 4) & ".html"


'*************************************
' Display arguments If verbose is true
'*************************************
If verbose Then
	msgbox " xmlFilename :" & xmlFilename & vbnewline & " xslFilename :" & xslFilename,vbInformation, "Received parameters"
End If


'***************
' Create objects
'***************
Set oDDT2000_cFilesAndFolders = createobject("DDT2000utilities.cFilesAndFolders")
Set oDDT2000_cDDT2000info = createobject("DDT2000utilities.cDDT2000info")

Set fso = createObject("Scripting.FileSystemObject")
Set shell = CreateObject("Shell.Application")
Set xslt = CreateObject("Msxml2.XSLTemplate")

Set xslDoc = CreateObject("Msxml2.FreeThreadedDOMDocument")
Set xmlDoc = CreateObject("Msxml2.DOMDocument")
Set outDoc = createObject("Msxml2.DOMDocument")


' *********
'Set async
' *********
xslDoc.async = false
xmlDoc.async = false
outDoc.async = false


' **********
' Load files
' **********
  ' StyleSheet
If Not (fso.FileExists(xslFilename)) Then
  msgBox "StyleShhet file not found:" & vbnewline & xslFileName, vbOKOnly, TOOL_NAME
  wscript.quit
Else
  If Not (xslDoc.load(xslFilename)) Then
    msgbox "Error on loading XSL file:" & vbnewline & xslFileName, vbOKOnly, TOOL_NAME
    wscript.quit
  End If
End If

  ' XML report file
If Not (fso.FileExists(xmlFilename)) Then
  msgBox "Report file Not found:" & vbnewline & xmlFilename, vbOKOnly, TOOL_NAME
  wscript.quit
Else
  If Not (xmlDoc.load(xmlFilename)) Then
    msgbox "Error on loading report file:" & vbnewline & xmlFilename, vbOKOnly, TOOL_NAME
    wscript.quit
  End If
End If


'**************
' Prepare files
'**************
  ' Create target path
If Not (fso.FolderExists(targetPath)) Then
  fso.createFolder targetPath
End If

  ' Copy stylesheets and other related files
If fso.FileExists(SOURCE_PATH & FILES_1) Then
  fso.CopyFile SOURCE_PATH & FILES_1, targetPath
End If

If fso.FileExists(SOURCE_PATH & FILES_2) Then
  fso.CopyFile SOURCE_PATH & FILES_2, targetPath
End If

If fso.FileExists(SOURCE_PATH & FILES_3) Then
  fso.CopyFile SOURCE_PATH & FILES_3, targetPath
End If

If fso.FileExists(SOURCE_PATH & FILES_4) Then
  fso.CopyFile SOURCE_PATH & FILES_4, targetPath
End If


' *********************************************
' Configure converter xml report -> html report
' *********************************************
Set xslt.stylesheet = xslDoc
Set xslProc = xslt.createProcessor()

xslProc.addParameter "language",  oDDT2000_cDDT2000info.DDT_language
xslProc.input = xmlDoc
xslProc.output = outDoc


'**********************************************
' Convert report XML file into report html file
'**********************************************
If Not (xslProc.Transform())  Then
  msgBox "Unable to generate html file:" & vbnewline & outputFilename, vbOKOnly, TOOL_NAME
Else
  outDoc.Save outputFilename
  shell.Open(outputFilename)
End If
