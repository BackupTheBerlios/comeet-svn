<?php

$servicio = "pruebas";

$usuario = "orfeo";

$contrasena = "3ld0r4d0"; 

$servidor = "localhost:5432";

$db = "pruebas";

$driver = "postgres";

 //Variable que indica el ambiente de trabajo, sus valores pueden ser  desarrollo,prueba,orfeo
$ambiente = "orfeo";

//Servidor que procesa los documentos
$servProcDocs = "192.168.1.5";

$entidad= "OPAIN S.A.";

//$FILE_LOCAL = "localEcuador.php";

$entidad_largo= "OPAIN S.A."; //Variable usada generalmente para los títulos en informes.";

$entidad_tel = 000000; 

$entidad_dir = "Avenida El Dorado";

/****
        *       Se crea la variable $ADODB_PATH.
        *       El Objetivo es que al independizar ADODB de ORFEO, éste (ADODB) se pueda actualizar sin causar
        *       traumatismos en el resto del código de ORFEO. En adelante se utilizará esta variable para hacer
        *       referencia donde se encuentre ADODB
        */

$ADODB_PATH = "/home/orfeo/adodb";

$ADODB_CACHE_DIR = "/tmp";

?>

