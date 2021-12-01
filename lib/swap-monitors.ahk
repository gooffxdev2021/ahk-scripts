; MonSwap - Swaps all the application windows from one monitor to another.
; v1.0
; Author: Alan Henager

SetWinDelay, 0 ; This switching should be instant

; Set this key combination to whatever.
+^!s::
SwapAll:
{
  DetectHiddenWindows, Off ; I think this is default, but just for safety's sake...
  WinGet, WinArray, List ; , , , Sharp
  ; Enable the above commented out portion if you are running SharpE

  i := WinArray
  Loop, %i% {
     WinID := WinArray%A_Index%
     WinGetTitle, CurWin, ahk_id %WinID%
     If (CurWin = ) ; For some reason, CurWin <> didn't seem to work.
     {}
     else
     {
        WinGet, IsMin, MinMax, ahk_id %WinID% ; The window will re-locate even if it's minimized
        If (IsMin = -1) {
           WinRestore, ahk_id %WinID%
           SwapMon(WinID)
           WinMinimize, ahk_id %WinID%
        } else {
           SwapMon(WinID)
        }
     }
  }
  return
}

SwapMon(WinID) ; Swaps window with and ID of WinID onto the other monitor
{
  SysGet, Mon1, Monitor, 1
  SysGet, Mon2, Monitor, 2
  WinGetPos, WinX, WinY, WinWidth, , ahk_id %WinID%

  WinCenter := WinX + (WinWidth / 2) ; Determines which monitor this is on by the position of the center pixel.
  if (WinCenter > Mon1Left and WinCenter < Mon1Right) {
    WinX := Mon2Left + (WinX - Mon1Left)
  } else if (WinCenter > Mon2Left and WinCenter < Mon2Right) {
    WinX := Mon1Left + (WinX - Mon2Left)
  }

  WinMove, ahk_id %WinID%, , %WinX%, %WinY%
  return
}