<?php
include ('connect.php');

$nbre=$_POST['duree'];
$idcmd=$_POST['idcmd'];
if(isset($nbre,$idcmd)){
    try {
     $update=$db->query("UPDATE `commande` SET `duree` = '$nbre' WHERE `commande`.`Idcmd` =$idcmd");
     if($update){
        $num=0;
         $out="Commnde modifier avec succès. Durée du contrat :$nbre";
     }
     else
     {
         $num=1;
        $out="Modifications échoué";
     }
    
    } catch (\Throwable $th) {
        //throw $th;
        echo 'ERROR :'.$th->getMessage();
        $out=$th;
        $num=1;
    }
}
$array=array($num,$out);
echo json_encode($array);

?>