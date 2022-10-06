<?php

include('connect.php');
$nom = $_POST['nom'];
$email = $_POST['email'];
$pass = sha1($_POST['pass']);
$idgoogle = $_POST['id_google'];
$photo = $_POST['photo'];

try {
  if (isset($idgoogle, $email, $pass)) {
    $req=$db->prepare("SELECT * FROM client WHERE email=?");
    $req->execute(array($email.trim(" ")));
    $exis=$req->rowCount();
    if($exis==0){
      $req = $db->prepare("INSERT INTO client(`nomprenom`,`email`,`pass`,`idgoogle`,`photodeprofil`) VALUES(?,?,?,?,?)");
      $req->execute(array($nom, $email, $pass, $idgoogle,$photo));
      if ($req) {
        $reqclient=$db->prepare("SELECT * FROM CLIENT WHERE email=? AND pass=?");
        $reqclient->execute(array($email,$pass));
        $outnum = 0;
        $array = $reqclient->fetch();
        $output = "Vous avez été enregistré avec succes";
      } else {
        $output = "Email ou mot de passe incorrect";
        $outnum = 1;
        $array = [];
      }
    }
    else
    {
      $output = " Cet email exist déjà";
      $outnum = 1;
      $array = [];
    }
  } else {
    $output = "Champ vide";
    $outnum = 1;
  }
} catch (\Throwable $th) {
  $outnum = 1;
  $output = "Error :" . $th->getMessage();
}
$out=array($output,$outnum,$array);
    echo json_encode ( $out);
   