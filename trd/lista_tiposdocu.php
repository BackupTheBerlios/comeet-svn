<?php
session_start();
if (!$ruta_raiz) $ruta_raiz= "..";
$val = null;
$sqlFechaDocto =  $db->conn->SQLDate("Y-m-D H:i:s A","mf.sgd_rdf_fech");
$sqlSubstDescS =  $db->conn->substr."(SGD_TPR_DESCRIP, 0, 75)";

$sql = "SELECT SGD_TRAD_CODIGO,SGD_TRAD_DESCR FROM SGD_TRAD_TIPORAD ORDER BY SGD_TRAD_CODIGO";
$ADODB_COUNTRECS = true;
$rs_trad = $db->query($sql);
if ($rs_trad->RecordCount() >= 0)
{	
	$til = "SGD_TPR_TP";
	$isqlC = 'select SGD_TPR_CODIGO AS "CODIGO", '. $sqlSubstDescS .' AS "TIPOD",
			  SGD_TPR_TERMINO As "TERMINO", SGD_TPR_ESTADO as "ESTADO", ';
	$i = 0;
	while ($arr = $rs_trad->FetchRow())
	{	
		$cod .= $til.$arr['SGD_TRAD_CODIGO']." As ".$arr['SGD_TRAD_DESCR'].",";
				
		$titu .= "<td class=titulos3 align=center>";	
		$titu .= strtoupper($arr['SGD_TRAD_DESCR']);
		$titu .= "</td>";
		
		$matriz[$i] = strtoupper($arr['SGD_TRAD_DESCR']);
		$i = $i + 1;
	}	
	$cod = substr($cod, 0, strlen($cod)-1);
	$isqlC .= $cod.' from SGD_TPR_TPDCUMENTO '.$whereBusqueda.' order by  '. $sqlSubstDescS;
	
	$rsC=$db->query($isqlC);
   	while(!$rsC->EOF)
	{
		$val .= "<tr class=paginacion>";
		$val .= "<td>".$rsC->fields["CODIGO"]."</td>";
    	$val .= "<td align='left'>".$rsC->fields["TIPOD"]."</td>";
    	$val .= "<td>".$rsC->fields["TERMINO"]."</td>";
    	$conteo = count($matriz);
		for ($j = 0; $j < $conteo; $j++)
		{
			$val .= "<td>".$rsC->fields[$matriz[$j]]."</td>";		
		}		
    	$val .= '<td>'.$rsC->fields["ESTADO"].'</td></tr>';					
    	$rsC->MoveNext();
  	}
}
else $tipos .= "<tr><td align='center'> NO SE HAN GESTIONADO TIPOS DE RADICADOS</td></tr>";
$ADODB_COUNTRECS = false;
?>
<table class=borde_tab width='100%' cellspacing="5">
	<tr>
		<td class=titulos2><center>TIPOS DOCUMENTALES</center></td>
	</tr>
</table>
<table>
	<tr>
		<td></td>
	</tr>
</table>
<br>
<TABLE width="850" class="borde_tab" cellspacing="4">
 <tr class=tpar> 
  <td class=titulos3 align='center'>CODIGO</td>
  <td class=titulos3 align='center'>DESCRIPCION</td>
  <td class=titulos3 align='center''>TERMINO</td>
  <?php
  	echo $titu;   
  ?> 
  <td class=titulos3 align='center'>ESTADO</td>
 </tr>
 <?php  		
 	echo $val;
 ?> 
</table>






<?php
/*

AUN NO ENTIENDO COMO ALGUIEN PUEDE CREAR UNA SENTENCIA ESTATICA DE LA TABLA SGD_TPR_TPDCUMENTO CUANDO ESTA 
SE CREA 'DINAMICAMENTE'. NO COMPARTO ESTE TIPO DE DESARROLLO. HLP.

session_start();
if (!$ruta_raiz) $ruta_raiz= "..";
$sqlFechaDocto =  $db->conn->SQLDate("Y-m-D H:i:s A","mf.sgd_rdf_fech");
$sqlSubstDescS =  $db->conn->substr."(SGD_TPR_DESCRIP, 0, 75)";
$isqlC = 'select 
			  SGD_TPR_CODIGO          AS "CODIGO",
			'. $sqlSubstDescS .  '    AS "TIPOD",
			  SGD_TPR_TERMINO		  as "TERMINO",
			  SGD_TPR_TP2   		  as "ENTRADA",
			  SGD_TPR_TP1   		  as "SALIDA",
			  SGD_TPR_TP3   		  as "MEMORANDO",
			  SGD_TPR_TP5   		  as "RESOLUCION",
			  SGD_TPR_TP9   		  as "PROYECTO" ,
			  SGD_TPR_TP6			  as "CONTRIBUCIONES", 
			  SGD_TPR_ESTADO 	      as "ESTADO" 
			from 
				SGD_TPR_TPDCUMENTO
				'.$whereBusqueda.'
			order by  '. $sqlSubstDescS;
     error_reporting(7);
?>
<table class=borde_tab width='100%' cellspacing="5"><tr><td class=titulos2><center>TIPOS DOCUMENTALES</center></td></tr></table>
<table><tr><td></td></tr></table>
<br>
<TABLE width="850" class="borde_tab" cellspacing="5">
  <tr class=tpar> 
   <td class=titulos3 align=center>CODIGO </td>
   <td class=titulos3 align=center>DESCRIPCION </td>
   <td class=titulos3 align=center>TERMINO </td>
   <td class=titulos3 align=center>ENTRADA </td>
   <td class=titulos3 align=center>SALIDA </td>
   <td class=titulos3 align=center>MEMORANDO </td>
   <td class=titulos3 align=center>RESOLUCION </td>
   <td class=titulos3 align=center>CONTRIBUCIONES </td>
   <td class=titulos3 align=center>PROYECTO </td>
   <td class=titulos3 align=center>ESTADO </td>
  </tr>
  	<?php
	 	$rsC=$db->query($isqlC);
   		while(!$rsC->EOF)
			{
      			$codserie  =$rsC->fields["CODIGO"];
	  			$dtipod   =$rsC->fields["TIPOD"]; 
				$vtermi   =$rsC->fields["TERMINO"];
				$ventrad  =$rsC->fields["ENTRADA"];	
				$vsalida  =$rsC->fields["SALIDA"];				
				$vmemo    =$rsC->fields["MEMORANDO"];				
				$vreso    =$rsC->fields["RESOLUCION"];		
				$vContrib =$rsC->fields["CONTRIBUCIONES"];		
				$vproye   =$rsC->fields["PROYECTO"];				
				$vestado  =$rsC->fields["ESTADO"];				
		?> 
    		  <tr class=paginacion>
				<td> <?=$codserie?></td>
				<td align=left> <?=$dtipod?> </td>
				<td> <?=$vtermi?> </td>
				<td> <?=$ventrad?> </td>
				<td> <?=$vsalida?> </td>
				<td> <?=$vmemo?> </td>
				<td> <?=$vreso?> </td>
				<td> <?=$vContrib?> </td>
				<td> <?=$vproye?> </td>
				<td> <?=$vestado?> </td>
		 	  </tr>
	<?
				$rsC->MoveNext();
  		}
		//<font face="Arial, Helvetica, sans-serif" class="etextomenu">
		 ?>
   </table>
*/
?>