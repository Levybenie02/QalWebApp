<?php

include ('connect.php');

$email=$_POST['email'];

try {
    
    if(isset($email)){
        $req1=$db->prepare("DELETE FROM `client` WHERE `client`.`email` = ?");
        $req1->execute(array($email));
    
        if($req1){
            $outNum=0;
            $output="Compte supprimé";
        }else{
            $outNum=1;
            $output="Ce compte exist";
        }
    }
} catch (\Throwable $th) {
    $output="Error".$th->getMessage();
    $outNum=1;
}
$out=array($outNum,$output);
echo json_encode($out);


?>