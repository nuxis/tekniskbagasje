<?php

$allowed_chars = "abcdefghijklmnopqrstuvwxyz";
$all_chars = str_split($allowed_chars);
$output = '';
$number_of_chars = 20;

for($i=0;$i<$number_of_chars;$i++) {
	$array_size = count($all_chars);
	$char = $all_chars[rand(0, $array_size-1)];
	$output .= $char;
	if($i % 2) $output .= ' ';

	$all_chars = array_diff($all_chars, array($char));
	sort($all_chars);
	#print_r($all_chars);
}

echo $output."\n";


