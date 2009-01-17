<?php

session_start();
include "$ruta_raiz/rec_session.php";
include_once "../config.php";

$krd = $_GET['krd'];

if (isset($_GET['page'])) {
    $_SESSION['REPORT_PAGE'] = $_GET['page'];
}

if (isset($_GET['index'])) {
    $_SESSION['INDEX_REPORT'] = $_GET['index'];
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
    $_SESSION['fecha_busq'] = $_POST['fecha_busq'];
    $_SESSION['fecha_busq2'] = $_POST['fecha_busq2'];

   if (strlen($numRadicado) == 14) {
        $condiciones[0] = "r.radi_nume_radi = $numRadicado";
    }

    if ($tipoDependencia != -1) {
        $condiciones[1] = "r.radi_depe_radi = $tipoDependencia";
    }

    if (!$_POST['fecha_busq']) {
        $_SESSION['fecha_busq'] = -1;
    } else {
        $condiciones[2] = "r.radi_fech_radi >= '".$_SESSION['fecha_busq']."'";
    }

    if (!$_POST['fecha_busq2']) {
        $_SESSION['fecha_busq2'] = -1;
    } else {
        $condiciones[3] = "r.radi_fech_radi <= '".$_SESSION['fecha_busq2']."'";
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

    $sql = "SELECT r.radi_nume_radi, d.depe_nomb, r.ra_asun FROM radicado r, dependencia d WHERE r.radi_depe_radi = d.depe_codi ";
    if (strlen($where) > 0) {
        $sql = $sql.$where;
    }

    $counter = pg_query($dbconn, $sql);
    $size = pg_num_rows($counter);

    $_SESSION['SQL_REPORT'] = $sql;
    $_SESSION['REPORT_PAGE'] = 1;
    $_SESSION['REPORT_SIZE'] = $size;
    $_SESSION['INDEX_REPORT'] = 1; 
} 

$index = $_SESSION['REPORT_PAGE'] - 1;
$offset = $index * 20;

$sql = $_SESSION['SQL_REPORT']." ORDER BY r.radi_nume_radi LIMIT 20 OFFSET ".$offset;
$result = pg_query($dbconn, $sql);

$pages_total = $_SESSION['REPORT_SIZE']/20;
if ($_SESSION['REPORT_SIZE']%20 > 0) {
     $pages_total = floor($pages_total);
     $pages_total++;
}

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
              echo "<font class=\"titulos3b\">Se encontraron ".$_SESSION['REPORT_SIZE']." registros asociados a los criterios de b&uacute;squeda [ ".$pages_total." p&aacute;ginas de resultados ]</font><br/>";
              echo "</center>";

              if (($_SESSION['fecha_busq'] != -1) && ($_SESSION['fecha_busq2'] != -1)) {
                 echo "<font class=\"titulos3b\">Rango de Fechas: ".$_SESSION['fecha_busq']." / ".$_SESSION['fecha_busq2']."</font><br/>";
              }

              echo "<font class=\"titulos3b\">P&aacute;gina ".$_SESSION['REPORT_PAGE']."</font><br/>";
              echo "<center>"; 
              echo "<br/>";
    ?> 
              <table width="100%" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
              <tr>
                <td class="titulos3a">N&uacute;mero de Radicado</td>
                <td class="titulos3a">Dependencia</td>
                <td class="titulos3a">Asunto</td>
              </tr>
    <?php
              while ($row = pg_fetch_array($result)) {
                     echo "<tr>";
                     echo "<td class=\"titulos3b\">$row[0]</td>\n";
                     echo "<td class=\"titulos3b\">$row[1]</td>\n";
                     echo "<td class=\"titulos3b\">$row[2]</td>\n";
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

 if ($pages_total <= 20) {
     for ($i=1;$i<=$pages_total;$i++) {
          if ($i != $_SESSION['REPORT_PAGE']) {
              echo "<a href=\"resultado02.php?krd=$krd&page=$i\">$i</a> ";
          } else {
              echo "<b>$i</b> ";
          }
     }
     echo "<br/>";

 } else {
 
   if ($_SESSION['INDEX_REPORT'] > 20) {
       $index = $_SESSION['INDEX_REPORT'] - 20;
       echo "<a href=\"resultado02.php?krd=".$krd."&page=".$index."&index=".$index."\"><- 20 Anteriores</a>&nbsp;&nbsp;&nbsp;";
   }

   $init = $_SESSION['INDEX_REPORT'];
   $end = $_SESSION['INDEX_REPORT'] + 20;

   if ($end > $pages_total) {
       $end = $pages_total + 1;
   }

   for ($i=$init;$i<$end;$i++) {
          if ($i != $_SESSION['REPORT_PAGE']) {
              echo "<a href=\"resultado02.php?krd=".$krd."&page=".$i."&index=".$_SESSION['INDEX_REPORT']."\">".$i."</a> ";
          } else {
              echo "<b>$i</b> ";
          }
   }

   $bound = $pages_total % 20;

   if ($_SESSION['REPORT_PAGE'] < ($pages_total-$bound)) {
       $_SESSION['INDEX_REPORT'] = $_SESSION['INDEX_REPORT'] + 20;
       $page = $_SESSION['INDEX_REPORT'];
       echo "&nbsp;&nbsp;&nbsp;<a href=\"resultado02.php?krd=".$krd."&page=".$page."&index=".$_SESSION['INDEX_REPORT']."\">20 Siguientes -></a>";  
   } 

   echo "<br/>";
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

