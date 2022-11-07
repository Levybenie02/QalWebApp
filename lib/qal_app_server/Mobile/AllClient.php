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
        file_put_contents('data.json',null);

        $sql="SELECT * FROM `client` WHERE 1";
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
    header('Content-Type: application/json');
  // $jsonfile= json_encode($response,JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
   //file_put_contents('data.json',$jsonfile);
   echo json_encode($response);
    ?>