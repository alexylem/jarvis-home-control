#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file

pg_jc_turn () {
    # $1: action [on|off]
    # $2: received order
    [ "$1" == "off" ] && local url="$pg_hc_turnoff_url" || local url="$pg_hc_turnon_url"
    local -r order="$(jv_sanitize "$2")"
    while read device; do
        local sdevice="$(jv_sanitize "$device" ".*")"
        if [[ "$order" =~ .*$sdevice.* ]]; then
            local address="$(echo $pg_hc_config | jq -r ".devices[] | select(.name==\"$device\") | .address")"
            jv_curl "${url//\[ADDRESS\]/$address}"
            return $?
        fi
    done <<< "$(echo $pg_hc_config | jq -r '.devices[].name')"
    jv_error "ERROR: no device maching $2"
    return 1
}
