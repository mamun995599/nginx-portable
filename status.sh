#!/data/data/com.termux/files/usr/bin/bash

BASE_DIR="$HOME/nginx-portable"

echo "====================================="
echo "   Service Status"
echo "====================================="
echo ""

# Nginx
if pgrep -f "nginx-portable/build/nginx" > /dev/null; then
    echo "Nginx:    ✓ RUNNING"
else
    echo "Nginx:    ✗ STOPPED"
fi

# PHP-FPM
if [ -S "$BASE_DIR/php/var/run/php-fpm.sock" ]; then
    echo "PHP-FPM:  ✓ RUNNING"
else
    echo "PHP-FPM:  ✗ STOPPED"
fi

# MySQL
if [ -S "$BASE_DIR/mysql/run/mysqld.sock" ]; then
    echo "MySQL:    ✓ RUNNING"
else
    echo "MySQL:    ✗ STOPPED"
fi

echo ""
echo "====================================="
