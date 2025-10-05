Option Explicit
Dim Session
Dim odoc
Dim converter
Dim DataDisplays
Dim ActiveFeature
Dim flgRead
Dim DocRequests
Dim KLineRequests
Dim KLineProtocols

Sub Window_OnLoad
Dim obj
Dim DiagContext
Dim DocUserItems
Dim KLineDiagItems

set converter = createObject("DDT2000Helper.Converter")
set DiagContext = createObject("DiagnosticContext.Context")
Set Session = DiagContext.Object
set DiagContext = Nothing
set odoc = document.XMLDocument
odoc.setProperty "SelectionLanguage", "XPath"
'MsgBox odoc.getProperty("SelectionLanguage")
odoc.setProperty "SelectionNamespaces", "xmlns:cf='http://www-diag.renault.com/2003/CustomerFeatures'"
'MsgBox odoc.getProperty("SelectionNamespaces")
set DataDisplays = CreateObject("Scripting.Dictionary")
set KLineDiagItems = CreateObject("Scripting.Dictionary")
set KLineRequests = CreateObject("Scripting.Dictionary")
set KLineProtocols = CreateObject("Scripting.Dictionary")
ActiveFeature = ""


document.all.EtatPage.style.color = "lightgreen"
document.all.EtatPage.innerText = "READY"

Set obj = document.all("displayitems")
If obj is nothing Then
	Exit Sub
End If

Dim FunctionName
Set DocUserItems = Session.NewDiagItems
for each obj in document.all("displayitems")
	Dim DiagItem
	Dim Protocol
	Dim UserItems
	Set obj.object.DiagSession = Session
	Set DiagItem = obj.object.DiagItem
	Set Protocol = Converter.ToDiagProtocol(DiagItem.parent.parent)
	If (protocol.ProtocolName="CAN") Or (protocol.ProtocolName="DiagOnCAN") Then
		Set UserItems = DocUserItems	
	Else
		FunctionName = Protocol.FunctionName
		If KLineDiagItems.exists(FunctionName) Then
			Set UserItems = KLineDiagItems(FunctionName)
		Else
			Set UserItems = Session.NewDiagItems
			KLineDiagItems.add FunctionName, UserItems
			KlineProtocols.add FunctionName, Protocol
		End If
		 
	End If
	UserItems.Add DiagItem
Next
Set DocRequests = DocUserItems.Requests

For each FunctionName in KLineDiagItems.keys
	KLineRequests.add FunctionName, KLineDiagItems(FunctionName).requests
Next

On Error Resume Next
DocRequests.Protocols.Init
If Err<>0 Then
	MsgBox Err.Description
	Err.Clear
Else
	DoRead
End If

End Sub


'-------------
Sub ReadLoop()
'-------------
Dim FunctionName
DocRequests.Send
For each FunctionName in KLineRequests.keys
	Dim Requests
	Dim Protocol
	Set Requests = KLineRequests(FunctionName)
	Set Protocol = KLineProtocols(FunctionName)
	Protocol.init
	Requests.send
Next
End Sub

'----------------------
Sub ExitButton_OnClick
'----------------------
' warning : this function works if in XSLT you have only internal navigation
'           with window.navigate() function. Do not use Href="" in XSLT.
history.go(-1)
end sub

'-----------
Sub DoRead()
'-----------
On Error Resume Next
ReadLoop
If Err<>0 Then
	window.status =  Err.Description
	Err.Clear
Else
	if flgRead Then settimeout "DoRead", 100
End If
End Sub

sub ShowHideDetails()
Dim obj
for each obj in document.all("DiagDetail")
    if obj.style.display = "none" then
       obj.style.display = ""
    else
       obj.style.display = "none"
    end If
Next
end Sub

sub StartStopMonitor()
Dim obj
For each obj in document.all("MonitorButton")
    if obj.innertext = "START MONITOR" then
       obj.innertext = "STOP MONITOR"
       window.status = "diag monitor running"
       flgRead = true
       DoRead
    Else
       flgRead = false
       obj.innertext = "START MONITOR"
       window.status = ""
    end If
Next
If flgRead = true Then
	For each obj in document.all("ComStatus")
		obj.src="picture/ComOn.gif"
	Next
Else
	For each obj in document.all("ComStatus")
		obj.src="picture/ComOff.gif"
	Next
End If

end Sub