module System.InputDevice
    ( InputDevice (..)
    , InputDeviceGroup (..)
    , getInputDeviceGroup
    )
where

import Foreign.Ptr
import Foreign.C.Error (throwErrnoIfNull)

newtype InputDevice = InputDevice (Ptr InputDevice) deriving (Eq, Show)
newtype InputDeviceGroup = InputDeviceGroup (Ptr InputDeviceGroup) deriving (Eq, Show)

foreign import ccall unsafe "libinput_device_get_device_group" c_get_device_group :: Ptr InputDevice -> IO (Ptr InputDeviceGroup)

getInputDeviceGroup :: InputDevice -> IO InputDeviceGroup
getInputDeviceGroup (InputDevice ptr) =
    InputDeviceGroup <$> throwErrnoIfNull "getInputDeviceGroup" (c_get_device_group ptr)
