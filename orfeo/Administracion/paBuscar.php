<?
/*************************************************************************************/
/* ORFEO GPL:Sistema de Gestion Documental		http://www.orfeogpl.org	     */
/*	Idea Original de la SUPERINTENDENCIA DE SERVICIOS PUBLICOS DOMICILIARIOS     */
/*				COLOMBIA TEL. (57) (1) 6913005  orfeogpl@gmail.com   */
/* ===========================                                                       */
/*                                                                                   */
/* Este programa es software libre. usted puede redistribuirlo y/o modificarlo       */
/* bajo los terminos de la licencia GNU General Public publicada por                 */
/* la "Free Software Foundation"; Licencia version 2. 			             */
/*                                                                                   */
/* Copyright (c) 2005 por :	  	  	                                     */
/* SSPS "Superintendencia de Servicios Publicos Domiciliarios"                       */
/*   Jairo Hernan Losada  jlosada@gmail.com                Desarrollador             */
/*   Sixto Angel Pinzón López --- angel.pinzon@gmail.com   Desarrollador             */
/* C.R.A.  "COMISION DE REGULACION DE AGUAS Y SANEAMIENTO AMBIENTAL"                 */ 
/*   Liliana Gomez        lgomezv@gmail.com                Desarrolladora            */
/*   Lucia Ojeda          lojedaster@gmail.com             Desarrolladora            */
/* D.N.P. "Departamento Nacional de Planeación"                                      */
/*   Hollman Ladino       hladino@gmail.com                Desarrollador             */
/*                                                                                   */
/* Colocar desde esta lInea las Modificaciones Realizadas Luego de la Version 3.5    */
/*  Nombre Desarrollador   Correo     Fecha   Modificacion                           */
/*  Fabian mauricio losada            23/05/2007 									 */    
/*************************************************************************************/
?>
<table border=0  cellpad=2 cellspacing='0' width=98% class='t_bordeGris' valign='top' align='center' >
	<tr>
	<tr/>
	<tr><td width='100%' >
	<table width="98%" align="center" cellspacing="0" cellpadding="0">
	<tr class="tablas"><td class="etextomenu" >
	<span class="etextomenu">
	<form name=form_busq_rad action='<?=$pagina_actual?>?<?=session_name()."=".session_id()."&krd=$krd" ?>&estado_sal=<?=$estado_sal?>&tpAnulacion=<?=$tpAnulacion?>&estado_sal_max=<?=$estado_sal_max?>&pagina_sig=<?=$pagina_sig?>&dep_sel=<?=$dep_sel?>&nomcarpeta=<?=$nomcarpeta?>' method=post>
	Buscar usuario(s) (Separados por coma)
	<input name="busqRadicados" type="text" size="60" class="tex_area" value="<?=$busqRadicados?>">
	<input type=submit value='Buscar ' name=Buscar valign='middle' class='botones'>
	</span>
	</td></tr>
	<tr class="tablas">
	<td class="etextomenu">
	Activos	<input type="radio" name="esta" value="1" <? if ($esta==1 or $esta==0) echo "checked"; else echo "";?> />
	Inactivos	<input type="radio" name="esta" value="2" <? if ($esta==2) echo "checked"; else echo "";?> />
	<td>
	</tr>
	<?
	if ($busqRadicados) {
		$busqRadicados = trim($busqRadicados);
		$textElements = split (",", $busqRadicados);
		$newText = "";
		$i = 0;
		foreach ($textElements as $item) {
			$item = trim ( $item );
			if ($item) { 
			if ($i != 0) $busq_and = " or "; else $busq_and = " ";
				$busq_radicados_tmp .= " $busq_and $varBuscada like '%$item%' ";
				$i++;
			}
		} //FIN foreach

	$dependencia_busq2 .= " and ($busq_radicados_tmp) ";
	} //FIN if ($busqRadicados)
	if($esta==1 or $esta==0)$depe_esta=" and u.usua_esta=1";
	elseif($esta==2)$depe_esta=" and u.usua_esta=0";
	?>
	</form>
	 
	</table>
	<td/>
  <tr/>
</table>
