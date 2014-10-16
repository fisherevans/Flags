<?php

  $pdo;

  function sqlConnect() {
    global $pdo;
    global $mysqlUsername;
    global $mysqlPassword;
    global $mysqlHostname;
    global $mysqlDatabase;
    global $mysqlCharset;
    $pdo = new PDO("mysql:host=".$mysqlHostname.";dbname=".$mysqlDatabase.";charset=".$mysqlCharset, $mysqlUsername, $mysqlPassword);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
  }
    
  function invokeStmt($stmt, $params) {
    $ref    = new ReflectionClass('mysqli_stmt'); 
    $method = $ref->getMethod("bind_param"); 
    $method->invokeArgs($stmt,$params); 
  }
  
  function executeStmt($stmt) {
    if(!$stmt -> execute()) {
        response(501, "MySQL Error: " . $stmt->error);
    }
  }
  
  function sqlRun() {
    global $pdo;
    $params = func_get_args();
    $sql = array_shift($params);
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
  }
  
  function sqlInsert() {
    global $pdo;
    $params = func_get_args();
    $sql = array_shift($params);
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $pdo->lastInsertId();
  }
  
  function sqlCount() {
    global $pdo;
    $params = func_get_args();
    $sql = array_shift($params);
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->rowCount();
  }
  
  function sqlQuery() {
    global $pdo;
    $params = func_get_args();
    $sql = array_shift($params);
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
  }
  
  function sqlUnique() {
    global $pdo;
    $params = func_get_args();
    $sql = array_shift($params);
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetch(PDO::FETCH_ASSOC);
  }
?>