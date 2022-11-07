<?php
header('Access-Control-Allow-Origin: *');

include 'connect.php';
$name = $_POST['name'];
$service = $_POST['service'];
$email = $_POST['email'];
$contact = $_POST['contact'];
$birthday = $_POST['birthday'];
$commune = $_POST['commune'];
$ethnie = $_POST['ethnie'];
$religion = $_POST['religion'];
$nationalite = $_POST['nationalite'];
$nivetude = $_POST['nivetude'];
$pass = $_POST['pass'];
$image = $_POST['image'];
$rapport = array();
$date = date("Y-m-d H:i:s");
try {
    if (isset($name, $service, $contact, $birthday, $commune, $ethnie, $religion, $nationalite, $nivetude, $pass, $image)) {
        $req = $db->prepare("SELECT * FROM prestataires WHERE email_prest=?");
        $req->execute(array($email . trim(" ")));
        $exis = $req->rowCount();
        if ($exis == 0) {
            $matcreate = $db->query("SELECT * FROM prestataires");
            $matv = $matcreate->rowCount();
            $mat = $matv + 1;
            $matricule = "QP00$mat";

            $req = $db->prepare("INSERT INTO prestataires VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            $req->execute(array($matricule, $date, $email, $pass, $name, $contact, $birthday, $commune, $nationalite, $ethnie, $religion, '5', $nivetude, $image, '', 'Gold', '0'));
            if ($req) {
                $prestations = $db->prepare("INSERT INTO prestations VALUES (NULL,?,?,?)");
                $prestations->execute(array($service, $matricule, 'false'));
                if ($prestations) {
                    $outnum = 0;
                    $output = "Vous avez été enregistré avec succes";
                }
            } else {
                $outnum = 1;
                $output = "Erreur de votre inscription";
            }
        } else {
            $outnum = 1;
            $output = "Cet email existe déjà";
        }
    }
} catch (\Throwable $th) {
    $outnum = 1;
    $output = "Error :" . $th->getMessage();
}
$rapport = array($outnum, $output);
echo json_encode($rapport);
