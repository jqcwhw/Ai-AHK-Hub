; PS99 Auto Hatch
#Requires AutoHotkey v2.0
#SingleInstance Force

hatching := false

; F1 - Toggle hatching
F1::
{
    global hatching
    hatching := !hatching
    
    if (hatching) {
        if WinExist("Roblox") {
            WinActivate()
        }
        
        SetTimer(HatchLoop, 3000)
        ToolTip("Auto Hatch: ON")
    } else {
        SetTimer(HatchLoop, 0)
        ToolTip("Auto Hatch: OFF")
    }
    
    SetTimer(() => ToolTip(), -2000)
}

HatchLoop() {
    ; Click on egg location (adjust coordinates)
    Click(960, 540)  ; Center of screen
    Sleep(500)
    
    ; Click hatch button (adjust based on your UI)
    Click(960, 700)
    Sleep(500)
    
    ; Skip animation (press space or click)
    Send("{Space}")
    Sleep(500)
    
    ; Close results
    Send("{Space}")
    Sleep(1000)
}

^q::ExitApp()