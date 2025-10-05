<?xml version="1.0" encoding="windows-1252"?>
<!--
    [XSL-XSLT] This stylesheet automatically updated from an IE5-compatible XSL stylesheet to XSLT.
    The following problems which need manual attention may exist in this stylesheet:
    -->
<xsl:stylesheet version="1.0" exclude-result-prefixes="msxsl ddt ds"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:ddt="http://www-diag.renault.com/2002/ECU"
  xmlns:ds="http://www-diag.renault.com/2002/screens"
  xmlns:local="#local-functions"
  >
<msxsl:script language="VBScript" implements-prefix = "local">
<![CDATA[
Const VALID_FIRST_CHARS       = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
Const VALID_FIRST_CHARS_DESC_EN  = "a to z, A to Z"
Const VALID_FIRST_CHARS_DESC_FR  = "a à z, A à Z"

Const NAME_VALID_CHARS      = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_. "
Const NAME_VALID_CHARS_DESC_EN = "a to z, A to Z, 0 to 9, underscore (_), dot (.), space "
Const NAME_VALID_CHARS_DESC_FR = "a à z, A à Z, 0 à 9, underscore (_), point (.), espace "

Const VALID_LAST_CHARS        = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_."
Const VALID_LAST_CHARS_DESC   = "a to z, A to Z, 0 to 9, underscore (_), dot (.)"

Const NAME_ACCENT_CHARS   = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ "
Const NAME_REPLACE_CHARS  = "AAAAAAACEEEEIIIIINOOOOOXOUUUUYbbaaaaaaaceeeeiiiidnooooo-ouuuuyby_"

Const TARGET_NAME_VALID_CHARS      = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_. "
Const VALID_TARGET_NAME_CHARS_DESC_EN = "a to z, A to Z, 0 to 9, dash (-), underscore (_), dot(.), space"
Const VALID_TARGET_NAME_CHARS_DESC_FR = "a à z, A à Z, 0 à 9, tiret (-), underscore (_), point (.), espace"

Const INVALID_NAME_FIRST_CHARS  = ";0123456789-:{([<>])}&~# "
Const INVALID_NAME_CHARS  = ";"
Const INVALID_NAME_CHARS_WARN  = "&~#:"

Const ASCII_ACCENT_CHARS = "!#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿµ£¨§²± """

Const ASCII_ACCENT_CHARS_DESC_EN = "All ASCII characters as well as accented characters except for control characters."
Const ASCII_ACCENT_CHARS_DESC_FR = "Tous les caractères ASCII ainsi que les caractères accentués exception faite des caractères de contrôle."

Const REPORT_PATH = "DDT2000\checkBase_report\"
Const FILE_LOG_PRE = "REP_"
Const FILE_LOG_EXT = ".log"


Const IO_MODE_READ = 1
Const IO_MODE_WRITE = 2
Const IO_MODE_APPEND = 8

' ****************************************************
Function getValidChars(language, first)
  If ("fr" = language) Then
    If (first = 1) Then
      getValidChars= VALID_FIRST_CHARS_DESC_FR
    Else
      getValidChars= NAME_VALID_CHARS_DESC_FR
    End if
  Else
    If (first = 1) Then
      getValidChars= VALID_FIRST_CHARS_DESC_EN
    Else
      getValidChars= NAME_VALID_CHARS_DESC_EN
    End if
  End If
end Function

' ****************************************************
Function getTargetNameValidChars(language)
  If ("fr" = language) Then
    getTargetNameValidChars = VALID_TARGET_NAME_CHARS_DESC_FR
  Else
    getTargetNameValidChars = VALID_TARGET_NAME_CHARS_DESC_EN
  End If
End Function

' ****************************************************
Function isSameNormalizedName(Name1, Name2)
  if (NormalizeName(Name1) = NormalizeName(Name2)) then
    isSameNormalizedName = 1
  else
    isSameNormalizedName = 0
  end if
End Function

' ****************************************************
Function NormalizeName(aName)
  dim myName
  dim myResult
  dim ch
  dim i
  dim pos

  for i = 1 to len(aName)
    ch = mid(aName,i,1)
        pos = InStr(NAME_VALID_CHARS, ch)
        If (pos > 0) Then
            ' valid char
            myResult = myResult & ch
        else
            pos = InStr(NAME_ACCENT_CHARS, ch)
            If (pos > 0) Then
                ' accented char, replaced by a non-accented char
                myResult = myResult & Mid(NAME_REPLACE_CHARS, pos, 1)
            else
                ' invalid char
                myResult = myResult & "_" & hex(asc(ch)) & "_"
      end if
    end if
  next

  NormalizeName = UCase(myResult)
End Function

' ****************************************************
Function CheckInvalidCharRequestDataName(aName)
  dim i
  dim ch
  dim pos
  CheckInvalidCharRequestDataName= ""

  ' ***************************
  ' Checking invalid first char
  ' ***************************
  ch = mid(aName,1,1)
  pos = InStr(VALID_FIRST_CHARS, ch)
  if (pos = 0) then
    ' *********************
    ' invalid first char
    ' *********************
    CheckInvalidCharRequestDataName = ch
    exit function
  end if
  ' *********************
  ' Checking invalid char
  ' *********************
  for i = 1 to (len(aName)-1)
    ch = mid(aName,i,1)
    pos = InStr(NAME_VALID_CHARS, ch)
    if (pos = 0) then
      ' ************
      ' invalid char : error or warning
      ' ************

      pos = InStr(INVALID_NAME_CHARS, ch)
      if (pos <> 0) then
        ' ************
        ' error invalid char
        ' ************
        CheckInvalidCharRequestDataName = ch
        exit function
      else
        ' ************
        ' warning invalid char
        ' ************
        'CheckInvalidCharRequestDataName = "warning|" & ch
        CheckInvalidCharRequestDataName = ch
      end if
    end if
  next
  ' ***************************
  ' Checking invalid last char
  ' ***************************
  ch = mid(aName,len(aName),1)
  pos = InStr(VALID_LAST_CHARS, ch)
  if (pos = 0) then
      ' *********************
    ' invalid last char
    ' *********************
    CheckInvalidCharRequestDataName = ch
    exit function
  end if
End Function

' ****************************************************
Function checkTargetName(targetName)
  Dim index
  Dim character
  Dim position
  
  checkTargetName = ""
  
  For index = 1 To Len(targetName)
    character = Mid(targetName, index, 1) 
      position = InStr(TARGET_NAME_VALID_CHARS, character)
      If (position = 0) Then
          checkTargetName = character
          Exit For
      End If
  Next
End Function

' ****************************************************
Function CheckInvalidASCIIChar(astring)
  Dim index
  Dim character
  Dim position
  
  CheckInvalidASCIIChar = ""
  
  For index = 1 To Len(astring)
    character = Mid(astring, index, 1) 
    position = InStr(ASCII_ACCENT_CHARS, character)
    If (position = 0) Then
      CheckInvalidASCIIChar = character
      Exit For
    End If
  Next
End Function


' ****************************************************
Function GetInvalidASCIIPosition(astring)
  Dim index
  Dim position
  
  GetInvalidASCIIPosition = 0
  For index = 1 To Len(astring)
    character = Mid(astring, index, 1) 
    position = InStr(ASCII_ACCENT_CHARS, character)
    if (position = 0) Then
      GetInvalidASCIIPosition = index
      Exit For
    End If
  Next
  
End Function
' ****************************************************
Function GeneralErrorCode()
  GeneralErrorCode = clng(&haa55aa55)
End Function

' ****************************************************
Function ComputeEndByte(StartByte , startBit , dataLengthInBits)
    Dim Data_NbBits
    Dim Data_NbByte

  on error resume next

    Data_NbBits = clng(startBit) + clng(dataLengthInBits)
    If (Data_NbBits mod 8) = 0 Then
        Data_NbByte = Data_NbBits \ 8
    Else
        Data_NbByte = (Data_NbBits \ 8) + 1
    End If

    ComputeEndByte = clng(clng(StartByte) + Data_NbByte - 1)
  if err then
    ComputeEndByte = GeneralErrorCode()
    err.clear
  end if
End Function

' ****************************************************
Function GetCurrentTime()
     GetCurrentTime= FormatDateTime(now(), 0)
end Function

' ****************************************************
Function GetCurrentTimer()
     GetCurrentTimer = Timer
end Function

' ****************************************************
Function DiffTimer(StartTimer)
  dim EndTimer

  EndTimer = Timer
  'DiffTimer = clng(EndTimer - StartTimer)
  DiffTimer = EndTimer - StartTimer
end Function

' ****************************************************
function ToDec(t)
 ToDec = clng("&h" & t )
end function

' ****************************************************
function ToHex(n,nbDigit)
  ToHex = right(string(nbDigit,"0") & hex(n),nbDigit)
end function

' ****************************************************
function WriteMultiLineEx(sText, nbCar)
  dim s
  dim i

  if (len(sText) = 0) then
    WriteMultiLineEx = "XX"
    exit function
  end if

  s = ""
  if (len(sText) <= nbCar) then
    s = sText
  else
    for i = 1 to len(sText) step nbCar
      s = s & mid(sText,i,nbCar) & vbnewline
    next
  end if
  WriteMultiLineEx = Cstr(s)
end function
' ****************************************************
function LowerSpaceRemove(str1)
  LowerSpaceRemove = Replace(str1, " ", "")
  LowerSpaceRemove = LCase(LowerSpaceRemove)
end function
' ****************************************************
function LowerCase(str)
  LowerCase = LCase(str)
end function

' ****************************************************
function CheckTemplate(SentBytes,ReplyBytes)

  dim service
  dim expectedReplyBytes
  dim nbBytesToCheck

  if (len(SentBytes) = 0) then
    CheckTemplate = ""
    exit function
  end if

  if (len(ReplyBytes) = 0) then
    CheckTemplate = ""
    exit function
  end if


  service = left(SentBytes,2)
  select case service
    case "19"
      nbBytesToCheck = 2
    case "21"
      nbBytesToCheck = 2
    case "22"
      nbBytesToCheck = 3
    case "3B"
      nbBytesToCheck = 2
    case "2E"
      nbBytesToCheck = 3
    case else
      nbBytesToCheck = 1
  end select


  expectedReplyBytes = ToHex(ToDec(service)+64,2) & Mid(sentBytes,3,2 * (nbBytesToCheck - 1))

  if (len(ReplyBytes) < (2 * nbBytesToCheck) ) then
    CheckTemplate = expectedReplyBytes
    exit function
  end if

  if left(replyBytes,len(expectedReplyBytes)) = expectedReplyBytes then
    CheckTemplate = ""
  else
    CheckTemplate = expectedReplyBytes
  end if
end function

' ****************************************************
Function MaxValue(nbBit,Signed)

  on error resume next

  If Signed = 1 then
    MaxValue = 2^(nbBit-1) - 1
  else
    MaxValue = 2^nbBit - 1
  end if
  if err then
    MaxValue = GeneralErrorCode()
    err.clear
  end if
End Function

' ****************************************************
Function MinValue(nbBit,Signed)

  on error resume next

  If Signed = 1 then
    MinValue = -2^(nbBit-1)
  else
    MinValue = 0
  end if
  if err then
    MinValue = GeneralErrorCode()
    err.clear
  end if

End Function

' ****************************************************
function FileExists(aFilename)
   dim fso

   on error resume next
   FileExists = false
   set fso = CreateObject("Scripting.FileSystemObject")
   if fso.FileExists(aFilename) then
     FileExists = true
   else
     FileExists = false
   end if

exit function

end function

Function CreateLogFile(fileName, version)
  Dim fso
  Dim oDDT2000_cFilesAndFolder
  Dim targetPath
  Dim logFile
  
  Set fso = createObject("Scripting.fileSystemObject")
  Set oDDT2000_cFilesAndFolder = createobject("DDT2000utilities.cFilesAndFolders")
  
  targetPath = oDDT2000_cFilesAndFolder.pathAddBackslash(oDDT2000_cFilesAndFolder.getFolder_PERSONAL) & REPORT_PATH

  if fso.FileExists(targetPath & FILE_LOG_PRE & fileName & FILE_LOG_EXT) then
    fso.DeleteFile(targetPath & FILE_LOG_PRE & fileName & FILE_LOG_EXT)
  end if

  Set logFile = fso.CreateTextFile(targetPath & FILE_LOG_PRE & fileName & FILE_LOG_EXT, true)
  logFile.WriteLine("Checker version " & version)
  logFile.Close

  CreateLogFile = version
end Function


Function AddMessage(fileName, message)
  Dim fso
  Dim oDDT2000_cFilesAndFolder
  Dim targetPath
  Dim logFile
  
  Set fso = createObject("Scripting.fileSystemObject")
  Set oDDT2000_cFilesAndFolder = createobject("DDT2000utilities.cFilesAndFolders")
  
  targetPath = oDDT2000_cFilesAndFolder.pathAddBackslash(oDDT2000_cFilesAndFolder.getFolder_PERSONAL) & REPORT_PATH

  if fso.FileExists(targetPath & FILE_LOG_PRE & fileName & FILE_LOG_EXT) then
    Set logFile = fso.OpenTextFile(targetPath & FILE_LOG_PRE & fileName & FILE_LOG_EXT,IO_MODE_APPEND)
    logFile.WriteLine(GetCurrentTime() & ": " & message)
    logFile.Close
  end if

  AddMessage = message
end Function
]]>
</msxsl:script>



</xsl:stylesheet>
