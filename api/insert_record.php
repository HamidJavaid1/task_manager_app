<?php
include("db_connection.php");
$con = dbconection();

// Debugging: Log incoming POST data for verification
error_log("POST Data: " . print_r($_POST, true));

// Check if all required POST fields are set
if (isset($_POST["name"]) && isset($_POST["email"]) && isset($_POST["password"])) {
    $name = trim($_POST["name"]);
    $email = trim($_POST["email"]);
    $password = trim($_POST["password"]);

    // Validate that none of the fields are empty
    if (empty($name) || empty($email) || empty($password)) {
        echo json_encode(["success" => false, "message" => "Fields cannot be empty."]);
        return;
    }

    // Secure the input data to prevent SQL Injection
    $name = mysqli_real_escape_string($con, $name);
    $email = mysqli_real_escape_string($con, $email);
    $password = mysqli_real_escape_string($con, $password);

    // Insert the data into the database
    $query = "INSERT INTO `user` (`uname`, `uemail`, `upassword`) VALUES ('$name', '$email', '$password')";
    $exe = mysqli_query($con, $query);

    $arr = [];
    if ($exe) {
        $arr["success"] = true;
        $arr["message"] = "User registered successfully.";
    } else {
        $arr["success"] = false;
        $arr["message"] = "Failed to insert record: " . mysqli_error($con);
    }
    print json_encode($arr);
} else {
    // Return error response if any field is missing
    echo json_encode(["success" => false, "message" => "Required fields are missing."]);
    return;
}
?>
