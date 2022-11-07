<?php
   $host = "91.216.107.161";
   $dbname = "nexle1991881_17fwvp";
   $dbuser = "nexle1991881_17fwvp";
   $pass = "miattdakev";
    $jsonpath="data.json";
    try {
        $db=new mysqli($host,$dbuser,$pass,$dbname);
        file_put_contents('data.json',null);

        $sql="SELECT prestations.*,prestataires.*,categorie.Sal_catg,service.Lib_serv 
        FROM prestations 
        INNER JOIN prestataires ON prestataires.Mat_prest=prestations.Mat_prest INNER JOIN categorie ON categorie.Lib_catg=prestataires.Lib_catg 
        INNER JOIN service ON prestations.Numserv=service.Numserv 
        WHERE service.Lib_serv='Servantes';
        ";
        $result=$db->query($sql);
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