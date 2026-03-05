#!/data/data/com.termux/files/usr/bin/bash

echo "Stopping services..."
pkill -f "nginx-portable/build/nginx" 2>/dev/null
pkill -f "nginx-portable/php/bin/php-fpm" 2>/dev/null

rm -f ~/nginx-portable/php/var/run/php-fpm.sock
rm -f ~/nginx-portable/php/var/run/php-fpm.pid

echo "✓ All services stopped!"
