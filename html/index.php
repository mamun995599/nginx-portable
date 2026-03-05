<!DOCTYPE html>
<html>
<head>
    <title>Nginx RTMP + PHP Server</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #1a1a2e; color: #eee; padding: 20px; }
        .container { max-width: 900px; margin: 0 auto; }
        h1 { color: #00d9ff; margin-bottom: 10px; }
        h2 { color: #888; font-weight: normal; margin-bottom: 30px; }
        .card { background: #16213e; border-radius: 10px; padding: 20px; margin-bottom: 20px; }
        .card h3 { color: #00d9ff; margin-bottom: 15px; border-bottom: 1px solid #333; padding-bottom: 10px; }
        .endpoint { background: #0f3460; padding: 10px 15px; border-radius: 5px; margin-bottom: 10px; font-family: monospace; }
        .endpoint .label { color: #00d9ff; font-weight: bold; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; }
        .stat { background: #0f3460; padding: 15px; border-radius: 8px; text-align: center; }
        .stat .value { font-size: 24px; color: #00d9ff; font-weight: bold; }
        .stat .label { color: #888; font-size: 14px; }
        a { color: #00d9ff; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .btn { display: inline-block; background: #00d9ff; color: #000; padding: 10px 20px; border-radius: 5px; font-weight: bold; }
        .btn:hover { background: #00b8d4; text-decoration: none; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; text-align: left; border-bottom: 1px solid #333; }
        th { color: #00d9ff; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎬 Nginx RTMP Server</h1>
        <h2>Portable Streaming Server with PHP <?php echo phpversion(); ?></h2>

        <div class="card">
            <h3>📊 Server Status</h3>
            <div class="grid">
                <div class="stat">
                    <div class="value"><?php echo phpversion(); ?></div>
                    <div class="label">PHP Version</div>
                </div>
                <div class="stat">
                    <div class="value"><?php echo date('H:i:s'); ?></div>
                    <div class="label">Server Time</div>
                </div>
                <div class="stat">
                    <div class="value"><?php echo round(memory_get_usage() / 1024 / 1024, 2); ?> MB</div>
                    <div class="label">Memory Usage</div>
                </div>
                <div class="stat">
                    <div class="value"><a href="/stat" class="btn">View Stats</a></div>
                    <div class="label">RTMP Statistics</div>
                </div>
            </div>
        </div>

        <div class="card">
            <h3>📺 Streaming Endpoints</h3>
            <table>
                <tr>
                    <th>Type</th>
                    <th>URL</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><span class="label">RTMP</span></td>
                    <td><code>rtmp://YOUR_IP:1935/live/STREAM_KEY</code></td>
                    <td>Publish stream (OBS, FFmpeg)</td>
                </tr>
                <tr>
                    <td><span class="label">HLS</span></td>
                    <td><code>http://YOUR_IP:8080/hls/STREAM_KEY/index.m3u8</code></td>
                    <td>Playback (Browser, VLC)</td>
                </tr>
                <tr>
                    <td><span class="label">DASH</span></td>
                    <td><code>http://YOUR_IP:8080/dash/STREAM_KEY/index.mpd</code></td>
                    <td>Playback (DASH.js)</td>
                </tr>
                <tr>
                    <td><span class="label">Record</span></td>
                    <td><code>rtmp://YOUR_IP:1935/rec/STREAM_KEY</code></td>
                    <td>Stream + Record</td>
                </tr>
            </table>
        </div>

        <div class="card">
            <h3>🔗 Quick Links</h3>
            <div class="grid">
                <div class="endpoint"><a href="/stat">📊 RTMP Statistics</a></div>
                <div class="endpoint"><a href="/recordings">📁 Recordings</a></div>
                <div class="endpoint"><a href="/api/">🔌 API</a></div>
                <div class="endpoint"><a href="/info.php">ℹ️ PHP Info</a></div>
                <div class="endpoint"><a href="/nginx_status">📈 Nginx Status</a></div>
            </div>
        </div>

        <div class="card">
            <h3>📖 Quick Start Guide</h3>
            <p><strong>1. Stream with OBS:</strong></p>
            <div class="endpoint">
                Server: rtmp://YOUR_IP:1935/live<br>
                Stream Key: mystream
            </div>
            
            <p style="margin-top: 15px;"><strong>2. Stream with FFmpeg:</strong></p>
            <div class="endpoint">
                ffmpeg -re -i video.mp4 -c copy -f flv rtmp://localhost:1935/live/mystream
            </div>
            
            <p style="margin-top: 15px;"><strong>3. Watch Stream:</strong></p>
            <div class="endpoint">
                HLS: http://YOUR_IP:8080/hls/mystream/index.m3u8
            </div>
        </div>

        <div class="card">
            <h3>⚙️ Control API</h3>
            <table>
                <tr>
                    <th>Action</th>
                    <th>URL</th>
                </tr>
                <tr>
                    <td>Start Recording</td>
                    <td><code>/control/record/start?app=live&name=STREAM</code></td>
                </tr>
                <tr>
                    <td>Stop Recording</td>
                    <td><code>/control/record/stop?app=live&name=STREAM</code></td>
                </tr>
                <tr>
                    <td>Drop Publisher</td>
                    <td><code>/control/drop/publisher?app=live&name=STREAM</code></td>
                </tr>
                <tr>
                    <td>Drop Subscriber</td>
                    <td><code>/control/drop/subscriber?app=live&name=STREAM</code></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
