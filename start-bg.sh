#!/data/data/com.termux/files/usr/bin/bash
cd ~/nginx-portable
nohup ./build/nginx > /dev/null 2>&1 &
echo "Nginx started in background (PID: $!)"
