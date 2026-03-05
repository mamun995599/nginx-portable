#!/data/data/com.termux/files/usr/bin/bash

BASE_DIR="$HOME/nginx-portable"
PHP_DIR="$BASE_DIR/php"

# Set library path
export LD_LIBRARY_PATH="$PHP_DIR/lib:$LD_LIBRARY_PATH"

# Force PHP to use portable config
export PHPRC="$PHP_DIR/etc"
export PHP_INI_SCAN_DIR="$PHP_DIR/etc/conf.d"

# Clean previous
rm -f "$PHP_DIR/var/run/php-fpm.sock"
rm -f "$PHP_DIR/var/run/php-fpm.pid"

echo "Starting PHP-FPM..."
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

echo "Starting Nginx..."
"$BASE_DIR/build/nginx" &

echo ""
echo "====================================="
echo "   Server Started!"
echo "====================================="
echo "  HTTP:  http://localhost:8080"
echo "  PHP:   http://localhost:8080/index.php"
echo "  RTMP:  rtmp://localhost:1935/live/stream"
echo "  HLS:   http://localhost:8080/hls/live/stream/index.m3u8"
echo "====================================="
echo ""
echo "Press Ctrl+C to stop..."

trap "pkill -f 'nginx-portable'; exit" SIGINT SIGTERM
wait
