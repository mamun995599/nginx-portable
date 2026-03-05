<?php
echo "<h1>PHP Configuration Check</h1>";
echo "<table border='1' cellpadding='10'>";

echo "<tr><td><b>php.ini Path</b></td><td>" . php_ini_loaded_file() . "</td>";
if (strpos(php_ini_loaded_file(), 'nginx-portable') !== false) {
    echo "<td style='color:green'>✓ Portable</td>";
} else {
    echo "<td style='color:red'>✗ System</td>";
}
echo "</tr>";

echo "<tr><td><b>Extension Dir</b></td><td>" . ini_get('extension_dir') . "</td>";
if (strpos(ini_get('extension_dir'), 'nginx-portable') !== false) {
    echo "<td style='color:green'>✓ Portable</td>";
} else {
    echo "<td style='color:orange'>⚠ Built-in (OK)</td>";
}
echo "</tr>";

echo "<tr><td><b>Session Save Path</b></td><td>" . ini_get('session.save_path') . "</td>";
if (strpos(ini_get('session.save_path'), 'nginx-portable') !== false) {
    echo "<td style='color:green'>✓ Portable</td>";
} else {
    echo "<td style='color:red'>✗ System</td>";
}
echo "</tr>";

echo "<tr><td><b>Upload Tmp Dir</b></td><td>" . ini_get('upload_tmp_dir') . "</td>";
if (strpos(ini_get('upload_tmp_dir'), 'nginx-portable') !== false) {
    echo "<td style='color:green'>✓ Portable</td>";
} else {
    echo "<td style='color:red'>✗ System</td>";
}
echo "</tr>";

echo "<tr><td><b>Error Log</b></td><td>" . ini_get('error_log') . "</td>";
if (strpos(ini_get('error_log'), 'nginx-portable') !== false) {
    echo "<td style='color:green'>✓ Portable</td>";
} else {
    echo "<td style='color:red'>✗ System</td>";
}
echo "</tr>";

echo "</table>";

echo "<h2>All Scanned INI Files</h2>";
echo "<pre>";
print_r(php_ini_scanned_files());
echo "</pre>";
?>
