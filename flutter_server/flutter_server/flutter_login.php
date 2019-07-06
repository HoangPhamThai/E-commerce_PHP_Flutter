<?php
	include 'flutter_conn.php';

	if (!empty($_POST['account']) && !empty($_POST['password'])){
		$account = $_POST['account'];
		$password = hash('sha256',$_POST['password'].$account);
		$typeOfCus = $_POST['type'];

		if ($typeOfCus == 'client'){
			$nameOfCompany = '';
		}else{
			$nameOfCompany = $_POST["company"];
		}
		$queryResult = $conn->query("SELECT * FROM `userinfo` WHERE account=\"".$account."\" AND password=\"".$password."\" AND type=\"".$typeOfCus."\" AND company=\"".$nameOfCompany."\"");
		
		$result = array();
		while ($fetchData = $queryResult->fetch_assoc()) {
			$result[]=$fetchData;
		}
		echo json_encode($result);
	}

	mysqli_close($conn);
?>
