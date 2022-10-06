<?php
    header('Access-Control-Allow-Origin: *');

    $host="localhost";
    $dbname="qalapp";
    $dbuser="root";
    $pass="";
    $jsonpath="data.json";
    try {
        $db=new mysqli($host,$dbuser,$pass,$dbname);
        $cmd="SELECT commande.*,prestataires.nomcomplet_prest,prestataires.photo_prest,prestataires.Lib_catg,service.Lib_serv,categorie.Sal_catg 
        FROM commande 
        INNER JOIN prestations ON commande.Idprestation=prestations.Idprestation 
        INNER JOIN prestataires ON prestations.Mat_prest=prestataires.Mat_prest 
        INNER JOIN service ON prestations.Numserv=service.Numserv 
        INNER JOIN categorie on categorie.Lib_catg=prestataires.Lib_catg
        WHERE commande.statut='En cours'";
        $result=$db->query($cmd);
        $response=array();
        if($result->num_rows >0){
            while($row=$result->fetch_assoc()){
                array_push($response,$row);
            }
        }
    } catch (\Throwable $th) {
       echo 'ERROR :'.$th->getMessage();
    }

    $db->close();
   echo json_encode($response);
    ?>