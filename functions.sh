#!/bin/bash

pg_hc_turn () {
    # $1: action [on|off]
    # $2: received order
    [ "$1" == "off" ] && local url="$pg_hc_turnoff_url" || local url="$pg_hc_turnon_url"
    local -r order="$(jv_sanitize "$2")"
    while read device; do
        local sdevice="$(jv_sanitize "$device" ".*")"
        if [[ "$order" =~ .*$sdevice.* ]]; then
            local address="$(echo $pg_hc_config | jq -r ".devices[] | select(.name==\"$device\") | .address")"
            say "$(pg_hc_lg "switching_$1" "$2")"
            jv_curl "${url//\[ADDRESS\]/$address}"
            return $?
        fi
    done <<< "$(echo $pg_hc_config | jq -r '.devices[].name')"
    say "$(pg_hc_lg "no_device_matching" "$2")"
    return 0 # error already said above, no need to trigger error phrase
}
