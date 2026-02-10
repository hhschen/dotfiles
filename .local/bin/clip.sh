#!/usr/bin/env bash

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/cliphist/thumbnails"
[ -d "$cache_dir" ] || mkdir -p "$cache_dir"

cliphist_list=$(cliphist list)

send_notification() {
    busctl --user call \
        org.freedesktop.Notifications \
        /org/freedesktop/Notifications \
        org.freedesktop.Notifications \
        Notify \
        susssasa{sv}i \
        "Cliphist" 0 "edit-copy" "Clipboard Manager" "$1" 0 \
        1 "urgency" y 0 \
        2000
}

if [ -z "$cliphist_list" ]; then
    send_notification "Clipboard is empty!"
    exit 0
fi

read -r -d '' prog <<'EOF'
/^[0-9]+\s<meta http-equiv=/ { next }
match($0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
    id = grp[1]
    ext = grp[3]
    filename = id "." ext
    filepath = cache_dir "/" filename

    cmd = sprintf("[ -f \"%s\" ] || echo -e \"%s\\t\" | cliphist decode > \"%s\"", filepath, id, filepath)
    system(cmd)

    print $0 "\0icon\x1f" filepath
    next
}
1
EOF

selection=$(echo "$cliphist_list" | gawk -v cache_dir="$cache_dir" "$prog" | fuzzel -d \
    --placeholder="Search clipboard..." \
    --prompt=" " \
    --counter \
    --no-sort \
    --with-nth 2 \
    --width 60)

exit_code=$?

case $exit_code in
    0)
        if [ -n "$selection" ]; then
            echo "$selection" | cliphist decode | wl-copy
        fi
        ;;

    10) # Custom-1: Delete selected item
        if [ -n "$selection" ]; then
            id=$(echo "$selection" | cut -f1)
            echo "$id" | cliphist delete
            find "$cache_dir" -name "${id}.*" -delete
            exec "$0"
        fi
        ;;

    11) # Custom-2: Wipe all
        confirm=$(echo -e " Yes\n󰜺 No" | fuzzel -d \
            --prompt="" \
            --placeholder="Wipe all?" \
            --lines=2 \
            --width=30 \
            --inner-pad=10 \
            --no-icons)

        if [ "$confirm" == " Yes" ]; then
            cliphist wipe
            rm -rf "$cache_dir"/*
            exec "$0"
        fi
        ;;
esac

(
    for file in "$cache_dir"/*; do
        [ -e "$file" ] || continue
        filename=$(basename "$file")
        id="${filename%.*}"
        if [[ "$cliphist_list" != *"$id"* ]]; then
            rm "$file"
        fi
    done
) &
