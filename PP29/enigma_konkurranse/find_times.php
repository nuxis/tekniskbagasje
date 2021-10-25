<?php
require_once 'config.php';



$needs_time = $sql->query("SELECT * FROM challenges WHERE state='hidden' ORDER BY RAND()");
$number = $sql->query("SELECT COUNT(*) AS antall FROM challenges WHERE state='hidden'");
foreach($number as $count)
#die("SELECT * FROM challenges WHERE ((openTime IS NULL OR openTime >= '$stopTime') OR (state='hidden AND openTime <= '".time()."')  AND category = '$category' ");

$maxTime = $stopTime;
$challengeTime = time();
$diffTime = $maxTime - time();
$diff = $diffTime / $count['antall'];



foreach($needs_time as $row) {
	echo $row['name']."\n";
	$challengeTime = $challengeTime + $diff;
	
	$sql->query("UPDATE challenges SET openTime = '$challengeTime' WHERE id = '".$row['id']."'");

}
