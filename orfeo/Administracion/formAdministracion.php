<?php
	$ruta_raiz = "..";
	session_start();
	if(!isset($_SESSION['dependencia']))	include "$ruta_raiz/rec_session.php";	
	if($_SESSION['usua_admin_sistema'] !=1 ) die(include "$ruta_raiz/errorAcceso.php");
	$phpsession = session_name()."=".session_id();
?>
<html>
<head>
<title>Documento  sin t&iacute;tulo</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../estilos/orfeo.css">
</head>
<body>
  <table width="31%" align="center" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
  <tr bordercolor="#FFFFFF">
    <td colspan="2" class="titulos4"><div align="center"><strong>M&Oacute;DULO DE ADMINISTRACI&Oacute;N</strong></div></td>
  </tr>
  <tr bordercolor="#FFFFFF">
		<td align="center" class="listado2" width="48%">
			<a href='usuario/mnuUsuarios.php?<?=$phpsession ?>&krd=<?=$krd?>' target='mainFrame' class="vinculos">1. USUARIOS Y PERFILES</a>
		</td>
		<td align="center" class="listado2" width="48%"><a href="tbasicas/adm_dependencias.php" class="vinculos">2. DEPENDENCIAS</a></td>
  </tr>
  <!--tr bordercolor="#FFFFFF">
    <td align="center" class="listado2" width="48%"> <a  class="vinculos" target='mainFrame'>3. CARPETAS</a></td>
    <td align="center" class="listado2" width="48%"><a href="tbasicas/adm_fenvios.php" class="vinculos" target='mainFrame'>4. ENVIO DE CORRESPONDENCIA</a> </td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td align="center" class="listado2" width="48%"><a href="tbasicas/adm_tsencillas.php" class="vinculos" target='mainFrame'>5. TABLAS SENCILLAS</a></td-->
<tr bordercolor="#FFFFFF">
    <td align="center" class="listado2" width="48%"><a href="tbasicas/adm_trad.php" class="vinculos" target='mainFrame'>6. TIPOS DE RADICACI&Oacute;N</a></td>
<td align="center" class="listado2" width="48%"><a href="tbasicas/adm_paises.php" class="vinculos" target='mainFrame'>7. PA&Iacute;SES</a></td>
  </tr>
  <tr bordercolor="#FFFFFF">
        <td align="center" class="listado2" width="48%"><a href="tbasicas/adm_dptos.php" class="vinculos" target='mainFrame'>8. DEPARTAMENTOS</a></td>
<td align="center" class="listado2" width="48%"><a href="tbasicas/adm_mcpios.php" class="vinculos" target='mainFrame'>9. MUNICIPIOS</a></td>
  </tr>
  
    
	<!--td align="center" class="listado2" width="48%"><a href="tbasicas/adm_tarifas.php" class="vinculos" target='mainFrame'>10. TARIFAS</a></td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td align="center" class="listado2" width="48%"><a href="tbasicas/adm_contactos.php" class="vinculos" target='mainFrame'>11. CONTACTOS</a></td>
	<td align="center" class="listado2" width="48%">
		<a href="tbasicas/adm_esp.php?krd=<?=$krd?>" class="vinculos" target='mainFrame'>12. ESP</a>
	</td>
  </tr>
  <tr bordercolor="#FFFFFF">
    <td align="center" class="listado2" width="48%"><a href="tbasicas/adm_temas.php" class="vinculos" target='mainFrame'>13. TABLAS TEM&Aacute;TICAS</a></td>
	<td align="center" class="listado2" width="48%">
	</td-->
  </table>
</body>
</html>
