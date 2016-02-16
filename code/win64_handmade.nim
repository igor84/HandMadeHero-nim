import windows

var operation = WHITENESS

proc mainWindowCallback(window: HWND, message: WINUINT, wparam: WPARAM, lparam: LPARAM): LRESULT {.stdcall.} =
    result = 0;
    case message
    of WM_SIZE: OutputDebugStringA("WM_SIZE\n")
    of WM_DESTROY: OutputDebugStringA("WM_DESTROY\n")
    of WM_CLOSE: OutputDebugStringA("WM_CLOSE\n")
    of WM_ACTIVATEAPP: OutputDebugStringA("WM_ACTIVATEAPP\n")
    of WM_PAINT:
        var paint: PAINTSTRUCT;
        var deviceContext = BeginPaint(window, paint);
        let x = paint.rcPaint.TopLeft.x;
        let y = paint.rcPaint.TopLeft.y;
        let height = paint.rcPaint.BottomRight.y - y;
        let width = paint.rcPaint.BottomRight.x - x;
        discard PatBlt(deviceContext, cast[int32](x), cast[int32](y), width, height, cast[DWORD](operation));
        if operation == WHITENESS:
            operation = BLACKNESS
        else:
            operation = WHITENESS
        discard EndPaint(window, paint);
    else: result = DefWindowProcA(window, message, wparam, lparam)


let instance = GetModuleHandleA(nil);
var windowClass = WNDCLASS(lpfnWndProc: mainWindowCallback, hInstance: instance, lpszClassName: "HandmadeHeroWindowClass");
if RegisterClassA(windowClass) != 0 :
    var windowHandle = CreateWindowExA(0, windowClass.lpszClassName, "Handmade", WS_OVERLAPPEDWINDOW or WS_VISIBLE,
                                        CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, Handle(0), Handle(0), instance, nil)
    if windowHandle != 0 :
        var message: MSG;
        while true:
            var messageResult = GetMessageA(message, 0, 0, 0)
            if (messageResult > 0):
                discard TranslateMessage(message)
                discard DispatchMessageA(message)
            else:
                break;
    else:
        #TODO: Logging
        discard
else:
    #TODO: Logging
    discard
