<?php
header('Access-Control-Allow-Origin: *');

include "connect.php";
$email=$_POST['email'];
$pass=sha1($_POST['pass']);
$out=array();
try {
    if(isset($email,$pass)){
    $reqAgt=$db->prepare("SELECT * FROM Agents WHERE username=? AND pass=?");
    $reqAgt->execute(array($email,$pass));
    $Agt=$reqAgt->rowCount();
      if ($Agt==1){
        $outnum=0;
        $array=$reqAgt->fetch();
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
    echo json_encode($out);
