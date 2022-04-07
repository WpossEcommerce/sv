<?php
const DOMAIN = "plataforma-local.enlazateonline.com";
const PRIVATE_STORAGE = "/home/usuario-maquin/Projects/atc/plataforma_atc/private/";
const ATC_ENDPOINT = "http://127.0.0.1:8001/";
const DEBIT_WS = "";
const TOKEN_WS = "";
const NS = "https://ws-local.enlazateonline.com/";
const IPSTACK_KEY = "";
const SMTPSECURE = "tls";
define("ADMIN_EMAIL", "admin@" . DOMAIN);
define("DIRECTOR_EMAIL", "director@" . DOMAIN);
$Nombre_Servidor = "Servidor de Produccion";
$servidormysql = "localhost";
$usuariomysql = "root";
$clavemysql = "clave-mysql";
$dbmysql = "atc_plataforma";
$conexion = MYSQL_CONNECT($servidormysql, $usuariomysql, $clavemysql);
mysql_select_db($dbmysql, $conexion);
mysql_set_charset('utf8', $conexion);

// Compatibilidad para no reportar errores
mysql_query("SET SESSION sql_mode = ''");

// Filtramos todos los request
function cleanInput($input)
{
    $search = array(
        '@<script[^>]?>.?</script>@si',   // Strip out javascript
        '@<[\/\!]?[^<>]?>@si',            // Strip out HTML tags
        '@<style[^>]?>.?</style>@siU',    // Strip style tags properly
        '@mouse@',    // Strip style tags properly
        '@over@',    // Strip style tags properly
        '@parker@',    // Strip style tags properly
        '@select@',    // Strip style tags properly
        '@SELECT@',    // Strip style tags properly
        '@SELEC@',    // Strip style tags properly
        '@netsparker@',    // Strip style tags properly
        '@onmouseover@',    // Strip style tags properly
        '@from@',    // Strip style tags properly
        '@FROM@',    // Strip style tags properly
        '@=@',    // Strip style tags properly
        '@<![\s\S]?--[ \t\n\r]>@'         // Strip multi-line comments
    );

    $output2 = preg_replace($search, '', $input);
    $output = str_replace('"', '``', str_replace("'", "", $output2));
    $output = str_replace("\'", '', str_replace("\"", "", $output));
    $output = str_replace("`", '', str_replace("``", "", $output));
    $output = str_replace("\"", '', str_replace("``", "", $output));
    //$result = htmlentities($output);
    $result = preg_replace('/^(&quot;)(.*)(&quot;)$/', "", $output);
    $result = preg_replace('/^(&laquo;)(.*)(&raquo;)$/', "", $result);
    $result = preg_replace('/^(&#8220;)(.*)(&#8221;)$/', "", $result);
    $result = preg_replace('/^(&#39;)(.*)(&#39;)$/', "", $result);
    // solo permitimos letras, numeros y algunos simbolos.
    $result = preg_replace("/[^A-Za-z0-9._!?+ #-@$*.,]/", '', $result);
    //  $result = html_entity_decode($result);
    return $result;
}

function sanitize($input)
{
    if (is_array($input)) {
        foreach ($input as $var => $val) {
            $output[$var] = sanitize($val);
        }
    } else {
        if (get_magic_quotes_gpc()) {
            $input = stripslashes($input);
        }
        $input = cleanInput($input);
        $output = preg_replace("/\"/", "'", $input);
    }
    return $output;
}

$_POST = sanitize($_POST);
$_GET = sanitize($_GET);
$_REQUEST = sanitize($_REQUEST);

