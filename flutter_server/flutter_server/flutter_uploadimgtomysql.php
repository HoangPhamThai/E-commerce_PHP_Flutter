<?php
	include "flutter_conn.php";
	// if (!empty($_POST['name']) && !empty($_POST['description']) && !empty($_POST['price']) && !empty($_POST['category'])){

	// }
	// if (is_null($_FILES['image']['name'])){
	// 	echo json_encode('No image!');
	// }else{
		$image = $_FILES["image"]["name"];
		$imagePath = "uploadImage/".$image;
		$name = $_POST["name"];
		$description = $_POST["description"];
		$price = $_POST["price"];
		$category = $_POST["category"];
		$producer = $_POST["producer"];
		move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);

		// $queryResult = $conn->query("INSERT INTO `".$category."`(`name`,`image`,`description`,`price`) VALUES (\"".$name."\",\"".$image."\",\"".$description."\",\"".$price."\")");
		$queryResult = $conn->query("INSERT INTO `".$category."`(`name`,`image`,`description`,`price`,`producer`) VALUES (\"".$name."\",\"".$image."\",\"".$description."\",\"".$price."\",\"".$producer."\")");
		// $queryResult = $conn->query("INSERT INTO `".$category."`(`name`,`image`,`description`) VALUES (\"".$name."\",\"".$image."\",\"".$description."\")");
		echo json_encode($queryResult);
	// }
	mysqli_close($conn);
?>