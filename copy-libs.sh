#!/data/data/com.termux/files/usr/bin/bash

DEST="$HOME/nginx-portable/php/lib"

copy_deps() {
    for lib in $(ldd "$1" 2>/dev/null | awk '{print $3}' | grep -v "^$"); do
        if [ -f "$lib" ]; then
            cp -n "$lib" "$DEST/" 2>/dev/null
            echo "Copied: $(basename $lib)"
        fi
    done
}

echo "Copying PHP dependencies..."
copy_deps "$PREFIX/bin/php"

echo ""
echo "Copying PHP-FPM dependencies..."
copy_deps "$PREFIX/bin/php-fpm"

echo ""
echo "Done!"
