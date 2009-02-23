<?php
error_reporting(0);
session_start();
$ruta_raiz = ".";
if(!isset($_SESSION['dependencia'])) include "./rec_session.php";
$carpeta=$carpetano;
$tipo_carp = $tipo_carpp;
include_once "$ruta_raiz/include/db/ConnectionHandler.php";
$db = new ConnectionHandler("$ruta_raiz");
error_reporting(7);
$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
?>
<head>
<META HTTP-EQUIV="Refresh" CONTENT="60">
<link rel="stylesheet" href="estilos/orfeo.css">
<script>
// Variable que guarda la �ltima opci�n de la barra de herramientas de funcionalidades seleccionada
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function reload_window($carpetano,$carp_nomb,$tipo_carp)
{
	document.write("<form action=cuerpo.php?<?=session_name()."=".session_id()?>&krd=<?=$krd?>&ascdesc=desFc method=post name=form4 target=mainFrame>");
	document.write("<input type=hidden name=carpetano value=" + $carpetano + ">");
	document.write("<input type=hidden name=carp_nomb value=" + $carp_nomb + ">");
	document.write("<input type=hidden name=tipo_carpp value=" + $tipo_carp + ">");
	document.write("<input type=hidden name=tipo_carpt value=" + $tipo_carpt + ">");
	document.write("</form>");
	document.form4.submit();
}
selecMenuAnt=-1;
swVePerso = 0;
numPerso = 0;
function cambioMenu(img){

		MM_swapImage('plus' + img,'','imagenes/menuraya.gif',1);

	if (selecMenuAnt!=-1 && img!=selecMenuAnt)
		MM_swapImage('plus' + selecMenuAnt,'','imagenes/menu.gif',1);
	selecMenuAnt = img;

	if (swVePerso==1 && numPerso!=img){
		document.getElementById('carpersolanes').style.display="none";
		MM_swapImage('plus' + numPerso,'','imagenes/menu.gif',1);
		swVePerso=0;
	}



}
function verPersonales(img){

    if (swVePerso!=1){
		document.getElementById('carpersolanes').style.display="";
		swVePerso=1;
	}else{
		document.getElementById('carpersolanes').style.display="none";
		MM_swapImage('plus' + selecMenuAnt,'','imagenes/menu.gif',1);
		selecMenuAnt = img;
		swVePerso=0;
	}
	numPerso = img;
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<?
	$fechah = date("dmy") . "_" . time("hms");
	$carpeta = $carpetano;
?>
<form action=correspondencia.php method="post" >
<?
function fnc_date_calcd($this_date,$num_days){
echo $this_date;
	  //puts the UNIX timestamp back into string format
    return $return_date;//exit function and return string
}//end of function

$fechC=date('Y-m-d');
$ho=date('H');
$mi=date('i')+1;
$hf=$ho;
$mo=$mi-1;
if($mo<0){
	$mo=59;
	$hf=$hf-1;
}
//$db->conn->debug=true;
$rsA=$db->conn->Execute("select distinct(r.radi_nume_radi), c.carp_desc, p.nomb_carp,r.carp_per from usuario u, hist_eventos h,
 carpeta c, radicado r left join carpeta_per p on p.codi_carp=r.carp_codi 
and p.usua_codi=r.radi_usua_actu and p.depe_codi=r.radi_depe_actu
 where r.radi_depe_actu=u.depe_codi and r.radi_usua_actu=u.usua_codi 
 and u.usua_login like '$krd' and c.carp_codi=r.carp_codi and h.radi_nume_radi=r.radi_nume_radi 
and h.hist_fech between '$fechC $hf:$mo' and '$fechC $ho:$mi' and h.sgd_ttr_codigo in (2,9,10,12,16)");
$rad_r=$rsA->fields['RADI_NUME_RADI'];
$car_r=$rsA->fields['CARP_DESC'];
$car_p=$rsA->fields['NOMB_CARP'];
$car_pe=$rsA->fields['CARP_PER'];
if($rad_r!="" and $car_r!="" and $car_pe==0){
?>
<script>
alert("Tiene un radicado nuevo en la bandeja <?=$car_r?>");
</script>
<?
}
elseif($rad_r!=""){
?>
<script>
alert("Tiene un radicado nuevo en la bandeja <?=$car_p?>");
</script>
<?
}
 // Cambia a Mayuscula el login-->krd -- Permite al usuario escribir su login en mayuscula o Minuscula
 	$numeroa=0;$numero=0;$numeros=0;$numerot=0;$numerop=0;$numeroh=0;
	$fechah=date("dmy") . time("hms");
 	//Relaiza la consulta del usuarios y de una vez cruza con la tabla dependencia
 	$isql = "select a.*,b.depe_nomb from usuario a,dependencia b
           where a.depe_codi=b.depe_codi
           AND USUA_LOGIN ='$krd' ";
	$rs = $db->query($isql);
 	$phpsession = session_name()."=".session_id();
	echo "<font size=1 face=verdana>";
 // Valida Longin y contrase� encriptada con funcion md5()
 if (trim($rs->fields["USUA_LOGIN"])==trim($krd))
 {
	$contraxx=$rs->fields["USUA_PASW"];
	if (trim($contraxx))
	{
		$codusuario =$rs->fields["USUA_CODI"];
		$dependencianomb=$rs->fields["DEPE_NOMB"];
		$fechah = date("dmy") . "_" . time("hms");
		$contraxx=$rs->fields["USUA_PASW"];
		$nivel=$rs->fields["CODI_NIVEL"];
		$iusuario = " and us_usuario='$krd'";
		$perrad = $rs->fields["PERM_RADI"];
//Adicionado as contador
		// si el usuario tiene permiso de radicar el prog. muestra los iconos de radicaci�
	include "$ruta_raiz/menu/menuPrimero.php";
	include "$ruta_raiz/menu/radicacion.php";

	// Esta consulta selecciona las carpetas Basicas de DocuImage que son extraidas de la tabla Carp_Codi
 	$isql ="select CARP_CODI,CARP_DESC from carpeta order by carp_codi ";
	$rs = $db->query($isql);
 	$addadm = "";
?>

<table border="0" cellpadding="0" cellspacing="0" width="160">
<!-- fwtable fwsrc="Sin t�tulo" fwbase="menu.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
  <tr>
   <td><img src="imagenes/spacer.gif" width="10" height="1" border="0" alt=""></td>
   <td><img src="imagenes/spacer.gif" width="150" height="1" border="0" alt=""></td>
   <td><img src="imagenes/spacer.gif" width="1" height="1" border="0" alt=""></td>
  </tr>

  <tr>
   <td colspan="2"><a href="#" onClick="window.location.reload()"><img name="menu_r3_c1" src="imagenes/menu_r5_c1.gif" alt="Presione para actualizar las carpetas." width="148" height="31" border="0" ></a></td>
   <td><img src="imagenes/spacer.gif" width="1" height="25" border="0" alt=""></td>
  </tr>
  <tr>
   <td>&nbsp;</td>
   <td valign="top"><table width="150" border="0" cellpadding="0" cellspacing="0" bgcolor="c0ccca">
     <tr>
       <td valign="top"><table width="150"  border="0" cellpadding="0" cellspacing="3" bgcolor="#C0CCCA">
		<?

	while(!$rs->EOF)
	{
		if($data=="")
			$data = "NULL";
		$numdata = trim($rs->fields["CARP_CODI"]);
		
		$sqlCarpDep = "select SGD_CARP_DESCR from SGD_CARP_DESCRIPCION where SGD_CARP_DEPECODI = $dependencia and SGD_CARP_TIPORAD = $numdata";

		$rsCarpDesc = $db->query($sqlCarpDep);
		$descripcionCarpeta =  $rsCarpDesc->fields["SGD_CARP_DESCR"];
		if ( $descripcionCarpeta ) {
			$data = $descripcionCarpeta;
		}else {
	   		$data = trim($rs->fields["CARP_DESC"]);
		}

		if($numdata==11)
		{   // Se realiza la cuenta de radicados en Visto Bueno VoBo
		if($codusuario ==1)
			{
				$isql="select count(*) as CONTADOR from radicado
					where carp_per=0 and carp_codi=$numdata
					and  radi_depe_actu=$dependencia
					and radi_usua_actu=$codusuario
					";
			}
			else
			{
				$isql="select count(*) as CONTADOR from radicado
					where carp_per=0
						and carp_codi=$numdata
						and radi_depe_actu=$dependencia
						and radi_usu_ante='$krd'
						";
			}
		$addadm = "&adm=1";
		}
	else
		{
		$isql="select count(*) as CONTADOR from radicado
					where carp_per=0 and carp_codi=$numdata
						and  radi_depe_actu=$dependencia
						and radi_usua_actu=$codusuario  ";
			$addadm = "&adm=0";
		}
		if($carpeta==$numdata)
	{
	$imagen="folder_open.gif";
	}
	else
	{
	$imagen="folder_cerrado.gif";
	}
		$flag = 0;

		$rs1 = $db->query($isql);
//		ora_parse($cursor1,$isql) or $flag==1;
		$numerot = $rs1->fields["CONTADOR"];
		if ($flag==1)
			echo "$isql";
		//if ($numdata == 0 ){$numdata=800;}

	?>


         <tr  valign="middle">
    	<td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>'  name="plus<?=$i?>"></td>
		<td width="125"><a onclick="cambioMenu(<?=$i?>);" href='cuerpo.php?<?=$phpsession?>&krd=<?=$krd?>&adodb_next_page=1&fechah=<?php echo "$fechah&nomcarpeta=$data&carpeta=$numdata&tipo_carpt=0&adodb_next_page=1"; ?>' class="menu_princ" target="mainFrame" alt="Seleccione una Carpeta">
		<? echo "$data($numerot)";?>
		</a> </td>
	</tr>


<?
	$i++;
	$rs->MoveNext();
   }
	?>
<?
//Modificado idrd para poner en rojo SI tiene copias importantes
	$isql="SELECT count(*) AS contador FROM rta_compartida WHERE depe_codi=$dependencia AND usua_codi=$codusuario AND rta_resp!="."0";

        #echo "<br>SQL: $isql<br>";

	$rs1=$db->query($isql);
	$numerot = $rs1->fields["CONTADOR"];

    $i++;
    $data="Documentos De Asignacion Compartida";

	if($numerot!= '0')
        {
        ?>

                  <tr  valign="middle">
                <td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>' name="plus<?=$i?>"></td>
                <td width="125"><a onclick="cambioMenu(<?=$i?>);" href='cuerporta.php?<?=$phpsession?>&krd=<?=$krd?>&<?= "mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&carpeta=13&nomcarpeta=Rta_Compartida&orderTipo=desc&adodb_next_page=1"; ?>' class="menu_princ" target="mainFrame" alt='Documentos De Asignacion Compartida' title="Documentos De Asignacion Compartida">
                <? echo "<font color='#990000'>Rta Compartida($numerot)</font>";  $i++;?>
                </a> </td>
                </tr>
        <?
        }
	else {
	$isql2="SELECT count(*) AS contador FROM rta_compartida WHERE depe_codi=$dependencia AND usua_codi=$codusuario";

        //echo "<br>SQL: $isql<br>";

	$rs2=$db->query($isql2);
	$numerot2 = $rs2->fields["CONTADOR"];

	?>

	  <tr  valign="middle">
    	<td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>' name="plus<?=$i?>"></td>
		<td width="125"><a onclick="cambioMenu(<?=$i?>);" href='cuerporta.php?<?=$phpsession?>&krd=<?=$krd?>&<?= "mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&carpeta=13&nomcarpeta=Rta_Compartida&orderTipo=desc&adodb_next_page=1"; ?>' class="menu_princ" target="mainFrame" alt='Documentos De Asignacion Compartida' title="Documentos De Asignacion Compartida">
		<? echo "Rta Compartida($numerot2)";  $i++;?>
		</a> </td>
	</tr>
	<?
	}
    /**
	  * PARA ARCHIVOS AGENDADOS NO VENCIDOS
	  *  (Por. SIXTO 20040302)
	  */
	$sqlFechaHoy=$db->conn->DBTimeStamp(time());
	//$db->conn->debug = true;
	$sqlAgendado=" AND (agen.SGD_AGEN_FECHPLAZO > ".$sqlFechaHoy.")";
	$isql="SELECT count(*) AS contador FROM sgd_agen_agendados agen, radicado r WHERE usua_doc=$usua_doc AND agen.SGD_AGEN_ACTIVO=1 AND agen.radi_nume_radi = r.radi_nume_radi $sqlAgendado";

        #echo "<br>SQL: $isql<br>";

        $rs=$db->query($isql);
        $num_exp = $rs->fields["CONTADOR"];
        $data="Agendados no vencidos";
?>

	<tr  valign="middle">
    	<td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>'  name="plus<?=$i?>"></td>
		<td width="125"><a onclick="cambioMenu(<?=$i?>);" href='cuerpoAgenda.php?<?=$phpsession?>&agendado=1&krd=<?=$krd?>&fechah=<?php echo "$fechah&nomcarpeta=$data&tipo_carpt=0"; ?>' class="menu_princ" target="mainFrame" alt="Seleccione una Carpeta">
		<? echo "Agendado($num_exp)";?>
		</a> </td>
	</tr>

	<?
//$db->conn->debug=true;
/**
* PARA ARCHIVOS AGENDADOS  VENCIDOS
*  (Por. SIXTO 20040302)
*/
	$sqlAgendado=" and (agen.SGD_AGEN_FECHPLAZO <= ".$sqlFechaHoy.")";
	$isql="SELECT count(*) AS contador FROM sgd_agen_agendados agen WHERE usua_doc=$usua_doc AND agen.SGD_AGEN_ACTIVO=1 $sqlAgendado";

        #echo "<br>SQL: $isql<br>";

	$rs=$db->query($isql);
	$num_exp = $rs->fields["CONTADOR"];
	$data="Agendados vencidos";
	$i++;
?>



		<tr  valign="middle">
    	<td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>' name="plus<?=$i?>"></td>
		<td width="125"><a onclick="cambioMenu(<?=$i?>);" href='cuerpoAgenda.php?<?=$phpsession?>&agendado=2&krd=<?=$krd?>&fechah=<?php echo "$fechah&nomcarpeta=$data&&tipo_carpt=0&adodb_next_page=1"; ?>' class="menu_princ" target="mainFrame" alt="Seleccione una Carpeta">
		<? echo "Agendado Vencido(<font color='#990000'>$num_exp</font>)";?>
		</a> </td>
		</tr>
	<?
/**
* PARA ARCHIVOS AGENDADOS  UN DIA
*  (Por. fabian losada)
*/
	$sqlFechaHoy3=date('Y-m-d');
	$my_time = strtotime ($sqlFechaHoy3); //converts date string to UNIX timestamp
   	$timestam = $my_time +  86400; //calculates # of days passed ($num_days) * # seconds in a day (86400)
	$sqlFechaHoy2 = date("Y-m-d",$timestam);
	//$sqlFechaHoy2=fnc_date_calc($sqlFechaHoy3,1);
	$sqlAgendado=" and (agen.SGD_AGEN_FECHPLAZO > '".$sqlFechaHoy3."' and agen.SGD_AGEN_FECHPLAZO <='".$sqlFechaHoy2."')";
	$isql="SELECT count(*) AS contador FROM sgd_agen_agendados agen, radicado r WHERE usua_doc=$usua_doc AND agen.SGD_AGEN_ACTIVO=1 AND agen.radi_nume_radi = r.radi_nume_radi $sqlAgendado";

       #echo "<br>SQL: $isql<br>";
//$db->conn->debug=true;
	$rs=$db->query($isql);
	$num_exp = $rs->fields["CONTADOR"];
	$data="Agendados un Dia";
	$i++;
?>



		<tr  valign="middle">
    	<td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>' name="plus<?=$i?>"></td>
		<td width="125"><a onclick="cambioMenu(<?=$i?>);" href='cuerpoAgenda.php?<?=$phpsession?>&agendado=3&krd=<?=$krd?>&fechah=<?php echo "$fechah&nomcarpeta=$data&&tipo_carpt=0&adodb_next_page=1"; ?>' class="menu_princ2" target="mainFrame" alt="Seleccione una Carpeta">
		<? echo "Agendado un Dia(<font color='#990000'>$num_exp</font>)";?>
		</a> </td>
		</tr>
	        <?
	// Coloca el mensaje de Informados y cuenta cuantos registros hay en informados

  	if($carpeta==$numdata and $tipo_carp=0)
		{
		$imagen="folder_open.gif";
		}
	else
	{
		$imagen="folder_cerrado.gif";
	}

	//Modificado idrd para poner en rojo SI tiene copias importantes
	$isql="SELECT count(*) AS contador FROM informados WHERE depe_codi=$dependencia AND usua_codi=$codusuario AND info_resp!="."0";

        #echo "<br>SQL: $isql<br>";

	$rs1=$db->query($isql);
	$numerot = $rs1->fields["CONTADOR"];

    $i++;
    $data="Documentos De Informacion";

	if($numerot!= '0')
        {
        ?>

                  <tr  valign="middle">
                <td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>' name="plus<?=$i?>"></td>
                <td width="125"><a onclick="cambioMenu(<?=$i?>);" href='cuerpoinf.php?<?=$phpsession?>&krd=<?=$krd?>&<?= "mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&carpeta=8&nomcarpeta=Informados&orderTipo=desc&adodb_next_page=1"; ?>' class="menu_princ" target="mainFrame" alt='Documentos De Informacion' title="Documentos De Informacion">
                <? echo "<font color='#990000'>Informados($numerot)</font>";  $i++;?>
                </a> </td>
                </tr>
        <?
        }
	else {
	$isql2="SELECT count(*) AS contador FROM informados WHERE depe_codi=$dependencia AND usua_codi=$codusuario";

        //echo "<br>SQL: $isql<br>";

	$rs2=$db->query($isql2);
	$numerot2 = $rs2->fields["CONTADOR"];

	?>

	  <tr  valign="middle">
    	<td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>' name="plus<?=$i?>"></td>
		<td width="125"><a onclick="cambioMenu(<?=$i?>);" href='cuerpoinf.php?<?=$phpsession?>&krd=<?=$krd?>&<?= "mostrar_opc_envio=1&orderNo=2&fechaf=$fechah&carpeta=8&nomcarpeta=Informados&orderTipo=desc&adodb_next_page=1"; ?>' class="menu_princ" target="mainFrame" alt='Documentos De Informacion' title="Documentos De Informacion">
		<? echo "Informados($numerot2)";  $i++;?>
		</a> </td>
	</tr>
	<?
	}

//Fin
	?>
	 <tr  valign="middle">
	 <?  $data="Despliegue de Carpetas Personales";
	 ?>
    	<td width="25"><img src="imagenes/menu.gif" width="15" height="18" alt='<?=$data ?> ' title='<?=$data ?>' name="plus<?=$i?>">


    	</td>
		<td width="125" class="menu_princ"><!--a onclick="cambioMenu(<?=$i?>);verPersonales(<?=$i?>);" href='#' class="menu_princ"  alt="Despliegue de Carpetas Personales" title="Despliegue de Carpetas Personales"-->
		<? echo "PERSONALES";?>
		<!--/a--> </td>
	</tr>

       <!--/table>

       <table width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="cacac9" id=carpersolanes style="display:none"  -->
	<tr>
    <td colspan="2"><a class="vinculos" href="crear_carpeta.php?<?=$phpsession ?>&krd=<?=$krd?>&<? echo "fechah=$fechah&adodb_next_page=1"; ?>" class="menu_princ" target='mainFrame' alt='Creacion de Carpetas Personales'  title='Creacion de Carpetas Personales' ><font size=2>Nueva carpeta</font></a> </td>
    </tr>
		<?
	// BUSCA LAS CARPETAS PERSONALES DE CADA USUARIO Y LAS COLOCA contando el numero de documentos en cada carpeta.
	$isql ="select CODI_CARP,DESC_CARP,NOMB_CARP from carpeta_per where usua_codi=$codusuario and depe_codi=$dependencia order by codi_carp  ";
	$rs=$db->query($isql);
  while(!$rs->EOF)
	{
		if($data=="")
		$data = "NULL";
		$data = trim($rs->fields["NOMB_CARP"]);
		$numdata =  trim($rs->fields["CODI_CARP"]);
		$detalle = trim($rs->fields["DESC_CARP"]);
		$data = trim($rs->fields["NOMB_CARP"]) ;
		$isql="select count(*) as CONTADOR from radicado where carp_per=1 and carp_codi=$numdata and  radi_depe_actu=$dependencia and radi_usua_actu=$codusuario ";
	if($carpeta==$numdata and $tipo_carp==1)
	{
	 	$imagen="ico_carpeta_personal_abierta.gif";
	}
	else
	{
  	$imagen="ico_carpeta_personal_cerrada.gif";
	}
		$rs1=$db->query($isql);
		$numerot = $rs1->fields["CONTADOR"];
		$datap = "$data(Personal)";
		?>
	    <tr>

	    	<td height="18" colspan="2" ><a href="cuerpo.php?<?=$phpsession ?>&krd=<?=$krd?>&<? echo "fechah=$fechah&nomcarpeta=$data "; ?>(Personal)<? echo "&tipo_carp=1&carpeta=$numdata&adodb_next_page=1"; ?>" alt="<?=$detalle?>" title="<?=$detalle?>" class="menu_princ" target="mainFrame">	<? echo "$data($numerot)";?></a> </td>
         </tr>

    	<?
			$rs->MoveNext();
		}
		?>
		</table>
     </td>
    </tr>
   </table></td>
   </tr>
   </table>
<?php
  }
}
//*********************TRANSACCIONES DEL CURSOR DE CONSULTA PRIMARIA**************************************************************************************************
if(!$db->imagen())
{
  $logo = "logoEntidad.gif";
}else{
  $logo = $db->imagen();
}
?>

<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="t_bordeVerde">
	<tr align="center">
		<td height="20">
			<font size="1" face="Verdana, Arial, Helvetica, sans-serif">
			Equipo:
			<?	// Coloca de direccion ip del equipo desde el cual se esta entrando a la pagina.
				echo $_SERVER['REMOTE_ADDR'];
			?></font>
		</td>
	</tr>
</table>
</td>
</tr>
</body>
</html>
