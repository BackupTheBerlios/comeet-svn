<?php
error_reporting(0);
session_start();
$krd=strtoupper($krd);
$ruta_raiz = "."; 
if(!isset($_SESSION['dependencia'])) include "./rec_session.php";
$fechah = date("ymd") ."_". time("hms");
?>
<html>
<head>
<title>.:: Sistema de Gesti&oacute;n Documental ::.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="shortcut icon" href="imagenes/arpa.gif">
<script>
  function cerrar_ventana()
        {
           window.close();
        }
</script>
</head>
<frameset rows="75,864*" frameborder="NO" border="0" framespacing="0" cols="*">
  <frame name="topFrame" scrolling="NO" noresize src='f_top.php?<?=session_name()."=".session_id()?>&krd=<?=$krd?>&fechah=<?=$fechah?>'>
  <frameset cols="165,947*" border="0" framespacing="0" rows="*">
          <frame name='leftFrame' scrolling='AUTO' src='correspondencia.php?<?=session_name()."=".session_id()?>&krd=<?=$krd?>&fechah=<?=$fechah?>' marginwidth='0' marginheight='0' scrolling='AUTO'>
    <frame name='mainFrame' src='cuerpo.php?<?=session_name()."=".session_id()?>&krd=<?=$krd?>&swLog=<?=$swLog?>&fechah=<?=$fechah?>' scrolling='AUTO'>
    <frame src="UntitledFrame-3">
  </frameset>
</frameset>
<noframes></noframes>
</frameset>
</html>
