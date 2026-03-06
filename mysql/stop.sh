#!/data/data/com.termux/files/usr/bin/bash

MYSQL_DIR="$HOME/nginx-portable/mysql"

export LD_LIBRARY_PATH="$MYSQL_DIR/lib:$LD_LIBRARY_PATH"

echo "Stopping MySQL..."

if [ -S "$MYSQL_DIR/run/mysqld.sock" ]; then
    "$MYSQL_DIR/bin/mysqladmin" \
        --socket="$MYSQL_DIR/run/mysqld.sock" \
        -u root \
        shutdown 2>/dev/null
fi

# Force kill if still running
pkill -f "nginx-portable/mysql/bin/mysqld" 2>/dev/null

rm -f "$MYSQL_DIR/run/mysqld.sock"
rm -f "$MYSQL_DIR/run/mysqld.pid"

echo "✓ MySQL stopped!"
