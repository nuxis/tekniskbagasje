<?php
require_once 'config.php';


$result = $sql->query("SELECT * FROM challenges WHERE openTime <= '".time()."' AND state = 'hidden' LIMIT 0,1");

#die("SELECT * FROM challenges WHERE openTime <= '".time()."' AND state = 'hidden' LIMIT 0,1");

foreach($result as $row) {
	$sql->query("UPDATE challenges SET state = 'visible' WHERE id = '".$row['id']."'");
	$msg = create_discordmsg();
	$sendmsg = discordmsg($msg);
	require_once 'find_times.php';
}

#$needs_points = $sql->query("SELECT * FROM solves");
$needs_points = $sql->query("SELECT * FROM solves WHERE user_points IS NULL");

foreach($needs_points as $row) {
	$points = calculate_points($row['id']);
	$sql->query("UPDATE solves SET user_points = '$points' WHERE id = '".$row['id']."'");
	if($points > 0) {
		$usermsg = discord_userSolve($row['id']);
		$sendmsg = discordmsg($usermsg);
	}

}



function calculate_points($solve_id) {
	global $sql;
	#echo $solve_id;
	
	$solve = $sql->query("SELECT * FROM solves WHERE id = $solve_id");
	foreach($solve as $solved)
	
	$challenge = $sql->query("SELECT * FROM challenges WHERE id = '".$solved['challenge_id']."'");
	foreach($challenge as $challenged)
	$dynamic_score = $sql->query("SELECT * FROM dynamic_challenge WHERE id = '".$solved['challenge_id']."'");
	foreach($dynamic_score as $dynamic_scored)

	
	
	if($challenged['type'] == 'standard') {
		#echo $challenged['id']. " ". $challenged['value']."\n";
		echo "Should return 0";
		return $challenged['value'];
	}
	else {
		$count_before = $sql->query("SELECT COUNT(*) AS antall FROM solves WHERE id < '$solve_id' AND challenge_id = '".$solved['challenge_id']."'");
		#die("SELECT COUNT(*) AS antall FROM solves WHERE id < '$solve_id' AND challenge_id = '".$solved['challenge_id']."'");
		foreach($count_before as $count)
		#echo $challenged['name']. " - ".$count['antall']."\n";
		$points = $dynamic_scored['initial'] - $count['antall'];
		if($points < $dynamic_scored['minimum']) $points = $dynamic_scored['minimum'];
		return $points;
	}
	
}


function discordmsg($msg) {
	$webhook = $GLOBALS['webhook'];

	if($webhook != "") {
		$ch = curl_init($webhook);
		$msg = "payload_json=" . urlencode(json_encode($msg))."";
		if(isset($ch)) {
			curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
			curl_setopt($ch, CURLOPT_POSTFIELDS, $msg);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			$result = curl_exec($ch);
			curl_close($ch);
			return $result;
		} // End if isset
		else echo "No curl handler";
	} // end if webhook
	else {
		echo "No webhook?";
	}
} // End function


function create_discordmsg() {
	$msg = json_decode('
{
	"username": "ENIGMA",
	"content": "En ny oppgave er lagt ut på ENIGMA-konkurransen! Bli med på https://enigma.pp29.polarparty.no"
}',true);


	return $msg;
	
} // end create_discordmsg


function discord_userSolve($solveID) {
	global $sql;

	$solve = $sql->query("SELECT u.name as username,c.name as challenge_name,s.user_points FROM (solves s JOIN users u ON s.user_id=u.id) JOIN challenges c ON c.id=s.challenge_id WHERE s.id = '$solveID'");

	foreach($solve as $solved)

	$msg = json_decode('
	{
		"username": "ENIGMA",
		"content": "'.$solved['username'].' løste oppgaven '.$solved['challenge_name'].' og fikk '.$solved['user_points'].' poeng"
	}', true);
	return $msg;
}