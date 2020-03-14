;-----------------------------------------
; Mac keyboard to Windows Key Mappings
;=========================================

; --------------------------------------------------------------
; NOTES
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.

#InstallKeybdHook
#SingleInstance force
SetTitleMatchMode 2
SendMode Input


; --------------------------------------------------------------
; media/function keys all mapped to the right option key
; --------------------------------------------------------------

RAlt & F7::SendInput {Media_Prev}
RAlt & F8::SendInput {Media_Play_Pause}
RAlt & F9::SendInput {Media_Next}
F10::SendInput {Volume_Mute}
F11::SendInput {Volume_Down}
F12::SendInput {Volume_Up}

; swap left command/windows key with left alt
LWin::LAlt
; LAlt::LWin ; add a semicolon in front of this line if you want to disable the windows key

; Eject Key
;F20::SendInput {Insert} ; F20 doesn't show up on AHK anymore, see #3

; F13-15, standard windows mapping
F13::SendInput {PrintScreen}
F14::SendInput {ScrollLock}
F15::SendInput {Pause}

;F16-19 custom app launchers, see http://www.autohotkey.com/docs/Tutorial.htm for usage info
;F16::Run http://twitter.com
;F17::Run http://tumblr.com
;F18::Run http://www.reddit.com
;F19::Run https://facebook.com

; --------------------------------------------------------------
; OS X system shortcuts
; --------------------------------------------------------------

; Make Ctrl + S work with cmd (windows) key
!s::Send ^{s}

; Selecting
!a::Send ^a

; Copying
!c::Send ^c

; Pasting
!v::Send ^v

; Cutting
!x::Send ^x

; Opening
!o::Send ^o

; Finding
!f::Send ^f

; Undo
!z::Send ^z

; Redo
!y::Send ^y

; New tab
!t::Send ^t

; close tab
!w::Send ^w

; new doc
!n::Send ^n

; Close windows (cmd + q to Alt + F4)
!q::Send !{F4}

^e::Send {End}
^a::Send {Home}

; Remap Windows + Tab to Alt + Tab.
;Lwin & Tab::AltTab
;Lalt & Tab::Send !{Tab}
;Lwin & Tab::Send #{Tab}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Cmd-Tab ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*q:: ;one-key alt-tab (tested on Windows 7)
$Tab::
vAltTabTickCount := A_TickCount
if WinActive("ahk_class TaskSwitcherWnd")
	SendInput, {Tab}
else
{
	SendInput, {Alt Down}{Tab}
	SetTimer, AltTabSendTab, 50
}
return

AltTabSendTab:
if GetKeyState("q", "P")
|| GetKeyState("Tab", "P")
	vAltTabTickCount := A_TickCount
if WinActive("ahk_class TaskSwitcherWnd")
&& !(A_TickCount - vAltTabTickCount > 400)
	return
SendInput, {Alt Up}
SetTimer, AltTabSendTab, Off
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Alt-Tab ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This AutoHotkey script is to switch between open Windows of the same type and same App (.exe)
; The "type" checking is based on the App's Title convention that stipulates that the App name should be at the end of the Window title (Eg: New Document - Word )
; It works well with regular Window Apps, Chrome Shortcuts and Chrome Apps

ExtractAppTitle(FullTitle)
{	
	AppTitle := SubStr(FullTitle, InStr(FullTitle, " ", false, -1) + 1)
	Return AppTitle
}

; Alt + ` -  Activate NEXT Window of same type (title checking) of the current APP
Lwin & Tab::
WinGet, ActiveProcess, ProcessName, A
WinGet, OpenWindowsAmount, Count, ahk_exe %ActiveProcess%

If OpenWindowsAmount = 1  ; If only one Window exist, do nothing
    Return
Else
	{
		WinGetTitle, FullTitle, A
		AppTitle := ExtractAppTitle(FullTitle)

		SetTitleMatchMode, 2		
		WinGet, WindowsWithSameTitleList, List, %AppTitle%
		
		If WindowsWithSameTitleList > 1 ; If several Window of same type (title checking) exist
		{
			WinActivate, % "ahk_id " WindowsWithSameTitleList%WindowsWithSameTitleList%	; Activate next Window	
		}
	}
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; minimize windows
!m::WinMinimize,a

; switch keyboard layout
#^Space::SendInput {Ctrl UP}{LShift DOWN}

; --------------------------------------------------------------
; OS X keyboard mappings for special chars
; --------------------------------------------------------------

; Map Alt + L to @
#l::SendInput {@}

; Map Alt + N to \
+#7::SendInput {\}

; Map Alt + N to ©
#g::SendInput {©}

; Map Alt + o to ø
#o::SendInput {ø}

; Map Alt + 5 to [
#5::SendInput {[}

; Map Alt + 6 to ]
#6::SendInput {]}

; Map Alt + E to €
#e::SendInput {€}

; Map Alt + - to –
#-::SendInput {–}

; Map Alt + 8 to {
#8::SendInput {{}

; Map Alt + 9 to }
#9::SendInput {}}

; Map Alt + - to ±
#+::SendInput {±}

; Map Alt + R to ®
#r::SendInput {®}

; Map Alt + N to |
#7::SendInput {|}

; Map Alt + W to ∑
#w::SendInput {∑}

; Map Alt + N to ~
#n::SendInput {~}

; Map Alt + 3 to #
#3::SendInput {#}

#r::#r



; --------------------------------------------------------------
; Custom mappings for special chars
; --------------------------------------------------------------

;#ö::SendInput {[} 
;#ä::SendInput {]} 

;^ö::SendInput {{} 
;^ä::SendInput {}} 

; alt-delete deletes previous word
#BS::Send {LShift down}{LCtrl down}{Left}{LShift Up}{Lctrl up}{Backspace}

; Navigation of smaller chunks (skip word)
!Left::Send {ctrl down}{Left}{ctrl up}
!Right::Send {ctrl down}{Right}{ctrl up}

; Navigation using of bigger chunks (Skip to start/end of line)
#Left::Send {Home}
#Right::Send {End}
#Up::Send {PgUp}
#Down::Send {PgDown}

; Selection (uses a combination of the above with shift)
#+Left::Send {ctrl down}{shift down}{Left}{shift up}{ctrl up}
#+Right::Send {ctrl down}{shift down}{Right}{shift up}{ctrl up}
^+Left::Send {shift down}{Home}}{shift up}
^+Right::Send {shift down}{End}}{shift up}
#+Up::Send {ctrl down}{shift down}{Up}}{shift up}{ctrl up}
#+Down::Send {ctrl down}{shift down}{Down}}{shift up}{ctrl up}
^+Up::Send {Lctrl down}{shift down}{Home}}{shift up}{Lctrl up}
^+Down::Send {Lctrl down}{shift down}{End}}{shift up}{Lctrl up}

; Start Menu
!Space::Send ^{Esc}

; Do not open start menu on Windows key or go to menu
#~LAlt Up::Send {Blind}{vk07}
#~LWin Up:: return

; --------------------------------------------------------------
; Application specific
; --------------------------------------------------------------

; Google Chrome
#IfWinActive, ahk_class Chrome_WidgetWin_1

; Show Web Developer Tools with cmd + alt + i
#!i::Send {F12}

; Show source code with cmd + alt + u
#!u::Send ^u

#IfWinActive

