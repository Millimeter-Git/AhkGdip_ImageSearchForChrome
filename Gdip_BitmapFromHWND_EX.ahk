; Được viết bởi Millimeter (http://autoitvn.com/members/millimeter.2239/)
; Chân thành cảm ơn LIP đã hỗ trợ (http://autoitvn.com/members/nppt.9557/)
; Cộng đồng ahk Việt Nam: http://autoitvn.com/forums/autohotkey/

; Function				Gdip_BitmapFromHWND_EX
; Description			Thay thế cho hàm Gdip_BitmapFromHWND
;
; hwnd					handle to the window to get a bitmap from
; w, h					Chiều dài và chiều rộng của cửa sổ cần lấy bitmap
; return				If the function succeeds, the return value is a pointer to a gdi+ bitmap
;
; notes					Window must not be not minimised in order to get a handle to it's client area

Gdip_BitmapFromHWND_EX(hwnd, w, h) {
	gdc := GetDC(hwnd), hdc := CreateCompatibleDC(gdc), hbm := CreateCompatibleBitmap(gdc, w, h), obm := SelectObject(hdc, hbm)
	BitBlt(hdc, 0, 0, w, h, gdc, 0, 0, 0x00CC0020)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), ReleaseDC(gdc, hwnd), DeleteDC(hdc)
	return pBitmap
}
