 <?php
    $host = "91.216.107.161";
    $dbname = "nexle1991881_17fwvp";
    $dbuser = "nexle1991881_17fwvp";
    $pass = "miattdakev"; 
    $jsonpath="data.json";
    $IDCLIENT=$_POST['idclient'];;
    try {
        $db=new mysqli($host,$dbuser,$pass,$dbname);
        $cmd="SELECT COUNT(*) FROM prestataires";
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
   echo json_encode($response[0]['SUM(categorie.Sal_catg)']);
    ?>