<?php
include("db_connection.php");
$con = dbconection();

$query = "SELECT `uid`, `uname`, `uemail`, `upassword` FROM `user`";
$exe = mysqli_query($con, $query);
$arr = [];

while ($row = mysqli_fetch_assoc($exe)) {
    $arr[] = $row; // Append each row to the array
}

// Encode and print the entire array once, after the loop
echo json_encode($arr);

mysqli_close($con); // Close the connection
?>
