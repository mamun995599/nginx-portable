#!/data/data/com.termux/files/usr/bin/bash

BASE_DIR="$HOME/nginx-portable"
PHP_DIR="$BASE_DIR/php"
MYSQL_DIR="$BASE_DIR/mysql"

# Set library paths
export LD_LIBRARY_PATH="$PHP_DIR/lib:$MYSQL_DIR/lib:$LD_LIBRARY_PATH"
export PHPRC="$PHP_DIR/etc"
export PHP_INI_SCAN_DIR="$PHP_DIR/etc/conf.d"

echo "====================================="
echo "   Starting All Services..."
echo "====================================="
echo ""

# -----------------------------------------
# Start MySQL
# -----------------------------------------
rm -f "$MYSQL_DIR/run/mysqld.sock"
rm -f "$MYSQL_DIR/run/mysqld.pid"

echo "[1/3] Starting MySQL..."
"$MYSQL_DIR/bin/mysqld" \
    --defaults-file="$MYSQL_DIR/etc/my.cnf" \
    --basedir="$MYSQL_DIR" \
    --datadir="$MYSQL_DIR/data" \
    --plugin-dir="$MYSQL_DIR/lib/plugin" \
    --socket="$MYSQL_DIR/run/mysqld.sock" \
    --pid-file="$MYSQL_DIR/run/mysqld.pid" \
    --log-error="$MYSQL_DIR/log/error.log" &

MYSQL_PID=$!

# Wait for MySQL socket
for i in {1..30}; do
    if [ -S "$MYSQL_DIR/run/mysqld.sock" ]; then
        echo "✓ MySQL started (PID: $MYSQL_PID)"
        break
    fi
    sleep 1
done

if [ ! -S "$MYSQL_DIR/run/mysqld.sock" ]; then
    echo "✗ MySQL failed to start!"
    cat "$MYSQL_DIR/log/error.log" | tail -10
    exit 1
fi

# -----------------------------------------
# Start PHP-FPM
# -----------------------------------------
rm -f "$PHP_DIR/var/run/php-fpm.sock"
rm -f "$PHP_DIR/var/run/php-fpm.pid"

echo "[2/3] Starting PHP-FPM..."
"$PHP_DIR/bin/php-fpm" \
    -c "$PHP_DIR/etc/php.ini" \
    -y "$PHP_DIR/etc/php-fpm.conf" \
    -p "$PHP_DIR" \
    --nodaemonize &

PHP_PID=$!

sleep 2

if [ -S "$PHP_DIR/var/run/php-fpm.sock" ]; then
    echo "✓ PHP-FPM started (PID: $PHP_PID)"
else
    echo "✗ PHP-FPM failed!"
    cat "$PHP_DIR/var/log/php-fpm.log" 2>/dev/null
    exit 1
fi

# -----------------------------------------
# Start Nginx
# -----------------------------------------
echo "[3/3] Starting Nginx..."
"$BASE_DIR/build/nginx" &

NGINX_PID=$!
sleep 1
echo "✓ Nginx started (PID: $NGINX_PID)"

echo ""
echo "====================================="
echo "   All Services Started!"
echo "====================================="
echo ""
echo "  Web:       http://localhost:8080"
echo "  PHP Info:  http://localhost:8080/info.php"
echo "  DB Test:   http://localhost:8080/db-test.php"
echo "  RTMP:      rtmp://localhost:1935/live/stream"
echo "  HLS:       http://localhost:8080/hls/live/stream/index.m3u8"
echo "  Stats:     http://localhost:8080/stat"
echo ""
echo "  MySQL Socket: $MYSQL_DIR/run/mysqld.sock"
echo ""
echo "====================================="
echo "Press Ctrl+C to stop all services..."
echo ""

trap "
    echo ''
    echo 'Stopping services...'
    kill $NGINX_PID 2>/dev/null
    kill $PHP_PID 2>/dev/null
    $MYSQL_DIR/bin/mysqladmin --socket=$MYSQL_DIR/run/mysqld.sock -u root shutdown 2>/dev/null
    pkill -f 'nginx-portable' 2>/dev/null
    echo 'All services stopped!'
    exit
" SIGINT SIGTERM

wait
