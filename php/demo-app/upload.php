<?php

echo '<pre>';

var_dump($_SERVER);
var_dump($_POST);

var_dump(ini_get('memory_limit'));

var_dump(memory_get_peak_usage(true)/1024/1024);

$file_names = explode('.', $_POST['video_file_name']);
$file_ext = array_pop($file_names);
$file_name = $_POST['video_file_md5'] . '.' . $file_ext;

rename($_POST['video_file_tmp_path'], '/var/www/apps/temp/nas/videos/' . $file_name);

var_dump(memory_get_peak_usage(true)/1024/1024);

echo 'http://demo.dev/videos/' . $file_name;