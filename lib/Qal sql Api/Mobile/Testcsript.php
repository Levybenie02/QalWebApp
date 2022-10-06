<?php
include 'connect.php';
$req=$db->query("SELECT * FROM test");
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