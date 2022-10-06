 <?php
    $host="localhost";
    $dbname="qalapp";
    $dbuser="root";
    $pass="";   
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