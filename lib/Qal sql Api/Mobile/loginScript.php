<?php
include "connect.php";
$email=$_POST['email'];
$pass=sha1($_POST['pass']);
$out=array();
try {
    if(isset($email,$pass)){
    $reqclient=$db->prepare("SELECT * FROM CLIENT WHERE email=? AND pass=?");
    $reqclient->execute(array($email,$pass));
    $client=$reqclient->rowCount();
      if ($client==1){
        $outnum=0;
        $array=$reqclient->fetch();
        $output="Bienvenue $email";
      }
        else
        {
            $output="Email ou mot de passe incorrect";
            $outnum=1;
            $array=[];
        }
 }
 else
 {
     $output="Champ vide";
     $outnum=1;
 }
 }
catch (\Throwable $th) {
    //throw $th;
    $output="Error".$th->getMessage();
    $outnum=1;
}
  $out=array($output,$outnum,$array);
    echo json_encode ( $out);
