<?php
require_once 'config.php';

$data = $sql->query("SELECT * FROM challenges WHERE openTime > 0 AND state='hidden' ORDER BY openTime ASC");

foreach($data as $row) {
	echo $row['name'];
	echo "\t";
	echo date("Y-m-d H:i", $row['openTime']);
	echo "\n";


}
