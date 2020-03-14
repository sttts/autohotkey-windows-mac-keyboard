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

; LAlt & r::Send #r

; swap left command/windows key with left alt
LWin::LAlt
LAlt::Return ; add a semicolon in front of this line if you want to disable the windows key

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
LAlt & s::Send ^{s}

; Selecting
LAlt & a::Send ^a

; Copying
LAlt & c::Send ^c

; Pasting
LAlt & v::Send ^v

; Cutting
LAlt & x::Send ^x

; Opening
LAlt & o::Send ^o

; Finding
LAlt & f::Send ^f

; Undo
LAlt & z::Send ^z

; Redo
LAlt & y::Send ^y

; New tab
LAlt & t::Send ^t

; close tab
LAlt & w::Send ^w

; new doc
LAlt & n::Send ^n

; Close windows (cmd + q to Alt + F4)
LAlt & q::Send !{F4}

; minimize windows
LAlt & m::WinMinimize,a

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

; switch keyboard layout
#^Space::SendInput {Ctrl UP}{LShift DOWN}

; --------------------------------------------------------------
; OS X keyboard mappings for special chars
; --------------------------------------------------------------

; Map Alt + L to @
LWin & l::SendInput {@}

; Map Alt + N to ©
LWin & g::SendInput {©}

; Map Alt + o to ø
LWin & o::SendInput {ø}

; Map Alt + 5 to [
LWin & 5::SendInput {[}

; Map Alt + 6 to ]
LWin & 6::SendInput {]}

; Map Alt + E to €
LWin & e::SendInput {€}

; Map Alt + - to –
LWin & -::SendInput {–}

; Map Alt + 8 to {
LWin & 8::SendInput {{}

; Map Alt + 9 to }
LWin & 9::SendInput {}}

; Map Alt + R to ®
LWin & r::SendInput {®}

; Map Alt + N to |
LWin & 7::SendInput {|}

; Map Alt + W to ∑
LWin & w::SendInput {∑}

; Map Alt + N to ~
LWin & n::SendInput {~}

; Map Alt + 3 to #
LWin & 3::SendInput {#}

#if getKeyState("LWin")
Shift & 6::Send {^}{Space}
Shift & 7::SendInput {\}
#if

; --------------------------------------------------------------
; Custom mappings for special chars
; --------------------------------------------------------------

;#ö::SendInput {[} 
;#ä::SendInput {]} 

;^ö::SendInput {{} 
;^ä::SendInput {}} 

; alt-delete deletes previous word
LWin & BS::Send {LShift down}{LCtrl down}{Left}{LShift Up}{Lctrl up}{Backspace}
^
; Navigation of smaller chunks (skip word)
LWin & Left::Send {ctrl down}{Left}{ctrl up}
LWin & Right::Send {ctrl down}{Right}{ctrl up}

; Navigation using of bigger chunks (Skip to start/end of line)
!Left::Send {Home}
!Right::Send {End}
!Up::Send {PgUp}
!Down::Send {PgDown}

; Selection (uses a combination of the above with shift)
^+Left::Send {shift down}{Home}}{shift up}
^+Right::Send {shift down}{End}}{shift up}
^+Up::Send {Lctrl down}{shift down}{Home}}{shift up}{Lctrl up}
^+Down::Send {Lctrl down}{shift down}{End}}{shift up}{Lctrl up}

; Start Menu
LWin & Space::Send ^{Esc}

; Do not open start menu on Windows key or go to menu
;#~LAlt Up::Send {Blind}{vk07}
;#~LWin Up:: return

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

