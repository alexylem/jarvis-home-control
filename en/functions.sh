#!/bin/bash

pg_hc_lg() {
    case "$1" in
        no_device_matching) echo "No device matching $2";;
        switching_on) echo "Switching on $2";;
        switching_off) echo "Switching off $2";;
        *) jv_error "ERROR: unknown translation key: $1";;
    esac
}
