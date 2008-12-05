<?php
	$ruta_raiz = "../..";
	session_start();
	if(!$dependencia or !$tpDepeRad) include "$ruta_raiz/rec_session.php";
	if($_SESSION['usua_admin_sistema'] !=1 ) die(include "$ruta_raiz/errorAcceso.php");
	$phpsession = session_name()."=".session_id();
?>
<html>
<head>
<title>Documento sin t&iacute;tulo</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../estilos/orfeo.css">
</head>
<body>
<form name='frmMnuUsuarios' action='../formAdministracion.php?<?=session_name()."=".session_id()?>&krd=<?=$krd?>' method="post">
  <table width="32%" align="center" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
  <tr bordercolor="#FFFFFF">
    <td colspan="2" class="titulos4"><div align="center"><strong>ADMINISTRACION DE USUARIOS Y PERFILES</strong></div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td align="center" class="listado2" width="98%"><a href='crear.php?usModo=1&<?=$phpsession ?>&krd=<?=$krd?>' class="vinculos" target='mainFrame'>1. Crear Usuario</a></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td align="center" class="listado2" width="98%"><a href='cuerpoEdicion.php?usModo=2&<?=$phpsession ?>&krd=<?=$krd?>' class="vinculos" target='mainFrame'>2. Editar Usuario</a></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td align="center" class="listado2" width="98%"><a href='cuerpoConsulta.php?<?=$phpsession ?>&krd=<?=$krd?>' class="vinculos" target='mainFrame'>3. Consultar Usuario</a></td>
  </tr>
  <tr bordercolor="#FFFFFF">
  	<td align="center" class="listado2">
	<center><input align="middle" class="botones" type="submit" name="Submit" value="Cerrar"></center>
	</td> </tr>
</table>
</form>
</body>
</html>
