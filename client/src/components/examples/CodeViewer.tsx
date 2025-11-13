import CodeViewer from '../CodeViewer';

const sampleCode = `; AutoHotkey v2 Window Snap Script
#Requires AutoHotkey v2.0

; Win + Left Arrow - Snap window to left half
#Left::
{
    WinGetPos(&X, &Y, &W, &H, "A")
    MonitorGetWorkArea(, &Left, &Top, &Right, &Bottom)
    WinMove(Left, Top, (Right-Left)//2, Bottom-Top, "A")
}

; Win + Right Arrow - Snap window to right half
#Right::
{
    WinGetPos(&X, &Y, &W, &H, "A")
    MonitorGetWorkArea(, &Left, &Top, &Right, &Bottom)
    WinMove(Left+(Right-Left)//2, Top, (Right-Left)//2, Bottom-Top, "A")
}`;

export default function CodeViewerExample() {
  return <CodeViewer code={sampleCode} title="Window Snap Script" />;
}