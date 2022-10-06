<?php
    header('Access-Control-Allow-Origin: *');

    $host="localhost";
    $dbname="qalapp";
    $dbuser="root";
    $pass="";
    $jsonpath="data.json";
    $response=array();
    try {
        $db=new mysqli($host,$dbuser,$pass,$dbname);
        $rech=$_POST['searchtxt'];
        if(isset($rech)){
            $sql="SELECT prestations.*,prestataires.*,categorie.Sal_catg,service.Lib_serv 
            FROM prestations INNER JOIN prestataires ON prestataires.Mat_prest=prestations.Mat_prest 
            INNER JOIN categorie ON categorie.Lib_catg=prestataires.Lib_catg 
            INNER JOIN service ON prestations.Numserv=service.Numserv
            WHERE prestataires.nationalite_prest LIKE '%$rech%' OR prestataires.nomcomplet_prest LIKE '%$rech%' OR
            prestataires.commune_prest LIKE '%$rech%' OR prestataires.ethnie_prest LIKE '%$rech%'
            OR prestataires.religion_prest LIKE '%$rech%' OR prestataires.niv_etude LIKE '%$rech%' OR service.Lib_serv  LIKE '%$rech%'
            
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
        else
        {
            array_push($response,'Empty');
        }
    } catch (\Throwable $th) {
       echo 'ERROR :'.$th->getMessage();
    }

    $db->close();
   echo json_encode($response);
    ?>