<?php
    header('Access-Control-Allow-Origin: *');

    $host = "91.216.107.161";
    $dbname = "nexle1991881_17fwvp";
    $dbuser = "nexle1991881_17fwvp";
    $pass = "miattdakev";
    $jsonpath="data.json";
    $response=array();
    try {
        $db=new mysqli($host,$dbuser,$pass,$dbname);
        $serv=$_POST['service'];
        $nat=$_POST['nationalite'];
        $comm=$_POST['commune'];
        $eth=$_POST['ethnie'];
        $rel=$_POST['religion'];

        
            $sql="SELECT prestations.*,prestataires.*,categorie.Sal_catg,service.Lib_serv 
            FROM prestations INNER JOIN prestataires ON prestataires.Mat_prest=prestations.Mat_prest 
            INNER JOIN categorie ON categorie.Lib_catg=prestataires.Lib_catg 
            INNER JOIN service ON prestations.Numserv=service.Numserv
            WHERE prestataires.nationalite_prest LIKE '%$nat%' AND
            prestataires.commune_prest LIKE '%$comm%' AND prestataires.ethnie_prest LIKE '%$eth%'
            AND prestataires.religion_prest LIKE '%$rel%' AND service.Lib_serv  LIKE '%$serv%'
            ORDER BY `prestataires`.`Mat_prest` DESC;
            ";
            $result=mysqli_query($db,$sql);
            if($result->num_rows >0){
                while($row=$result->fetch_assoc()){
                    array_push($response,$row);
                }
            }
            else
            {
                array_push($response,'Empty');
            }
        }
     
     catch (\Throwable $th) {
       echo 'ERROR :'.$th->getMessage();
    }

    $db->close();
   echo json_encode($response);
    ?>