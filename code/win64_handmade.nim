import windows, xinput

type
    Win32OffscreenBuffer = tuple
        # Pixels are always 32 bits
        info: BITMAPINFO
        memory: pointer
        width: int32
        height: int32
        pitch: int

    Win32WindowDimension = tuple
        width: int32
        height: int32

var globalRunning: bool
var globalBackBuffer: Win32OffscreenBuffer

proc win32GetWindowDimension(Window: HWND):  Win32WindowDimension =
    var ClientRect: RECT
    discard GetClientRect(Window, ClientRect)
    result.width = ClientRect.BottomRight.x - ClientRect.TopLeft.x
    result.height = ClientRect.BottomRight.y - ClientRect.TopLeft.y

proc renderWeirdGradient(buffer: Win32OffscreenBuffer, greenOffset: int; blueOffset: int) =
    var row = cast[int](buffer.memory)
    for y in 0..buffer.height - 1:
        var pixel = row
        for x in 0..buffer.width - 1:
            cast[ptr uint32](pixel)[] = uint32((x + greenOffset) shl 8 or (y + blueOffset))
            inc(pixel, 4)
        inc(row, buffer.pitch)

proc win32ResizeBackBuffer(buffer: var Win32OffscreenBuffer, width: int32, height: int32) =
    if (buffer.memory != nil):
        discard VirtualFree(buffer.memory, 0, MEM_RELEASE)

    buffer.width = width
    buffer.height = height

    buffer.info.bmiHeader.biSize = DWORD(sizeof(buffer.info.bmiHeader))
    buffer.info.bmiHeader.biWidth = LONG(buffer.width)
    buffer.info.bmiHeader.biHeight = LONG(-buffer.height)
    buffer.info.bmiHeader.biPlanes = 1
    buffer.info.bmiHeader.biBitCount = 32
    buffer.info.bmiHeader.biCompression = BI_RGB

    let bytesPerPixel = 4
    let bitmapMemorySize = DWORD(buffer.width * buffer.height * bytesPerPixel)

    buffer.memory = VirtualAlloc(nil, bitmapMemorySize, MEM_COMMIT, PAGE_READWRITE)
    buffer.pitch = buffer.width * bytesPerPixel

proc win32DisplayBufferInWindow(buffer: Win32OffscreenBuffer, deviceContext: HDC, windowWidth: int32, windowHeight: int32) =
    var info = buffer.info;
    discard StretchDIBits(deviceContext,
        0'i32, 0'i32, windowWidth, windowHeight,
        0'i32, 0'i32, buffer.width, buffer.height,
        buffer.memory, info, WINUINT(DIB_RGB_COLORS), DWORD(SRCCOPY))

proc mainWindowCallback(window: HWND, message: WINUINT, wparam: WPARAM, lparam: LPARAM): LRESULT {.stdcall.} =
    result = 0
    case message
    of WM_DESTROY: globalRunning = false
    of WM_CLOSE: globalRunning = false
    of WM_ACTIVATEAPP: OutputDebugStringA("WM_ACTIVATEAPP\n")
    of WM_SYSKEYUP, WM_SYSKEYDOWN, WM_KEYUP, WM_KEYDOWN:
        var wasDown = (lparam and (1 shl 30)) != 0
        var isDown = (lparam and (1 shl 31)) == 0
        var vkCode = wparam
        if (isDown != wasDown):
            if (vkCode == ord('W')):
                discard
    of WM_PAINT:
        var paint: PAINTSTRUCT
        var deviceContext = BeginPaint(window, paint)
        var dimension = win32GetWindowDimension(window)
        win32DisplayBufferInWindow(globalBackBuffer, deviceContext, dimension.width, dimension.height)
        discard EndPaint(window, paint)
    else: result = DefWindowProcA(window, message, wparam, lparam)


let instance = GetModuleHandleA(nil)
win32ResizeBackBuffer(globalBackBuffer, 1280, 720);
var windowClass = WNDCLASS(style: CS_HREDRAW or CS_VREDRAW or CS_OWNDC, lpfnWndProc: mainWindowCallback, hInstance: instance, lpszClassName: "HandmadeHeroWindowClass")
if RegisterClassA(windowClass) != 0 :
    var window = CreateWindowExA(0, windowClass.lpszClassName, "Handmade", WS_OVERLAPPEDWINDOW or WS_VISIBLE,
                                CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, Handle(0), Handle(0), instance, nil)
    if window != 0 :
        var deviceContext = GetDC(window)
        globalRunning = true
        var xOffset = 0
        var yOffset = 0
        while globalRunning:
            var message: MSG
            while PeekMessageA(message, HWND(0), WINUINT(0), WINUINT(0), WINUINT(PM_REMOVE)) != 0:
                if (message.message == WM_QUIT):
                    globalRunning = false
                discard TranslateMessage(message)
                discard DispatchMessageA(message)

            # TODO(casey): Should we poll this more frequently
            for controllerIndex in 0..XUSER_MAX_COUNT-1:
                var controllerState: XINPUT_STATE
                if (XInputGetState(DWORD(controllerIndex), controllerState) == ERROR_SUCCESS):
                    var pad = controllerState.Gamepad
                    #var up = (pad.wButtons and XINPUT_GAMEPAD_DPAD_UP) != 0
                    #var down = (pad.wButtons and XINPUT_GAMEPAD_DPAD_DOWN) != 0
                    #var left = (pad.wButtons and XINPUT_GAMEPAD_DPAD_LEFT) != 0
                    #var right = (pad.wButtons and XINPUT_GAMEPAD_DPAD_RIGHT) != 0
                    #var start = (pad.wButtons and XINPUT_GAMEPAD_START) != 0
                    #var back = (pad.wButtons and XINPUT_GAMEPAD_BACK) != 0
                    #var leftShoulder = (pad.wButtons and XINPUT_GAMEPAD_LEFT_SHOULDER) != 0
                    #var rightShoulder = (pad.wButtons and XINPUT_GAMEPAD_RIGHT_SHOULDER) != 0
                    #var aButton = (pad.wButtons and XINPUT_GAMEPAD_A) != 0
                    #var bButton = (pad.wButtons and XINPUT_GAMEPAD_B) != 0
                    #var xButton = (pad.wButtons and XINPUT_GAMEPAD_X) != 0
                    #var yButton = (pad.wButtons and XINPUT_GAMEPAD_Y) != 0

                    var stickX = pad.sThumbLX
                    var stickY = pad.sThumbLY

                    var xinputVibration = XINPUT_VIBRATION(wLeftMotorSpeed: cast[WORD](60000), wRightMotorSpeed: cast[WORD](60000))
                    discard XInputSetState(0, xinputVibration)

                    inc(xOffset, stickX shr 12)
                    inc(yOffset, sticky shr 12)

            renderWeirdGradient(globalBackBuffer, xOffset, yOffset)
            let dimension = win32GetWindowDimension(window);
            win32DisplayBufferInWindow(globalBackBuffer, deviceContext, dimension.width, dimension.height)
    else:
        #TODO: Logging
        discard
else:
    #TODO: Logging
    discard
