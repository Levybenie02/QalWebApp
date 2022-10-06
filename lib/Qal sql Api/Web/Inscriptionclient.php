<?php
    header('Access-Control-Allow-Origin: *');

include 'connect.php';
$id="";
$name=$_POST['name'];
$num=$_POST['num'];
$email=$_POST['email'];
$pass=sha1($_POST['pass']);
$birth=$_POST['birth'];
$age=$_POST['age'];
$genre=$_POST['genre'];
$commune=$_POST['commune'];
$photodeprofil=$_POST['profilimg'];
$rapport=array();
try {
    if(isset($name,$num,$email,$pass,$birth,$age,$genre,$commune,$photodeprofil)){
        $req=$db->prepare("SELECT * FROM client WHERE email=?");
        $req->execute(array($email.trim(" ")));
        $exis=$req->rowCount();
        if($exis==0){      
       $req=$db->prepare("INSERT INTO client VALUES(?,?,?,?,?,?,?,?,?,?)");
       $req->execute(array($id,$name,$num,$email,$pass,$birth,$age,$genre,$commune,$photodeprofil));
       if($req)
        {
         $outnum= 0;
          $output="Vous avez été enregistré avec succes";
        }
else
   {   
    $outnum= 1;
    $output="Erreur de votre inscription";
}
        }
        else
        {   
            $outnum= 1;
            $output="Cet email existe déjà";
        }
    }
} catch (\Throwable $th) {
    $outnum= 1;
    $output="Error :".$th ->getMessage();
}
$rapport=array($outnum,$output);
echo json_encode($rapport);


