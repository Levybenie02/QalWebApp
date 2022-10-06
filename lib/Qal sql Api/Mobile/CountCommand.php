<?php
    $host="localhost";
    $dbname="qalapp";
    $dbuser="root";
    $pass="";
    $IDCLIENT=1;
    $response=array();

    try {
        $db=new mysqli($host,$dbuser,$pass,$dbname);
        $count="SELECT * FROM commande WHERE commande.Idclient=$IDCLIENT AND commande.statut='En attente'";
        $result=$db->query($count);
        $row=$result->num_rows;
        if($row<1){
            $row=0;
        }
    } catch (\Throwable $th) {
       echo 'ERROR :'.$th->getMessage();
    }

   // $db->close();
   echo $row;
    ?>