<?php
require 'mailer/vendor/autoload.php';
use \Mailjet\Resources;
//$mj = new \Mailjet\Client(getenv(MJ_APIKEY_PUBLIC), getenv(MJ_APIKEY_PRIVATE),true,['version' => 'v3.1']);
$mj = new \Mailjet\Client('8d9b519b2d317aed2ffe9a69d3b067d9','41f2921fafe31c268a8864e2030507d3',true,['version' => 'v3.1']);

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
       $req=$db->prepare("INSERT INTO client VALUES(?,?,?,?,?,?,?,?,?,?,?)");
       $req->execute(array($id,$name,$num,$email,$pass,$birth,$age,$genre,$commune,$photodeprofil,'00'));
       if($req)
        {   
        $reqclient=$db->prepare("SELECT * FROM CLIENT WHERE email=? AND pass=?");
        $reqclient->execute(array($email,$pass));
        $client=$reqclient->rowCount();

        $code=rand(10000,99999);
         
         $data=$reqclient->fetch();
         $outnum= 0;
          $output="Vous avez été enregistré avec succes";
          $body = [
            'Messages' => [
                [
                    'From' => [
                        'Email' => "qalapp22@gmail.com",
                        'Name' => "QAL APP"
                    ],
                    'To' => [
                        [
                            'Email' => "$email",
                           // 'Name'  => "Levy Bénie"
                        ]
                    ],
                    'Subject' => "Qal App",
                    'TextPart' => "Qal application",
                    'HTMLPart' => "Code de confirmation Qal<h2> $code </h2> <br />May the delivery force be with you!"
                ]
            ]
        ];  
        $response = $mj->post(Resources::$Email, ['body' => $body]);
        $response->success() && ($response->getData());
        }
else
   {   
    $outnum= 1;
    $output="Erreur de votre inscription";
    $data=[];
}
        }
        else
        {   
            $outnum= 1;
            $output="Cet email existe déjà";
            $data=[];
        }
    }
} catch (\Throwable $th) {
    $outnum= 1;
    $output="Error PHP :".$th ->getMessage();
    $data=[];
}
$rapport=array($outnum,$output,$code,$data);
echo json_encode($rapport);


