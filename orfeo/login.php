<?php
/** FORMULARIO DE LOGIN A ORFEO
  * Aqui se inicia session 
	* @PHPSESID		String	Guarda la session del usuario
	* @db 					Objeto  Objeto que guarda la conexion Abierta.
	* @iTpRad				int		Numero de tipos de Radicacion
	* @$tpNumRad	array 	Arreglo que almacena los numeros de tipos de radicacion Existentes
	* @$tpDescRad	array 	Arreglo que almacena la descripcion de tipos de radicacion Existentes
	* @$tpImgRad	array 	Arreglo que almacena los iconos de tipos de radicacion Existentes
	* @query				String	Consulta SQL a ejecutar
	* @rs					Objeto	Almacena Cursor con Consulta realizada.
	* @numRegs		int		Numero de registros de una consulta
	*/
    $fechah = date("dmy") . "_" . time("hms");
	$ruta_raiz = ".";
	$usua_nuevo = 3;
	error_reporting(7);
	include_once("config.php");
	
	
if ($krd)
{
	include $ruta_raiz . "/session_orfeo.php";
	require_once($ruta_raiz . "/class_control/Mensaje.php");
	if ($usua_nuevo == 0)
	{
		include($ruta_raiz."/contraxx.php");	
		$ValidacionKrd = "NOOOO";
		if($j = 1) die("<center> -- </center>");
	}
}
else
{
  // echo "<hr>Usuario ??<hr>";
}

$krd = strtoupper($krd);
$datosEnvio = "$fechah&" . session_name() . "=" . trim(session_id()) . "&krd=$krd&swLog=1";
?>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Orfeo - Sistema de Gesti&oacute;n Documental</title>
<link rel="stylesheet" rev="stylesheet" href="css/estilos.css" />
<script language="javascript" type="text/javascript" src="js/scripts.js"></script>
 <SCRIPT TYPE="text/javascript">
<!--
function submitenter(myfield,e)
{
   var keycode;
   if (window.event) 
       keycode = window.event.keyCode;
   else if (e) 
       keycode = e.which;
   else 
       return true;

   if (keycode == 13)
   {
       myfield.form.submit();
       return false;
   }
   else
       return true;
}
//-->
</SCRIPT>
</head>
<body>
<form name="formulario" action="index_frames.php?fechah=<?php echo $datosEnvio; ?>" method="post">
  <input type="hidden" name="orno" value="1">
	<?php
    if ($ValidacionKrd == "Si")	
    {  
    ?>
    <script>
    	loginTrue();
    </script>
    <?php
    }
    ?>
  <input type="hidden" name="ornot" value="1">
</form>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblPrincipal">
  <tr>
    <td>
      <table border="0" cellspacing="0" cellpadding="0" class="tblLogin" align=center>
        <tr>
          <td style="height: 10px"></td>
        </tr>
        <tr>
          <td class="tdLogin">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="contenido">
              <tr>
                <td style="text-align: center; vertical-align: top; height: 71px"><img src="img/logoOpain.gif" alt="OPAIN S.A." width="349" height="71" /></td>
              </tr>
              <tr>
                <td style="text-align: left; height: 42px"><img src="img/tituloIngreso.jpg" alt="Ingreso al sistema" width="268" height="42" /></td>
              </tr>
              <tr>
                <td style="vertical-align: top">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td style="text-align: right; padding-right: 10px">
                        <form action="login.php?fechah=<?php echo $fechah; ?>" method="post" name="frmLogin">
                        <table width="230" border="0" cellspacing="3" cellpadding="0">
                          <tr>
                            <td><label for="usuario">Usuario:</label></td>
                            <td style="width: 149px">
                              <input type="text" name="krd" id="usuario" class="txtLogin" />
                            </td>
                          </tr>
                          <tr>
                            <td><label for="clave">Contrase&ntilde;a:</label></td>
                            <td><input type="password" name="drd" id="clave" class="txtLogin" onKeyPress="return submitenter(this,event)"/></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                            <td style="text-align: left">
                              <input type="hidden" name="tipo_carp" value="0" />
                              <input type="hidden" name="carpeta" value="0" />
                              <input type="hidden" name="order" value="radi_nume_radi" />
                              <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td style="width: 71px"><a href="#" onclick="javascript:enviar(); return false;"><img border="0" name="Submit" src="img/btnEntrar.jpg" alt="Entrar" width="65" height="20" /></a></td>
                                  <td><a href="#" onclick="javascript:limpiar(); return false;"><img border="0" name="reset" src="img/btnLimpiar.jpg" alt="Limpiar" width="65" height="20" /></a></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                        </form>
                      </td>
                      <td style="width: 284px"><img src="img/logoOrfeo.jpg" alt="Orfeo" width="284" height="85" /></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td style="height: 16px"><img src="img/biselInf.jpg" alt="" width="552" height="16" /></td>
        </tr>
      </table>
      <br />
      <img src="img/creditos.jpg" alt="Powered By Radar &amp; Kazak" width="78" height="45" /><br />
    </td>
  </tr>
</table>
</body>
</html>
