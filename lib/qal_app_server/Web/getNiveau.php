
<?php
    header('Access-Control-Allow-Origin: *');

 include('connect.php');
    $jsonpath="data.json";
   
    try {
        $cmd="SELECT * FROM niveau";
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
