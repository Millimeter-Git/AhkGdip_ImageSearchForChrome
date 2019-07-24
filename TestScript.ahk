#NoEnv
;ListLines, Off
SetBatchLines, -1
Process, Priority,, High

#Include <Gdip>
#Include <Gdip_ImageSearch>

OnExit, EXIT_LABEL
StartTickCout := A_TickCount
Win = ahk_class Chrome_WidgetWin_1

hWin := WinExist(Win)
;~ WinGetPos, X, Y, wWidth, wwHeight, % Win 
GetClientSize(hWin, wWidth, wHeight)

gdipToken := Gdip_Startup()
bmpHaystack := Gdip_BitmapFromHWND_EX(hWin,wWidth,wHeight)
bmpNeedle := Gdip_CreateBitmapFromFile("IMG/needle.png")
RET := Gdip_ImageSearch(bmpHaystack,bmpNeedle,LIST,0,0,0,0,0,0xFFFFFF,1,0)

MsgBox, % "Returned: " RET "`n`n" LIST "`n`nTime: " A_TickCount - StartTickCout

Gdip_DisposeImage(bmpHaystack)
Gdip_DisposeImage(bmpNeedle)
Gdip_Shutdown(gdipToken)

EXIT_LABEL: ; be really sure the script will shutdown GDIP
Gdip_Shutdown(gdipToken)
EXITAPP

GetClientSize(hWnd, ByRef w := "", ByRef h := "")
{
	VarSetCapacity(rect, 16)
	DllCall("GetClientRect", "ptr", hWnd, "ptr", &rect)
	w := NumGet(rect, 8, "int")
	h := NumGet(rect, 12, "int")
}