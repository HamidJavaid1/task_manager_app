<?php
include("db_connection.php");
$con = dbconection();

if (isset($_POST["id"])) {
    $id = $_POST["id"];
} else {
    echo json_encode(["success" => "false", "message" => "ID not provided"]);
    return;
}

$query = "DELETE FROM `user` WHERE `uid` = '$id'";

$exe = mysqli_query($con, $query);

$arr = [];

if ($exe) {
    $arr["success"] = "true";
} else {
    $arr["success"] = "false";
    $arr["message"] = "Failed to delete record.";
}

echo json_encode($arr);
?>
