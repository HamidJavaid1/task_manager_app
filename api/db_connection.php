<?php
function dbconection() {
    $con = mysqli_connect('localhost', 'root', '', 'task_manager_api');
    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }
    return $con;
}
?>
