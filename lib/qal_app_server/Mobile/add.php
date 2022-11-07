<?php
include 'connect.php';

$name=$_POST['name'];
$num=$_POST['num'];

if(isset($name,$num)){
$req=$db->prepare("INSERT INTO test VALUES(?,?)");
$req->execute(array($name,$num));
}
$listprest=array();
if($req)
{
    echo 'data send';
}
else
{
    echo 'data Not Send';
}
