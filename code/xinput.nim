#**************************************************************************
#                                                                          *
#   XInput.h -- This module defines Xbox 360 Common Controller APIs        *
#               and constants for the Windows platform.                    *
#                                                                          *
#   Copyright (c) Microsoft Corp. All rights reserved.                     *
#                                                                          *
#*************************************************************************

# Current name of the DLL shipped in the same SDK as this header.
# The name reflects the current version

import windows, dynlib

const
    #XINPUT_DLL* = "xinput1_4.dll"
    XINPUT_DLL* = "xinput9_1_0.dll"

#
# Device types available in XINPUT_CAPABILITIES
#

const
    XINPUT_DEVTYPE_GAMEPAD* = 0x00000001

#
# Device subtypes available in XINPUT_CAPABILITIES
#

const
    XINPUT_DEVSUBTYPE_GAMEPAD* = 0x00000001
    XINPUT_DEVSUBTYPE_UNKNOWN* = 0x00000000
    XINPUT_DEVSUBTYPE_WHEEL* = 0x00000002
    XINPUT_DEVSUBTYPE_ARCADE_STICK* = 0x00000003
    XINPUT_DEVSUBTYPE_FLIGHT_STICK* = 0x00000004
    XINPUT_DEVSUBTYPE_DANCE_PAD* = 0x00000005
    XINPUT_DEVSUBTYPE_GUITAR* = 0x00000006
    XINPUT_DEVSUBTYPE_GUITAR_ALTERNATE* = 0x00000007
    XINPUT_DEVSUBTYPE_DRUM_KIT* = 0x00000008
    XINPUT_DEVSUBTYPE_GUITAR_BASS* = 0x0000000B
    XINPUT_DEVSUBTYPE_ARCADE_PAD* = 0x00000013

#
# Flags for XINPUT_CAPABILITIES
#

const
    XINPUT_CAPS_VOICE_SUPPORTED* = 0x00000004
    XINPUT_CAPS_FFB_SUPPORTED* = 0x00000001
    XINPUT_CAPS_WIRELESS* = 0x00000002
    XINPUT_CAPS_PMD_SUPPORTED* = 0x00000008
    XINPUT_CAPS_NO_NAVIGATION* = 0x00000010

#
# Constants for gamepad buttons
#

const
    XINPUT_GAMEPAD_DPAD_UP* = 0x00000001
    XINPUT_GAMEPAD_DPAD_DOWN* = 0x00000002
    XINPUT_GAMEPAD_DPAD_LEFT* = 0x00000004
    XINPUT_GAMEPAD_DPAD_RIGHT* = 0x00000008
    XINPUT_GAMEPAD_START* = 0x00000010
    XINPUT_GAMEPAD_BACK* = 0x00000020
    XINPUT_GAMEPAD_LEFT_THUMB* = 0x00000040
    XINPUT_GAMEPAD_RIGHT_THUMB* = 0x00000080
    XINPUT_GAMEPAD_LEFT_SHOULDER* = 0x00000100
    XINPUT_GAMEPAD_RIGHT_SHOULDER* = 0x00000200
    XINPUT_GAMEPAD_A* = 0x00001000
    XINPUT_GAMEPAD_B* = 0x00002000
    XINPUT_GAMEPAD_X* = 0x00004000
    XINPUT_GAMEPAD_Y* = 0x00008000

#
# Gamepad thresholds
#

const
    XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE* = 7849
    XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE* = 8689
    XINPUT_GAMEPAD_TRIGGER_THRESHOLD* = 30

#
# Flags to pass to XInputGetCapabilities
#

const
    XINPUT_FLAG_GAMEPAD* = 0x00000001

#
# Devices that support batteries
#

const
    BATTERY_DEVTYPE_GAMEPAD* = 0x00000000
    BATTERY_DEVTYPE_HEADSET* = 0x00000001

#
# Flags for battery status level
#

const
    BATTERY_TYPE_DISCONNECTED* = 0x00000000
    BATTERY_TYPE_WIRED* = 0x00000001
    BATTERY_TYPE_ALKALINE* = 0x00000002
    BATTERY_TYPE_NIMH* = 0x00000003
    BATTERY_TYPE_UNKNOWN* = 0x000000FF

# These are only valid for wireless, connected devices, with known battery types
# The amount of use time remaining depends on the type of device.

const
    BATTERY_LEVEL_EMPTY* = 0x00000000
    BATTERY_LEVEL_LOW* = 0x00000001
    BATTERY_LEVEL_MEDIUM* = 0x00000002
    BATTERY_LEVEL_FULL* = 0x00000003

# User index definitions

const
    XUSER_MAX_COUNT* = 4
    XUSER_INDEX_ANY* = 0x000000FF

#
# Codes returned for the gamepad keystroke
#

const
    VK_PAD_A* = 0x00005800
    VK_PAD_B* = 0x00005801
    VK_PAD_X* = 0x00005802
    VK_PAD_Y* = 0x00005803
    VK_PAD_RSHOULDER* = 0x00005804
    VK_PAD_LSHOULDER* = 0x00005805
    VK_PAD_LTRIGGER* = 0x00005806
    VK_PAD_RTRIGGER* = 0x00005807
    VK_PAD_DPAD_UP* = 0x00005810
    VK_PAD_DPAD_DOWN* = 0x00005811
    VK_PAD_DPAD_LEFT* = 0x00005812
    VK_PAD_DPAD_RIGHT* = 0x00005813
    VK_PAD_START* = 0x00005814
    VK_PAD_BACK* = 0x00005815
    VK_PAD_LTHUMB_PRESS* = 0x00005816
    VK_PAD_RTHUMB_PRESS* = 0x00005817
    VK_PAD_LTHUMB_UP* = 0x00005820
    VK_PAD_LTHUMB_DOWN* = 0x00005821
    VK_PAD_LTHUMB_RIGHT* = 0x00005822
    VK_PAD_LTHUMB_LEFT* = 0x00005823
    VK_PAD_LTHUMB_UPLEFT* = 0x00005824
    VK_PAD_LTHUMB_UPRIGHT* = 0x00005825
    VK_PAD_LTHUMB_DOWNRIGHT* = 0x00005826
    VK_PAD_LTHUMB_DOWNLEFT* = 0x00005827
    VK_PAD_RTHUMB_UP* = 0x00005830
    VK_PAD_RTHUMB_DOWN* = 0x00005831
    VK_PAD_RTHUMB_RIGHT* = 0x00005832
    VK_PAD_RTHUMB_LEFT* = 0x00005833
    VK_PAD_RTHUMB_UPLEFT* = 0x00005834
    VK_PAD_RTHUMB_UPRIGHT* = 0x00005835
    VK_PAD_RTHUMB_DOWNRIGHT* = 0x00005836
    VK_PAD_RTHUMB_DOWNLEFT* = 0x00005837

#
# Flags used in XINPUT_KEYSTROKE
#

const
    XINPUT_KEYSTROKE_KEYDOWN* = 0x00000001
    XINPUT_KEYSTROKE_KEYUP* = 0x00000002
    XINPUT_KEYSTROKE_REPEAT* = 0x00000004

#
# Structures used by XInput APIs
#

type
    BYTE* = uint8

    XINPUT_GAMEPAD* = object
        wButtons*: WORD
        bLeftTrigger*: BYTE
        bRightTrigger*: BYTE
        sThumbLX*: SHORT
        sThumbLY*: SHORT
        sThumbRX*: SHORT
        sThumbRY*: SHORT

    PXINPUT_GAMEPAD* = ptr XINPUT_GAMEPAD
    XINPUT_STATE* = object
        dwPacketNumber*: DWORD
        Gamepad*: XINPUT_GAMEPAD

    PXINPUT_STATE* = ptr XINPUT_STATE
    XINPUT_VIBRATION* = object
        wLeftMotorSpeed*: WORD
        wRightMotorSpeed*: WORD

    PXINPUT_VIBRATION* = ptr XINPUT_VIBRATION
    XINPUT_CAPABILITIES* = object
        Type*: BYTE
        SubType*: BYTE
        Flags*: WORD
        Gamepad*: XINPUT_GAMEPAD
        Vibration*: XINPUT_VIBRATION

    PXINPUT_CAPABILITIES* = ptr XINPUT_CAPABILITIES
    XINPUT_BATTERY_INFORMATION* = object
        BatteryType*: BYTE
        BatteryLevel*: BYTE

    PXINPUT_BATTERY_INFORMATION* = ptr XINPUT_BATTERY_INFORMATION
    XINPUT_KEYSTROKE* = object
        VirtualKey*: WORD
        Unicode*: WCHAR
        Flags*: WORD
        UserIndex*: BYTE
        HidCode*: BYTE

    PXINPUT_KEYSTROKE* = ptr XINPUT_KEYSTROKE

    # Index of the gamer associated with the device
    # Receives the current state
    XInputGetStateProc* = proc (dwUserIndex: DWORD; pState: var XINPUT_STATE): DWORD {.stdcall.}

    # Index of the gamer associated with the device
    # The vibration information to send to the controller
    XInputSetStateProc* = proc (dwUserIndex: DWORD; pVibration: var XINPUT_VIBRATION): DWORD {.stdcall.}

var
    XInputGetState*: XInputGetStateProc
    XInputSetState*: XInputSetStateProc

proc XInputGetStateStub(dwUserIndex: DWORD; pState: var XINPUT_STATE): DWORD {.stdcall.} =
    return ERROR_INVALID_FUNCTION

proc XInputSetStateStub(dwUserIndex: DWORD; pVibration: var XINPUT_VIBRATION): DWORD {.stdcall.} =
    return ERROR_INVALID_FUNCTION

var XInputLibrary = loadLib(XINPUT_DLL);
if (XInputLibrary != nil):
    var getState = cast[XInputGetStateProc](symAddr(XInputLibrary, "XInputGetState"))
    if (getState != nil): XInputGetState = getState
    var setState = cast[XInputSetStateProc](symAddr(XInputLibrary, "XInputSetState"))
    if (setState != nil): XInputSetState = setState
else:
    XInputGetState = XInputGetStateStub
    XInputSetState = XInputSetStateStub

#proc XInputGetCapabilities*(dwUserIndex: DWORD; dwFlags: DWORD; pCapabilities: ptr XINPUT_CAPABILITIES): DWORD
    # Index of the gamer associated with the device
    # Input flags that identify the device type
    # Receives the capabilities
#proc XInputEnable*(enable: WINBOOL)
    # [in] Indicates whether xinput is enabled or disabled.
#proc XInputGetAudioDeviceIds*(dwUserIndex: DWORD; pRenderDeviceId: LPWSTR; pRenderCount: ptr WINUINT; pCaptureDeviceId: LPWSTR; pCaptureCount: ptr WINUINT): DWORD
    # Index of the gamer associated with the device
    # Windows Core Audio device ID string for render (speakers)
    # Size of render device ID string buffer (in wide-chars)
    # Windows Core Audio device ID string for capture (microphone)
    # Size of capture device ID string buffer (in wide-chars)
#proc XInputGetBatteryInformation*(dwUserIndex: DWORD; devType: BYTE; pBatteryInformation: ptr XINPUT_BATTERY_INFORMATION): DWORD
    # Index of the gamer associated with the device
    # Which device on this user index
    # Contains the level and types of batteries
#proc XInputGetKeystroke*(dwUserIndex: DWORD; dwReserved: DWORD; pKeystroke: PXINPUT_KEYSTROKE): DWORD
    # Index of the gamer associated with the device
    # Reserved for future use
    # Pointer to an XINPUT_KEYSTROKE structure that receives an input event.
#proc XInputGetDSoundAudioDeviceGuids*(dwUserIndex: DWORD; pDSoundRenderGuid: PGUID; pDSoundCaptureGuid: PGUID): DWORD
    # Index of the gamer associated with the device
    # DSound device ID for render (speakers)
    # DSound device ID for capture (microphone)
