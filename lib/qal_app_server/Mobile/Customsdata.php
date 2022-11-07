<?php
include 'connect.php';

//$email=$_POST["email"];
$email=$_POST['email'];
try {
    if(isset($email)){
     $req=$db->prepare("SELECT * FROM client where email=?");
    $req->execute(array($email));
if($req)
{
    $rowcount=$req->rowcount();
    while($prestdata=$req->fetchAll()){
        echo json_encode($prestdata);
    }
}
    }
} catch (\Throwable $th) {
    //throw $th;
}
?>