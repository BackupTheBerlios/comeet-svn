<? $krdOld = $krd;
session_start();
if(!$edit)$edit=$edi;
if(!$krd) $krd = $krdOld;
if (!$ruta_raiz) $ruta_raiz = "..";
include "$ruta_raiz/rec_session.php";
include_once("$ruta_raiz/include/db/ConnectionHandler.php");
include_once "$ruta_raiz/include/tx/Historico.php";
	$objHistorico= new Historico($db);
	$db = new ConnectionHandler("$ruta_raiz");
	$db2 = new ConnectionHandler("$ruta_raiz");
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	$encabezadol = "$PHP_SELF?".session_name()."=".session_id()."&dependencia=$dependencia&krd=$krd&sel=$sel";
	$encabezado = session_name()."=".session_id()."&krd=$krd&tipo_archivo=1&nomcarpeta=$nomcarpeta";

	function fnc_date_calcy($this_date,$num_years){
	$my_time = strtotime ($this_date); //converts date string to UNIX timestamp
   	$timestamp = $my_time + ($num_years * 86400); //calculates # of days passed ($num_days) * # seconds in a day (86400)
    $return_date = date("Y-m-d",$timestamp);  //puts the UNIX timestamp back into string format
    return $return_date;//exit function and return string
   }
    function fnc_date_calcm($this_date,$num_month){
	$my_time = strtotime ($this_date); //converts date string to UNIX timestamp
   	$timestamp = $my_time - ($num_month * 2678400 ); //calculates # of days passed ($num_days) * # seconds in a day (86400)
    $return_date = date("Y-m-d",$timestamp);  //puts the UNIX timestamp back into string format
    return $return_date;//exit function and return string
    }
?>
<html height=50,width=150>
<head>
<?
if($edit>=1 or $Modificar){
?>
<title>Modificar Archivo Central</title>
<?
}
else{
?>
<title>Insertar Archivo Central</title>
<? }?>
<link rel="stylesheet" href="../estilos/orfeo.css">
<CENTER>
<body bgcolor="#FFFFFF">
<div id="spiffycalendar" class="text"></div>
 <link rel="stylesheet" type="text/css" href="../js/spiffyCal/spiffyCal_v2_1.css">
 <script language="JavaScript" src="../js/spiffyCal/spiffyCal_v2_1.js">
</script>
<script>
 function CargarCsv() {
  window.open("<?=$ruta_raiz?>/archivo/cargarcsv.php?&krd=<?=$krd?>&arch=1","Generar CSV","height=150,width=350,scrollbars=yes");
}
 </script>



<form name=insertar_central method='post' action='insertar_central.php?<?=session_name()?>=<?=trim(session_id())?>krd=<?=$krd?>&edit=<?=$edit?>&rad=<?=$rad?>&depe2=<?=$depe2?>&ano2=<?=$ano2?>'>
<br>

<table border=0 width="90%" cellpadding="0"  class="borde_tab">
<?
if($edit>=1 or $Modificar){
?>
<td class=titulosError  width="80%" colspan="4" align="center">MODIFICAR ARCHIVO CENTRAL </td>
<?
}
else{
?>
  <td class=titulosError  width="80%" colspan="4" align="center">INSERTAR ARCHIVO CENTRAL </td>
<? }?>
<? // parametrizacion de items
	/*include("$ruta_raiz/include/query/archivo/queryBusqueda_central.php");
	$rs=$db->query($sql1);
	$item11=$rs->fields["SGD_EIT_NOMBRE"];
	$tm=explode('1',$item11);
	$item1=$tm[0];
	include("$ruta_raiz/include/query/archivo/queryBusqueda_central.php");
	$rs=$db->query($sql6);
	$item31=$rs->fields["SGD_EIT_NOMBRE"];
	$tm=explode('1',$item31);
	$item3=$tm[0];
	include("$ruta_raiz/include/query/archivo/queryBusqueda_central.php");
	$rs=$db->query($sql7);
	$item41=$rs->fields["SGD_EIT_NOMBRE"];
	$tm=explode('1',$item41);
	$item4=$tm[0];
	include("$ruta_raiz/include/query/archivo/queryBusqueda_central.php");
	$rs=$db->query($sql8);
	$item51=$rs->fields["SGD_EIT_NOMBRE"];
	$tm=explode('1',$item51);
	$item5=$tm[0];
	include("$ruta_raiz/include/query/archivo/queryBusqueda_central.php");
	$rs=$db->query($sql9);
	$item61=$rs->fields["SGD_EIT_NOMBRE"];
	$tm=explode('1',$item61);
	$item6=$tm[0];*/
	$item1="CARRO";
	$item3="CARA";
	$item4="ESTANTE";
	$item5="ENTREPANO";
	$item6="CAJA";
	if($edi==1){
		include("$ruta_raiz/include/query/archivo/queryinsertar_central.php");
		//$db->conn->debug=true;
		$rsqm=$db->conn->Execute($sqlqm);
		if(!$rsqm->EOF){
			$orden=$rsqm->fields['SGD_ARCHIVO_ORDEN'];
			$depe=$rsqm->fields['SGD_ARCHIVO_DEPE'];
			$proc=$rsqm->fields['SGD_ARCHIVO_TIPO'];
			$ano=$rsqm->fields['SGD_ARCHIVO_YEAR'];
			$deman=$rsqm->fields['SGD_ARCHIVO_DEMANDADO'];
			$demant=$rsqm->fields['SGD_ARCHIVO_DEMANDANTE'];
			$fechaIni=$rsqm->fields['SGD_ARCHIVO_FECHAI'];
			$fechaInif=$rsqm->fields['SGD_ARCHIVO_FECHAF'];
			$zona=$rsqm->fields['SGD_ARCHIVO_ZONA'];
			$carro=$rsqm->fields['SGD_ARCHIVO_CARRO'];
			$cara=$rsqm->fields['SGD_ARCHIVO_CARA'];
			$estante=$rsqm->fields['SGD_ARCHIVO_ESTANTE'];
			$entre=$rsqm->fields['SGD_ARCHIVO_ENTREPANO'];
			$caja=$rsqm->fields['SGD_ARCHIVO_CAJA'];
			$codserie=$rsqm->fields['SGD_ARCHIVO_SRD'];
			$tsub=$rsqm->fields['SGD_ARCHIVO_SBRD'];
			$inder=$rsqm->fields['SGD_ARCHIVO_INDET'];
			$mata=$rsqm->fields['SGD_ARCHIVO_MATA'];
			$docu=$rsqm->fields['SGD_ARCHIVO_CC_DEMANDANTE'];
			$folios=$rsqm->fields['SGD_ARCHIVO_FOLIOS'];
			$unidocu=$rsqm->fields['SGD_ARCHIVO_UNIDOCU'];
			$anexo=$rsqm->fields['SGD_ARCHIVO_ANEXO'];
			$prest=$rsqm->fields['SGD_ARCHIVO_PRESTAMO'];
			$funprest=$rsqm->fields['SGD_ARCHIVO_FUNPREST'];
			$fechaPrestf=$rsqm->fields['SGD_ARCHIVO_FECHPRESTF'];
			
			switch($mata){
				case '1':$mata1=1;break;
				case '2':$mata2=1;break;
				case '3':$mata3=1;break;
				case '4':$mata4=1;break;
				case '5':$mata5=1;break;
				case '6':$mata6=1;break;
				case '7':$mata1=1;$mata2=1;break;
				case '8':$mata1=1;$mata3=1;break;
				case '9':$mata1=1;$mata4=1;break;
				case '10':$mata1=1;$mata5=1;break;
				case '11':$mata1=1;$mata6=1;break;
				case '12':$mata2=1;$mata3=1;break;
				case '13':$mata2=1;$mata4=1;break;
				case '14':$mata2=1;$mata5=1;break;
				case '15':$mata2=1;$mata6=1;break;
				case '16':$mata3=1;$mata4=1;break;
				case '17':$mata3=1;$mata5=1;break;
				case '18':$mata3=1;$mata6=1;break;
				case '19':$mata4=1;$mata5=1;break;
				case '20':$mata4=1;$mata6=1;break;
				case '21':$mata5=1;$mata6=1;break;
				case '22':$mata1=1;$mata2=1;$mata3=1;break;
				case '23':$mata1=1;$mata2=1;$mata4=1;break;
				case '24':$mata1=1;$mata2=1;$mata6=1;break;
				case '25':$mata2=1;$mata3=1;$mata4=1;break;
				case '26':$mata2=1;$mata3=1;$mata5=1;break;
				case '27':$mata2=1;$mata3=1;$mata6=1;break;
				case '28':$mata3=1;$mata4=1;$mata5=1;break;
				case '29':$mata3=1;$mata4=1;$mata6=1;break;
				case '30':$mata1=1;$mata4=1;$mata5=1;break;
				case '31':$mata1=1;$mata3=1;$mata5=1;break;
				case '32':$mata1=1;$mata4=1;$mata6=1;break;
				case '33':$mata1=1;$mata3=1;$mata6=1;break;
				case '34':$mata2=1;$mata4=1;$mata5=1;break;
				case '35':$mata2=1;$mata4=1;$mata6=1;break;
				case '36':$mata1=1;$mata5=1;$mata6=1;break;
				case '37':$mata2=1;$mata5=1;$mata6=1;break;
				case '38':$mata3=1;$mata5=1;$mata6=1;break;
				case '39':$mata4=1;$mata5=1;$mata6=1;break;
				case '40':$mata1=1;$mata2=1;$mata5=1;break;
				case '41':$mata1=1;$mata3=1;$mata4=1;break;
				case '42':$mata1=1;$mata4=1;$mata5=1;break;
				
			}
			$depe2=$depe;
			$ano2=$ano;
		}
		$edit=2;
	}	
?>
<input type="hidden" name="depe2" value="<?=$depe2?>">
<input type="hidden" name="ano2" value="<?=$ano2?>">
<tr><td width="20%" class='titulos2' align="left">TIPO </td>
	<td width="20%" class='titulos2'>
	<?
  $seleD="";
  $seleES="";
  if(!$proc)$proc=1;
  switch($proc){
  	case 1: $seleD="selected";
		break;
  	case 2: $seleES="selected";
		break;
  }
  ?>
          <select class="select" name="proc" onchange="submit();">
	   <option value="1" <?=$seleD?>>Querella</option>
	<option value="2" <?=$seleES?>>Otros</option>
	  </select>
	  </td>
	  <td width="20%" class='titulos2' align="left">A&Ntilde;O</td>
	<td width="20%" class='titulos2'>
	<select class="select" name="ano" >
          <?
	$agnoactual=Date('Y');
	for($i = 1986; $i <= $agnoactual; $i++)
	{
		if($i == $ano) $option="<option SELECTED value=\"" . $ano . "\">" . $ano . "</option>";
		elseif($i == 1986)$option="<option value=\"\"> TODOS</option>";
		else $option="<option value=\"" . $i . "\">" . $i . "</option>";
		echo $option;
	}
	?>
          </select>
	  <input type="hidden" name="yea" value="<?=$ano?>">
	</td>
	 </tr>
<tr>
<?
if($proc==1){
?>
<td width="20%" class='titulos2' align="left">NRO DE DOCUMENTO </td>
<?}
else{
?>
<td width="20%" class='titulos2' align="left">NRO DE CARPETA </td>
<?}?>
	<td width="20%" class='titulos2'><input type=text name=orden value='<?=$orden?>' class="tex_area">
    </td>
    <td width="20%" class='titulos2'>DEPENDENCIA </td>
   <TD width="20%" class='titulos2' >
				<? 
				$conD=$db->conn->Concat("DEPE_CODI","'-'","DEPE_NOMB");
				$sql5="select ($conD) as detalle,DEPE_CODI from DEPENDENCIA order by DEPE_CODI";
				//$db->conn->debug=true;
				$rs=$db->conn->Execute($sql5);
				print $rs->GetMenu2('depe',$depe,true,false,"","class=select");
				?>
</td>
   	</tr>
<tr>
<?
if($proc==1){
?>
<td width="20%" class='titulos2' align="left">QUERELLADO </td>
<?}
else{
?>
<td width="20%" class='titulos2' align="left">TITULO </td>
<?}?>
<td width="20%" class='titulos2'><input type=text name=deman value='<?=$deman?>' class="tex_area"></td>
<?
if($proc==1){
?>
<td width="20%" class='titulos2' align="left">QUERELLANTE </td>
<?}
else{
?>
<td width="20%" class='titulos2' align="left">REMITENTE </td>
<?}
?>
<td width="20%" class='titulos2'><input type=text name=demant value='<?=$demant?>' class="tex_area" ></td></tr>
<tr><td width="20%" class='titulos2' align="left"> FECHA INICIAL 
            </td>
	<td width="20%" class='titulos2'>
	<!--script language="javascript">
   	var dateAvailable1 = new ctlSpiffyCalendarBox("dateAvailable1", "insertar_central", "fechaIni","btnDate1","<?=$fechaIni?>",scBTNMODE_CUSTOMBLUE);
	</script>
	<script language="javascript">
	dateAvailable1.date = "<?=date('Y-m-d');?>";
	dateAvailable1.writeControl();
	dateAvailable1.dateFormat="yyyy-MM-dd";
	</script-->
	<input type="text" name="fechaIni" value="<?=$fechaIni?>">
	 </td>
	    <td width="20%" class='titulos2' align="left"> FECHA FINAL
          <td width="20%" class='titulos2'>
	
  	<!--script language="javascript">
   	var dateAvailable2 = new ctlSpiffyCalendarBox("dateAvailable2", "insertar_central", "fechaInif","btnDate2","<?=$fechaInif?>",scBTNMODE_CUSTOMBLUE);
	</script>
	<script language="javascript">
	dateAvailable2.date = "<?=date('Y-m-d');?>";
	dateAvailable2.writeControl();
	dateAvailable2.dateFormat="yyyy-MM-dd";
	</script-->
	<input type="text" name="fechaInif" value="<?=$fechaInif?>">
            </td></tr>
	    
	
    	
<tr><td width="20%" class='titulos2' align="left">ZONA </td>
<td width="20%" class='titulos2'><input type=text name=zona value='<?=$zona?>' class="tex_area" size=5 maxlength="4"></td>
<?/*
$edi=$db->conn->Execute("select sgd_eit_codigo from sgd_eit_items where sgd_eit_nombre like 'central' or sgd_eit_nombre like 'CENTRAL' ");
$edi1=$edi->fields['SGD_EIT_CODIGO'];
  $query="select SGD_EIT_NOMBRE,SGD_EIT_CODIGO from SGD_EIT_ITEMS where SGD_EIT_COD_PADRE LIKE '$edi1'";
  $rs1=$db->conn->query($query);
  print $rs1->GetMenu2('buscar_zona',$buscar_zona,true,false,"","onChange='submit()' class=select");*/
  ?>

<td width="20%" class='titulos2'><?=$item1?> </td>
<td width="20%" class='titulos2'><input type=text name=carro value='<?=$carro?>' class="tex_area" size=5 maxlength="4"></td>
<?/*
				$sql="select SGD_EIT_NOMBRE,SGD_EIT_CODIGO from SGD_EIT_ITEMS where SGD_EIT_COD_PADRE LIKE '$buscar_zona'";
				$rs=$db->query($sql);
				print $rs->GetMenu2('buscar_carro',$buscar_carro,true,false,"","onChange='submit()'  class=select");
   		    	*/?>
</td></tr>

<tr><td width="20%" class='titulos2' align="left"><?=$item3?> </td>
<?
if($cara=="A")$sec1="checked";
elseif($cara=="B")$sec2="checked";
else $sec3="checked";
?>
<td width="20%" class='titulos2'><input type="radio" name="cara" value="A" <?=$sec1?>>A &nbsp;
<input type="radio" name="cara" value="B" <?=$sec2?>>B &nbsp;
<input type="radio" name="cara" value="" <?=$sec3?>>Ninguno &nbsp;</td>
<?
/*
  $query="select SGD_EIT_NOMBRE,SGD_EIT_CODIGO from SGD_EIT_ITEMS where SGD_EIT_COD_PADRE LIKE '$buscar_carro'";
  $rs1=$db->conn->query($query);
  print $rs1->GetMenu2('buscar_cara',$buscar_cara,true,false,"","onChange='submit()' class=select");
  */?>

<td width="20%" class='titulos2'><?=$item4?> </td>
<td width="20%" class='titulos2'><input type=text name=estante value='<?=$estante?>' class="tex_area" size=5 maxlength="4"></td>
<?/*
		$sql="select SGD_EIT_NOMBRE,SGD_EIT_CODIGO from SGD_EIT_ITEMS where SGD_EIT_COD_PADRE LIKE '$buscar_cara'";
		$rs=$db->query($sql);
		print $rs->GetMenu2('buscar_estante',$buscar_estante,true,false,"","onChange='submit()' class=select");
	*/?>
</td></tr>
<tr><td width="20%" class='titulos2' align="left"><?=$item5?> </td>
<td width="20%" class='titulos2'><input type=text name=entre value='<?=$entre?>' class="tex_area" size=5 maxlength="4"></td>
<?/*

  $query="select SGD_EIT_NOMBRE,SGD_EIT_CODIGO from SGD_EIT_ITEMS where SGD_EIT_COD_PADRE LIKE '$buscar_estante'";
  $rs1=$db->conn->query($query);
  print $rs1->GetMenu2('buscar_entre',$buscar_entre,true,false,"","onChange='submit()' class=select");
  */?>
  <td width="20%" class='titulos2' align="left"><?=$item6?> </td>
<td width="20%" class='titulos2'><input type=text name=caja value='<?=$caja?>' class="tex_area" size=5 maxlength="4"></td>
<?
/*
  $query="select SGD_EIT_NOMBRE,SGD_EIT_CODIGO from SGD_EIT_ITEMS where SGD_EIT_COD_PADRE LIKE '$buscar_entre'";
  $rs1=$db->conn->query($query);
  print $rs1->GetMenu2('buscar_caja',$buscar_caja,true,false,"","onChange='submit()' class=select");
  */?>
  </tr>
  <tr>
  <td width="20%" class='titulos2' align="left">UNIDAD DOCUMENTAL
	</td>
   <td width="20%" class='titulos2'>
<?
switch($unidocu){
  	case 'CRPT': $sele13="selected";
		break;
  	case 'LGJ': $sele14="selected";
		break;
	case 'CPDR': $sele15="selected";
		break;
	case 'A-Z': $sele16="selected";
		break;
	case 'CJ': $sele17="selected";
		break;
	case 'PQJ': $sele18="selected";
		break;
	case 'AGL': $sele19="selected";
		break;
	 }
  ?>
          <select class="select" name="unidocu">
	  <option value="0" <?=$sele0?>>Ninguno</option>
	<option value="CRPT" <?=$sele13?>>Carpetas</option>
	<option value="LGJ" <?=$sele14?>>Legajos</option>
	<option value="CPDR" <?=$sele15?>>Libro Copiado</option>
	<option value="A-Z" <?=$sele16?>>A-Z</option>
	<option value="CJ" <?=$sele17?>>Cajas</option>
	<option value="PQT" <?=$sele18?>>Paquete</option>
	<option value="AGL" <?=$sele19?>>Argollado</option>
	</select>
</td>
  <td width="20%" class='titulos2' align="left">FOLIOS
	</td>
   <td width="20%" class='titulos2'><input type=text name=folios value='<?=$folios?>' class="tex_area">
   </td>
	</tr>
<tr>
<td width="20%" class='titulos2' align="left">&nbsp;SERIE </td>
<td width="20%" class='titulos2'>
	<?php
	if(!$tdoc) $tdoc = 0;
	if(!$codserie) $codserie = 0;
	if(!$tsub) $tsub = 0;
	$fechah=date("dmy") . " ". time("h_m_s");
	$fecha_hoy = Date("Y-m-d");
	$sqlFechaHoy=$db->conn->DBDate($fecha_hoy);
	$check=1;
	$fechaf=date("dmy") . "_" . time("hms");
	$num_car = 4;
	$nomb_varc = "s.sgd_srd_codigo";
	$nomb_varde = "s.sgd_srd_descrip";
	include "$ruta_raiz/include/query/trd/queryCodiDetalle.php";
	$querySerie = "select distinct ($sqlConcat) as detalle, s.sgd_srd_codigo from sgd_mrd_matrird m,
 	sgd_srd_seriesrd s where s.sgd_srd_codigo = m.sgd_srd_codigo and ".$sqlFechaHoy." between s.sgd_srd_fechini
 	and s.sgd_srd_fechfin order by detalle ";
	$rsD=$db->conn->query($querySerie);
	$comentarioDev = "Muestra las Series Docuementales";
	include "$ruta_raiz/include/tx/ComentarioTx.php";
	print $rsD->GetMenu2("codserie", $codserie, "0:-- Seleccione --", false,"","onChange='submit()' class='select'" );
	?>
	<td width="20%" class='titulos2' align="left"> SUBSERIE </td>
	<td width="20%" class='titulos2'>
	<?
	$nomb_varc = "su.sgd_sbrd_codigo";
	$nomb_varde = "su.sgd_sbrd_descrip";
	include "$ruta_raiz/include/query/trd/queryCodiDetalle.php";
	$querySub = "select distinct ($sqlConcat) as detalle, su.sgd_sbrd_codigo from sgd_mrd_matrird m,
 	sgd_sbrd_subserierd su where m.sgd_srd_codigo = '$codserie' and su.sgd_srd_codigo = '$codserie'
			and su.sgd_sbrd_codigo = m.sgd_sbrd_codigo and ".$sqlFechaHoy." between su.sgd_sbrd_fechini
			and su.sgd_sbrd_fechfin order by detalle ";
	$rsSub=$db->conn->query($querySub);
	include "$ruta_raiz/include/tx/ComentarioTx.php";
	print $rsSub->GetMenu2("tsub", $tsub, "0:-- Seleccione --", false,""," class='select'" );

	if(!$codiSRD)
	{
		$codiSRD = $codserie;
		$codiSBRD =$tsub;
	}

	?>
	</tr>
	    <tr>
	    <td width="20%" class='titulos2' align="left">INDICADORES DE DETERIORO </td>
<td width="20%" class='titulos2'>
<?
switch($inder){
  	case 1: $sele1="selected";
		break;
  	case 2: $sele2="selected";
		break;
	case 3: $sele3="selected";
		break;
	case 4: $sele4="selected";
		break;
	case 5: $sele5="selected";
		break;
	}
  ?>
          <select class="select" name="inder">
	  <option value="0" <?=$sele0?>>Ninguno</option>
	<option value="1" <?=$sele1?>>Biologicos: Hongos</option>
	<option value="2" <?=$sele2?>>Biologicos: Roedores</option>
	<option value="3" <?=$sele3?>>Biologicos: Insectos</option>
	<option value="4" <?=$sele4?>>Decoloracion Soporte</option>
	<option value="5" <?=$sele5?>>Desgarros</option>
	</select>
</td>
<td width="20%" class='titulos2' align="left">MATERIALES INSERTADOS </td>
<td width="20%" class='titulos2'>
<table border=0 width="90%" cellpadding="0"  >
<?
        if($mata1==1)$sele7="checked";
	?>
	<tr>
	<td width="30%" class='titulos2'> <input type="checkbox" name="mata1" value=1 <?=$sele7?>>Metalico</option></td>
	<?
	if($mata2==1)$sele8="checked";
	?>
	<td width="30%" class='titulos2'> <input type="checkbox" name="mata2" value=1 <?=$sele8?>>Post-it</option></td>
	<?
	if($mata3==1)$sele9="checked";
	?>
	<td width="30%" class='titulos2'> <input type="checkbox" name="mata3" value=1 <?=$sele9?>>Planos</option></td></tr>
	<?
	if($mata4==1)$sele10="checked";
	?>
	<tr>
	<td width="30%" class='titulos2'> <input type="checkbox" name="mata4" value=1 <?=$sele10?>>Fotografia</option></td>
	<?
	if($mata5==1)$sele11="checked";
	?>
	<td width="30%" class='titulos2'> <input type="checkbox" name="mata5" value=1 <?=$sele11?>>Soporte Optico</option></td>
	<?
	if($mata6==1)$sele12="checked";
	?>
	<td width="30%" class='titulos2'> <input type="checkbox" name="mata6" value=1 <?=$sele12?>>Soporte Magnetico</option></td></tr>
</table>	
</td>	
 </tr>
 <tr> 
	<td width="20%" class='titulos2' align="left">CEDULA DEMANDANTE
	</td>
   <td width="20%" class='titulos2'><input type=text name=docu value='<?=$docu?>' class="tex_area">
   </td>
   <td width="20%" class='titulos2' align="left">ANEXO
	</td>
   <td width="20%" class='titulos2'><textarea rows="2" name="anexo" cols="30"><?=$anexo?></textarea>
   </td>
<tr>
<?
include("$ruta_raiz/include/query/archivo/queryBusqueda_central.php");		
$dbg=$db->conn->Execute($sqla);
if(!$dbg->EOF)$usua_perm_archi=$dbg->fields['USUA_ADMIN_ARCHIVO'];
if($usua_perm_archi==4){
?>
<TR><td class='titulos2' align="right">PRESTAMO</td>
<?
if($prest==1)$de="checked";else $de="";
?>
<td class='titulos2' align="left" ><input type="checkbox" name="prest" value=1 <?=$de?> onclick="submit();"> </td>
<?
if($prest==1){
?>
<td class='titulos2' align="right" >FUNCIONARIO PRESTAMO</td>
<TD class='titulos2' align="left" ><input type="text" name="funprest" value=<?=$funprest?>></td>
<?
if(!$fechaPrestf)$fechaPrestf=date("Y-m-d");
?>
</TR>
<TR>
<td class='titulos2' align="right" >FECHA DE ENTREGA</td>
<TD class='titulos2' align="left" >
<script language="javascript">
   	var dateAvailable1 = new ctlSpiffyCalendarBox("dateAvailable1", "insertar_central", "fechaPrestf","btnDate1","<?=$fechaPrestf?>",scBTNMODE_CUSTOMBLUE);
	</script>
	<script language="javascript">
	dateAvailable1.date = "<?=date('Y-m-d');?>";
	dateAvailable1.writeControl();
	dateAvailable1.dateFormat="yyyy-MM-dd";
	</script>
</TD>
<?}?>
</TR>
<?
}
if($edit>=1 or $Modificar){
?>
<td colspan="2" align="right"><input type=submit value=Modificar name=Modificar class="botones">&nbsp;</td>
<td colspan="2" align="left"><a href='busqueda_central.php?<?=session_name()?>=<?=trim(session_id())?>krd=<?=$krd?>&Buscar'><input name='Regresar' align="middle" type="button" class="botones" id="envia22" value="Regresar" ></td>
<?
}
else{
?>
<td colspan="2" align="right"><input name="CargarCSV" type="button" class="botones_mediano" onClick="CargarCsv();" value="Insertar Archivo CSV " >
<input type=submit value=Ingresar name=Ingresar class="botones">&nbsp;</td>
<td colspan="2" align="left"><a href='archivo.php?<?=session_name()?>=<?=trim(session_id())?>krd=<?=$krd?>'><input name='Regresar' align="middle" type="button" class="botones" id="envia22" value="Regresar" ></td>
<? }?>
</table>
<br>
<?
if ($Ingresar or $Modificar){
$confi=explode($ano,$fechaIni);
if($orden=="" and $proc==2)$orden=0;
if($ano!="" and $depe!="" and $orden!="" and $confi[1]!=""){
	$zon=strtoupper($zona);
	$demq=strtoupper($deman);
	$demtq=strtoupper($demant);
	//if($docu=="")$docu="''";
	if($prest!=1)$presta=0;
	else $presta=1;
	//if($folios=="")$folios=0;
	if($mata1==1 and $mata2==1 and $mata3==1)$mata=22;
	elseif($mata1==1 and $mata2==1 and $mata4==1)$mata=23;
	elseif($mata1==1 and $mata2==1 and $mata6==1)$mata=24;
	elseif($mata2==1 and $mata3==1 and $mata4==1)$mata=25;
	elseif($mata2==1 and $mata3==1 and $mata5==1)$mata=26;
	elseif($mata2==1 and $mata3==1 and $mata6==1)$mata=27;
	elseif($mata3==1 and $mata4==1 and $mata5==1)$mata=28;
	elseif($mata3==1 and $mata4==1 and $mata6==1)$mata=29;
	elseif($mata1==1 and $mata4==1 and $mata5==1)$mata=30;
	elseif($mata1==1 and $mata3==1 and $mata5==1)$mata=31;
	elseif($mata1==1 and $mata4==1 and $mata6==1)$mata=32;
	elseif($mata1==1 and $mata3==1 and $mata6==1)$mata=33;
	elseif($mata2==1 and $mata4==1 and $mata5==1)$mata=34;
	elseif($mata2==1 and $mata4==1 and $mata6==1)$mata=35;
	elseif($mata1==1 and $mata5==1 and $mata6==1)$mata=36;
	elseif($mata2==1 and $mata5==1 and $mata6==1)$mata=37;
	elseif($mata3==1 and $mata5==1 and $mata6==1)$mata=38;
	elseif($mata6==1 and $mata4==1 and $mata5==1)$mata=39;
	elseif($mata1==1 and $mata2==1 and $mata5==1)$mata=40;
	elseif($mata1==1 and $mata3==1 and $mata4==1)$mata=41;
	elseif($mata1==1 and $mata4==1 and $mata5==1)$mata=42;
	elseif($mata1==1 and $mata2==1)$mata=7;
	elseif($mata1==1 and $mata3==1)$mata=8;
	elseif($mata1==1 and $mata4==1)$mata=9;
	elseif($mata1==1 and $mata5==1)$mata=10;
	elseif($mata1==1 and $mata6==1)$mata=11;
	elseif($mata2==1 and $mata3==1)$mata=12;
	elseif($mata2==1 and $mata4==1)$mata=13;
	elseif($mata2==1 and $mata5==1)$mata=14;
	elseif($mata2==1 and $mata6==1)$mata=15;
	elseif($mata3==1 and $mata4==1)$mata=16;
	elseif($mata3==1 and $mata5==1)$mata=17;
	elseif($mata3==1 and $mata6==1)$mata=18;
	elseif($mata4==1 and $mata5==1)$mata=19;
	elseif($mata4==1 and $mata6==1)$mata=20;
	elseif($mata5==1 and $mata6==1)$mata=21;
	elseif($mata1==1)$mata=1;
	elseif($mata2==1)$mata=2;
	elseif($mata3==1)$mata=3;
	elseif($mata4==1)$mata=4;
	elseif($mata5==1)$mata=5;
	elseif($mata6==1)$mata=6;
	else $mata=0;	
	if($prest==1)$fprest=date("Y-m-d");
	$queryUs = "select depe_codi,usua_codi from usuario where USUA_LOGIN='$krd' AND USUA_ESTA=1";
	$rsu=$db->conn->Execute($queryUs);
	$depeU=$rsu->fields['DEPE_CODI'];
	$usuacod=$rsu->fields['USUA_CODI'];
	$ree=$db->conn->Execute("select max(HIST_ID) as coe from sgd_archivo_hist");
	$co=$ree->fields['COE']+1;
	if($Ingresar){
		$sec=$db->conn->nextId('SEC_CENTRAL');
		$rad=$ano.$depe.$sec."C";
		include("$ruta_raiz/include/query/archivo/queryinsertar_central.php");
		//$db->conn->debug=true;
		$rsq=$db->conn->Execute($query);
		if($rsq->RecordCount()!=0) {
			?>
			<script language="javascript">
			confirm('ESTE REGISTRO YA EXISTE');
			</script>
			<h1 >ESTE REGISTRO YA EXISTE</h1>
			<?
		}
		else{
		include("$ruta_raiz/include/query/archivo/queryinsertar_central.php");
			$rs=$db->conn->Execute($sql);
			if($rs->EOF){
			?>
			<tr><td align="center"><h1>EL NUMERO DE RADICADO ES  <?=$rad?></h1>
			</tr>
			<?
			$rad2[1]=$rad;
			$observa="Ingreso de registro en archivo central en la ubicacion: Zona ".$zona."-Carro ".$carro."-Cara ".$cara."-Estante ".$estante."-Entrepano ".$entre."-Caja ".$caja;
			$objHistorico->insertarHistoricoArch($co,$rad2,$depeU,$usuacod,$observa, 64);
			}
			else{
			?>
			<script language="javascript">
			confirm('HUBO UN ERROR EN LA CARGA');
			</script>
			<tr><td align="center"><h1>HUBO UN ERROR EN LA CARGA</h1>
			</tr>
			<?
			}
		}
	}
	if($Modificar){
	if($depe2!=$depe){
		$r2=explode($depe2,$rad);
		$rad1=$ano.$depe.$r2[1];
	 }
	 elseif($ano2!=$ano){
		$r2=explode($ano2,$rad);
		$rad1=$ano2.$r2[1];
	 }
	  else $rad1=$rad;
	 if($prest!=1){
		$fechaPrestf="";
		$fprest="";
	 }
	 $rqr=$db->conn->Execute("select sgd_archivo_usua from sgd_archivo_central where sgd_archivo_rad like ''$rad1'");
	 if($rqr->fields['SGD_ARCHIVO_USUA']=="")$qte=" ,sgd_archivo_usua='$krd', depe_codi='$depeU'";
	 else $qte="";
		include("$ruta_raiz/include/query/archivo/queryinsertar_central.php");
		//$db->conn->debug=true;
		$rs=$db->conn->Execute($sqlm);
		if($rs->EOF){
		?>
		<tr><td align="center"><h1 class="titulosError">EL REGISTRO FUE MODIFICADO</h1>
		</tr>
		<?
		$observa="Modificacion de registro en archivo central en la ubicacion: Zona ".$zona."-Carro ".$carro."-Cara ".$cara."-Estante ".$estante."-Entrepano ".$entre."-Caja ".$caja;
		$rad2[1]=$rad1;
		
		$objHistorico->insertarHistoricoArch($co,$rad2,$depeU,$usuacod,$observa, 63);
		}
	}
}
elseif($ano==""){
?>
	<script language="javascript">
	confirm('Debe seleccionar un a�o');
	</script>
<?
}
elseif($depe==""){
?>
	<script language="javascript">
	confirm('Debe seleccionar una dependencia');
	</script>
<?
}
elseif($orden==""){
?>
	<script language="javascript">
	confirm('Debe ingresar el numero de orden');
	</script>
<?
}
elseif($confi[1]==""){
?>
	<script language="javascript">
	confirm('Debe ingresar la fecha de inicial con el a�o que selecciono');
	</script>
<?
}
}
?>
</table>
</form>