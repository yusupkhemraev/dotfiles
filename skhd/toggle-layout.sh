#!/usr/bin/env bash
if [ "$(macism)" = "com.apple.keylayout.ABC" ]; then
    macism com.apple.keylayout.Russian
else
    macism com.apple.keylayout.ABC
fi
