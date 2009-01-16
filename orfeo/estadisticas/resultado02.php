<?php

session_start();
include "$ruta_raiz/rec_session.php";
include_once "../config.php";

$krd = $_GET['krd'];

if (isset($_GET['page'])) {
    $_SESSION['REPORT_PAGE'] = $_GET['page'];
}

list($host, $port) = split(":", $servidor, 2);
$dbconn = pg_connect("host=$host port=$port dbname=$db user=$usuario password=$contrasena");
if (!$dbconn) {
  echo "Ha ocurrido un error de conexion.\n";
  exit;
}

if (!isset($_SESSION['SQL_REPORT'])) { 

    $condiciones = array();
   
    $numRadicado = $_POST['numRadicado'];
    $tipoDependencia = $_POST['tipoDependencia'];
    $fecha_busq = $_POST['fecha_busq'];
    $fecha_busq2 = $_POST['fecha_busq2'];

    if (strlen($numRadicado) > 1) {
        $condiciones[0] = "r.radi_depe_rapi = $tipoDependencia";
    }

    if ($tipoDependencia != -1) {
        $condiciones[1] = "r.radi_depe_rapi = $tipoDependencia";
    }

    if (!$fecha_busq) {
        $fecha_busq = -1;
    } else {
        $condiciones[2] = "r.radi_fech_radi >= '$fecha_busq'";
    }

    if (!$fecha_busq2) {
        $fecha_busq2 = -1;
    } else {
        $condiciones[3] = "r.radi_fech_radi <= '$fecha_busq2'";
    }

    $where = "";

    foreach ($condiciones as $i => $value) {
        switch ($i) {
             case 0:
                    $condiciones[0] = " AND ".$condiciones[0];
                    $where = $where.$condiciones[0];
             break;
             case 1:
                    $condiciones[1] = " AND ".$condiciones[1];
                    $where = $where.$condiciones[1];
             break;
             case 2:
                    $condiciones[2] = " AND ".$condiciones[2];
                    $where = $where.$condiciones[2];
             break;
             case 3:
                    $condiciones[3] = " AND ".$condiciones[3];
                    $where = $where.$condiciones[3];
             break;
        }
    }

    $sql = "SELECT r.radi_nume_radi, r.radi_fech_radi, u.usua_nomb, d.depe_nomb FROM radicado r, dependencia d, usuario u WHERE r.radi_depe_radi = d.depe_codi AND r.radi_usua_radi = u.usua_codi ";
    if (strlen($where) > 0) {
        $sql = $sql.$where;
    }

    $counter = pg_query($dbconn, $sql);
    $size = pg_num_rows($counter);

    $_SESSION['SQL_REPORT'] = $sql;
    $_SESSION['REPORT_PAGE'] = 1;
    $_SESSION['REPORT_SIZE'] = $size;
} 

$index = $_SESSION['REPORT_PAGE'] - 1;
$offset = $index * 20;

$sql = $_SESSION['SQL_REPORT']." ORDER BY r.radi_nume_radi LIMIT 20 OFFSET ".$offset;
$result = pg_query($dbconn, $sql);

?>

<html>
<head>
<link rel="stylesheet" href="../estilos/orfeo.css">
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
 <tr>
  <td class="titulos4">
      REPORTE DE RADICADOS ACTUALES POR DEPENDENCIA
  </td>
 </tr>
 <tr>
  <td class="titulos2">
  <?php
    $hour = date('h:i:s A');
    $date = date('d / m / Y');
    echo "Hora: $hour - Fecha: $date";
  ?>
  </td>
 </tr>
 <tr>
  <td class="titulos2">
      Usuario: <?php echo $krd; ?>
  </td>
 </tr>
</table>
<center>
    <?php
          if ($_SESSION['REPORT_SIZE'] > 0) {
              echo "<br/>";
              echo "<font class=\"titulos3b\">Se encontraron ".$_SESSION['REPORT_SIZE']." registros asociados a los criterios de b&uacute;squeda.</font><br/>";
              echo "</center>";
              echo "<font class=\"titulos3b\">P&aacute;gina ".$_SESSION['REPORT_PAGE']."</font><br/>";
              echo "<center>"; 
              echo "<br/>";
    ?> 
              <table width="100%" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
              <tr>
                <td class="titulos3a">C&oacute;digo</td>
                <td class="titulos3a">Fecha</td>
                <td class="titulos3a">Usuario</td>
                <td class="titulos3a">Dependencia</td>
              </tr>
    <?php
              while ($row = pg_fetch_array($result)) {
                     echo "<tr>";
                     echo "<td class=\"titulos3b\">$row[0]</td>\n";
                     echo "<td class=\"titulos3b\">$row[1]</td>\n";
                     echo "<td class=\"titulos3b\">$row[2]</td>\n";
                     echo "<td class=\"titulos3b\">$row[3]</td>\n";
                     echo "</tr>\n";
              }
              echo "</table>";
          } else {
    ?>
            <br/>
            <table width="100%" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
             <tr>
               <td class="titulos3">EL REPORTE NO ARROJ&Oacute; RESULTADOS.</td>
             </tr>
            </table>
    <?php
          }
    ?>
<br/>
  <font class="titulos3b">

<?php
 $pages_total = $_SESSION['REPORT_SIZE']/20;
 if ($_SESSION['REPORT_SIZE']%20 > 0) {
     $pages_total = floor($pages_total);
     $pages_total++;
 } 

 for ($i=1;$i<=$pages_total;$i++) {
      if ($i != $_SESSION['REPORT_PAGE']) {
          echo "<a href=\"resultado01.php?krd=$krd&page=$i\">$i</a> ";
      } else {
          echo "<b>$i</b> ";
      }
 }
?>
  </font>
<br/>
<table width="100%" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
 <tr>
   <td class="titulos5">
     <center>
      <a href="vistaFormConsulta.php?krd=<?php echo $krd; ?>" class="titulos1">Regresar</a>
     </center>
   </td>
 </tr>
</table>

</center>
</body>
</html>

<?php
  pg_close($dbconn);
?>

