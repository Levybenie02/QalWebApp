
<?php
    header('Access-Control-Allow-Origin: *');

 include('connect.php');
    $jsonpath="data.json";
   
    try {
        $cmd="SELECT commande.Idcmd,client.nomprenom,prestataires.nomcomplet_prest,service.Lib_serv,commande.duree,commande.statut,commande.contratFile
        FROM commande INNER JOIN prestations ON commande.Idprestation=prestations.Idprestation 
        INNER JOIN client ON commande.Idclient=client.Idclient INNER JOIN prestataires ON prestataires.Mat_prest=prestations.Mat_prest 
        INNER JOIN service ON service.Numserv=prestations.Numserv 
        WHERE commande.statut='En cours' ORDER BY commande.Idcmd ASC
        ";
        $result=$db->query($cmd);
        $response=array();
        if($result->rowCount() >0){
            while($row=$result->fetchAll()){
                $response=$row;
            }
        }
        else
        {
            array_push($response,'Empty');
        }
    } catch (\Throwable $th) {
       echo 'ERROR :'.$th->getMessage();
    }
   echo json_encode($response);
