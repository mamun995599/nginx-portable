#!/data/data/com.termux/files/usr/bin/bash
cd ~/nginx-portable
./build/nginx
echo "Nginx RTMP server started!"
echo "RTMP: rtmp://localhost:1935/live/stream"
echo "HTTP: http://localhost:8080"
echo "HLS:  http://localhost:8080/hls/stream.m3u8"
echo "Stats: http://localhost:8080/stat"
