<?php
    header('Access-Control-Allow-Origin: *');

    include('connect.php');

    $idprest=$_POST['idprest'];

    $array=array();
    if(isset($idprest)){
        try {
            $sql=$db->prepare("DELETE FROM `prestataires` WHERE `prestataires`.`Mat_prest` = ?");
            $sql->execute(array($idprest));
            if($sql){
                $outnum=0;
            }
            else
            {
                $outnum=1;
            }
        } catch (\Throwable $th) {
            echo 'ERROR :'.$th->getMessage();
        }
    }
    else
    {
        echo ('Error ');
    }
    echo json_encode ($outnum);
?>