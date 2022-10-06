<?php
    include('connect.php');

    $idcmd=$_POST['idcmd'];
    $idprest=$_POST['idprest']; 
    $array=array();
    try {
        $sql=$db->prepare("DELETE FROM commande WHERE commande.Idcmd=?");
        $sql->execute(array($idcmd));
        if($sql){
            $num=0;
            $checkcmd=$db->prepare("UPDATE `prestations` SET `occupe` = 'false' WHERE `prestations`.`Idprestation` =?");
            $checkcmd->execute(array($idprest));
            if($checkcmd){
                $addmsg='Commande supprimé';
            }
            else{
                $addmsg='Erreur de suppression';
            }
        }
        else
        {
            $addmsg="Erreur de suppression";
            $num=1;
        }
    } catch (\Throwable $th) {
        echo 'ERROR :'.$th->getMessage();
    }
    $array=array($addmsg,$num);
    echo json_encode ( $array);
?>