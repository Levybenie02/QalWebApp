<?php
include ('connect.php');

    try {

        
            $update=$db->query("UPDATE commande SET commande.statut='En cours' WHERE commande.statut='En attente' AND commande.duree!='' ");
            $out="true";
    
    } catch (\Throwable $th) {
        //throw $th;
        echo 'ERROR :'.$th->getMessage();
        $out="false";
    }

echo json_encode($out);
 
?>