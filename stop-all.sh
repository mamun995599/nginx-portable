#!/data/data/com.termux/files/usr/bin/bash

BASE_DIR="$HOME/nginx-portable"
MYSQL_DIR="$BASE_DIR/mysql"

export LD_LIBRARY_PATH="$MYSQL_DIR/lib:$LD_LIBRARY_PATH"

echo "Stopping all services..."

# Stop Nginx
echo "Stopping Nginx..."
pkill -f "nginx-portable/build/nginx" 2>/dev/null

# Stop PHP-FPM
echo "Stopping PHP-FPM..."
pkill -f "nginx-portable/php/bin/php-fpm" 2>/dev/null
rm -f "$BASE_DIR/php/var/run/php-fpm.sock"

# Stop MySQL
echo "Stopping MySQL..."
if [ -S "$MYSQL_DIR/run/mysqld.sock" ]; then
    "$MYSQL_DIR/bin/mysqladmin" \
        --socket="$MYSQL_DIR/run/mysqld.sock" \
        -u root \
        shutdown 2>/dev/null
fi
pkill -f "nginx-portable/mysql/bin/mysqld" 2>/dev/null
rm -f "$MYSQL_DIR/run/mysqld.sock"
rm -f "$MYSQL_DIR/run/mysqld.pid"

echo ""
echo "✓ All services stopped!"
