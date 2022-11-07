<?php
 header('Access-Control-Allow-Origin: *');

include('connect.php');
$array=array();
try {
    $Stat1=$db->query('SELECT * FROM prestations WHERE prestations.Numserv=1');
    $Stat2=$db->query('SELECT * FROM prestations WHERE prestations.Numserv=2');
    $Stat3=$db->query('SELECT * FROM prestations WHERE prestations.Numserv=3');
    $cmd1=$db->query('SELECT * FROM prestataires WHERE prestataires.Statut=1');
    $cmd2=$db->query('SELECT * FROM prestataires WHERE prestataires.Statut=0');
    
    if($Stat1 && $Stat2 && $Stat3){
        $count1=$Stat1->rowCount();
        $count2=$Stat2->rowCount();
        $count3=$Stat3->rowCount();
        $cmdcount1=$cmd1->rowCount();
        $cmdcount2=$cmd2->rowCount();
        $array=array($count1,$count2,$count3,$cmdcount1,$cmdcount2);
    }
} catch (\Throwable $th) {
    //throw $th;
    'Error'.$th->getMessage();
}

echo json_encode($array);
