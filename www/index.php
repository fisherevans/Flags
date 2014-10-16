<?php
  // Error Checking
  error_reporting(E_ALL);
  ini_set('display_errors', 1);
  /**/

  require_once('config.php');
  require_once('global_functions.php');

  require_once('mysql.php');

  sqlConnect();
  date_default_timezone_set('America/New_York');

  $post = $_SERVER['REQUEST_METHOD'] === 'POST';
  $urlArray = explode('?', $_SERVER['REQUEST_URI']);
  $urlArray[0] = preg_replace("/[^0-9a-zA-Z\-\/]/", "", preg_replace("/\/$/", "", preg_replace("/^\//", "", $urlArray[0])));
  $path = explode('/', $urlArray[0]);

  foreach($path as $t) {
    if($t == null) 
      echo ">>>";
    echo $t . " - ";
  }
?>