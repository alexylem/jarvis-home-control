#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file

pg_jc_turn () {
    # $1: action [on|off]
    # $2: received order
    [ "$1" == "off" ] && local url="$pg_hc_turnoff_url" || local url="$pg_hc_turnon_url"
    local -r order="$2"
    while read device; do
        if [[ "$order" =~ .*$device.* ]]; then
            local address="$(echo $pg_hc_config | jq -r ".devices[] | select(.name==\"$device\") | .address")"
            curl -s -o /dev/null "${url//\[ADDRESS\]/$address}"
            return 0
        fi
    done <<< "$(echo $pg_hc_config | jq -r '.devices[].name')"
    return 1
}
