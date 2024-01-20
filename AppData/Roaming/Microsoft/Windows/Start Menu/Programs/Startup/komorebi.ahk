;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; .___  ________  __________  ________  ___.
; |   \ \       \ \        / /       / /   |
; |    \ \       \ \      / /_______/ /    |
; |     \ \       \ \    / ________  /     |
; |      \ \       \ \  / /       / /      |
; |_______\ \_______\ \/ /_______/ /_______|
;
; my config and hotkeys for tiling windows manager.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#SingleInstance Force

; Load library
#Include komorebic.lib.ahk

; My Config

myTerminal := "wt.exe" ; Default terminal
myBrowser := "brave.exe" ; My default browser
myEditor := "neovide" ; My default editor

; Reload AutoHotKey and Komorebi 
; Run after any changes to the Komorebi or AutoHotKey scripts
!q::
{
    Reload
    Run "komorebic start -c '$Env:USERPROFILE\komorebi.json"
}
; restart komono

; Close focused window
!c::
{
    Send "!{F4}"

}

; Open Browser
!b::
{
    Run myBrowser
}

; Open Terminal
!+Enter::
{
    Run myTerminal
}

; Open Neovide
!v::
{
    Run myEditor
}

; Focus windows
!h::Focus("left")
!j::Focus("down")
!k::Focus("up")
!l::Focus("right")
;!+[::CycleFocus("previous")
;!Tab::CycleFocus("next")

; Move windows
!+h::Move("left")
!+j::Move("down")
!+k::Move("up")
!+l::Move("right")
!+Space::Promote()

; Stack windows
!Left::Stack("left")
!Right::Stack("right")
!Up::Stack("up")
!Down::Stack("down")
!;::Unstack()
![::CycleStack("previous")
!]::CycleStack("next")

; Resize
!=::ResizeAxis("horizontal", "increase")
!-::ResizeAxis("horizontal", "decrease")
!+=::ResizeAxis("vertical", "increase")
!+-::ResizeAxis("vertical", "decrease")

; Manipulate windows
!t::ToggleFloat()
!+f::ToggleMonocle()

; Window manager options
!+r::Retile()
!+p::TogglePause()

; Layouts
!x::FlipLayout("horizontal")
!y::FlipLayout("vertical")

; Workspaces
!1::FocusWorkspace(0)
!2::FocusWorkspace(1)
!3::FocusWorkspace(2)

; Move windows across workspaces
!+1::MoveToWorkspace(0)
!+2::MoveToWorkspace(1)
!+3::MoveToWorkspace(2)
