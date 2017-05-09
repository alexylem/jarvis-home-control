#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file

turn () {
    # $1: action [on|off]
    # $2: received order
    [ "$1" == "off" ] && local url="$pg_hc_turnoff_url" || local url="$pg_hc_turnon_url"
    local -r order="$(jv_sanitize "$2")"


    while read device; do
        local sdevice="$(jv_sanitize "$device" ".*")"

	if [[ "$order" =~ .*$sdevice.* ]]; then
            local address="$(echo $pg_hc_config | jq -r ".devices[] | select(.name==\"$device\") | .address")"
            jv_curl "${url//\[ADDRESS\]/$address}"
	    say "voilà commande ok pour $2"
            return $?
        fi

    done <<< "$(echo $pg_hc_config | jq -r '.devices[].name')"
say "erreur: Commande non reconnu pour la piece $2"

    # jv_error $"erreur: Commande non reconnu pour $2"
    # return 1
}
