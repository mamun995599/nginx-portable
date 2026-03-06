#!/data/data/com.termux/files/usr/bin/bash

DEST="$HOME/nginx-portable/mysql/lib"

for bin in mysqld mysql mysqladmin; do
    for lib in $(ldd $PREFIX/bin/$bin 2>/dev/null | awk '{print $3}' | grep -v "^$"); do
        if [ -f "$lib" ]; then
            cp -n "$lib" "$DEST/" 2>/dev/null
        fi
    done
done

echo "Libraries copied!"
