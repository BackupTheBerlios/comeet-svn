<?
$coltp3Esp = '"'.$tip3Nombre[3][2].'"';
$sqlFechaAgenda = $db->conn->SQLDate("Y-m-d H:i A","agen.SGD_AGEN_FECHPLAZO");
$fechahoy = $db->conn->sysTimeStamp;
if($agendado==1)
{
	$whereAgendado = " AND agen.SGD_AGEN_FECHPLAZO>=".$fechahoy."";
}elseif($agendado==2)
{
	$whereAgendado = " AND agen.SGD_AGEN_FECHPLAZO<=".$fechahoy."";
}
else{
	$sqlFechaHoy3=date('Y-m-d');
	$my_time = strtotime ($sqlFechaHoy3); //converts date string to UNIX timestamp
   	$timestam = $my_time +  86400; //calculates # of days passed ($num_days) * # seconds in a day (86400)
	$sqlFechaHoy2 = date("Y-m-d",$timestam);
	//$sqlFechaHoy2=fnc_date_calc($sqlFechaHoy3,1);
	$whereAgendado=" and (agen.SGD_AGEN_FECHPLAZO > '".$sqlFechaHoy3."' and agen.SGD_AGEN_FECHPLAZO <='".$sqlFechaHoy2."')";
}
$isql = 'select
			cast(b.RADI_NUME_RADI as varchar(15)) as "IDT_Numero_Radicado",
			b.RADI_PATH 			as "HID_RADI_PATH",
			'.$sqlFecha.'			as "DAT_Fecha Radicado",
			cast(b.RADI_NUME_RADI as varchar(15)) as "HID_RADI_NUME_RADI",
			'.$sqlFechaAgenda.' 		as "Fecha Plazo Agenda",
			UPPER(agen.SGD_AGEN_OBSERVACION) as Observacion,
			UPPER(b.RADI_ARCH4)  as "Palabra Clave"
			,UPPER(b.RADI_CUENTAI)  as "Cuenta Interna",
			('.$trd.')		as "Serie/Subserie/Tipo Documental",
			(TO_DATE(agen.SGD_AGEN_FECHPLAZO,\'YYYY-MM-DD\')- TO_DATE(CURRENT_TIMESTAMP,\'YYYY-MM-DD\' )) as "Dias Calendario Restantes",
			us.USUA_LOGIN  		as "Agendado Por",
			(select usActu.usua_login from usuario usActu where usActu.usua_codi=b.radi_usua_actu and usActu.depe_codi=b.radi_depe_actu) as "Usuario_Actual"
				,cast(b.RADI_NUME_RADI as varchar(15)) as "CHK_CHKANULAR",
			b.RADI_LEIDO 			as "HID_RADI_LEIDO",
			b.RADI_NUME_HOJA 		as "HID_RADI_NUME_HOJA",
			b.CARP_PER 			as "HID_CARP_PER",
			b.CARP_CODI 			as "HID_CARP_CODI",
			b.SGD_EANU_CODIGO 		as "HID_EANU_CODIGO",
			b.RADI_NUME_DERI 		as "HID_RADI_NUME_DERI",
			b.RADI_TIPO_DERI 		as "HID_RADI_TIPO_DERI"
		from
			radicado b LEFT OUTER JOIN SGD_TPR_TPDCUMENTO c
			ON b.tdoc_codi=c.sgd_tpr_codigo
			left join (SGD_RDF_RETDOCF r 
			left join (SGD_MRD_MATRIRD m
			left join SGD_SRD_SERIESRD sd on sd.sgd_srd_codigo=m.sgd_srd_codigo
			left join SGD_SBRD_SUBSERIERD sbr on sbr.sgd_sbrd_codigo=m.sgd_sbrd_codigo
			and sbr.sgd_srd_codigo=m.sgd_srd_codigo)
			on m.sgd_mrd_codigo=r.sgd_mrd_codigo )
			on r.radi_nume_radi=b.radi_nume_radi
			 , SGD_AGEN_AGENDADOS AGEN, USUARIO us
	 	where
	 			agen.USUA_DOC=us.USUA_DOC
	 			AND b.RADI_NUME_RADI=agen.RADI_NUME_RADI
	 			AND agen.USUA_DOC='.$usua_doc.'
	 			AND agen.SGD_AGEN_ACTIVO=1
				AND b.radi_nume_radi is not null
				'.$whereUsuario.$whereFiltro.$whereAgendado.
				' order by '.$order .' ' .$orderTipo;
?>