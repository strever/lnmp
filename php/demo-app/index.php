<?php


$db = new PDO('mysql:host=mysql;port=3306;dbname=db_demo', 'db_user_demo', 'passWord@db_demo', [
    PDO::MYSQL_ATTR_INIT_COMMAND => 'set names utf8',
]);

$db->exec('CREATE TABLE IF NOT EXISTS `demo_user`(
`user_id` int(11) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
`name` varchar(64) COMMENT "姓名"
);

');

$randomName = md5(uniqid());
$db->exec("INSERT INTO demo_user VALUES(null, '{$randomName}');");
$statement = $db->query('SELECT * FROM demo_user', PDO::FETCH_ASSOC);
var_dump($statement->fetchAll());
