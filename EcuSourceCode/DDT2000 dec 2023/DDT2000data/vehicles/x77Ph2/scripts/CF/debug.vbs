set doc = CreateObject("MSXML2.DomDocument")
doc.async=false
doc.load "J77_ClimReg_V02.xml"
set xsl = CreateObject("MSXML2.DomDocument")
xsl.async=false
xsl.load "CustomerFeatureV4.xslt"
if xsl.parseerror.errorcode <> 0 then msgbox xsl.parseerror.reason
'MsgBox doc.xml
'MsgBox xsl.xml
set res = CreateObject("MSXML2.DomDocument")
doc.transformnodetoobject xsl,res
if res.parseerror.errorcode <> 0 then msgbox res.parseerror.reason
'MsgBox res.xml
res.save "DebugOutput.html"

