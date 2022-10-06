<?php
header('Access-Control-Allow-Origin: *');
//header('Access-Control-Allow-Methods : POST,GET,OPTIONS,PUT,DELETE');
//header('Access-Control-Allow-Headers : Content-Type, X-Auth-Token, Origin, Authorization');
include 'connect.php';

$req=$db->query("SELECT * FROM prestataires");
$listprest=array();
if($req)
{
    $rowcount=$req->rowcount();
    while($prestdata=$req->fetchAll()){
        $listprest=$prestdata;
    }
    echo json_encode($listprest);
}
?> 