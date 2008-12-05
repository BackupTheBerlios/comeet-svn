<?php

$coltp3Esp = '"'.$tip3Nombre[3][2].'"';	
if(!$orno) $orno=1;
$orderE = "	ORDER BY $orno $ascdesc ";

$desde = $fecha_ini . " ". "00:00:00";
$hasta = $fecha_fin . " ". "23:59:59";

$sWhereFec =  " and ".$db->conn->SQLDate('Y/m/d H:i:s', 'R.RADI_FECH_RADI')." >= '$desde'
				and ".$db->conn->SQLDate('Y/m/d H:i:s', 'R.RADI_FECH_RADI')." <= '$hasta'";

if ( $dependencia_busq != 99999)  $condicionE = " AND d.depe_codi=$dependencia_busq ";

if($tipoDocumento=='9999')
{	$queryE = "
		SELECT count(r.radi_nume_radi) Asignados
		FROM dependencia d, hist_eventos h, radicado r
		WHERE hist_obse = 'Rad.' 
			AND r.radi_nume_radi LIKE '%2'
			AND r.radi_nume_radi = h.radi_nume_radi 
			AND $tmp_substr(rtrim(h.usua_codi_dest),1,3) = d.depe_codi 
			$condicionE $sWhereFec 
		GROUP BY d.depe_codi";
}
else
{	if($tipoDocumento!='9998')	$condicionE .= " AND t.SGD_TPR_CODIGO = $tipoDocumento ";
	$queryE = "
		SELECT MIN(t.sgd_tpr_descrip) TIPO, 
			count(r.radi_nume_radi) Asignados, 
			SGD_TPR_CODIGO HID_TPR_CODIGO
		FROM dependencia d, hist_eventos h, radicado r, sgd_tpr_tpdcumento t
		WHERE h.hist_obse = 'Rad.' 
			AND r.radi_nume_radi LIKE '%2'
			AND r.radi_nume_radi = h.radi_nume_radi 
			AND $tmp_substr(rtrim(h.usua_codi_dest),1,3) = d.depe_codi
			AND r.tdoc_codi = t.sgd_tpr_codigo 
			$sWhereFec $condicionE
		GROUP BY t.sgd_tpr_codigo";
}
//-------------------------------
// Assemble full SQL statement
//-------------------------------

/** CONSULTA PARA VER DETALLES 
*/
$condicionE = "";
//if($tipoDocumento!='9999')	$condicionE = " AND t.SGD_TPR_CODIGO = $tipoDOCumento "; 
if(!is_null($tipoDOCumento))	$condicionE = " AND t.SGD_TPR_CODIGO = $tipoDOCumento "; 
if ($dependencia_busq != 99999)  $condicionE .= " AND $tmp_substr(rtrim(h.usua_codi_dest),1,3)=$dependencia_busq ";
		
$queryEDetalle = "
	SELECT r.radi_nume_radi AS RADICADO, 
		r.radi_fech_radi AS FECH_RAD, 
		t.sgd_tpr_descrip AS TIPO,
		r.RADI_PATH AS HID_RADI_PATH
		{$seguridad}
	FROM hist_eventos h, radicado r, sgd_tpr_tpdcumento t, USUARIO B
	WHERE h.hist_obse = 'Rad.' 
		AND r.radi_nume_radi LIKE '%2'
		AND r.radi_nume_radi = h.radi_nume_radi 
		AND r.tdoc_codi = t.sgd_tpr_codigo
		AND r.radi_usua_actu=b.usua_codi 
		AND r.radi_depe_actu=b.depe_codi 
		$sWhereFec";
$queryE .= $orderE;
$queryEDetalle .= $condicionE . $orderE;

	
if(isset($_GET['genDetalle'])&& $_GET['denDetalle']=1)
{
	$titulos=array("#","1#RADICADO","2#FECHA RADICACION","3#TIPO");
}
else
{
	$titulos=($tipoDocumento=='9999')?array("#","1#ASIGNADOS"):array("#","1#TIPO","2#ASIGNADOS");
}
		
function pintarEstadistica($fila,$indice,$numColumna){
        	global $ruta_raiz,$_POST,$_GET,$krd;
        	$numColumna=isset($fila['TIPO'])?$numColumna:2;
        	$salida="";
        	switch ($numColumna){
        		case  0:
        			$salida=$indice;
        			break;
        		case 1:	
        			$salida=$fila['TIPO'];
        		break;
        		case 2:
        			$datosEnvioDetalle="tipoEstadistica=".$_POST['tipoEstadistica']."&amp;genDetalle=1&amp;usua_doc=".urlencode($fila['HID_USUA_DOC'])."&amp;dependencia_busq=".$_POST['dependencia_busq']."&amp;fecha_ini=".$_POST['fecha_ini']."&amp;fecha_fin=".$_POST['fecha_fin']."&amp;tipoRadicado=".$_POST['tipoRadicado']."&amp;tipoDocumento=".$_POST['tipoDocumento']."&amp;codUs=".$fila['HID_COD_USUARIO']."&amp;&tipoDOCumento=".$fila['HID_TPR_CODIGO'];
	        		$datosEnvioDetalle=(isset($_POST['usActivos']))?$datosEnvioDetalle."&amp;usActivos=".$_POST['usActivos']:$datosEnvioDetalle;
	        		$salida="<a href=\"genEstadistica.php?{$datosEnvioDetalle}&amp;krd={$krd}\"  target=\"detallesSec\" >".$fila['ASIGNADOS']."</a>";       	break;
        	break;
        	}
        	return $salida;
        }

function pintarEstadisticaDetalle($fila,$indice,$numColumna)
{
	global $ruta_raiz,$encabezado,$krd;
	$verImg=($fila['SGD_SPUB_CODIGO']==1)?($fila['USUARIO']!=$_SESSION['usua_nomb']?false:true):($fila['USUA_NIVEL']>$_SESSION['nivelus']?false:true);
	$numRadicado=$fila['RADICADO'];	
	switch ($numColumna)
	{	case 0:
			$salida=$indice;
			break;
		case 1:
			if($fila['HID_RADI_PATH'] && $verImg)
				$salida="<center><a href=\"{$ruta_raiz}bodega".$fila['HID_RADI_PATH']."\">".$fila['RADICADO']."</a></center>";
			else 
				$salida="<center class=\"leidos\">{$numRadicado}</center>";	
			break;
		case 2:
			if($verImg)
				$salida="<a class=\"vinculos\" href=\"{$ruta_raiz}verradicado.php?verrad=".$fila['RADICADO']."&amp;".session_name()."=".session_id()."&amp;krd=".$_GET['krd']."&amp;carpeta=8&amp;nomcarpeta=Busquedas&amp;tipo_carp=0 \" >".$fila['FECH_RAD']."</a>";
			else 
				$salida="<a class=\"vinculos\" href=\"#\" onclick=\"alert(\"ud no tiene permisos para ver el radicado\");\">".$fila['FECH_RAD']."</a>";
			break;
		case 3:
			$salida="<center class=\"leidos\">".$fila['TIPO']."</center>";
			break;
	}
	return $salida;
}

/*
switch($db->driver)
{	case 'mssql':
		{	
		}break;
	case 'oracle':
	case 'oci8':
	case 'oci805':
	case 'ocipo':
		{	$sWhereFec =  " and R.RADI_FECH_RADI >= to_date('" . $desde . "','yyyy/mm/dd HH24:MI:ss')
    			    		and R.RADI_FECH_RADI <= to_date('" . $hasta . "','yyyy/mm/dd HH24:MI:ss')";
			if ( $dependencia_busq != 99999)  $condicionE = "	AND d.depe_codi=$dependencia_busq ";
			if($tipoDocumento=='9999')
			{	$queryE = "
					SELECT count(r.radi_nume_radi) 	Asignados
					FROM dependencia d, hist_eventos h, radicado r
					WHERE hist_obse = 'Rad.' 
						AND r.radi_nume_radi LIKE '%2'
						AND r.radi_nume_radi = h.radi_nume_radi 
						AND substr(h.usua_codi_dest,1,3) = d.depe_codi 
						$condicionE $sWhereFec 
					GROUP BY d.depe_codi";
	
			}
			else
			{	if($tipoDocumento!='9998')	$condicionE .= " AND t.SGD_TPR_CODIGO = $tipoDocumento ";
				$queryE = "
					SELECT MIN(t.sgd_tpr_descrip)	TIPO, 
						count(r.radi_nume_radi)	Asignados, 
						SGD_TPR_CODIGO			HID_TPR_CODIGO
					FROM dependencia d, hist_eventos h, radicado r, sgd_tpr_tpdcumento t
					WHERE h.hist_obse = 'Rad.' 
						AND r.radi_nume_radi LIKE '%2'
						AND r.radi_nume_radi = h.radi_nume_radi 
						AND substr(h.usua_codi_dest,1,3) = d.depe_codi
						AND r.tdoc_codi = t.sgd_tpr_codigo 
						$sWhereFec $condicionE
					GROUP BY t.sgd_tpr_codigo";
			}
			//-------------------------------
			// Assemble full SQL statement
			//-------------------------------
		
			// CONSULTA PARA VER DETALLES 
			$condicionE = "";
			if($tipoDocumento!='9999')	$condicionE = " AND t.SGD_TPR_CODIGO = $tipoDOCumento "; 
			if ($dependencia_busq != 99999)  $condicionE .= " AND substr(h.usua_codi_dest,1,3)=$dependencia_busq ";
		
			$queryEDetalle = "
				SELECT r.radi_nume_radi 	RADICADO, 
					r.radi_fech_radi		FECH_RAD, 
					t.sgd_tpr_descrip 		TIPO,
					r.RADI_PATH 			HID_RADI_PATH
				FROM hist_eventos h, radicado r, sgd_tpr_tpdcumento t
				WHERE h.hist_obse = 'Rad.' 
					AND r.radi_nume_radi LIKE '%2'
					AND r.radi_nume_radi = h.radi_nume_radi 
					AND r.tdoc_codi = t.sgd_tpr_codigo
					$sWhereFec";
			$queryE .= $orderE;
			$queryEDetalle .= $condicionE . $orderE;
		}break;
}
*/
?>