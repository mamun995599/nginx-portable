#!/data/data/com.termux/files/usr/bin/bash

MYSQL_DIR="$HOME/nginx-portable/mysql"

export LD_LIBRARY_PATH="$MYSQL_DIR/lib:$LD_LIBRARY_PATH"

# Clean previous socket/pid
rm -f "$MYSQL_DIR/run/mysqld.sock"
rm -f "$MYSQL_DIR/run/mysqld.pid"

echo "Starting MySQL..."

"$MYSQL_DIR/bin/mysqld" \
    --defaults-file="$MYSQL_DIR/etc/my.cnf" \
    --basedir="$MYSQL_DIR" \
    --datadir="$MYSQL_DIR/data" \
    --plugin-dir="$MYSQL_DIR/lib/plugin" \
    --socket="$MYSQL_DIR/run/mysqld.sock" \
    --pid-file="$MYSQL_DIR/run/mysqld.pid" \
    --log-error="$MYSQL_DIR/log/error.log" &

# Wait for socket
for i in {1..30}; do
    if [ -S "$MYSQL_DIR/run/mysqld.sock" ]; then
        echo "✓ MySQL started!"
        echo "  Socket: $MYSQL_DIR/run/mysqld.sock"
        exit 0
    fi
    sleep 1
done

echo "✗ MySQL failed to start!"
cat "$MYSQL_DIR/log/error.log" | tail -20
exit 1
