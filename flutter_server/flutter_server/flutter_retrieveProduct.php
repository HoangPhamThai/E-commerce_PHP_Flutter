<?php
	include "flutter_conn.php";
	// if (!empty($_POST['category'])){
	$category = $_POST["category"];
	$producer = $_POST["producer"];
	if ($producer == 'all'){
		$results = $conn -> query("SELECT * FROM `".$category."`");
	}else{
		$results = $conn -> query("SELECT * FROM `".$category."` WHERE producer=\"".$producer."\"");
	}
	

	$jsonResult = array();
	while ($fetchData = $results->fetch_assoc()){
		$jsonResult[] = $fetchData;
	}
	// if ($result === []){
	// 	echo json_decode('No data');
	// }else{
		echo json_encode($jsonResult);	
		//}
	//}
	
	mysqli_close($conn);
?>