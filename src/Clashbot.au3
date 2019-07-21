#include <AutoItConstants.au3>
#include '.\lib\include\ImageSearch2015.au3'

Local $hWnd

_Main()

Func _Main()
	_Init()
	_Run()
EndFunc

Func _Init()
	HotKeySet('{END}', '_Exit')

	_Libraries_Load()
	_Resources_Load()

	_Window_Attach('BlueStacks App Player')
EndFunc

Func _Run()
	AdlibRegister('_Items_Collect', 250)
	AdlibRegister('_ToolTip', 500)
	AdlibRegister('_TimeIn', 30000)

	While True
		Sleep(5000)
	WEnd
EndFunc

Func _ToolTip()
	Local $wndCoords = WinGetPos($hWnd)

	If WinActive('BlueStacks App Player') Then
		ToolTip('Running', $wndCoords[0] + 87, $wndCoords[1] + 211, 'Clashbot')
	Else
		ToolTip('')
	EndIf
EndFunc

Func _Items_Collect()
	Local $wndCoords = WinGetPos($hWnd)
	Local $x, $y

	Local $items[2] = ['gold', 'elixir']

	For $i = 0 To UBound($items) - 1
		For $j = 0 To 4
			If (_ImageSearchArea('..\temp\resources\' & $items[$i] & $j & '.png', 1, $wndCoords[0], $wndCoords[1], $wndCoords[0] + $wndCoords[2], $wndCoords[1] + $wndCoords[3], $x, $y, 60) And ($x <> 0 Or $y <> 0)) Then
				MouseClick('primary', $x, $y, 1, 0)
			EndIf
		Next
	Next
EndFunc

Func _TimeIn()
	Local $wndCoords = WinGetPos($hWnd)

	MouseClick('primary', $wndCoords[0] + 76, $wndCoords[1] + 41, 1, 0)
EndFunc

Func _Window_Attach($title)
	$hWnd = WinWait($title, '', 5)

	If $hWnd = 0 Then
		MsgBox(0, 'ERROR', 'Could not locate window', 10)
		_Exit()
	EndIf

	WinActivate($hWnd)

	If Not WinWaitActive($hWnd, '', 5) Then
		MsgBox(0, 'ERROR', 'Could not activate window', 10, $hWnd)
		_Exit()
	EndIf
EndFunc

Func _Libraries_Load()
	DirCreate('..\temp\lib')

	FileInstall('..\lib\ImageSearchDLLx32.dll', '..\temp\lib\ImageSearchDLLx32.dll')
	FileInstall('..\lib\ImageSearchDLLx64.dll', '..\temp\lib\ImageSearchDLLx64.dll')
	FileInstall('..\lib\msvcr110.dll', '..\temp\lib\msvcr110.dll')
	FileInstall('..\lib\msvcr110d.dll', '..\temp\lib\msvcr110d.dll')
EndFunc

Func _Resources_Load()
	DirCreate('..\temp\resources')

	FileInstall('..\resources\elixir0.png', '..\temp\resources\elixir0.png')
	FileInstall('..\resources\elixir1.png', '..\temp\resources\elixir1.png')
	FileInstall('..\resources\elixir2.png', '..\temp\resources\elixir2.png')
	FileInstall('..\resources\elixir3.png', '..\temp\resources\elixir3.png')
	FileInstall('..\resources\elixir4.png', '..\temp\resources\elixir4.png')
	FileInstall('..\resources\gold0.png', '..\temp\resources\gold0.png')
	FileInstall('..\resources\gold1.png', '..\temp\resources\gold1.png')
	FileInstall('..\resources\gold2.png', '..\temp\resources\gold2.png')
	FileInstall('..\resources\gold3.png', '..\temp\resources\gold3.png')
	FileInstall('..\resources\gold4.png', '..\temp\resources\gold4.png')
EndFunc

Func _Deinit()
	DirRemove('..\temp', $DIR_REMOVE)
EndFunc

Func _Exit()
	_Deinit()

	Exit
EndFunc
