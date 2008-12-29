<?php

if (!$db) {
 session_start();
 $krdOld = $krd;
 $carpetaOld = $carpeta;
 $tipoCarpOld = $tipo_carp;

 if (!$tipoCarpOld) {
    $tipoCarpOld= $tipo_carpt;
 }

 if (!$krd) {
     $krd=$krdOsld;
 }

 $ruta_raiz = "..";
 include "$ruta_raiz/rec_session.php";
 if (isset($_GET['genDetalle'])) {
?>	

  <html>
  <title>ORFEO - IMAGEN ESTADISTICAS </title>
  <link rel="stylesheet" href="../estilos/orfeo.css" />
  <body>
  <center>

<?php
 }
 include "$ruta_raiz/envios/paEncabeza.php";
?>

<table>
   <tr><td></td></tr>
</table>

<?php

 include_once "$ruta_raiz/include/db/ConnectionHandler.php";
 require_once("$ruta_raiz/class_control/Mensaje.php");
 include("$ruta_raiz/class_control/usuario.php");
 $db = new ConnectionHandler($ruta_raiz);	 

 $db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
 $objUsuario = new Usuario($db);
 if (isset($dependencia_busq)) {
    $dependencia_busq = $HTTP_GET_VARS["dependencia_busq"];	
 }

 $whereDependencia = " AND depe_codi = $dependencia_busq ";
 $datosaenviar = "fechaf=$fechaf&genDetalle=$genDetalle&tipoEstadistica=$tipoEstadistica&codus=$codus&krd=$krd&dependencia_busq=$dependencia_busq&ruta_raiz=$ruta_raiz&fecha_ini=$fecha_ini&fecha_fin=$fecha_fin&tipoRadicado=$tipoRadicado&tipoDocumento=$tipoDocumento&codUs=$codUs&fecSel=$fecSel"; 
}

$seguridad =", r.sgd_spub_codigo, b.codi_nivel AS USUA_NIVEL";
$whereTipoRadicado = "";

if ($tipoRadicado) {
    $whereTipoRadicado=" AND r.radi_nume_radi LIKE '%$tipoRadicado'";
}

if ($tipoRadicado and ($tipoEstadistica==1 or $tipoEstadistica==6)) {
    $whereTipoRadicado=" AND r.radi_nume_radi LIKE '%$tipoRadicado'";
}	
	
if ($codus) {
    $whereTipoRadicado.=" AND b.usua_codi = $codus ";
} elseif (!$codus and $usua_perm_estadistica < 1) {
    $whereTipoRadicado.=" AND b.usua_codi = $codusuario ";
}

if ($tipoDocumento and ($tipoDocumento!='9999' and $tipoDocumento!='9998' and $tipoDocumento!='9997')) {
    $whereTipoRadicado.=" AND t.sgd_tpr_codigo = $tipoDocumento ";
} elseif ($tipoDocumento=="9997") {
    $whereTipoRadicado.=" AND t.sgd_tpr_codigo = 0 ";
}

include_once($ruta_raiz."/include/query/busqueda/busquedaPiloto1.php");

switch($tipoEstadistica) {
	case "1";
		include "$ruta_raiz/include/query/estadisticas/consulta001.php";
		$generar = "ok";
		break;
	case "2";
		include "$ruta_raiz/include/query/estadisticas/consulta002.php";
		$generar = "ok";
		break;
	case "3";
		include "$ruta_raiz/include/query/estadisticas/consulta003.php";
		$generar = "ok";
		break;
	case "4";
		include "$ruta_raiz/include/query/estadisticas/consulta004.php";
		$generar = "ok";
		break;
	case "5";
		include "$ruta_raiz/include/query/estadisticas/consulta005.php";
		$generar = "ok";
		break;		
	case "6";
		include "$ruta_raiz/include/query/estadisticas/consulta006.php";
		$generar = "ok";
		break;				
	case "7";
		include "$ruta_raiz/include/query/estadisticas/consulta007.php";
		$generar = "ok";
		break;				
	case "8";
		include "$ruta_raiz/include/query/estadisticas/consulta008.php";
		$generar = "ok";
		break;				
	case "9";
		include "$ruta_raiz/include/query/estadisticas/consulta009.php";
		$generar = "ok";
		break;				
	case "10";
		include "$ruta_raiz/include/query/estadisticas/consulta010.php";
		$generar = "ok";
		break;				
	case "11";
		include "$ruta_raiz/include/query/estadisticas/consulta011.php";
		$generar = "ok";
		break;				
	case "12";
		include "$ruta_raiz/include/query/estadisticas/consulta012.php";
		$generar = "ok";
		break;
	case "13";
		include "$ruta_raiz/include/query/estadisticas/consulta013.php";
		$generar = "ok";
		break;
	case "14";
		include "$ruta_raiz/include/query/estadisticas/consulta014.php";
		$generar = "ok";
		break;
}

/*********************************************************************************
Modificado Por: Supersolidaria
Fecha: 15 diciembre de 2006
Descripci�n: Se incluy� el reporte de radicados archivados reporte_archivo.php
**********************************************************************************/

if ($tipoReporte==1) {
    include "$ruta_raiz/include/query/archivo/queryReportePorRadicados.php";
    $generar = "ok";
}

//$db->conn->debug=true;
if($generar == "ok") {
        $queryE = "";

	if ($genDetalle==1) {
            $queryE = $queryEDetalle;
        } else {
	   if ($genTodosDetalle==1) {
               $queryE = $queryETodosDetalle;
           } else {
               $queryE = $queryETodosDetalle;
           }
        }

        $flag = "FLAG: $genDetalle - $genTodosDetalle<br>";
        echo "$flag";
        echo "QUERY: ".$queryEDetalle;

	$ADODB_COUNTRECS = true;
	$rsE = $db->conn->Execute($queryE);
	$ADODB_COUNTRECS = false;

	if ($rsE) {
		if ($rsE->RecordCount() > 0) {
			include ("tablaHtml.php");
		} else {
			echo "<p align=center class=titulosError2>No se han encontrado registros con el criterio de b&uacute;squeda</p>";
                }
        } else { 
		echo "<p align=center class=titulosError2>Error al ejecutar la sentencia.</p>";	
        }
}

?>
