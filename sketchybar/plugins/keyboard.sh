#!/usr/bin/env bash
SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist \
         AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null)

case "$SOURCE" in
    *Russian*) LABEL="RU"; COLOR=0xffcdd6f4 ;;
    *)         LABEL="EN"; COLOR=0xffcdd6f4 ;;
esac


sketchybar --set "$NAME" label="$LABEL" label.color=$COLOR
