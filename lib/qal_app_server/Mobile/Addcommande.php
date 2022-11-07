<?php
    include ('connect.php');

    $idclient=$_POST['Idclient'];
    $idprest=$_POST['Idprest'];
    $duree=$_POST['duree']; 
    $date=date("d-m-Y H:i");
    if(isset($idclient,$idprest,$duree))
    {
        try {
            $add=$db->prepare("INSERT INTO `commande` (`Idcmd`, `Idclient`, `Idprestation`, `duree`,`statut`,`contratFile`,`Motif`,`Datecommande`) VALUES (Null,?,?,?,?,?,?,?);");
            $add->execute(array($idclient,$idprest,$duree,'En cours','','',$date));
            if($add){
                $addnum=0;
                $checkcmd=$db->prepare("UPDATE `prestations` SET `occupe` = 'true' WHERE `prestations`.`Idprestation` =?");
                $checkcmd->execute(array($idprest));
                if($checkcmd){
                    $addmsg='Commande effectué avec succès';
                }
            }
            else
            {
                $addnum=1;
                $addmsg='Commande Refusé';
            }
            
        } catch (\Throwable $th) {
            $addnum=1;
            $addmsg="Error :".$th ->getMessage();
        }
    }
    else
    {
        $addnum=1;
        $addmsg='Données manquantes';
    }
    $array=array($addnum,$addmsg);
    echo json_encode($array);
