<?
$krdOld = $krd;
session_start();
if(!$krd) $krd=$krdOsld;
$ruta_raiz = "..";
if(!isset($_SESSION['dependencia'])) include "../rec_session.php";
?>
<html>
<head>
<title>Buscar Radicado</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../estilos/orfeo.css" type="text/css">
<script >
function solonumeros()
{
 jh =  document.getElementById('nurad').value;
 if(jh)
 {
		
		var1 =  parseInt(jh);
		if(var1 != jh)
		{
			alert("Atencion: El numero de Radicado debe ser de solo Numeros.");
			return false;
		}else{
			numCaracteres = document.getElementById('nurad').value.length;
			if(numCaracteres>=6)
			{
				document.FrmBuscar.submit();
			}else
			{
				alert("Atendcion: El numero de Caracteres del radicado es de 14. (Digito :"+numCaracteres+")");
			}
			
		}
 }else{
 	document.FrmBuscar.submit();
 }
}
</script>

</head>

<body>
	<table border=0 width=100% class="borde_tab" cellspacing="5">
	<tr align="center" class="titulos5">
	<td height="15" class="titulos5">MODIFICACI&Oacute;N DE RADICADOS </td>
</tr></Table>
<center></P>
  <form action='NEW.php?<?=session_name()."=".session_id()."&krd=$krd"?>&Submit3=ModificarDocumentos'  name="FrmBuscar" class=celdaGris method="POST">
    <table width="80%" class='borde_tab' cellspacing='5'>
  <tr class='titulos2'> 
        <td width="25%" height="49">N&uacute;mero de Radicado</td>
    <td width="55%" class=listado2>
		<input type='text' name=nurad class=tex_area id=nurad>
		<input type=hidden name=modificarRad Value="ModificarR" id=modificarRad> 
		<input type=hidden name=Buscar Value="Buscar Radicado"> 
     <input type=button name=Buscar1 Value="Buscar Radicado" class=botones_largo onclick="solonumeros();"> 
	 </td>
  </tr>
</table>
</form>
</center>
</body>
</html>
