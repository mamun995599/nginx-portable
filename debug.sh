#!/data/data/com.termux/files/usr/bin/bash

echo "====================================="
echo "   Debug Info"
echo "====================================="

echo ""
echo "=== MySQL Process ==="
pgrep -fa mysqld || echo "MySQL NOT running!"

echo ""
echo "=== Socket Files ==="
ls -la ~/nginx-portable/mysql/run/ 2>/dev/null || echo "No socket directory!"
ls -la ~/nginx-portable/php/var/run/ 2>/dev/null || echo "No PHP socket directory!"

echo ""
echo "=== MySQL Error Log (last 20 lines) ==="
tail -20 ~/nginx-portable/mysql/log/error.log 2>/dev/null || echo "No error log!"

echo ""
echo "=== MySQL CLI Test ==="
export LD_LIBRARY_PATH="$HOME/nginx-portable/mysql/lib:$LD_LIBRARY_PATH"
~/nginx-portable/mysql/bin/mysql -u root -S ~/nginx-portable/mysql/run/mysqld.sock -e "SELECT 'CLI Works!' AS status;" 2>&1

echo ""
echo "=== PHP-FPM Error Log (last 10 lines) ==="
tail -10 ~/nginx-portable/php/var/log/php-fpm.log 2>/dev/null || echo "No PHP-FPM log!"

echo ""
echo "=== PHP Error Log (last 10 lines) ==="
tail -10 ~/nginx-portable/php/var/log/php-error.log 2>/dev/null || echo "No PHP error log!"

echo ""
echo "====================================="
