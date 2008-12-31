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

$condiciones = array();

$tipoDependencia = $_POST['tipoDependencia'];
$tipoUsuario = $_POST['tipoUsuario'];
$tipoRadicado = $_POST['tipoRadicado'];
$tipoDocumento = $_POST['tipoDocumento'];
$fecha_busq = $_POST['fecha_busq'];
$fecha_busq2 = $_POST['fecha_busq2'];

if ($tipoDependencia != -1) {
    $condiciones[0] = "r.radi_depe_rapi = $tipoDependencia";
}

if ($tipoUsuario != -1) {
    $condiciones[1] = "r.radi_usua_radi = $tipoUsuario";
}

if ($tipoRadicado != -1) {
    $condiciones[2] = "r.carp_codi = $tipoRadicado";
}

if ($tipoDocumento != -1) {
    $condiciones[3] = "r.tdoc_codi = $tipoDocumento";
}

if (!$fecha_busq) {
    $fecha_busq = -1;
} else {
    $condiciones[4] = "r.radi_fech_radi >= '$fecha_busq'";
}

if (!$fecha_busq2) {
    $fecha_busq2 = -1;
} else {
    $condiciones[5] = "r.radi_fech_radi <= '$fecha_busq2'";
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
             case 4:
                    $condiciones[4] = " AND ".$condiciones[4];
                    $where = $where.$condiciones[4];
             break;
             case 5:
                    $condiciones[5] = " AND ".$condiciones[5];
                    $where = $where.$condiciones[5];
             break;
     }
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
          $sql = "SELECT r.radi_nume_radi, r.radi_fech_radi, u.usua_nomb, d.depe_nomb FROM radicado r, dependencia d, usuario u WHERE r.radi_depe_radi = d.depe_codi AND r.radi_usua_radi = u.usua_codi ";
          if (strlen($where) > 0) {
              $sql = $sql.$where;
          } 
          $sql = $sql." ORDER BY r.radi_nume_radi";

          $result=pg_query($dbconn, $sql);
          $size = pg_num_rows($result);
          if ($size > 0) {
    ?> 
              <table width="100%" border="0" cellpadding="0" cellspacing="5" class="borde_tab">
              <tr>
                <td>C&odigo</td>
                <td>Fecha</td>
                <td>Usuario</td>
                <td>Dependencia</td>
              </tr>
    <?php
              while ($row = pg_fetch_array($result)) {
                     echo "<tr>";
                     echo "<td>$row[0]</td>\n";
                     echo "<td>$row[1]</td>\n";
                     echo "<td>$row[2]</td>\n";
                     echo "<td>$row[3]</td>\n";
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
<br>
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

