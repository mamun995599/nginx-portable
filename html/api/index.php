<?php
header('Content-Type: application/json');

$response = [
    'status' => 'success',
    'message' => 'API is working!',
    'timestamp' => date('c'),
    'php_version' => phpversion(),
    'endpoints' => [
        'GET /api/' => 'This info',
        'GET /stat' => 'RTMP statistics',
        'GET /control/record/start|stop' => 'Recording control',
        'GET /control/drop/publisher|subscriber' => 'Drop connections'
    ]
];

echo json_encode($response, JSON_PRETTY_PRINT);
