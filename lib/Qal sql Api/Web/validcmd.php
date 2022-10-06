<?php
header('Access-Control-Allow-Origin: *');

    include('connect.php');
    $idcmd=$_POST['idcmd'];
    if(isset($idcmd)){
        try {
            $sql=$db->query("UPDATE commande SET `commande`.`statut`='Validé' WHERE `commande`.`idcmd`='$idcmd'");
            if($sql){
                $outnum=0;
            }
            else
            {
                $outnum=1;
            }
        } catch (\Throwable $th) {
            echo 'Exception catch :'.$th->getMessage();
        }
    }
    else
    {
        echo ('Error ');
    }
    echo json_decode($outnum);