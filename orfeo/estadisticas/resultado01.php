<?php

session_start();
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
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
 <tr>
  <td class="titulos4">
      REPORTE DE RADICADOS POR USUARIO
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
          $result=pg_query($dbconn, "SELECT radi_nume_radi, radi_fech_radi, radi_usua_actu FROM radicado ORDER BY radi_nume_radi");
          $size = pg_num_rows($result);
          if ($size > 0) {
    ?> 
              <table width="100%" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
    <?php
              while ($row = pg_fetch_array($result)) {
                     echo "<tr>";
                     echo "<td>$row[0]</td>\n";
                     echo "<td>$row[1]</td>\n";
                     echo "<td>$row[2]</td>\n";
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
</center>
</body>
</html>

<?php
  pg_close($dbconn);
?>

