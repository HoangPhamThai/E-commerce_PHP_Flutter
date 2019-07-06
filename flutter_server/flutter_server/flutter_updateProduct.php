<?php
	include "flutter_conn.php";
	$id = (int)$_POST['id'];
	$image = $_FILES["image"]["name"];
	$imagePath = "uploadImage/".$image;
	$name = $_POST["name"];
	$description = $_POST["description"];
	$price = $_POST["price"];
	$category = $_POST["category"];
	$oldImage = $_POST["oldImage"];

	move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);

	// $queryResult = $conn->query("INSERT INTO `".$category."`(`name`,`image`,`description`,`price`) VALUES (\"".$name."\",\"".$image."\",\"".$description."\",\"".$price."\")");
	$queryResult = $conn->query("UPDATE `".$category."` SET `name`=\"".$name."\",`image`=\"".$image."\", `description`=\"".$description."\", `price`=\"".$price."\" WHERE `".$category."`.`id`=".$id."");
	// $queryResult = $conn->query("INSERT INTO `".$category."`(`name`,`image`,`description`) VALUES (\"".$name."\",\"".$image."\",\"".$description."\")");
	echo json_encode($queryResult);
	$linkToOldImg = "uploadImage/".$oldImage;
	unlink($linkToOldImg) or die("Can not delete file");
	// }
	mysqli_close($conn);
?>
