;★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ Fiver-Alert ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★

;~~~~~~~~~~~~~~~~INCLUDES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#include<StringConstants.au3>    ;~~~~                     ~~
#include<AutoItConstants.au3>    ;~~~~                     ~~
#include<ColorConstantants.au3>  ;~~~~            This is not important
#include<StaticConstants.au3>    ;~~~~                     ~~
#include<WindowsConstants.au3>   ;~~~~                     ~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$timerbat = Timerinit()
While 1
 Sleep(1000)
 If TimerDiff($trimerbat) >= 14400000 Then            ; Each 4h execute your.bat file you can change it, ( 1sec = 1000 )
	ShellExecute("C:\Program Files\AutoIt3\file.bat") ; Replace this with the full directory of your .bat file , it will run it each 4 hours.
	WinWait("[CLASS:MozillaWindowClass]")             ; I don't know the title of your page, so I put the class of firefox. Script will wait until firefox is active
    Sleep(10000)                                      ;Since I don't know the title, I'll just make this script sleep 10s, to be sure your.bat file already opened the right page
$TimerSearch = TimerInit()
While TimerDiff($TimerSearch) < 30000                 ;Search for your conditions ( pixel + text ) for 30 sec
Local $Pixcord = PixelSearch(0, 0, @DESKTOPWIDTH, @DESKTOPHEIGHT, 0xB6EF83, 10) ; 10 is the range of our pixel color to search for, change it as you want ( between 0 and 255 )
If NOT @ERROR Then                                    ;If pixel green found
$SourceCode = _InetGetSource("YOUR URL PAGE")         ;Go to the source code of your page
$StrReg = StringRegExp($SourceCode, "NOT")            ;Searching for text "Not"
Switch $StrReg
Case 0                                                ;If not found :
   sleep(1)                                           ;Do nothing
Case 1                                                ;If found
   _TwilioSend1()                                      ;We do this function _twiliosend() we are going to define it later in the code
EndSwitch
EndIF
Local $pixcordRed = PixelSearch(0, 0, @DESKTOPWIDTH, @DESKTOPHEIGHT, 0xFF0000, 10) ;Searching for pure pixel red ( 10 is the range of our pixel color you can put larger or less )
If NOT @ERROR then                                                                 ;If pixel red found
$SourceCode2 = _InetGetSource("Your URL PAGE")                                     ;Go to sourcecode
$StrReg2 = StringRegExp($SourceCode2, "Designated Collection")                     ;Search for text "Designated Collection"
Switch $StrReg2
Case 0                                                                             ;If not found
   sleep(1)                                                                        ;Do nothing
Case 1                                                                             ;If found
   _TwilioSend2()                                                                   ;Do twiliosend(), we are going to define it later in the code
EndSwitch
EndIF
Wend
ProcessClose("firefox.exe")                                                        ;After 30sec of searching, close firefox
$timerbat = Timerinit()                                                            ;Repeating the loop, each 4hours.
Wend

;Function If color Green + "NOT"
Func _TwilioSend()                                                                 ;Let's define the function twilio Send
   ShellExecute("https://www.twilio.com/user/account/developer-tools/api-explorer/message-create") ; We open the page that sends sms
   WinWaitActive("IT Support Guides - Mozilla Firefox") ; If your default browser is mozilla, else we've got to change it
   MouseMove(716, 617) ; Mouse will move to the bar where you should enter the phone number ( you will certainly have other dimensions , so adapt those numbers to your window )
   sleep(1000)
   MouseClick("{LEFT}")
   sleep(1000)
   Send("+7145551212") ; We write your phone number
   Sleep(1000)
   Send("{TAB}") ; We move to the next bar
   Sleep(1000)
   Send(" PUT HERE FROM WHO " ) ; Please fill this by what you want to write in the "from" bar
   Sleep(1000)
   Send("{TAB}")
   Send("Checked OK")   ; We write Checked Ok in body
   MouseClickDrag("{LEFT}", 1356, 122, 1356, 502) ; We drag the page down
   Sleep(1000)
   MouseClick("{LEFT}", 799, 448) ; We click on "Make request")
   Sleep(8000)
   ProcessClose("firefox.exe")
EndFunc
;End Function

;Function If color Red + "Designated Collection"  ( the only thing that will change is body )
Func _TwilioSend2()
   ShellExecute("https://www.twilio.com/user/account/developer-tools/api-explorer/message-create") ; We open the page that sends sms
   WinWaitActive("IT Support Guides - Mozilla Firefox") ; If your default browser is mozilla, else we've got to change it
   MouseMove(716, 617) ; Mouse will move to the bar where you should enter the phone number ( you will certainly have other dimensions , so adapt those numbers to your window )
   sleep(1000)
   MouseClick("{LEFT}")
   sleep(1000)
   Send("+7145551212") ; We write your phone number
   Sleep(1000)
   Send("{TAB}") ; We move to the next bar
   Sleep(1000)
   Send(" PUT HERE FROM WHO " ) ; Please fill this by what you want to write in the "from" bar
   Sleep(1000)
   Send("{TAB}")
   Send("ALERT RED COLLECT")   ; We write Checked Ok in body
   MouseClickDrag("{LEFT}", 1356, 122, 1356, 502) ; We drag the page down
   Sleep(1000)
   MouseClick("{LEFT}", 799, 448) ; We click on "Make request")
   Sleep(8000)
   ProcessClose("firefox.exe")
EndFunc
; End Function


;Please take time to replace pixels of this code to adapt them to your window, also put your URL in its place, If you want to know the exact pixels where you should move Mouse
;to automate sending sms open autoit windows info tool drag the finder tool to the bar you want and go to mouse option and you will see position. (XXX.YYY)