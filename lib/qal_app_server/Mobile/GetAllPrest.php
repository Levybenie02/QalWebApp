<?php
include('connect.php');
    $db_data=array();
    $sql=$db->query('SELECT * FROM PRESTATAIRES');
    if($sql->rowCount()>0){
        while($row=$sql->fetchAll()){
            $db_data[]=$row;
        }
        echo ("Good Day !!");
    }
    else
    {
        echo 'Error';
    }
    $db=null;
    return;
?>