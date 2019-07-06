<?php
	include "flutter_conn.php";

	// if (!empty($_POST["productType"])){
		$productType = $_POST["productType"];
		$request = $conn->query("SELECT DISTINCT `producer` FROM `".$productType."`");

		$jsonResult = array();
		while ($fetchData = $request->fetch_assoc()){
			$jsonResult[] = $fetchData;
		}
		echo json_encode($jsonResult);
	// }
	mysqli_close($conn);
?>