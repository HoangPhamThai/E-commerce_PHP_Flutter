<?php
	$servername = "localhost";
	$username = "flutterphp";
	$password = "flutterphp";
	$dbname = "flutter_php_db";

	$conn = new mysqli($servername, $username, $password, $dbname);

	if ($conn){
	}else{
		echo "Connection failed";
		exit();
	}
?>