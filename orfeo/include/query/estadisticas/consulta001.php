<?
/*************************************************************************************/
/* ORFEO GPL:Sistema de Gestion Documental		http://www.orfeogpl.org	     */
/*	Idea Original de la SUPERINTENDENCIA DE SERVICIOS PUBLICOS DOMICILIARIOS     */
/*				COLOMBIA TEL. (57) (1) 6913005  orfeogpl@gmail.com   */
/* ===========================                                                       */
/*                                                                                   */
/* Este programa es software libre. usted puede redistribuirlo y/o modificarlo       */
/* bajo los terminos de la licencia GNU General Public publicada por                 */
/* la "Free Software Foundation"; Licencia version 2. 			             */
/*                                                                                   */
/* Copyright (c) 2005 por :	  	  	                                     */
/* SSPS "Superintendencia de Servicios Publicos Domiciliarios"                       */
/*   Jairo Hernan Losada  jlosada@gmail.com                Desarrollador             */
/*   Sixto Angel Pinzón López --- angel.pinzon@gmail.com   Desarrollador             */
/* C.R.A.  "COMISION DE REGULACION DE AGUAS Y SANEAMIENTO AMBIENTAL"                 */ 
/*   Liliana Gomez        lgomezv@gmail.com                Desarrolladora            */
/*   Lucia Ojeda          lojedaster@gmail.com             Desarrolladora            */
/* D.N.P. "Departamento Nacional de Planeación"                                      */
/*   Hollman Ladino       hollmanlp@gmail.com              Desarrollador             */
/*                                                                                   */
/* Colocar desde esta lInea las Modificaciones Realizadas Luego de la Version 3.5    */
/*  Nombre Desarrollador   Correo     Fecha   Modificacion                           */
/*  Martha Yaneth Mera    mymera@gmail.com     2006-05-10*/
/*************************************************************************************/
?>
<?
/** CONSUTLA 001 
	* Estadiscas por medio de recepcion Entrada
	* @autor JAIRO H LOSADA - SSPD
	* @version ORFEO 3.1
	* 
	*/
$coltp3Esp = '"'.$tip3Nombre[3][2].'"';
if(!$orno) $orno=2;
 /**
   * $db-driver Variable que trae el driver seleccionado en la conexion
   * @var string
   * @access public
   */
 /**
   * $fecha_ini Variable que trae la fecha de Inicio Seleccionada  viene en formato Y-m-d
   * @var string
   * @access public
   */
/**
   * $fecha_fin Variable que trae la fecha de Fin Seleccionada
   * @var string
   * @access public
   */
/**
   * $mrecCodi Variable que trae el medio de recepcion por el cual va a sacar el detalle de la Consulta.
   * @var string
   * @access public
   */
switch($db->driver)
	{
	case 'mssql':
	case 'postgresql':	
	{	if($tipoDocumento=='9999')
			{	$queryE = "SELECT b.USUA_NOMB USUARIO, count(*) RADICADOS, MIN(USUA_CODI) HID_COD_USUARIO, MIN(depe_codi) HID_DEPE_USUA 
						FROM RADICADO r 
							INNER JOIN USUARIO b ON r.radi_usua_radi=b.usua_CODI AND $tmp_substr($radi_nume_radi,5,3)=b.depe_codi 
						WHERE ".$db->conn->SQLDate('Y/m/d', 'r.radi_fech_radi')." BETWEEN '$fecha_ini' AND '$fecha_fin' 
							$whereDependencia $whereActivos $whereTipoRadicado 
						GROUP BY b.USUA_NOMB ORDER BY $orno $ascdesc";
			}
			else
			{	$queryE = "SELECT b.USUA_NOMB USUARIO, t.SGD_TPR_DESCRIP TIPO_DOCUMENTO, count(*) RADICADOS,
							MIN(USUA_CODI) HID_COD_USUARIO, MIN(SGD_TPR_CODIGO) HID_TPR_CODIGO, MIN(depe_codi) HID_DEPE_USUA
						FROM RADICADO r 
							INNER JOIN USUARIO b ON r.RADI_USUA_RADI = b.USUA_CODI AND $tmp_substr($radi_nume_radi, 5, 3) = b.DEPE_CODI 
							LEFT OUTER JOIN SGD_TPR_TPDCUMENTO t ON r.TDOC_CODI = t.SGD_TPR_CODIGO
						WHERE ".$db->conn->SQLDate('Y/m/d', 'r.radi_fech_radi')." BETWEEN '$fecha_ini' AND '$fecha_fin' 
							$whereDependencia $whereActivos $whereTipoRadicado 
						GROUP BY b.USUA_NOMB,t.SGD_TPR_DESCRIP ORDER BY $orno $ascdesc";		
			}
 			/** CONSULTA PARA VER DETALLES 
	 		*/
			$condicionDep = " AND depe_codi = $depeUs ";
			$condicionE = " AND b.USUA_CODI=$codUs $condicionDep ";
			$queryEDetalle = "SELECT $radi_nume_radi RADICADO
					,r.RADI_FECH_RADI FECHA_RADICADO
					,t.SGD_TPR_DESCRIP TIPO_DE_DOCUMENTO
					,r.RA_ASUN ASUNTO 
					,r.RADI_DESC_ANEX 
					,r.RADI_NUME_HOJA 
					,m.MREC_DESC MEDIO_RECEPCION
					,b.usua_nomb Usuario
					,r.RADI_PATH HID_RADI_PATH {$seguridad}
					FROM RADICADO r
						INNER JOIN USUARIO b ON r.radi_usua_radi=b.usua_CODI AND $tmp_substr($radi_nume_radi,5,3)=b.depe_codi 
						LEFT OUTER JOIN SGD_TPR_TPDCUMENTO t ON r.tdoc_codi=t.SGD_TPR_CODIGO 
						LEFT OUTER JOIN MEDIO_RECEPCION m ON r.MREC_CODI = m.MREC_CODI
					WHERE ".$db->conn->SQLDate('Y/m/d', 'r.radi_fech_radi')." BETWEEN '$fecha_ini' AND '$fecha_fin' $whereTipoRadicado ";
					$orderE = "	ORDER BY $orno $ascdesc";
			 /** CONSULTA PARA VER TODOS LOS DETALLES 
			 */ 
		
			$queryETodosDetalle = $queryEDetalle . $condicionDep . $orderE;
			$queryEDetalle .= $condicionE . $orderE;
		}
	break;
	case 'oracle':
	case 'oci8':
	case 'oci805':
	case 'ocipo':
	if($tipoDocumento=='9999')
	{
	$queryE = "
	    SELECT b.USUA_NOMB USUARIO
			, count(*) RADICADOS
			, MIN(USUA_CODI) HID_COD_USUARIO
			, MIN(depe_codi) HID_DEPE_USUA
			FROM RADICADO r
			, USUARIO b 
		WHERE 
			r.radi_usua_radi=b.usua_CODI 
			AND substr(r.radi_nume_radi,5,3)=b.depe_codi
			$whereDependencia
			AND TO_CHAR(r.radi_fech_radi,'yyyy/mm/dd') BETWEEN '$fecha_ini'  AND '$fecha_fin' 
			$whereActivos
		$whereTipoRadicado 
		GROUP BY b.USUA_NOMB
		ORDER BY $orno $ascdesc";
	}
	else
	{
		$queryE = "
	    SELECT b.USUA_NOMB USUARIO
			, t.SGD_TPR_DESCRIP TIPO_DOCUMENTO
			, count(*) RADICADOS
			, MIN(USUA_CODI) HID_COD_USUARIO
			, MIN(SGD_TPR_CODIGO) HID_TPR_CODIGO
			, MIN(depe_codi) HID_DEPE_USUA
			FROM RADICADO r
			, USUARIO b 
			, SGD_TPR_TPDCUMENTO t
		WHERE 
			r.radi_usua_radi=b.usua_CODI 
			AND r.tdoc_codi=t.SGD_TPR_CODIGO (+)
			AND substr(r.radi_nume_radi,5,3)=b.depe_codi
			$whereDependencia 
			AND TO_CHAR(r.radi_fech_radi,'yyyy/mm/dd') BETWEEN '$fecha_ini'  AND '$fecha_fin' 
			$whereActivos
		$whereTipoRadicado 
		GROUP BY b.USUA_NOMB,t.SGD_TPR_DESCRIP
		ORDER BY $orno $ascdesc";
	}
 /** CONSULTA PARA VER DETALLES 
	 */
	$condicionDep = " AND depe_codi = $dependencia_busq";
	$condicionE = " AND b.USUA_CODI=$codUs $condicionDep ";
	$queryEDetalle = "SELECT r.RADI_NUME_RADI RADICADO
			,r.RADI_FECH_RADI FECHA_RADICADO
			,t.SGD_TPR_DESCRIP 	TIPO_DE_DOCUMENTO
			,r.RA_ASUN ASUNTO
			,r.RADI_DESC_ANEX ANEXOS
			,r.RADI_NUME_HOJA N_HOJAS
			,m.MREC_DESC	MEDIO_RECEPCION
			,b.usua_nomb USUARIO
			,r.RADI_PATH HID_RADI_PATH
			,bod.NOMBRE_DE_LA_EMPRESA ESP
			,n.par_serv_nombre SECTOR			
			,(select CAU.sgd_cau_DESCRIP
				from  sgd_dcau_causal dc, sgd_cau_causal cau
      				where dc.sgd_dcau_codigo=o.sgd_dcau_codigo
      	    			and dc.SGD_cau_codigo=cau.sgd_cau_codigo) CAUSAL			
			,(select dc.sgd_dcau_descrip
				from sgd_dcau_causal dc
     				 where dc.sgd_dcau_codigo=o.sgd_dcau_codigo) DETALLE_CAUSAL {$seguridad}			
			FROM RADICADO r, 
				USUARIO b, 
				SGD_TPR_TPDCUMENTO t,
				MEDIO_RECEPCION m,
				bodega_empresas bod,
				par_serv_servicios n,
				sgd_caux_causales o
		WHERE 
			r.eesp_codi = bod.identificador_empresa (+)
			and r.radi_usua_radi=b.usua_CODI 
			AND r.tdoc_codi=t.SGD_TPR_CODIGO (+)
			AND substr(r.radi_nume_radi,5,3)=b.depe_codi
			AND TO_CHAR(r.radi_fech_radi,'yyyy/mm/dd') BETWEEN '$fecha_ini'  AND '$fecha_fin'
			AND r.MREC_CODI = m.MREC_CODI (+)
			and r.par_serv_secue=n.par_serv_codigo(+)
			and r.radi_nume_radi=o.radi_nume_radi(+)

		$whereTipoRadicado ";
		$orderE = "	ORDER BY $orno $ascdesc";			

 /** CONSULTA PARA VER TODOS LOS DETALLES 
	 */ 

	$queryETodosDetalle = $queryEDetalle . $condicionDep . $orderE;
	$queryEDetalle .= $condicionE . $orderE;
	break;
	}
if(isset($_GET['genDetalle'])&& $_GET['denDetalle']=1)
		$titulos=array("#","1#RADICADO","2#FECHA RADICADO","3#TIPO DOCUMENTO","4#ASUNTO","5#ANEXOS","6#NO HOJAS","7#MEDIO  DE RECEPCION","8#USUARIO","9#ESP","10#SECTOR","11#CAUSAL","12#DETALLE CAUSAL");
	else 		
		$titulos=array("#","1#Usuario","2#Radicados");
		
function pintarEstadistica($fila,$indice,$numColumna){
        	global $ruta_raiz,$_POST,$_GET;
        	$salida="";
        	switch ($numColumna){
        		case  0:
        			$salida=$indice;
        			break;
        		case 1:	
        			$salida=$fila['USUARIO'];
        		break;
        		case 2:
        			$datosEnvioDetalle="tipoEstadistica=".$_POST['tipoEstadistica']."&amp;genDetalle=1&amp;usua_doc=".urlencode($fila['HID_USUA_DOC'])."&amp;dependencia_busq=".$_POST['dependencia_busq']."&amp;fecha_ini=".$_POST['fecha_ini']."&amp;fecha_fin=".$_POST['fecha_fin']."&amp;tipoRadicado=".$_POST['tipoRadicado']."&amp;tipoDocumento=".$_POST['tipoDocumento']."&amp;codUs=".$fila['HID_COD_USUARIO'];
	        		$datosEnvioDetalle=(isset($_POST['usActivos']))?$datosEnvioDetalle."&amp;usActivos=".$_POST['usActivos']:$datosEnvioDetalle;
	        		$salida="<a href=\"genEstadistica.php?{$datosEnvioDetalle}\"  target=\"detallesSec\" >".$fila['RADICADOS']."</a>";
        	break;
        	default: $salida=false;
        	}
        	return $salida;
        }
function pintarEstadisticaDetalle($fila,$indice,$numColumna){
			global $ruta_raiz,$encabezado,$krd;
			$verImg=($fila['SGD_SPUB_CODIGO']==1)?($fila['USUARIO']!=$_SESSION['usua_nomb']?false:true):($fila['USUA_NIVEL']>$_SESSION['nivelus']?false:true);
        	$numRadicado=$fila['RADICADO'];	
			switch ($numColumna){
					case 0:
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
		   					$salida="<a class=\"vinculos\" href=\"{$ruta_raiz}verradicado.php?verrad=".$fila['RADICADO']."&amp;".session_name()."=".session_id()."&amp;krd=".$_GET['krd']."&amp;carpeta=8&amp;nomcarpeta=Busquedas&amp;tipo_carp=0 \" >".$fila['FECHA_RADICADO']."</a>";
		   				else 
		   				$salida="<a class=\"vinculos\" href=\"#\" onclick=\"alert(\"ud no tiene permisos para ver el radicado\");\">".$fila['FECHA_RADICADO']."</a>";
						break;
					case 3:
						$salida="<center class=\"leidos\">".$fila['TIPO_DE_DOCUMENTO']."</center>";		
						break;
					case 4:
						$salida="<center class=\"leidos\">".$fila['ASUNTO']."</center>";
						break;
					case 5:
						$salida="<center class=\"leidos\">".$fila['ANEXOS']."</center>";
						break;
					case 6:
						$salida="<center class=\"leidos\">".$fila['N_HOJAS']."</center>";			
						break;	
					case 7:
						$salida="<center class=\"leidos\">".$fila['MEDIO_RECEPCION']."</center>";			
						break;	
					case 8:
						$salida="<center class=\"leidos\">".$fila['USUARIO']."</center>";			
						break;	
					case 9:
						$salida="<center class=\"leidos\">".$fila['ESP']."</center>";			
						break;	
					case 10:
						$salida="<center class=\"leidos\">".$fila['SECTOR']."</center>";			
						break;
					case 11:
						$salida="<center class=\"leidos\">".$fila['CAUSAL']."</center>";			
						break;
					case 12:
						$salida="<center class=\"leidos\">".$fila['DETALLE_CAUSAL']."</center>";			
						break;
			}
			return $salida;
		}
    	
	
?>
