#!/data/data/com.termux/files/usr/bin/bash

PHP_DIR="$HOME/nginx-portable/php"

# Set environment
export LD_LIBRARY_PATH="$PHP_DIR/lib:$LD_LIBRARY_PATH"
export PHPRC="$PHP_DIR/etc"
export PHP_INI_SCAN_DIR="$PHP_DIR/etc/conf.d"

echo "========================================"
echo "   PHP Configuration Check"
echo "========================================"
echo ""

echo "=== Environment Variables ==="
echo "PHPRC: $PHPRC"
echo "PHP_INI_SCAN_DIR: $PHP_INI_SCAN_DIR"
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo ""

echo "=== PHP Binary ==="
echo "Using: $PHP_DIR/bin/php"
$PHP_DIR/bin/php -v
echo ""

echo "=== Loaded INI File ==="
$PHP_DIR/bin/php -c "$PHP_DIR/etc/php.ini" --ini
echo ""

echo "=== Key Paths ==="
$PHP_DIR/bin/php -c "$PHP_DIR/etc/php.ini" -r "
echo 'error_log: ' . ini_get('error_log') . PHP_EOL;
echo 'session.save_path: ' . ini_get('session.save_path') . PHP_EOL;
echo 'upload_tmp_dir: ' . ini_get('upload_tmp_dir') . PHP_EOL;
"
echo ""

echo "=== Status ==="
CONFIG_PATH=$($PHP_DIR/bin/php -c "$PHP_DIR/etc/php.ini" --ini | grep "Loaded Configuration" | awk -F': ' '{print $2}')

if [[ "$CONFIG_PATH" == *"nginx-portable"* ]]; then
    echo "✓ PHP is using PORTABLE config: $CONFIG_PATH"
else
    echo "✗ Still not loading config properly"
    echo "  Config path returned: $CONFIG_PATH"
fi

echo "========================================"
