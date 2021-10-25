<?php
$sql = new mysqli("127.0.0.1", "ctfd", "ctfd", "ctfd");
if($sql->connect_error) {
	die("Connection failed: " . $sql->connect_error);
}


$current_time = time();

$stopTime = strtotime("2021-10-14 22:00");
$category = "Polar Party";
$webhook = 'DISCORD ENIGMA_URL';
