' ------------------------------------------------------------
' Create an XML report file, by applying XSLT transformation
' on a DDT2000 database XML file
'
' v1.0 - 2007-11-14
' v1.1 - 2008-04-14 - Copy stylesheets and other files in the report folder
' V1.2 - 2019-07-11 - Change file organisation and add check in case of unsuccesful transfom
' V1.3 - 2020-10-23 - Add calling to forbidden characters tool
' ------------------------------------------------------------
Option Explicit
On error resume next

Const TOOL_NAME = "DDT report file generator"
Const SOURCE_PATH = "C:\DDT2000data\checkBaseDDT\scripts\"
Const REPORT_PATH = "DDT2000\checkBase_report\"
Const FORBIDDEN_CHARS_FILENAME = "C:\DDT2000data\checkBaseDDT\ForbiddenCharacters.xml"

Dim objArgs
Dim oDDT2000_cDDT2000info
Dim fso

Dim xmlBaseDDTFileName
Dim xslFileName
Dim xslPreProcessingFileName
Dim PreProcessingFileName
Dim reportFileName

' Pre-processing
Dim xslPreProc
Dim xsltPreProcess
Dim xslPreProcessFile
Dim xmlOrgDdtFile
Dim xmlOutDdtFile

' Checking
Dim xslProc
Dim xsltCheck
Dim xslCheckFile
Dim xmlPreDdtFile
Dim xmlOutFile

'Report result on DDT file
Dim strErrorCode
Dim objShell
Dim command

Dim verbose
verbose = false

' Check arguments
Set objArgs = WScript.Arguments
If (objArgs.Count <> 3) Then
	msgBox "Wrong arguments", vbOKOnly, TOOL_NAME
	wscript.quit
End If


'***************
' Set files name
'***************
xmlBaseDDTFileName = objArgs(0)
xslFilename        = objArgs(1)
reportFileName     = objArgs(2)

xslPreProcessingFileName = "C:\DDT2000data\checkBaseDDT\scripts\PreProcessing.xsl"
  'replace "xml.report.xml" from input parameter 3 (objArgs(2)) given by builder by "_pre-processing.xml" 
preProcessingFileName = Replace(objArgs(2), ".xml.report.xml","_pre-processing.xml")

'*************************************
' Display arguments If verbose is true
'*************************************
If verbose = true Then
	msgBox "+ xmlBaseDDTFileName:" & vbnewline & xmlBaseDDTFileName & vbnewline & vbnewline & "+ xslFilename:" & vbnewline & xslFilename & vbnewline & vbnewline & "+ reportFileName:" & vbnewline & reportFileName & vbnewline & vbnewline & "+ language : " & oDDT2000_cDDT2000info.DDT_language, vbInformation, "Received parameters"
End If


'***************
' Create objects
'***************
' Commun
Set oDDT2000_cFilesAndFolders = createobject("DDT2000utilities.cFilesAndFolders")
Set oDDT2000_cDDT2000info = createobject("DDT2000utilities.cDDT2000info")
Set fso = createObject("Scripting.FileSystemObject")

' Pre-processing
Set xsltPreProcess = CreateObject("Msxml2.XSLTemplate")
Set xslPreProcessFile = CreateObject("Msxml2.FreeThreadedDOMDocument")
Set xmlOrgDdtFile = CreateObject("Msxml2.DOMDocument")
Set xmlOutDdtFile = createObject("Msxml2.DOMDocument")

' Checking
Set xsltCheck = CreateObject("Msxml2.XSLTemplate")
Set xslCheckFile = CreateObject("Msxml2.FreeThreadedDOMDocument")
Set xmlPreDdtFile = CreateObject("Msxml2.DOMDocument")
Set xmlOutFile = createObject("Msxml2.DOMDocument")

' *********
' Set async
' *********
' Pre-processing
xslPreProcessFile.async = False
xmlOrgDdtFile.async = False
xmlOutDdtFile.async = False

' Checking
xslCheckFile.async = False
xmlPreDdtFile.async = False
xmlOutFile.async = False

'Delete previous invalid characters file
If fso.FileExists(FORBIDDEN_CHARS_FILENAME) Then
  fso.DeleteFile(FORBIDDEN_CHARS_FILENAME)
End If

'Delete previous pre-processing file
If fso.FileExists(preProcessingFileName) Then
  fso.DeleteFile(preProcessingFileName)
End If

'Delete previous report
If fso.FileExists(reportFileName) Then
  fso.DeleteFile(reportFileName)
End If

'**********************************************
' CHECK INVALID CHARACTERS
'**********************************************
' Prepart DDT_InvalidCharacters.exe command line
command = "cmd /c" & AddDoubleQuote(AddDoubleQuote(SOURCE_PATH & "DDT_ForbiddenCharacters.exe") & " " & AddDoubleQuote(xmlBaseDDTFileName))

' Diplay command line if required
if verbose then
  msgBox command, vbInformation, "Forbidden character checker command line"
end if

' launch checker.exe  
Set objShell = Wscript.CreateObject("WScript.Shell")
strErrorCode = objShell.Run(command, 1, True)



'**********************************************
' PRE-PROCESSING DDT FILE
'**********************************************
'Load Preprocessing StyleSheet
If Not(fso.FileExists(xslPreProcessingFileName)) Then
  msgBox "StyleSheet file Not found:" & vbnewline & xslPreProcessingFileName, vbOKOnly, TOOL_NAME
  wscript.quit
ElseIf Not xslPreProcessFile.load(xslPreProcessingFileName) Then
    msgBox "Error on loading XSL file:" & vbnewline & xslPreProcessingFileName, vbOKOnly, TOOL_NAME
    wscript.quit
End If  

' Load DDT file
' fso.FileExists does Not work when DDT file come from "Central database on network" or from "Local copy of central database"
'  == > as Builder call check with current open file, it exists
If Not xmlOrgDdtFile.load(xmlBaseDDTFilename) Then
  msgBox "Error on loading DDT file:" & vbnewline & xmlBaseDDTFilename, vbOKOnly, TOOL_NAME
  wscript.quit
End If

' Configure converter
Set xsltPreProcess.stylesheet = xslPreProcessFile
Set xslPreProc = xsltPreProcess.createProcessor()
xslPreProc.input  = xmlOrgDdtFile
xslPreProc.output = xmlOutDdtFile

' Rewrite DDT file with pre-processing instructions
If Not (xslPreProc.Transform())Then
  msgBox "Unable to generate pre-processing  file:" & vbnewline & PreProcessingFileName, vbOKOnly, TOOL_NAME
Else
  xmlOutDdtFile.Save preProcessingFileName
End If


'**********************************************
' CHECK PRE-PROCESSING FILE
'**********************************************
' Load StyleSheet
If Not(fso.FileExists(xslFileName)) Then
  msgBox "StyleSheet file Not found:" & vbnewline & xslFileName, vbOKOnly, TOOL_NAME
  wscript.quit
ElseIf Not xslCheckFile.load(xslFileName) Then
  msgBox "Error on loading XSL file:" & vbnewline & xslFileName, vbOKOnly, TOOL_NAME
  wscript.quit
End If  

' Load pre-processing file
' fso.FileExists does Not work when DDT file come from "Central database on network" or from "Local copy of central database"
'  == > as Builder call check with current open file, it exists
If Not(fso.FileExists(preProcessingFileName)) Then
  msgBox "Pre-processing file Not found:" & vbnewline & preProcessingFileName, vbOKOnly, TOOL_NAME
ElseIf Not xmlPreDdtFile.load(preProcessingFileName) Then
  msgBox "Error on loading pre-processing file:" & vbnewline & preProcessingFileName, vbOKOnly, TOOL_NAME
  wscript.quit
End If


' Configure converter
Set xsltCheck.stylesheet = xslCheckFile
Set xslProc = xsltCheck.createProcessor()
xslProc.addParameter "language",  oDDT2000_cDDT2000info.DDT_language
xslProc.input  = xmlPreDdtFile
xslProc.output = xmlOutFile


' Convert DDT file into report file
If Not (xslProc.Transform())Then
  msgBox "Unable to generate report file:" & vbnewline & reportFileName, vbOKOnly, TOOL_NAME

Else
  xmlOutFile.insertBefore xmlOutFile.createProcessingInstruction("xml", "version='1.0' encoding='UTF-8'"), xmlOutFile.documentElement
  xmlOutFile.insertBefore xmlOutFile.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='displayCheckBaseDDT.xsl'"), xmlOutFile.documentElement
  xmlOutFile.Save reportFileName
End If

'Delete pre-processing file
If fso.FileExists(preProcessingFileName) Then
  fso.DeleteFile(preProcessingFileName)
End If

' Prepart checker.exe command line
command = "cmd /c" & AddDoubleQuote(AddDoubleQuote(SOURCE_PATH & "CheckResultOnDdtFile.exe") & " " & AddDoubleQuote(xmlBaseDDTFileName) & " " & AddDoubleQuote(reportFileName))

' Diplay command line if required
if verbose then
  msgBox command, vbInformation, "Check result on DDT file command line"
end if

' launch checker.exe  
Set objShell = Wscript.CreateObject("WScript.Shell")
strErrorCode = objShell.Run(command, 1, True)

'Delete new invalid characters file
If fso.FileExists(FORBIDDEN_CHARS_FILENAME) Then
  fso.DeleteFile(FORBIDDEN_CHARS_FILENAME)
End If


Function AddDoubleQuote(str)
  AddDoubleQuote = chr(34) & str & chr (34)
End Function