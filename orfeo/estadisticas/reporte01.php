<?php
session_start();

unset($_SESSION['SQL_REPORT']);
$_SESSION['fecha_busq']  = "";
$_SESSION['fecha_busq2'] = "";

$krd = $_GET['krd'];
include "$ruta_raiz/rec_session.php";
include_once "../config.php";

list($host, $port) = split(":", $servidor, 2);
$dbconn = pg_connect("host=$host port=$port dbname=$db user=$usuario password=$contrasena");
if (!$dbconn) {
  echo "Ha ocurrido un error de conexion.\n";
  exit;
}

?>

<html>
<head>
<link rel="stylesheet" href="../estilos/orfeo.css">
<link rel="stylesheet" type="text/css" href="../js/spiffyCal/spiffyCal_v2_1.css">
<script language="JavaScript" src="../js/spiffyCal/spiffyCal_v2_1.js"></script>
</head>

<body>
<div id="spiffycalendar" class="text"></div>
<script language="javascript">
  var dateAvailable = new ctlSpiffyCalendarBox("dateAvailable", "adm_serie", "fecha_busq","btnDate1","<?=$fecha_busq?>",scBTNMODE_CUSTOMBLUE);
  var dateAvailable2 = new ctlSpiffyCalendarBox("dateAvailable2", "adm_serie", "fecha_busq2","btnDate1","<?=$fecha_busq2?>",scBTNMODE_CUSTOMBLUE);
</script>

<form method="post" action="resultado01.php?krd=<?php echo $krd; ?>" name="adm_serie">

<center>
<table  width="40%"  border="0" cellpadding="0" cellspacing="5" class="borde_tab">
 <tr>
  <td class="titulos4">
       REPORTE: Radicaci&oacute;n - Consulta de radicados por usuario
  </td>
 </tr>
</table>

<br/>

<table  width="40%"  border="0" cellpadding="0" cellspacing="5" class="borde_tab">
 <tr>
  <td class="titulos2">
       Descripci&oacute;n:&nbsp; 
  </td>
  <td class="titulos3">
       Este reporte genera la cantidad de radicados asignados o generados por cada usuario.
       Se puede discriminar por tipo de radicaci&oacute;n. 
  </td>
 </tr>
</table>

<br/>

<table  width="40%"  border="0" cellpadding="0" cellspacing="5" class="borde_tab">
 <tr>
   <td class="titulos2">
    Dependencia: 
   </td>
   <td>
    <select name="tipoDependencia" class="select">
    <?php
          $result=pg_query($dbconn, "SELECT depe_codi, depe_nomb FROM dependencia ORDER BY depe_nomb");
          $size = pg_num_rows($result);
          if ($size > 0) {
              echo "<option value=\"-1\">Todos</option>\n";
              while ($row = pg_fetch_array($result)) {
                     echo "<option value=\"".$row[0]."\">\n";
                     echo "$row[1]\n";
                     echo "</option>\n";
              }
          } else {
            echo "<option value=\"-1\">Todos</option>";
          }
    ?>
    </select>
   </td>
 </tr>
 <tr>
   <td class="titulos2">
    Tipo de Radicado:
   </td>
   <td>
    <select name="tipoRadicado" class="select">
    <?php
          $result=pg_query($dbconn, "SELECT sgd_trad_codigo, sgd_trad_descr FROM sgd_trad_tiporad ORDER BY sgd_trad_descr");
          $size = pg_num_rows($result);
          if ($size > 0) {
              echo "<option value=\"-1\">Todos</option>\n";
              while ($row = pg_fetch_array($result)) {
                     echo "<option value=\"".$row[0]."\">\n";
                     echo "$row[1]\n";
                     echo "</option>\n";
              }
          } else {
            echo "<option value=\"-1\">Todos</option>";
          }
    ?>
    </select>
   </td>
 </tr>
 <tr>
   <td class="titulos2">
    Tipo de Documento:
   </td>
   <td>
    <select name="tipoDocumento" class="select">
    <?php
          $result=pg_query($dbconn, "SELECT sgd_tpr_codigo, sgd_tpr_descrip FROM sgd_tpr_tpdcumento ORDER BY sgd_tpr_descrip");
          $size = pg_num_rows($result);
          if ($size > 0) {
              echo "<option value=\"-1\">Todos</option>\n";
              while ($row = pg_fetch_array($result)) {
                     echo "<option value=\"".$row[0]."\">\n";
                     echo "$row[1]\n";
                     echo "</option>\n";
              }
          } else {
            echo "<option value=\"-1\">Todos</option>";
          }
    ?>
    </select>
   </td>
 </tr>
 <tr>
   <td class="titulos2">
    Fecha Inicial:
   </td>
   <td class="listado2">
    <script language="javascript">
            dateAvailable.date = "<?=date('Y-m-d');?>";
            dateAvailable.writeControl();
            dateAvailable.dateFormat="yyyy-MM-dd";
    </script>

   </td>
 </tr>
 <tr>
   <td class="titulos2">
    Fecha Final:
   </td>
   <td class="listado2">
    <script language="javascript">
            dateAvailable2.date = "<?=date('Y-m-d');?>";
            dateAvailable2.writeControl();
            dateAvailable2.dateFormat="yyyy-MM-dd";
    </script>
   </td>
 </tr>
 <tr>
    <td colspan="2" class="titulos2">
      <center>
        <input type="submit" class="botones_funcion" value="Generar" name="generarOrfeo">
      </center>
    </td>
 </tr>
 <tr>
   <td colspan="2" class="titulos2">
     <center>
      <a href="vistaFormConsulta.php?krd=<?php echo $krd; ?>" class="titulos1">Regresar</a>
     </center>
   </td>
 </tr>
</table>
</center>

</form>
</body>
</html>

<?php
  pg_close($dbconn);
?>
