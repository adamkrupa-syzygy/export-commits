#!/usr/bin/env bash

if [ "$CONFIG_EXPORTED" = "" ]; then
    exit;
fi

source "$SRC/library.sh";

get_scheduled() {
    scheduled="`date -v-30d +'%Y_%m'`"
    scheduled_formatted="`date -v-30d +'%Y-%m'`"
    scheduled_year="`date -v-30d +'%Y'`"
    if [ -z ${scheduled+x} ]; then
        error "cannot determine scheduled date";
    fi
}

get_last_export() {
    last_export="`cat $LAST_EXPORT_CACHE`"
    if [ -z ${last_export+x} ]; then
        error "cannot determine last export";
    fi
}

determine_scheduled() {
    get_scheduled
    get_last_export
    echo "Scheduled for now: $scheduled";
    echo "Last export was for: $last_export";
    if [ "$last_export" = "$scheduled" ]; then
        error "This scheduled export is already done";
    fi
}

remember_last_export() {
    echo "Saving last export: $scheduled";
    echo "$scheduled" > "$LAST_EXPORT_CACHE";
}