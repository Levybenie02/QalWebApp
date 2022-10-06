<?php
    header('Access-Control-Allow-Origin: *');

    $host="localhost";
    $dbname="qalapp";
    $dbuser="root";
    $pass="";
    $jsonpath="data.json";
    $response=array();

    $cl=0;
    
    try {
        $db=new mysqli($host,$dbuser,$pass,$dbname);
        $client=$db->query('SELECT COUNT(*) FROM commande');
      //  $prestataire=$db->query('SELECT COUNT(*) FROM prestataires');
      //  $encours=$db->query('SELECT COUNT(*) FROM commande where commande.statut="En cours" ');
      //  $enAtt=$db->query('SELECT COUNT(*) FROM commande where commande.statut="En attente" ');
      //  $valid=$db->query('SELECT COUNT(*) FROM commande where commande.statut="Validé" ');
        if($client->num_rows >0){
            while($row=$client->fetch_assoc()){
                array_push($response,$row["COUNT(*)"]);  
            }
        }
    } catch (\Throwable $th) {
       echo 'ERROR :'.$th->getMessage();
    }

    $db->close();
   echo json_encode($response);
?>