<?php
	include 'flutter_conn.php';
	// if (isset($_POST['name']) && isset($_POST['account']) && isset($_POST['password']) && isset($_POST['email']) && isset($_POST['phone'])){
	if (!empty($_POST['name']) && !empty($_POST['account']) && !empty($_POST['password']) && !empty($_POST['email']) && !empty($_POST['phone'])){
		$name = $_POST['name'];
		$account = $_POST['account'];
		$password = hash('sha256',$_POST['password'].$account);
		$email = $_POST['email'];
		$phone = $_POST['phone'];
		$type = $_POST['type'];

		if ($type == 'client'){
			$nameOfCompany = '';
		}else{
			$nameOfCompany = $_POST["company"];
		}
		
		$duplicateResult = $conn->query("SELECT * FROM `userinfo` WHERE (account=\"".$account."\") OR (email=\"".$email."\")");

		$result = array();
		while ($fetchData = $duplicateResult->fetch_assoc()) {
			$result[]=$fetchData;
		}
		if (($result) === []){
			$jsonresult = '0';
			$queryResult = $conn->query("INSERT INTO `userinfo`(`name`,`account`,`password`,`email`,`phone`,`type`,`company`) VALUES (\"".$name."\",\"".$account."\",\"".$password."\",\"".$email."\",\"".$phone."\",\"".$type."\",\"".$nameOfCompany."\")");
		}else{
			$jsonresult = '1'; 
		}
		echo json_encode($jsonresult);
	}
	mysqli_close($conn);
?>