<?php
    $host="localhost";
    $dbname="qalapp";
    $dbuser="root";
    $pass="";
    $jsonpath="data.json";
    $response=array();
    $idclient=$_POST['idclient'];
    try {
        $db=new mysqli($host,$dbuser,$pass,$dbname);
        file_put_contents('data.json',null);

        $sql="SELECT prestations.*,prestataires.*,categorie.Sal_catg,service.Lib_serv ,commande.*
        FROM commande INNER JOIN prestations ON commande.Idprestation=prestations.Idprestation INNER JOIN prestataires ON prestataires.Mat_prest=prestations.Mat_prest 
        INNER JOIN categorie ON categorie.Lib_catg=prestataires.Lib_catg 
        INNER JOIN service ON prestations.Numserv=service.Numserv
        WHERE prestations.occupe='true' AND commande.Idclient=$idclient ORDER BY `prestations`.`Idprestation` DESC";
        $result=$db->query($sql);
        if($result->num_rows >0){
            while($row=$result->fetch_assoc()){
                array_push($response,$row);
            }
        }
    } catch (\Throwable $th) {
       echo 'ERROR :'.$th->getMessage();
    }

    $db->close();
   // header('Content-Type: application/json');
   $jsonfile= json_encode($response,JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
//   file_put_contents('data.json',$jsonfile);
   echo json_encode($response   );
    ?>