<?php
 include('connect.php');
    $jsonpath="data.json";
    $idclient=$_POST['Idclient'];
   
    try {
        $cmd="SELECT commande.*,prestataires.nomcomplet_prest,prestataires.photo_prest,prestataires.Lib_catg,service.Lib_serv,categorie.Sal_catg 
        FROM commande 
        INNER JOIN prestations ON commande.Idprestation=prestations.Idprestation 
        INNER JOIN prestataires ON prestations.Mat_prest=prestataires.Mat_prest 
        INNER JOIN service ON prestations.Numserv=service.Numserv 
        INNER JOIN categorie on categorie.Lib_catg=prestataires.Lib_catg
        WHERE commande.Idclient=$idclient AND commande.statut='En attente'";
        $result=$db->query($cmd);
        if($result->rowCount() >0){
            while($row=$result->fetchAll()){
               $response=$row;
            }
        }
        else
        {
            $response=['Empty'];
        }
    } catch (\Throwable $th) {
       echo 'ERROR :'.$th->getMessage();
    }
   echo json_encode($response);
