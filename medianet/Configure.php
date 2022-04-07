<?php
const DOMAIN = "plataforma-local.medianetpay.ec";
const PRIVATE_STORAGE = "/home/melvinp/Projects/medianet/plataforma_medianet/private/";
const MEDIANET_ENDPOINT = "http://192.168.137.1:7020";//http://localhost:8080/ganicu/txn - http://192.168.1.10:7020/ganicu/txn
const CYRBERSOURCE_ENDPOINT = "http://192.168.137.1:8011/"; //http://localhost:8011/
const DEBIT_WS = "";
const TOKEN_WS = "";
const NS = "https://ws-local.medianetpay.ec/";
define("ADMIN_EMAIL", "admin@".DOMAIN);
define("DIRECTOR_EMAIL", "director@".DOMAIN);
$Nombre_Servidor = "Servidor de Produccion";
$servidormysql = "127.0.0.1";
$usuariomysql = "user";
$clavemysql = "contraseña";
$dbmysql = "medianet_plataforma";
$conexion = MYSQL_CONNECT($servidormysql, $usuariomysql, $clavemysql);
mysql_select_db($dbmysql, $conexion);
mysql_set_charset('utf8', $conexion);

// Compatibilidad para no reportar errores
mysql_query("SET SESSION sql_mode = ''");
