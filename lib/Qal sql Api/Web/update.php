<?php
    header('Access-Control-Allow-Origin: *');

    include('connect.php');

    $idprest=$_POST['idprest'];
    $nom=$_POST['nom'];
    $cont=$_POST['contact'];
    $serv=$_POST['service'];
    $nat=$_POST['nationalite'];
    $com=$_POST['commune'];
    $eth=$_POST['ethnie'];
    $rel=$_POST['religion'];
    $stat=$_POST['statut']; 


    $array=array();
    if(isset($idprest)){
        try {
            $sql=$db->query("UPDATE prestataires INNER JOIN prestations ON prestations.Mat_prest=prestataires.Mat_prest 
            SET `prestataires`.`nomcomplet_prest`='$nom',`prestataires`.`contact_prest`='$cont',`prestations`.`Numserv`='$serv',`prestataires`.`nationalite_prest`='$nat',`prestataires`.`commune_prest`='$com', `prestataires`.`ethnie_prest` ='$eth', `prestataires`.`religion_prest`='$rel',`prestataires`.`Statut` ='$stat' 
            WHERE `prestataires`.`Mat_prest` = '$idprest'");
            if($sql){
                $outnum=0;
            }
            else
            {
                $outnum=1;
            }
        } catch (\Throwable $th) {
            echo 'Exception catch :'.$th->getMessage();
        }
    }
    else
    {
        echo ('Error ');
    }
    echo  ($outnum);