<?php
include("db_connection.php");
$con = dbconection();

if (isset($_POST["name"]) && isset($_POST["email"]) && isset($_POST["password"])) {
    $name = trim($_POST["name"]);
    $email = trim($_POST["email"]);
    $password = trim($_POST["password"]);

    if (empty($name) || empty($email) || empty($password)) {
        echo json_encode(["success" => false, "message" => "Fields cannot be empty."]);
        return;
    }

    $name = mysqli_real_escape_string($con, $name);
    $email = mysqli_real_escape_string($con, $email);
    $password = mysqli_real_escape_string($con, $password);

    $query = "UPDATE `user` SET `uname`='$name', `upassword`='$password' WHERE `uemail`='$email'";
    $exe = mysqli_query($con, $query);

    if ($exe) {
        echo json_encode(["success" => true, "message" => "Record updated successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to update record."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid input."]);
}
?>