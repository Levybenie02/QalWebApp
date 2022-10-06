<?php


  try {
    $host = "localhost";
    $dbname = "qalapp";
    $dbuser = "root";
    $pass = "";
    $db = new PDO("mysql:host=$host;dbname=$dbname", $dbuser, $pass);
    return $db;
  } catch (\Throwable $th) {
    echo 'ERROR :' . $th->getMessage();
  }

//Connexion Script
/* function LoginScript($email, $pass)
{
  try {
    if (isset($email, $pass)){
      $db = dBconnect();
      $reqclient = $db->query("SELECT * FROM CLIENT WHERE email=$email AND pass=$pass");
      $client = $reqclient->rowCount();

      return $client;
    } else {
      $output = "email::NULL || password::NULL";
      return $output;
    }
  } catch (\Throwable $th) {
    //throw $th;
    $output = "Error" . $th->getMessage();
  }
} */
