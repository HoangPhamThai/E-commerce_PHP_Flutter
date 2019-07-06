<?php
	include "flutter_conn.php";
	$id = (int)$_POST['id'];
	$image = $_POST['image'];
	$category = $_POST['category'];

	$result = $conn->query("DELETE FROM `".$category."` WHERE `".$category."`.`id`=\"".$id."\"");
	echo json_encode($result);

	$linkToImg = "uploadImage/".$image;
	unlink($linkToImg) or die("Can not delete file");
	mysqli_close($conn);
?>