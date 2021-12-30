<?php
//error_reporting(E_ERROR);
//ini_set('display_errors', 'On');
//if ($_REQUEST['trace']) {
//    error_reporting(E_ALL);
//    ini_set('display_errors', 'On');
//}
const DOMAIN = "plataforma-local.enlazateonline.com";
const WS = "https://ws-local.enlazateonline.com/";
const ONBOARDING_URL = "onboarding-local.medianetpay.ec";
const DEBIT_WS = "";
const TOKEN_WS = "";
const APP_NAME = "Plataforma local";
const STORAGE = "/home/agperezb/Repositorios/plataforma_atc/gateway/files/";
const PRIVATE_STORAGE = "/home/agperezb/Repositorios/plataforma_atc/private/";
const SERVER_IP = "";
const ADMIN_EMAIL = "admin@" . DOMAIN;
const DIRECTOR_EMAIL = "director@" . DOMAIN;
const RECAPTCHA_PUBLIC = "6LfPmm4aAAAAAMS4VmI7dbkUKcCrDetc2kn8iIHr";
const RECAPTCHA_PRIVATE = "6LfPmm4aAAAAANxO8k23yqZpPhQJVf2bqnU4hcii";
const SMTPSECURE = "tls";
$servername = "localhost";
$username = "root";
$password = "";
$dbName = "atc_plataforma";

// Create connection
$conn = mysql_connect($servername, $username, $password);

// Check connection
if (!$conn) {
    echo "Error Conectando a MYSQL ";
} else {
// echo "Connected successfully";

}
mysql_set_charset('utf8', $conn);


// Hacer que foo sea la base de datos actual
$bd_seleccionada = mysql_select_db($dbName, $conn);
if (!$bd_seleccionada) {
    die ("No pude seleccionar la base de datos $dbName" . mysql_error());
}

// Compatibilidad para no reportar errores
mysql_query("SET SESSION sql_mode = ''");

$Q = 'SELECT * FROM wsistema WHERE id=\'1\'';
$R = mysql_query($Q);

while ($F = mysql_fetch_array($R)) {
    $sys['tema'] = $F['tema'];

    $sys['urllogo'] = $F['urllogo'];
    $sys['urllogologin'] = $F['urllogologin'];
    $sys['razonsocial'] = $F['razonsocial'];
    $sys['razonsocialurl'] = $F['razonsocialurl'];
    $sys['reversiones'] = $F['reversiones'];
    $sys['correobanner'] = $F['correobanner'];
    $sys['mailslogan'] = $F['mailslogan'];
    $sys['mailhost'] = $F['mailhost'];
    $sys['mailport'] = $F['mailport'];
    $sys['mailcuenta'] = $F['mailcuenta'];
    $sys['mailclave'] = $F['mailclave'];
    $sys['mailadmin'] = $F['mailadmin'];
    $sys['numresult'] = $F['numresult'];
}

//$tema=$sys[tema];
//echo $tema;

// Filtramos todos los request
if (!function_exists('cleanInput')) {
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
}

if (!function_exists('sanitize')) {
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
}
$_POST = sanitize($_POST);
$_GET = sanitize($_GET);
$_REQUEST = sanitize($_REQUEST);