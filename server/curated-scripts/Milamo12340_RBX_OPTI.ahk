
; PS99 CPU & GPU Optimizer By ✨Milamoo12340✨
; Specialized script for CPU and GPU performance optimization
; AutoHotkey v2

#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn ;ignore all and force run with administrator elevations 

; Optimization Configuration
global CPUOptimization := {
    SetHighPriority: true,
    DisableUnnecessaryServices: true,
    OptimizePowerPlan: true,
    SetProcessorAffinity: true,
    EnableGameMode: true
}

global GPUOptimization := {
    OptimizeNVIDIA: true,
    OptimizeAMD: true,
    OptimizeIntel: true,
    DisableVSync: true,
    MaximizePerformance: true
}

; Initialize optimizer
InitializeCPUGPUOptimizer()

InitializeCPUGPUOptimizer() {
    ; Detect hardware
    DetectHardware()
    
    ; Create GUI
    CreateOptimizerGUI()
    
    ; Apply initial optimizations
    ApplyInitialOptimizations()
}

DetectHardware() {
    ; Detect CPU
    for objItem in ComObjGet("winmgmts:").ExecQuery("SELECT Name, NumberOfCores, NumberOfLogicalProcessors FROM Win32_Processor") {
        global CPUName := objItem.Name
        global CPUCores := objItem.NumberOfCores
        global CPUThreads := objItem.NumberOfLogicalProcessors
        break
    }
    
    ; Detect GPU
    global GPUName := ""
    global GPUVendor := ""
    for objItem in ComObjGet("winmgmts:").ExecQuery("SELECT Name FROM Win32_VideoController WHERE PNPDeviceID LIKE 'PCI%'") {
        GPUName := objItem.Name
        if (InStr(GPUName, "NVIDIA")) {
            GPUVendor := "NVIDIA"
        } else if (InStr(GPUName, "AMD") || InStr(GPUName, "Radeon")) {
            GPUVendor := "AMD"
        } else if (InStr(GPUName, "Intel")) {
            GPUVendor := "Intel"
        }
        break
    }
}

CreateOptimizerGUI() {
    ; Create main window
    OptimizerGui := Gui("+Resize", "😻PS99 Graphics CPU & GPU Optimizer😻")
    OptimizerGui.SetFont("s10", "Segoe UI")
    OptimizerGui.BackColor := "0x2D2D2D"
    
    ; Hardware Info
    OptimizerGui.AddText("x10 y10 w400 h25 cWhite Center", "Hardware Booster By ✨Milamoo12340✨").SetFont("s12 Bold")
    OptimizerGui.AddText("x10 y40 w100 h20 cWhite", "CPU:").SetFont("s9")
    OptimizerGui.AddText("x110 y40 w290 h20 cLime", CPUName).SetFont("s9")
    OptimizerGui.AddText("x10 y60 w100 h20 cWhite", "Cores/Threads:").SetFont("s9")
    OptimizerGui.AddText("x110 y60 w290 h20 cLime", CPUCores . " cores / " . CPUThreads . " threads").SetFont("s9")
    OptimizerGui.AddText("x10 y80 w100 h20 cWhite", "GPU:").SetFont("s9")
    OptimizerGui.AddText("x110 y80 w290 h20 cLime", GPUName).SetFont("s9")
    
    ; CPU Optimizations
    OptimizerGui.AddText("x10 y120 w400 h25 cWhite Center", "CPU Optimizations").SetFont("s12 Bold")
    
    CPUPriorityBtn := OptimizerGui.AddButton("x10 y150 w190 h30", "Set High Priority")
    CPUPriorityBtn.OnEvent("Click", SetHighPriority)
    
    PowerPlanBtn := OptimizerGui.AddButton("x210 y150 w190 h30", "High Performance Plan")
    PowerPlanBtn.OnEvent("Click", SetHighPerformancePlan)
    
    AffinityBtn := OptimizerGui.AddButton("x10 y190 w190 h30", "Optimize CPU Affinity")
    AffinityBtn.OnEvent("Click", OptimizeCPUAffinity)
    
    GameModeBtn := OptimizerGui.AddButton("x210 y190 w190 h30", "Enable Game Mode")
    GameModeBtn.OnEvent("Click", EnableWindowsGameMode)
    
    ; GPU Optimizations
    OptimizerGui.AddText("x10 y240 w400 h25 cWhite Center", "GPU Optimizations").SetFont("s12 Bold")
    
    if (GPUVendor = "NVIDIA") {
        NVIDIABtn := OptimizerGui.AddButton("x10 y270 w190 h30", "NVIDIA Optimization")
        NVIDIABtn.OnEvent("Click", OptimizeNVIDIA)
    }
    
    if (GPUVendor = "AMD") {
        AMDBtn := OptimizerGui.AddButton("x10 y270 w190 h30", "AMD Optimization")
        AMDBtn.OnEvent("Click", OptimizeAMD)
    }
    
    VSyncBtn := OptimizerGui.AddButton("x210 y270 w190 h30", "Disable VSync")
    VSyncBtn.OnEvent("Click", DisableVSync)
    
    ; System Optimizations
    OptimizerGui.AddText("x10 y320 w400 h25 cWhite Center", "System Optimizations").SetFont("s12 Bold")
    
    ServicesBtn := OptimizerGui.AddButton("x10 y350 w120 h30", "Stop Services")
    ServicesBtn.OnEvent("Click", StopUnnecessaryServices)
    
    TimerBtn := OptimizerGui.AddButton("x140 y350 w120 h30", "Set Timer Res")
    TimerBtn.OnEvent("Click", SetOptimalTimerResolution)
    
    FullscreenBtn := OptimizerGui.AddButton("x270 y350 w130 h30", "Fullscreen Opts")
    FullscreenBtn.OnEvent("Click", OptimizeFullscreenSettings)
    
    ; Apply All Button
    ApplyAllBtn := OptimizerGui.AddButton("x10 y400 w400 h40 cWhite", "APPLY ALL OPTIMIZATIONS")
    ApplyAllBtn.SetFont("s11 Bold")
    ApplyAllBtn.OnEvent("Click", ApplyAllOptimizations)
    
    ; Status Log
    OptimizerGui.AddText("x10 y450 w400 h20 cWhite", "Status Log:").SetFont("s10 Bold")
    global StatusLog := OptimizerGui.AddEdit("x10 y470 w400 h100 ReadOnly VScroll Background0x1E1E1E cLime", "PS99 CPU & GPU Optimizer Ready`nHardware detected successfully`nClick APPLY ALL OPTIMIZATIONS to begin")
    
    ; Store GUI reference
    global MainOptimizerGUI := OptimizerGui
    
    ; Show GUI
    OptimizerGui.Show("w420 h590")
}

; === CPU OPTIMIZATIONS ===
SetHighPriority(*) {
    LogOptimizerMessage("Setting high priority for Roblox processes...")
    
    processesOptimized := 0
    for process in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process WHERE Name='RobloxPlayerBeta.exe'") {
        try {
            ProcessSetPriority("High", process.ProcessId)
            processesOptimized++
            LogOptimizerMessage("✓ Set high priority for PID: " . process.ProcessId)
        } catch Error as e {
            LogOptimizerMessage("⚠ Could not set priority: " . e.Message)
        }
    }
    
    if (processesOptimized = 0) {
        LogOptimizerMessage("ℹ No Roblox processes found")
    } else {
        LogOptimizerMessage("Optimized " . processesOptimized . " Roblox processes")
    }
}

SetHighPerformancePlan(*) {
    LogOptimizerMessage("Setting high performance power plan...")
    
    try {
        ; High Performance GUID
        RunWait('powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c', , "Hide")
        LogOptimizerMessage("✓ High performance power plan activated")
        
        ; Additional power settings for gaming
        RunWait('powercfg /change monitor-timeout-ac 0', , "Hide")
        RunWait('powercfg /change disk-timeout-ac 0', , "Hide")
        RunWait('powercfg /change standby-timeout-ac 0', , "Hide")
        LogOptimizerMessage("✓ Power saving features disabled")
    } catch Error as e {
        LogOptimizerMessage("⚠ Could not change power plan (requires admin)")
    }
}

OptimizeCPUAffinity(*) {
    LogOptimizerMessage("Optimizing CPU affinity for Roblox...")
    
    if (CPUCores <= 2) {
        LogOptimizerMessage("ℹ CPU has too few cores for affinity optimization")
        return
    }
    
    ; Calculate optimal affinity mask (use cores 2-N, leave core 0 for system)
    affinityMask := 0
    Loop CPUCores - 1 {
        affinityMask |= (1 << A_Index)  ; Skip core 0
    }
    
    for process in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process WHERE Name='RobloxPlayerBeta.exe'") {
        try {
            ; Set CPU affinity using WMI
            hProcess := DllCall("kernel32.dll\OpenProcess", "UInt", 0x0200, "Int", false, "UInt", process.ProcessId, "Ptr")
            if (hProcess) {
                DllCall("kernel32.dll\SetProcessAffinityMask", "Ptr", hProcess, "Ptr", affinityMask)
                DllCall("kernel32.dll\CloseHandle", "Ptr", hProcess)
                LogOptimizerMessage("✓ CPU affinity optimized for PID: " . process.ProcessId)
            }
        } catch Error as e {
            LogOptimizerMessage("⚠ Could not set CPU affinity: " . e.Message)
        }
    }
}

EnableWindowsGameMode(*) {
    LogOptimizerMessage("Enabling Windows Game Mode...")
    
    try {
        ; Enable Game Mode
        RegWrite("1", "REG_DWORD", "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar", "AutoGameModeEnabled")
        RegWrite("1", "REG_DWORD", "HKEY_CURRENT_USER\System\GameConfigStore", "GameDVR_Enabled")
        LogOptimizerMessage("✓ Windows Game Mode enabled")
    } catch Error as e {
        LogOptimizerMessage("⚠ Could not enable Game Mode: " . e.Message)
    }
}

; === GPU OPTIMIZATIONS ===
OptimizeNVIDIA(*) {
    LogOptimizerMessage("Applying NVIDIA optimizations...")
    
    try {
        ; NVIDIA Control Panel settings via registry
        nvKey := "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video\{NVIDIA_GUID}\0000"
        
        ; Maximum Performance
        RegWrite("1", "REG_DWORD", nvKey, "PowerMizerEnable")
        RegWrite("1", "REG_DWORD", nvKey, "PowerMizerLevel")
        
        ; Disable VSync
        RegWrite("0", "REG_DWORD", nvKey, "VSync")
        
        LogOptimizerMessage("✓ NVIDIA settings optimized")
    } catch {
        LogOptimizerMessage("⚠ Could not modify NVIDIA settings")
    }
    
    ; Try to launch NVIDIA Control Panel settings
    try {
        Run("nvidia-settings", , "Hide")
        LogOptimizerMessage("ℹ NVIDIA Control Panel launched - apply manual settings")
    } catch {
        LogOptimizerMessage("ℹ NVIDIA Control Panel not found")
    }
}

OptimizeAMD(*) {
    LogOptimizerMessage("Applying AMD optimizations...")
    
    try {
        ; AMD registry optimizations
        amdKey := "HKEY_CURRENT_USER\SOFTWARE\AMD\CN"
        
        ; if the AMD or RADEON software is not found try detect or locate AMD software in these locations and continue optimisations C:\Program Files (x86)\ATI Technologies\ATI.ACE\Core-Static HKEY_LOCAL_MACHINE\Software\ATI\ACE HKEY_CURRENT_USER\SOFTWARE\ATI\ACE)

        ; Performance settings
        RegWrite("1", "REG_DWORD", amdKey, "PowerState")
        RegWrite("0", "REG_DWORD", amdKey, "VSync")
        
        LogOptimizerMessage("✓ AMD settings optimized")
    } catch {
        LogOptimizerMessage("⚠ Could not modify AMD settings")
    }
    
    ; Try to launch AMD Software 
    ; if the AMD or RADEON software is not found try detect or locate AMD software in these locations and continue optimisations ("C:\Program Files (x86)\ATI Technologies\ATI.ACE\Core-Static", "HKEY_LOCAL_MACHINE\Software\ATI\ACE HKEY_CURRENT_USER\SOFTWARE\ATI\ACE")
    try {
        Run("RadeonSettings.exe", , "Hide")
        LogOptimizerMessage("ℹ AMD Software launched - apply manual settings")
    } catch {
        LogOptimizerMessage("ℹ")
    }
}

DisableVSync(*) {
    LogOptimizerMessage("Disabling VSync system-wide...")
    
    try {
        ; DirectX VSync disable
        RegWrite("0", "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX", "DisableVSync")
        
        ; Additional VSync registry entries
        RegWrite("0", "REG_DWORD", "HKEY_CURRENT_USER\SOFTWARE\Microsoft\DirectX\UserGpuPreferences", "VSync")
        
        LogOptimizerMessage("✓ VSync disabled system-wide")
    } catch {
        LogOptimizerMessage("⚠ Could not disable VSync")
    }
}

; === SYSTEM OPTIMIZATIONS ===
StopUnnecessaryServices(*) {
    LogOptimizerMessage("Stopping unnecessary services...")
    
    servicesToStop := [
        "Fax",
        "Spooler",
        "TabletInputService",
        "Themes",
        "WSearch",
        "SysMain"  ; Superfetch
    ]
    
    stoppedCount := 0
    for serviceName in servicesToStop {
        try {
            RunWait('sc stop "' . serviceName . '"', , "Hide")
            stoppedCount++
            LogOptimizerMessage("✓ Stopped service: " . serviceName)
        } catch {
            ; Service may not exist or already stopped
        }
    }
    
    LogOptimizerMessage("Stopped " . stoppedCount . " unnecessary services")
}

SetOptimalTimerResolution(*) {
    LogOptimizerMessage("Setting optimal timer resolution...")
    
    try {
        ; Set to 1ms resolution for better performance
        DllCall("winmm.dll\timeBeginPeriod", "UInt", 1)
        LogOptimizerMessage("✓ Timer resolution set to 1ms")
    } catch Error as e {
        LogOptimizerMessage("⚠ Could not set timer resolution: " . e.Message)
    }
}

OptimizeFullscreenSettings(*) {
    LogOptimizerMessage("Optimizing fullscreen settings...")
    
    try {
        ; Disable fullscreen optimizations for Roblox check file path C:\Users\%USER%\AppData\Local\Roblox\Versions\version-2a06298afe3947ab although version may differ if still not found search the windows desktop location for robloxplayer or robloxplayerbeta.exe
        robloxPath := GetRobloxExecutablePath()
        if (robloxPath) {
            RegWrite("~ DISABLEDXMAXIMIZEDWINDOWEDMODE", "REG_SZ", "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", robloxPath)
            LogOptimizerMessage("✓ Fullscreen optimizations disabled for Roblox")
        } else {
            LogOptimizerMessage("⚠ Could not find a fullscreen roblox executable no fullscreen optimisation needed")
        }
    } catch Error as e {
        LogOptimizerMessage("⚠ Could not optimize fullscreen settings: " . e.Message)
    }
}

GetRobloxExecutablePath() {
    possiblePaths := [
        A_AppData . "\..\Local\Roblox\Versions",
        "C:\Program Files (x86)\Roblox\Versions"
    ]
    
    for basePath in possiblePaths {
        if (DirExist(basePath)) {
            Loop Files, basePath . "\*\RobloxPlayerBeta.exe", "R" {
                return A_LoopFileFullPath
            }
        }
    }
    
    return ""
}

; === APPLY ALL OPTIMIZATIONS ===
ApplyAllOptimizations(*) {
    LogOptimizerMessage("=== APPLYING ALL OPTIMIZATIONS ===")
    
    SetHighPriority()
    Sleep(500)
    SetHighPerformancePlan()
    Sleep(500)
    OptimizeCPUAffinity()
    Sleep(500)
    EnableWindowsGameMode()
    Sleep(500)
    
    if (GPUVendor = "NVIDIA") {
        OptimizeNVIDIA()
        Sleep(500)
    } else if (GPUVendor = "AMD") {
        OptimizeAMD()
        Sleep(500)
    }
    
    DisableVSync()
    Sleep(500)
    StopUnnecessaryServices()
    Sleep(500)
    SetOptimalTimerResolution()
    Sleep(500)
    OptimizeFullscreenSettings()
    
    LogOptimizerMessage("=== ALL OPTIMIZATIONS APPLIED ===")
    LogOptimizerMessage("Restart Roblox for best results")
}

ApplyInitialOptimizations() {
    ; Apply basic optimizations on startup
    LogOptimizerMessage("Applying initial optimizations...")
    
    ; Set timer resolution immediately
    try {
        DllCall("winmm.dll\timeBeginPeriod", "UInt", 1)
    } catch {
    }
    
    LogOptimizerMessage("Initial optimizations applied")
}

; === UTILITY FUNCTIONS ===
LogOptimizerMessage(message) {
    timestamp := FormatTime(A_Now, "HH:mm:ss")
    logText := "[" . timestamp . "] " . message
    
    ; Append to log
    currentText := StatusLog.Text
    newText := currentText . "`n" . logText
    
    ; Keep only last 15 lines
    lines := StrSplit(newText, "`n")
    if (lines.Length > 15) {
     
        newText := ""
        for line in lines {
            newText .= line . "`n"
        }
    }
    
    StatusLog.Text := newText
    
    ; Auto-scroll to bottom
    SendMessage(0x0115, 7, 0, StatusLog.Hwnd)
}

; === HOTKEYS ===
SetHighPriority("Alt&P")
ApplyAllOptimizations("Alt&G")

; === CLEANUP ON EXIT ===
OnExit(CleanupCPUGPUOptimizer)

CleanupCPUGPUOptimizer(*) {
    ; Reset timer resolution
    try {
        DllCall("winmm.dll\timeEndPeriod", "UInt", 1)
    } catch {
    }
    
    LogOptimizerMessage("PS99 CPU & GPU Optimizer closed")
    ExitApp()
}

; Show startup message
LogOptimizerMessage("=== PS99 CPU & GPU OPTIMIZER ===")
LogOptimizerMessage("Hardware: " . CPUName)
LogOptimizerMessage("GPU: " . GPUName)
LogOptimizerMessage("Ready for optimization!")
