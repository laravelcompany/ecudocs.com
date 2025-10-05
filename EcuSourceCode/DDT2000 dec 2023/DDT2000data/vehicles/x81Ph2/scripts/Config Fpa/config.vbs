Option Explicit

Sub SendRequest
Dim R
Dim sel
	
	'document.XMLDocument.selectionLanguage="XPath"
	R = document.XMLDocument.selectsinglenode("/*/prefix/text()").nodevalue
	For each sel in Params
		R = R & sel.value
	Next
	RequestText.innerText = R & document.XMLDocument.selectsinglenode("/*/suffix/text()").nodevalue
On Error Resume Next
	Envoyer
If Err=0 Then
	StatusText.innerText = "OK"
Else
	StatusText.innerText = Err.Description
	Err.Clear
End If
End Sub

Sub Envoyer
Dim DiagContext
Dim Session
Dim p
Dim converter
Dim protocol
Dim Request
Dim Response

Set DiagContext = Createobject("DiagnosticContext.Context")
 
Set Session = DiagContext.Object
Set p=Session(document.XMLDocument.selectsinglenode("/*/@function").nodevalue)

Set converter = createobject("DDT2000Helper.converter")
Set protocol = Converter.ToDiagProtocol(p)

If not protocol.connected Then protocol.Init

Set Request=CreateObject("DiagLibs2.ByteArray")
Request.lowIndex=1
Request.Text=RequestText.innerText
Set Response=CreateObject("DiagLibs2.ByteArray")
Response.lowIndex=1

protocol.SendRsvp Request,Response
End Sub
