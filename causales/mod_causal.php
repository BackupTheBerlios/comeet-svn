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
/*   Hollman Ladino       hladino@gmail.com                Desarrollador             */
/*                                                                                   */
/* Colocar desde esta lInea las Modificaciones Realizadas Luego de la Version 3.5    */
/*  Nombre Desarrollador   Correo     Fecha   Modificacion                           */
/*************************************************************************************/
	$verradicado = $verrad;
	$carpetaOld = $carpeta;
	$krdOld = $krd;
	$menu_ver_tmpOld = $menu_ver_tmp;
	$menu_ver_Old = $menu_ver;
	session_start();
	$ruta_raiz = "..";
	include "../rec_session.php";
	if (!$ent) $ent = substr($verradicado, -1 );
	if(!$carpeta) $carpeta = $carpetaOld;
	if(!$menu_ver_tmp) $menu_ver_tmp = $menu_ver_tmpOld;
	if(!$menu_ver) $menu_ver = $menu_ver_Old;
	if(!$krd) $krd=$krdOld;
	if(!$menu_ver) {
		$menu_ver=3;
	}
	if($menu_ver_tmp) {
		$menu_ver=$menu_ver_tmp;
	}
    define('ADODB_ASSOC_CASE', 1);
	include_once ("$ruta_raiz/include/db/ConnectionHandler.php");	
	if(!$verrad) $verrad = $verradicado;
	
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<?=$ruta_raiz?>/estilos/orfeo.css">
<script src="js/popcalendar.js"></script>
<script src="js/mensajeria.js"></script>
<script language="javascript">
	vecSubseccionE = new Array (
<?
	// For para el javascript
	// new subseccionE ( id, Nombre, SeccionQuePertenece)
	$rs = $db->query("SELECT * FROM SGD_DCAU_CAUSAL");
	$cont = 0;
	while(!$rs->EOF) {
		$coma = ($cont == 0) ? '': ',';
		echo $coma . 'new seccionE ("' .  $rs->fields["SGD_DCAU_CODIGO"] . '",' .
									'"'	. $rs->fields["SGD_DCAU_DESCRIP"] . '",' .
									'"' . $rs->fields["SGD_CAU_CODIGO"] . '")' . "\n";
		$cont++;
		$rs->MoveNext();
	}
?>);

	vecSeccionE = new Array ();
	vecCategoriaE = new Array ();
	
	//Inicializo las variables isNav, isIE dependiendo del navegador
	var isNav, isIE

	if (parseInt(navigator.appVersion) >= 4) {
		if (navigator.appName == "Netscape" ) {
			isNav = true;
		} else{
			isIE = true;
		}	
	}

	//Variable que va a tener el valor de la opcion seleccionada para hacer la busqueda.
	var idFinal=0 ;  

	//Estructuras para almacenar la informacion de las tablas de categorias, seccion y subseccion de la base de datos.
	function categoriaE (id, nombre) {
		this.id = id;
		this.nombre = nombre;
	}
	
	function seccionE (id, nombre, id_categoria) {
		this.id = id;
		this.nombre = nombre;
		this.id_categoria = id_categoria;
	}
	
	function subseccionE (id, nombre, id_seccion) {
		this.id = id;
		this.nombre = nombre;
		this.id_seccion = id_seccion;
	}
	
	// Funcion que segun la opcion de la categoria, arma el combo de la seccion con los datos que tienen como padre dicha categoria.
	function cambiar_seccion(elselect) {	
		var j =1;
		limpiar_todo();
		indice = elselect.selectedIndex;
		id = elselect.options[indice].value;
		nombre = elselect.options[indice].text;
		for (i=0;i<vecSubseccionE.length;i++) {
			if (vecSubseccionE[i].id_categoria==id) {
				document.form_causales.deta_causal.options[j] = new Option(vecSubseccionE[i].nombre,vecSubseccionE[i].id);
				j ++;
			}
		}
		if(j==1){
		   document.form_causales.causal_new.options[0] = new Option('No aplica.',0);
		   document.form_causales.deta_causal.options[0] = new Option('No aplica.',0);
		}
		idFinal = id;
		nombreFinal = nombre;
	}

	// Funcion que segun la opcion de la seccion, arma el combo de la subseccion con los datos que tienen como padre dicha seccion.
	function cambiar_subseccion(elselect) {
		limpiar_subseccion();
		indice = elselect.selectedIndex;
		id = elselect.options[indice].value;
		nombre = elselect.options[indice].text;
		var j =1;
		for (i=0; i<vecSubseccionE.length;i++) {
			if (vecSubseccionE[i].id_seccion==id) {
				document.form_causales.deta_causal.options[j] = new Option(vecSubseccionE[i].nombre,vecSubseccionE[i].id);
				j ++;
			}	
		}
		if(j==1){
			document.form_causales.deta_causal.options[0] = new Option('----',0);
		}
		idFinal = id;
		nombreFinal = nombre;
	}

	//Funciones que borran los datos de los combos y los deja con un solo valor 0.
	function limpiar_todo(){
		//document.form_causales.sector.options[0]= new Option('Escoja',0);
		document.form_causales.deta_causal.options[0]= new Option('----',0);
		//var tamsec = document.form_causales.sector.options.length;
		var tamsubsec = document.form_causales.deta_causal.options.length;
		for (j=1; j<tamsubsec ; j++) {
			document.form_causales.deta_causal.options[1] = null;
		}
	}

	function limpiar_subseccion(){
		document.form_causales.deta_causal.options[0]= new Option('---',0);
		var tamsubsec = document.form_causales.deta_causal.options.length;
		alert(document.form_causales.deta_causal.options[0]);
		for (j=1; j<tamsubsec ; j++) {
		  document.form_causales.deta_causal.options[1] = null;
		}
	}

	//Funcion que actualiza el idFinal
	function cambiar_idFinal(elselect){
		indice = elselect.selectedIndex;
		id = elselect.options[indice].value;
		nombre = elselect.options[indice].text;
		idFinal = id ;
		nombreFinal = nombre;
	}
	
	//Funcion que valida los campos y pasa a la pagina siguiente despues de hacer enter en el campo palabra
	function cambiar_pagina(){
		indice = document.form_causales.categoria.selectedIndex;     
		if (document.form_causales.categoria.options[indice].value == 0) {
			alert("Escoja una categoria");
			return (false);
		}  else if ( idFinal == 18 || idFinal == 16 ) {
			alert("Escoja una seccion");
			return (false);
		}  else if ( idFinal == 26 || idFinal == 27 || idFinal == 28 || idFinal == 29 ) {
			alert("Escoja una Subseccion");
			return (false);
		} else {
			document.form_causales.target = "";
			document.form_causales.action = "resultados_empleo.php";
			if (idFinal != "") {
				document.form_causales.id.value = idFinal;
				document.form_causales.nombre.value = nombreFinal;
			}	
			return (true); 
		}
	}

	//Funcion que valida los campos y pasa a la pagina siguiente despues de hacer click en el boton de buscar
	function cambiar_pagina_buscar(){
		//Obtengo la fecha que le interesa buscar al usuario
		//document.form_causales.historico.value = document.form_causales.fechas_historico.value;
		
		//Obtengo el indice de la fecha
		//indice_fecha = document.form_causales.fechas_historico.selectedIndex;
		
		//Obtengo el valor de la fecha completa
		//document.form_causales.fecha_completa.value = document.form_causales.fechas_historico.options[indice_fecha].text;
	
		indice = document.form_causales.categoria.selectedIndex;     
		if (document.form_causales.categoria.options[indice].value == 0) {
			alert("Escoja una categoria");
		} else if ( idFinal == 18 || idFinal == 16 ) {
			alert("Escoja una seccion");
		} else if ( idFinal == 26 || idFinal == 27 || idFinal == 28 || idFinal == 29 ) {
			alert("Escoja una Subseccion");
		} else {
			document.form_causales.target = "";
			document.form_causales.action = "resultados_empleo.php";
			if (idFinal != "") {
				document.form_causales.id.value = idFinal;
				document.form_causales.nombre.value = nombreFinal;
			}
			document.form_causales.submit();
		}
	}
	
	function verificacionCampos() {
		/*detalleCasual = document.form_causales.deta_causal.value;
		mensaje = '';
		
		if (detalleCasual==0) {
			if (detalleCasual == 0) {
				mensaje += 'Falta por asignar Detalle de Causal\n';
			}
		}
		
		if (mensaje!=''){
			alert(mensaje);
			return false;
		} else {*/
		document.form_causales.submit();
		//}
	}
	
	function cerrar() {
		opener.regresar();
		window.close();
	}
</script>
 <div id="spiffycalendar" class="text"></div>
</head>
<table border=0 width 100%  cellpadding="0" cellspacing="5" class="borde_tab" >
<form name=form_causales  method="post" action="<?=$ruta_raiz?>/causales/mod_causal.php?<?=session_name()?>=<?=trim(session_id())?>&krd=<?=$krd?>&verrad=<?=$verradicado?>&verradicado=<?=$verradicado?><?="&datoVer=$datoVer&mostrar_opc_envio=$mostrar_opc_envio&nomcarpeta=$nomcarpeta"?>">
  <tr>
  <td class="titulos2">Sector</td>
  <td>
  <?
  		include_once($ruta_raiz."/sector/mod_sector.php");
		echo $mostrarSector;
  ?>
  </td>
  </tr>
  <tr>
      <td class="titulos2"> CAUSAL
<?   
	if (!$ruta_raiz) $ruta_raiz="..";
	include_once($ruta_raiz."/include/tx/Historico.php");
	$objHistorico= new Historico($db);
	if  (count($recordSet)>0)
	array_splice($recordSet, 0);  		
	if  (count($recordWhere)>0)
	array_splice($recordWhere, 0);  
	$fecha_hoy = Date("Y-m-d");
	$sqlFechaHoy=$db->conn->DBDate($fecha_hoy);     
	$arrayRad = array();
	$arrayRad[]=$verradicado;
	$actualizo = 0;
	$actualizoFlag = false;
	$insertoFlag = false;
	
	if (($grabar_causal) && (($causal_new != $causal_grb) || ($deta_causal != $deta_causal_grb))) {
		/** Intenta actualizar causal
		 *  Si esta no esta entonces simplemente le inserte
		 */
		if($causal==0) {
			$ddca_causal="0"; 
			$data_causa ="0";
		}
		if(!$ddca_causal) {
			$ddca_causal="";
		}
		if(!$deta_causal) {
		   $data_causa ="";
		}
		$recordSet["SGD_DDCA_CODIGO"] = "'".$ddca_causal."'";
		$recordSet["SGD_DCAU_CODIGO"] = "'".$deta_causal."'";
		$recordWhere["RADI_NUME_RADI"] = $verradicado;
		$sqlSelect = "SELECT SGD_CAUX_CODIGO,COUNT(RADI_NUME_RADI) COUNT_RADI
						FROM SGD_CAUX_CAUSALES 
						WHERE RADI_NUME_RADI = '$verradicado'
						GROUP BY SGD_CAUX_CODIGO";
		
		$db->update("SGD_CAUX_CAUSALES", $recordSet,$recordWhere);
		//select para saber habia registro por actualizar
		$rs = $db->conn->Execute($sqlSelect);
		
		if (!$recordSet->EOF) $actualizo = $rs->fields["COUNT_RADI"];
		
		array_splice($recordSet, 0);
		array_splice($recordWhere, 0);
		$causal_nombre_grb = ($causal_nombre != '') ? $causal_nombre: 'Sin Tipificar' ;
		$dcausal_nombre_grb = ($dcausal_nombre != '') ? $dcausal_nombre : 'Sin Tipificar' ;
		
		if ($actualizo != null) {
			echo "Causal Actualizada";
			$observa = "*Cambio Causal/detalle* ($causal_nombre_grb / $dcausal_nombre_grb)";
			$codusdp = str_pad($dependencia, 3, "0", STR_PAD_LEFT).str_pad($codusuario, 3, "0", STR_PAD_LEFT);
			$objHistorico->insertarHistorico($arrayRad,$dependencia ,$codusuario, $dependencia,$codusuario, $observa, 17);
			$actualizoFlag = true;
		}
		// Si no habia nada por actualizar inserta el registro
		if ($actualizo == null) {
			// Si la causal no se encuentra la inserta en este procedimineto 
			$isql = "SELECT a.SGD_CAUX_CODIGO FROM SGD_CAUX_CAUSALES a
							WHERE rownum < 10 
							 ORDER BY a.SGD_CAUX_CODIGO desc";	
			$flag = 0;
			$rs = $db->query($isql);
			$cod_caux = $rs->fields["SGD_CAUX_CODIGO"];
			$cod_caux++;
			$recordSet["SGD_CAUX_CODIGO"] = "'".$cod_caux."'";						
			$recordSet["SGD_DCAU_CODIGO"] = "'".$deta_causal."'";										
			$recordSet["RADI_NUME_RADI"] = $verradicado;										
			$recordSet["SGD_DDCA_CODIGO"] = "'".$ddca_causal."'";	
			$rs = $db->insert("SGD_CAUX_CAUSALES", $recordSet);							
			array_splice($recordSet, 0);  	
			if ($rs) {
				echo "<span class=info>Causal Agregada</span>";
				$observa = "*Cambio Causal/detalle* ($causal_nombre_grb / $dcausal_nombre_grb) ";
				$codusdp = str_pad($dependencia, 3, "0", STR_PAD_LEFT).str_pad($codusuario, 3, "0", STR_PAD_LEFT);
				$objHistorico->insertarHistorico($arrayRad,$dependencia ,$codusuario, $dependencia,$codusuario, $observa, 17);
				$insertoFlag = true;
			} // Fin de insercion de causales
	  	} // Fin de actualizacion o insercion de casales
	  	
	  	// Verifica banderas de actualizacion o de insercion para actulizar los nuevos datos
	 	if ($actualizoFlag || $insertoFlag) {
			$sqlSelect = "SELECT caux.SGD_CAUX_CODIGO, 
							dcau.SGD_DCAU_CODIGO,
							dcau.SGD_CAU_CODIGO,
							dcau.SGD_DCAU_DESCRIP,
							cau.SGD_CAU_DESCRIP
						FROM SGD_CAUX_CAUSALES caux,
								SGD_DCAU_CAUSAL dcau,
								SGD_CAU_CAUSAL cau
						WHERE caux.RADI_NUME_RADI = '$verradicado' AND
					          dcau.SGD_DCAU_CODIGO = caux.SGD_DCAU_CODIGO AND
					          cau.SGD_CAU_CODIGO = dcau.SGD_CAU_CODIGO";
			
			$rs = $db->query($sqlSelect);
			
			if (!$rs->EOF){
				$causal_grb = $rs->fields["SGD_CAU_CODIGO"];
				$causal_nombre = $rs->fields["SGD_CAU_DESCRIP"];
				$deta_causal_grb = $rs->fields["SGD_DCAU_CODIGO"];
				$dcausal_nombre = $rs->fields["SGD_DCAU_DESCRIP"];
			}	
		}
   }
   ?>
      </td>
    <TD width="70%">
	<?
	error_reporting(7);
	// capturando causal cuando envie el radicado 
	$isql = "SELECT caux.SGD_DCAU_CODIGO, 
					dcau.SGD_CAU_CODIGO 
				FROM SGD_CAUX_CAUSALES caux, 
					SGD_DCAU_CAUSAL dcau  
				WHERE caux.RADI_NUME_RADI = '$verradicado' AND
						caux.SGD_DCAU_CODIGO = dcau.SGD_DCAU_CODIGO";
	$rsDetalleCau = $db->query($isql);
	
	if(!$rsDetalleCau->EOF) {
		if (empty($causal_new)) {
			$deta_causal = $rsDetalleCau->fields["SGD_DCAU_CODIGO"];
			$causal_new = $rsDetalleCau->fields["SGD_CAU_CODIGO"];
		}
	}
	
	$isql = "SELECT * FROM SGD_CAU_CAUSAL ORDER BY SGD_CAU_CODIGO";
	$rs = $db->query($isql);
	
	if($rs && !$rs->EOF) {
		if($causal_new == 0) {
			$causal = 0;
		} elseif ($causal_new) {
			$causal = $causal_new;
		}
	?>
	<select name=causal_new onChange="javascript:cambiar_seccion(this);"  class="select">
	<?
		do {
			$codigo_cau = $rs->fields["SGD_CAU_CODIGO"];
			$nombre_cau = $rs->fields["SGD_CAU_DESCRIP"];
		  	if($codigo_cau==$causal) {
				$datoss = "selected";
			} else {
				$datoss = " ";
			}
			echo "<option value=$codigo_cau $datoss>$nombre_cau</option>\n";
			$rs->MoveNext();
		} while(!$rs->EOF);
	?>
	</select >
	<? } ?>
      </TD>
<TR>
  <td class="titulos2" > DETALLE CAUSAL</td>
      <TD width="323">
        <?
		$isql = "SELECT * 
					FROM SGD_DCAU_CAUSAL 
					WHERE SGD_CAU_CODIGO = $causal";
		$rs = $db->query($isql);
		if($rs && !$rs->EOF) {
	?>
        <select name=deta_causal  class="select">
          <option value='0' > --- </option>
          <? 
			do {
				$codigo_dcau = $rs->fields["SGD_DCAU_CODIGO"];
				$nombre_dcau = $rs->fields["SGD_DCAU_DESCRIP"];
		  	  	if($codigo_dcau == $deta_causal) {
					$datoss = "selected";
				} else {
					$datoss = " ";
				}
				echo "<option value='$codigo_dcau' $datoss>$nombre_dcau</option>\n";
				$rs->MoveNext();
			} while(!$rs->EOF);
	?>
        </select>
        <?
		}
	?>
      </td>
</tr>
<tr>
<td class="titulos2" > DETALLE DESAGREGADO </td>
    <TD width="323" class='celdaGris' class='etextomenu'>
	<?
	if ($deta_causal and $sector) {
		$isql = "SELECT * 
					FROM SGD_DDCA_DDSGRGDO 
					WHERE SGD_DCAU_CODIGO = $deta_causal AND 
							PAR_SERV_SECUE = $sector";
		$rs = $db->query($isql);
		if ($rs && !$rs->EOF) {
	?>
	<select name=ddca_causal  onChange="submit();"  class="select" >
	<?
			do {
				$codigo_ddcau =  $rs->fields["SGD_DDCA_CODIGO"];
				$nombre_ddcau =  $rs->fields["SGD_DDCA_DESCRIP"];
				if($ddca_causal==$codigo_ddcau) {
					$datoss = " selected ";
				} else {
					$datoss = " ";
				}
				echo "<option value='$codigo_ddcau' '$datoss'>$nombre_ddcau</option>\n";
				$rs->MoveNext();
			} while(!$rs->EOF);
	?>
	</select >
    <?
		}
	} else {
		echo "<span class='alarmas' >No ha sido un detalle de Causal</span>";
	}
	 ?>
	</td>

</TR>

<tr>
<td colspan="2" align="center">
<table>
	<td align="right">
		<input type="button" name=grabar_causal value='Grabar Cambio'  class='botones' onclick="verificacionCampos();">
	</td>
	<td align="left">
		<input type="button" name=grabar_causal value='Cerrar'  class='botones' onclick="cerrar();">
	</td>
</td>
</table>
</tr>
<input type=hidden name=ver_causal value="Si ver Causales">
<input type=hidden name="grabar_causal" value="1">
<input type=hidden name="$verrad" value="<?=$verradicado?>">
<input type=hidden name="sectorNombreAnt" value="<?=$sectorNombreAnt?>">
<input type=hidden name="sectorCodigoAnt" value="<?=$sectorCodigoAnt?>">
<input type=hidden name="causal_grb" value="<?=$causal_grb?>">
<input type=hidden name="causal_nombre" value="<?=$causal_nombre?>">
<input type=hidden name="deta_causal_grb" value="<?=$deta_causal_grb?>">
<input type=hidden name="dcausal_nombre" value="<?=$dcausal_nombre?>">
</form>
</table>
<?
	$ruta_raiz = ".";
?>
