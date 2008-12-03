<?php
session_start();

$ruta_raiz = "..";
if (!isset($_SESSION['dependencia']))	include "../rec_session.php";
include_once  $ruta_raiz."/include/db/ConnectionHandler.php";
$db = new ConnectionHandler("$ruta_raiz");

$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;

if(!isset($_POST['fecha_busq']))	$fecha_busq=date("Y-m-d");

$sql = "SELECT SGD_FENV_DESCRIP, SGD_FENV_CODIGO FROM SGD_FENV_FRMENVIO
		WHERE SGD_FENV_ESTADO=1 AND SGD_FENV_PLANILLA=1
		ORDER BY SGD_FENV_DESCRIP";
$Rs_fenv = $db->conn->Execute($sql);
$slc_fenv = $Rs_fenv->GetMenu2('slc_fenv',$_POST['slc_fenv'],"0:&lt;SELECCIONE&gt;",false,false,"class='select' Onchange='this.form.submit()'");

if (isset($_POST[slc_fenv]) && $_POST['slc_fenv']>0)
{
	$fecha_mes = substr($fecha_busq,0,7) ;
	// conte de el ultimo numero de planilla generado.
	$sqlChar = $db->conn->SQLDate("Y-m","SGD_RENV_FECH");
	//include "$ruta_raiz/include/query/radsalida/queryGenerar_envio.php";
	$query = "SELECT sgd_renv_planilla, sgd_renv_fech FROM sgd_renv_regenvio
				WHERE DEPE_CODI=$dependencia AND $sqlChar = '$fecha_mes'
					AND ".$db->conn->length."(sgd_renv_planilla) > 0 
					AND sgd_fenv_codigo = $codigo_envio ORDER BY sgd_renv_fech desc, SGD_RENV_PLANILLA desc";
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;
	$rs = $db->query($query);
	if ($rs)
	{
		$planilla_ant       = $rs->fields["SGD_RENV_PLANILLA"];
		$fecha_planilla_ant = $rs->fields["SGD_RENV_FECH"];
	}
	switch ($_POST['slc_fenv'])
	{
		case 101:
		case 108:
		case 109:
			{
				$msg_pf = "<br><span class=etexto>&Uacute;ltima planilla generada : <b> $planilla_ant </b>  Fec:$fecha_planilla_ant";
			}break;
		default:$msg_pf="";
	}
}
?>
<html>
<head>
<link rel="stylesheet" href="../estilos/orfeo.css">
<script>
function validar(action)
{
	if(action!=2)
	{
		document.new_product.action = "generar_envio.php?<?=session_name()."=".session_id()."&krd=$krd&fecha_h=$fechah"?>&generar_listado_existente= Generar Plantilla existente ";
	}else{

		document.new_product.action = "generar_envio.php?<?=session_name()."=".session_id()."&krd=$krd&fecha_h=$fechah"?>&generar_listado= Generar Nuevo Envio ";
	}
	solonumeros();
}

function rightTrim(sString)
{	while (sString.substring(sString.length-1, sString.length) == ' ')
	{	sString = sString.substring(0,sString.length-1);  }
	return sString;
}

function solonumeros()
{	jh =  document.getElementById('no_planilla');
	if(rightTrim(jh.value) == "" || isNaN(jh.value))
	{	alert('Sólo introduzca números.' );
	jh.value = "";
	jh.focus();
	return false;
}
else
{	document.new_product.submit();	}
}
</script>
</head>
<body>
<div id="spiffycalendar" class="text"></div>
<link rel="stylesheet" type="text/css" href="../js/spiffyCal/spiffyCal_v2_1.css">
<script language="JavaScript" src="../js/spiffyCal/spiffyCal_v2_1.js"></script>
<script language="javascript">
var dateAvailable = new ctlSpiffyCalendarBox("dateAvailable", "new_product", "fecha_busq","btnDate1","<?=$fecha_busq?>",scBTNMODE_CUSTOMBLUE);
</script>
<table class=borde_tab width='100%' cellspacing="5"><tr><td class=titulos2><center>GENERACI&Oacute;N PLANILLAS Y GUIAS DE CORREO</center></td></tr></table>
<table><tr><td></td></tr></table>
<form name="new_product"  action='generar_envio.php?<?=session_name()."=".session_id()."&krd=$krd&fecha_h=$fechah"?>' method='post'>
<center>
<TABLE width="450" class="borde_tab" cellspacing="5">
<TR>
	<TD width="125" height="21"  class='titulos2'>
		Fecha<br><?echo "(".date("Y-m-d").")";?>
	</TD>
	<TD width="225" align="right" valign="top" class='listado2'>
		<script language="javascript">
		dateAvailable.date = "2003-08-05";
		dateAvailable.writeControl();
		dateAvailable.dateFormat="yyyy-MM-dd";
		</script>
	</TD>
	</TR>
<TR>
	<TD height="26" class='titulos2'> Desde la Hora</TD>
	<TD valign="top" class='listado2'>
	<?php
	if(!$hora_ini) $hora_ini = 01;
	if(!$hora_fin) $hora_fin = date("H");
	if(!$minutos_ini) $minutos_ini = 01;
	if(!$minutos_fin) $minutos_fin = date("i");
	if(!$segundos_ini) $segundos_ini = 01;
	if(!$segundos_fin) $segundos_fin = date("s");
	?>
	<select name=hora_ini class='select'>
	<?php
	for($i=0;$i<=23;$i++)
	{
		if ($hora_ini==$i){ $datoss = " selected "; }else{ $datoss = " "; }
	?>
		<option value='<?=$i?>' '<?=$datoss?>'>
	<?=$i?>
		</option>
	<?php
	}
	?>
	</select>:
	<select name=minutos_ini class='select'>
	<?php
	for($i=0;$i<=59;$i++)
	{
		if ($minutos_ini==$i){ $datoss = " selected "; }else{ $datoss = " "; }
	?>
		<option value='<?=$i?>' '<?=$datoss?>'>
	<?=$i?>
		</option>
	<?
	}
	?>
	</select>
	</TD>
</TR>
<Tr>
	<TD height="26" class='titulos2'>Hasta</TD>
	<TD valign="top" class='listado2'>
	<select name=hora_fin class=select>
	<?
	for($i=0;$i<=23;$i++)
	{
		if ($hora_fin==$i){ $datoss = " selected "; }else{ $datoss = " "; }
	?>
		<option value='<?=$i?>' '<?=$datoss?>'>
	<?=$i?>
		</option>
	<?php
	}
	?>
	</select>:
	<select name=minutos_fin class=select>
	<?php
	for($i=0;$i<=59;$i++)
	{
		if ($minutos_fin==$i){ $datoss = " selected "; }else{ $datoss = " "; }
	?>
		<option value='<?=$i?>' '<?=$datoss?>'>
	<?=$i?>
		</option>
	<?php
	}
	?>
	</select>
	</TD>
</TR>
<tr>
	<TD height="26" class='titulos2'>Tipo de Salida</TD>
	<TD valign="top" align="left" class='listado2'>
	   <?=$slc_fenv?>
	</TD>
</tr>
<tr>
	<TD height="26" class='titulos2'>Numero de Planilla</TD>
	<TD valign="top" align="left" class='listado2'>
		<input type="text" name="no_planilla" id="no_planilla" value='<?=$_POST['no_planilla']?>' class='tex_area' size=11 maxlength="9" >
		<?=$msg_pf?>
	</TD>
<tr>
	<td height="26" colspan="2" valign="top" class='titulos2'>
	<center>
	<INPUT TYPE=button name=generar_listado_existente Value=' Generar Plantilla existente ' class='botones_funcion' onClick="validar(1);">
	</center>
	</td>
</tr>
<tr>
	<td height="26" colspan="2" valign="top" class='titulos2'>
	<center>
	<INPUT TYPE=button name=generar_listado Value=' Generar Nuevo Envio ' class='botones_largo' onClick="validar(2);">
	</center>
	</td>
</tr>
</TABLE>
</form>
<table><tr><td></td></tr></table>
<?php
if($generar_listado or $generar_listado_existente)
{
	switch ($_POST['slc_fenv'])
	{
		case 101:
			{
				error_reporting(7);
				if($generar_listado_existente)
				{
					$generar_listado = "Genzzz";
					echo "<table class=borde_tab width='100%'><tr><td class=listado2><CENTER>Generar Listado Existente</td></tr></table>";
				}
				include "./listado_planillas.php";
				echo "<table class=borde_tab width='100%'><tr><td class=titulos2><CENTER>FECHA DE BUSQUEDA $fecha_busq</cebter></td></tr></table>";
			}break;
		case 105:
			{
				include "./listado_guias.php";
				echo "<table class=borde_tab width='100%'><tr><td class=listado2><CENTER>FECHA DE BUSQUEDA $fecha_busq </center></td></tr></table>";
			}break;
		case 108:
			{
				echo "<table class=borde_tab width='100%'><tr><td class=titulos2><CENTER>PLANILLA NORMAL</center></td></tr></table>";
				if($generar_listado_existente)  $generar_listado = "Genzzz";
				include "./listado_planillas_normal.php";
				echo "<table class=borde_tab width='100%'><tr><td class=titulos2><CENTER>FECHA DE BUSQUEDA $fecha_busq </center></td></tr></table>";
			}break;
		case 109:
			{
				echo "<table class=borde_tab width='100%'><tr><td class=titulos2><CENTER>PLANILLA ACUSE DE RECIBO</center></td></tr></table>";
				if($generar_listado_existente)  $generar_listado = "Genzzz";
				include "./lPlanillaAcuseR.php";
				echo "<table class=borde_tab width='100%'><tr><td class=listado2><CENTER>FECHA DE BUSQUEDA $fecha_busq </td></tr></table>";
			}break;
		default:break;
	}
}
?>
</body>
</html>