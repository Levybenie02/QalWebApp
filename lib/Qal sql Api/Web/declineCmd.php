<?php
header('Access-Control-Allow-Origin: *');

    include('connect.php');
    $idcmd=$_POST['idcmd'];
    $motif=$_POST['motif'];
    if(isset($idcmd)){
        try {
            $sql=$db->query("UPDATE commande SET `commande`.`motif`='$motif',`commande`.`statut`='Annulé' WHERE `commande`.`idcmd`='$idcmd'");
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