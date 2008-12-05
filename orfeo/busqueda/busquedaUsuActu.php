<?
session_start();
$verrad = "";
$ruta_raiz = "..";
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler("$ruta_raiz");	 
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
if (!isset($_SESSION['dependencia']))   include "$ruta_raiz/rec_session.php";
if($orden_cambio==1)
{	if(!$orderTipo)
	{	$orderTipo="desc";	}
	else
	{	$orderTipo="";	}
}
$encabezado1 = "$PHP_SELF?".session_name()."=".session_id()."&krd=$krd";
$linkPagina = "$encabezado1&n_nume_radi=$n_nume_radi&s_RADI_NOM=$s_RADI_NOM&s_solo_nomb=$s_solo_nomb&tipoRadicado=$tipoRadicado&fecha_ini=$fecha_ini&fecha_fin=$fecha_fin&fecha1=$fecha1&tipoDocumento=$tipoDocumento&dependenciaSel=$dependenciaSel&orderTipo=$orderTipo&orderNo=$orderNo";
$encabezado = "".session_name()."=".session_id()."&krd=$krd&n_nume_radi=$n_nume_radi&s_RADI_NOM=$s_RADI_NOM&s_solo_nomb=$s_solo_nomb&tipoRadicado=$tipoRadicado&fecha_ini=$fecha_ini&fecha_fin=$fecha_fin&fecha1=$fecha1&tipoDocumento=$tipoDocumento&dependenciaSel=$dependenciaSel&orderTipo=$orderTipo&orderNo=";
$nombreSesion = "".session_name()."=".session_id();
$ss_TRAD_CODIDisplayValue = "Todos los Tipos (-1,-2,-3,-5, . . .)";
$ss_TDOC_CODIDisplayValue = "Todos los Tipos";
$ss_RADI_DEPE_ACTUDisplayValue = "Todas las Dependencias";
$HasParam = false;
$usuario = $krd;
?>

<html>
<head>
<title>Consultas</title>
<meta name="GENERATOR" content="YesSoftware CodeCharge v.2.0.5 build 11/30/2001">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"><link rel="stylesheet" href="Site.css" type="text/css">
<link rel="stylesheet" href="../estilos/orfeo.css">

<script>

  function limpiar()
	{
   	   document.Search.elements['n_nume_radi'].value = "";
	   document.Search.elements['s_RADI_NOMB'].value = "";
	   document.Search.elements['dependenciaSel'].value = "99999";
	   document.Search.elements['tipoDocumento'].value = "9999";
	   document.Search.elements['s_entrada'].checked=1;
       document.Search.elements['s_salida'].checked=1;	 
       document.Search.s_solo_nomb[0].checked = true; 	

   	
	}
</script>
</head>
<body class="PageBODY">
<div id="spiffycalendar" class="text"></div>
<link rel="stylesheet" type="text/css" href="../js/spiffyCal/spiffyCal_v2_1.css">
<script language="JavaScript" src="../js/spiffyCal/spiffyCal_v2_1.js"></script>

  <?
	 $ano_ini = date("Y");
	 $mes_ini = substr("00".(date("m")-1),-2);
	 if ($mes_ini==0) {$ano_ini==$ano_ini-1; $mes_ini="12";}
	 $dia_ini = date("d");
	 if(!$fecha_ini) $fecha_ini = "$ano_ini/$mes_ini/$dia_ini";
     $fecha_busq = date("Y/m/d") ;
	 if(!$fecha_fin) $fecha_fin = $fecha_busq;

  ?>
<script language="javascript"><!--
  var dateAvailable = new ctlSpiffyCalendarBox("dateAvailable", "Search", "fecha_ini","btnDate1","<?=$fecha_ini?>",scBTNMODE_CUSTOMBLUE);
  var dateAvailable1 = new ctlSpiffyCalendarBox("dateAvailable1", "Search", "fecha_fin","btnDate2","<?=$fecha_fin?>",scBTNMODE_CUSTOMBLUE);
//--></script>

 <table>
  <tbody><tr>
   <td valign="top">
	<!--<form method="get" action="busquedaHist.php" name="Search">//-->
	<form method="post" action="<?=$encabezadol?>" name="Search">
	<input type="hidden" name="FormName" value="Search"><input type="hidden" name="FormAction" value="search">
    <table border=0 cellpadding=0 cellspacing=2 class='borde_tab'>
     <tbody><tr>
      <td class="titulos4" colspan="13"><a name="Search">B&uacute;squeda por Usuario</a></td>
     </tr>

     <tr>
      <td class="titulos5">Radicado</td>
      <td class="listado5"><input class="tex_area" type="text" name="n_nume_radi" id="n_nume_radi" maxlength="" value="<?=$n_nume_radi?>" size="" ></td>
     </tr>
<tr>
  <td class="titulos5">
    
  <INPUT type="radio" NAME="s_solo_nomb" value="All" CHECKED
  <? if($s_solo_nomb=="All"){ echo ("CHECKED");} ?>>Todas las palabras (y)<br>
  <INPUT type="radio" NAME="s_solo_nomb" value="Any"
  <? if($s_solo_nomb=="Any"){echo ("CHECKED");} ?>>Cualquier Palabra (o)<br>
  </td>
  <td class="listado5"><input class="tex_area" type="text" name="s_RADI_NOMB" maxlength="70" value="<?=$s_RADI_NOMB?>" size="70" ></td>
</tr>
<tr>
  
  <td colspan="2" class="titulos5"></td>
</tr>
     <tr>
	 <td class="titulos5">Buscar en Radicados de</td>
             		<td class="listado5">
               		<? 
			   			$rs = $db->conn->Execute('select SGD_TRAD_DESCR, SGD_TRAD_CODIGO  from SGD_TRAD_TIPORAD order by 2');
						$nmenu = "tipoRadicado";
						$valor = "9999";
						$default_str=$tipoRadicado;
		        		print $rs->GetMenu2($nmenu, $default_str, $blank1stItem = "$valor:$ss_TRAD_CODIDisplayValue",false,0,'class=select');
			   		?>
             		</td>
					
		<tr>
        <td class="titulos5">Desde Fecha 
              (yyyy/mm/dd)</td>
		<td class="listado5">
		  <script language="javascript">
		        dateAvailable.writeControl();
				dateAvailable.dateFormat="yyyy/MM/dd";
    	  </script>
			</td>
          </tr>
          <tr> 
            <td class="titulos5">Hasta Fecha 
              (yyyy/mm/dd)</td>
            <td class="listado5">
			  <script language="javascript">
		        dateAvailable1.writeControl();
			    dateAvailable1.dateFormat="yyyy/MM/dd";
    	  </script>
			</td>
          </tr>
          <tr> 
      <td class="titulos5">Tipo de Documento</td>
      <td class="listado5">
	  <?
	  	$isqlt = "select SGD_TPR_DESCRIP,SGD_TPR_CODIGO from SGD_TPR_TPDCUMENTO order by 2";
	  	$rs= $db->conn->execute($isqlt);
	  	$nmenu = "tipoDocumento";
		$valor = "9999";
	  	$default_str=$tipoDocumento;
		print $rs->GetMenu2($nmenu, $default_str, $blank1stItem = "$valor:$ss_TDOC_CODIDisplayValue",false,0,'class=select');
		  ?>
	  </td>
     </tr>
     <tr>
      <td class="titulos5">Dependencia Actual</td>
      <td class="listado5">
	  <?
	  	$isqlt = "select DEPE_NOMB,DEPE_CODI from DEPENDENCIA order by 2";
		$nmenu = "dependenciaSel";
		$valor = "99999";
	  	$default_str=$dependenciaSel;
	    $rs= $db->conn->execute($isqlt);
	  	print $rs->GetMenu2($nmenu, $default_str, $blank1stItem = "$valor:$ss_RADI_DEPE_ACTUDisplayValue",false,0,'class=select');
	  ?>
  </td>
 </tr>

 <tr>
     <td colspan="3" align="right"><input class="botones" value="Limpiar" onclick="limpiar();" type="button"><input class="botones" value="B&uacute;squeda" type="submit"></td>
    </tr>
   </tbody></table>
   </form>

   </td>
   <td valign="top">
     <a class="vinculos" href="../busqueda/busquedaPiloto.php?<?=$phpsession ?>&krd=<?=$krd?>&<? echo "&fechah=$fechah&primera=1&ent=2"; ?>">B&uacute;squeda clasica</a><br>
	 <a class="vinculos" href="../busqueda/busquedaHist.php?<?=$phpsession ?>&krd=<?=$krd?>&<? echo "&fechah=$fechah&primera=1&ent=2"; ?>">B&uacute;squeda Historicos</a><br>
	 <a class="vinculos" href="../busqueda/busquedaExp.php?<?=$phpsession ?>&krd=<?=$krd?>&<? echo "&fechah=$fechah&primera=1&ent=2"; ?>">B&uacute;squeda Expediente</a>
   </td>
  </tr>
 </tbody></table>
 <?	  

//-------------------------------
// Build WHERE statement
//-------------------------------

//if($n_nume_radi != "" or s_RADI_NOMB != "" or $adodb_next_page != "" or $orderNo != "" or $orderTipo != "" or $orden_cambio != "" or $dependenciaSel != "")
if (($_POST['n_nume_radi'] != "") or ($_POST['dependenciaSel'] != ""))
{
  /* Se recibe la dependencia actual para bsqueda */
  if ($dependenciaSel == "99999") $dependenciaSel = "";
  if($dependenciaSel)
  {
    $HasParam = true;
    $sWhere = $sWhere . " and R.RADI_DEPE_ACTU=" . $dependenciaSel;
  }
/* Se recibe el numero del Radicado a Buscar */
	if($_POST['n_nume_radi'])
		{
		    $HasParam = true;
   			$sWhere = $sWhere . " AND r.radi_nume_radi  like '%$n_nume_radi%'" ;
		}
		
  /* Se decide si busca en radicado de entrada o de salida o ambos */
  if ($tipoRadicado == "9999") $tipoRadicado = "";
	  if($tipoRadicado){
	      $HasParam = true;
		 $sWhere = $sWhere . " AND r.radi_nume_radi like '%$tipoRadicado'" ;
   		}
  
	
/* Se recibe el tipo de documento para la bsqueda */
  if ($tipoDocumento == "9999") $tipoDocumento = "";
  if($tipoDocumento)
  {
    $HasParam = true;
    $sWhere = $sWhere . " and R.TDOC_CODI =" . $tipoDocumento;
  }

/* Se recibe la cadena a buscar y el tipo de busqueda (All) (Any) */
  if($s_RADI_NOMB)
	 {
    	if ($s_solo_nomb=="All")
			{
      			$sWhere.= " and ";
      			$and="false";
      			$s_RADI_NOMB = strtoupper($s_RADI_NOMB);
      			$tok = strtok($s_RADI_NOMB," ");
      			while ($tok)
					 {
        				if($sWhere != "" && $and=="true")
          					//$sWhere .= " and ";	Comentariada por HLP.
          					$sWhere .= " or ";
	        			$HasParam = true;
    	    			$sWhere .= " (upper(".$db->conn->Concat("R.RADI_NOMB","R.RADI_PRIM_APEL","R.RADI_SEGU_APEL","R.RA_ASUN","R.RADI_REM").") like '%".$tok."%' OR U.USUA_NOMB LIKE '%".$tok."%' ";
        				$tok = strtok(" ");
        				$and="true";
								$sWhere.=")";
      				}
      			
    		}
    if ($s_solo_nomb=="Any")
	 	{
      		$sWhere.= " and (";
      		$and="false";
 	        $ps_RADI_NOMB = strtoupper($ps_RADI_NOMB);
	        $tok = strtok($s_RADI_NOMB," ");
      		while ($tok)
			 {
        		$HasParam = true;
        		if($sWhere != "" && $and=="true")
				 {
		          $sWhere .= ") and (";
        		}
        		$sWhere .= "(upper(".$db->conn->Concat("R.RADI_NOMB","R.RADI_PRIM_APEL","R.RADI_SEGU_APEL","R.RA_ASUN","R.RADI_REM").") like '%".$tok."%' OR U.USUA_NOMB LIKE '%".$tok."%' ";
        		$tok = strtok(" ");
        		$and="true";
     		 }
      		$sWhere.="))";
    }
  }
		//$sqlFecha = $db->conn->SQLDate("Y/m/d H:i A","r.RADI_FECH_RADI");
		$sqlFecha = $db->conn->SQLDate("Y/m/d","r.RADI_FECH_RADI");
  	    $sqlDiasfal = "round(((r.radi_fech_radi+(td.sgd_tpr_termino * 7/5))- sysdate))";

  
//-------------------------------
// Build base SQL statement
//-------------------------------
	require_once("../include/query/busqueda/busquedaPiloto1.php");
    $fecha_ini = mktime(00,00,00,substr($fecha_ini,5,2),substr($fecha_ini,8,2),substr($fecha_ini,0,4));
	$fecha_fin = mktime(23,59,59,substr($fecha_fin,5,2),substr($fecha_fin,8,2),substr($fecha_fin,0,4));
	$isql = 'SELECT '.$radi_nume_radi.' as "IMG_Radicado",
			r.RADI_PATH as "HID_RADI_PATH",'
			.$sqlFecha.' as "DAT_Fecha_Radicado",'
			.$radi_nume_radi.' as "HID_Numero Radicado",
	r.RADI_NOMB as "Nombre",
	r.RADI_PRIM_APEL as "Apellido 1",
	r.RADI_SEGU_APEL as "Apellido 2",
    r.RADI_NUME_IDEN as "Identificacion", 
    U.USUA_NOMB as "USUARIO ACTUAL",
    r.RA_ASUN as "HID_ASUN",
    r.RADI_REM as "HID_R_RADI_REM",
    r.TDOC_CODI as "HID_R_TDOC_CODI"
    from RADICADO r, USUARIO U';
	//Construccion Condicion de Fechas
	$isql = $isql .	' WHERE '.$db->conn->SQLDate('Y-m-d','r.radi_fech_radi'). ' BETWEEN
	'.$db->conn->DBDate($fecha_ini).' and '.$db->conn->DBDate($fecha_fin) ;
/* Busqueda por nivel y usuario*/
$isql = $isql . " and r.RADI_USUA_ACTU=U.USUA_CODI AND r.RADI_DEPE_ACTU=U.DEPE_CODI and r.CODI_NIVEL<=$nivelus";

/* Otras condiciones*/
	if($HasParam)
		{
			$isql = $isql . $sWhere;
		}

/* Contador */

     $ADODB_COUNTRECS = true;
     $rs = $db->conn->Execute($isql);
	 if ($rs){
	 	$nregis = $rs->recordcount();
	 	$fldTotal = $nregis;
	}else
     	$fldTotal = 0;
     $ADODB_COUNTRECS = false;
 ?>
 <table>
  <tbody><tr>
   <td width="534" valign="top">
     <table width="100%" height="27" class="FormTABLE">
      <tbody><tr>
       <td class="titulos5" colspan="6"><a name="RADICADO">Reporte por Usuarios</a></td>

      </tr>
    </tbody>
 </table>
 <table>
  <tbody><tr>
   <td valign="top">

     <table width="645" class="FormTABLE">
      <tbody>
	    <tr>
	 <td colspan="5" class="info"><font class="DataFONT"><b>Total Registros Encontrados: <?=$fldTotal?></b></td>
     </tr>
 
 </tbody></table>
 <?	  
		$pager = new ADODB_Pager($db,$isql,'adodb', true,$orderNo,$orderTipo);
		$pager->checkAll = false;
		$pager->checkTitulo = true; 
		$pager->toRefLinks = $linkPagina;
		$pager->toRefVars = $encabezado;
		$pager->Render($rows_per_page=30,$linkPagina,$checkbox=chkAnulados);
}
	
?>

</body></html>