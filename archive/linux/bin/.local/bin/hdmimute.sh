#!/bin/bash

current_state=$(amixer sget -c 0 'Auto-Mute Mode' | grep Item0 | awk '{print $2}')
echo $current_state
if [[ $current_state =~ 'Disabled' ]]; then
    new_state="Enabled"
else
    new_state="Disabled"
fi

echo "Auto-Mute is $current_state, setting to $new_state."
amixer sset -c 1 'Auto-Mute Mode' $new_state
