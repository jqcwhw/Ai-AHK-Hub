#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

global totalPurchases := 0
global startTime := 0
global isRunning := false
global windows := []
global soldOutCount := 0
global lastPurchaseTime := 0
global scrollCycleCount := 0
global maxScrollsBeforeReset := 11

instructionGui := Gui("+AlwaysOnTop ", "Merchant Buy Macro")
instructionGui.SetFont("s16 bold", "Segoe UI")
instructionGui.Add("Text", "c0066CC w600 Center ", "🏪 Merchant Buy Macro 🏪")
instructionGui.Add("Progress", "w600 h2 Background0066CC")

instructionGui.SetFont("s12 bold", "Segoe UI")
instructionGui.Add("GroupBox", "x10 y+1 w600 h125", "⚙️ Settings ⚙️")
instructionGui.SetFont("s11 norm", "Segoe UI")
instructionGui.Add("Text", "xp+10 yp+25", "Purchase Delay (ms):")
global purchaseDelay := instructionGui.Add("Edit", "x+10 w60 Number", "500") 
instructionGui.Add("Text", "xp-150 yp+25", "Set the number above Low (1-250) if you arent lagging.")
instructionGui.Add("Text", "xp yp+25", "Set the number above High (500-1000) if you are lagging.")
instructionGui.Add("Text", "xp yp+25", "Set the number above to 0 if you want the fastest performance (RECCOMENDED).")

instructionGui.SetFont("s12 bold", "Segoe UI")
instructionGui.Add("GroupBox", "x10 y+20 w600 h50", "📋 Required Setup 📋")
instructionGui.SetFont("s11 norm", "Segoe UI")
instructionGui.Add("Text", "xp+10 yp+25", "
(
1️⃣  Open merchant UI for each account
)")

instructionGui.SetFont("s12 bold", "Segoe UI")
instructionGui.Add("GroupBox", "x10 y+19 w600 h70", "📊 Statistics 📊")
instructionGui.SetFont("s11 norm", "Segoe UI")
global statusText := instructionGui.Add("Text", "xp+10 yp+21 w580 Center cBlue", "Ready to Start...")
global statsText := instructionGui.Add("Text", "xp yp+25 w580 Center", "Total Purchases: 0 | Runtime: 0m 0s")

instructionGui.SetFont("s12 bold", "Segoe UI")
instructionGui.Add("GroupBox", "x10 y+10 w600 h200", "⚡ Quick Controls ⚡")

instructionGui.SetFont("s11 bold", "Segoe UI")
startBtn := instructionGui.Add("Button", "x20 yp+30 w580 h35", "Start Macro (F1)")
startBtn.OnEvent("Click", DetectAndStartMacro)
pauseBtn := instructionGui.Add("Button", "x20 y+5 w580 h35", "⏸️ Pause Macro (F2)")
reloadBtn := instructionGui.Add("Button", "x20 y+5 w580 h35", "🔄 Reload Script (F5)")
exitBtn := instructionGui.Add("Button", "x20 y+5 w580 h35", "❌ Exit Macro (F3)")

pauseBtn.OnEvent("Click", (*) => TogglePause())
reloadBtn.OnEvent("Click", (*) => Reload())
exitBtn.OnEvent("Click", (*) => ExitApp())

instructionGui.SetFont("s10", "Segoe UI")
instructionGui.Add("Text", "x10 y+10 w600 cGray Center", "F1: Start | F2: Pause | F5: Reload | F3: Exit")

instructionGui.BackColor := "FFFFFF"
instructionGui.Show()

DetectAndStartMacro(*) {
    global windows
    DetectRobloxWindows()
    if (windows.Length > 0) {
        Main()
    }
}

UpdateStats() {
    if (startTime = 0) {
        return
    }
    runtime := FormatTime(A_TickCount - startTime)
    elapsedMinutes := (A_TickCount - startTime) / 60000
    purchaseRate := elapsedMinutes > 0 ? Round(totalPurchases / elapsedMinutes, 1) : 0
    statsText.Value := "Total Purchases: " totalPurchases " | Runtime: " runtime " | Rate: " purchaseRate "/min"
}

FormatTime(ms) {
    seconds := Floor(ms/1000)
    minutes := Floor(seconds/60)
    seconds := Mod(seconds, 60)
    return minutes "m " seconds "s"
}

TogglePause() {
    Pause(-1)
    if (A_IsPaused) {
        instructionGui.Show()
        UpdateStats()
        statusText.Value := "⏸️ Macro Paused"
    } else {
        statusText.Value := "▶️ Macro Running"
    }
}

DetectRobloxWindows() {
    global windows, statusText
    windows := []
    windowsList := WinGetList("ahk_exe RobloxPlayerBeta.exe")
    for hwnd in windowsList {
        if WinGetStyle("ahk_id " hwnd) & 0x10000000
        {
            windows.Push(hwnd)
        }
    }
    if (windows.Length = 0) {
        UpdateStatus("No Roblox windows detected.")
    } else {
        UpdateStatus("Found " windows.Length " Roblox windows. Optimizing layout...")
        ResizeRobloxWindows()
    }
}

ResizeRobloxWindows() {
    global windows
    screenWidth := A_ScreenWidth
    screenHeight := A_ScreenHeight
    windowWidth := 800
    windowHeight := 600
        
    for hwnd in windows {
        WinActivate("ahk_id " hwnd)
        
        x := 0
        y := 0
        
        WinMove(x, y, windowWidth, windowHeight, "ahk_id " hwnd)
    }
}

UpdateStatus(status) {
    global statusText
    statusText.Value := status
}

Main() {
    global isRunning, startTime, totalPurchases, statusText, windows, soldOutCount, lastPurchaseTime
    
    if (isRunning) {
        return
    }
    
    if (windows.Length = 0) {
        UpdateStatus("No Roblox windows detected. Please detect windows first.")
        return
    }
    
    isRunning := true
    startTime := A_TickCount
    lastPurchaseTime := A_TickCount
    SetTimer(UpdateStats, 1000)
    
    try {
        MainLoop()
    } catch Error as err {
        MsgBox("An error occurred: " err.Message "`nThe script will reload.", "Error", "Icon!")
        Reload()
    }
}

MainLoop() {
    global totalPurchases, soldOutCount, windows, lastPurchaseTime, scrollCycleCount
    
    loop {
        for hwnd in windows {
            if (!WinExist("ahk_id " hwnd)) {
                continue
            }
            
            WinActivate("ahk_id " hwnd)
            Sleep(purchaseDelay.Value)
            
            if (A_TickCount - lastPurchaseTime > 300000) {
                UpdateStatus("No purchases in 5 minutes. Reloading windows...")
                ResizeRobloxWindows()
                lastPurchaseTime := A_TickCount
            }
            
            ; Keep clicking blue items on current account until none left
            ProcessAllBlueItemsOnCurrentAccount(hwnd)
            
            Sleep(purchaseDelay.Value)
        }
        
        ; After going through all accounts, scroll down and repeat
        ScrollDown()
        
        Sleep(purchaseDelay.Value)
    }
}

ProcessAllBlueItemsOnCurrentAccount(hwnd) {
    local blueItemFound := true
    local attempts := 0
    local maxAttempts := 10  ; Safety limit to prevent infinite loops
    
    ; Keep processing blue items on this account until none are found
    while (blueItemFound && attempts < maxAttempts) {
        blueItemFound := false
        attempts++
        
        try {
            if (PixelSearch(&mX, &mY, 62, 178, 756, 476, "0x66E4FD", 15)) {
                ProcessPurchase(mX, mY)
                blueItemFound := true
                Sleep(purchaseDelay.Value) ; Wait between clicks
            }
        } catch Error as err {
            UpdateStatus("PixelSearch error: " err.Message)
            break
        }
    }
    
    if (!blueItemFound) {
        UpdateStatus("No more blue items found on current account.")
    }
}

ScrollDown() {
    global scrollCycleCount, maxScrollsBeforeReset
    
    middleX := 400
    middleY := 300
    
        SendEvent "{Click " middleX " " middleY "}"
        Send("{WheelDown}")

    scrollCycleCount++
    UpdateStatus("Scrolled down (cycle " . scrollCycleCount . "/" . maxScrollsBeforeReset . ")")
    
    if (scrollCycleCount >= maxScrollsBeforeReset) {
        ScrollUp()
        scrollCycleCount := 0
    }
}

ScrollUp() {
    middleX := 400
    middleY := 300
    
    UpdateStatus("Resetting scroll position...")
    loop 12 {
        SendEvent "{Click " middleX " " middleY "}"
        Send("{WheelUp}")
    }
    
    UpdateStatus("Scrolled back to top")
}

ProcessPurchase(x, y) {
    global totalPurchases, soldOutCount, lastPurchaseTime
    
    SendEvent "{Click " x " " y "}"
    Sleep(50)
    SendEvent "{Click 395, 397}"
    totalPurchases++
    lastPurchaseTime := A_TickCount
    UpdateStatus("Purchase made! Total: " totalPurchases)
    soldOutCount := 0
}

ExitHandler(*) {
    ExitApp()
}

F1::DetectAndStartMacro()
F2::TogglePause()
F5::Reload()
F3::ExitHandler()
