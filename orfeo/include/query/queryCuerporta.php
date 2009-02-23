<?
//
switch($db->driver)
{	case 'mssql':
	{	
		
		$radi_nume_radi = "convert(varchar(14),a.RADI_NUME_RADI)";
		$tmp_cad1 = "convert(varchar,".$db->conn->concat("'0'","'-'",$radi_nume_radi).")";
		$tmp_cad2 = "convert(varchar,".$db->conn->concat('c.rta_codi',"'-'",$radi_nume_radi).")";
		$redondeo = $db->conn->round($sqlOffset."-".$systemDate);
		$concatenar = "CAST(DEPE_CODI AS VARCHAR(10))";
		$isql = 'select '.$radi_nume_radi.' "IMG_Numero Radicado",
			a.RADI_PATH  "HID_RADI_PATH",
			'.$sqlFecha.'  "DAT_Fecha Radicado",
			'.$radi_nume_radi.' "HID_RADI_NUME_RADI",
			c.rta_desc "Asunto",
			b.sgd_tpr_descrip as "Tipo Documento",
			'.$redondeo.' as "Dias Restantes",
			'.chr(39).chr(39).'  AS "Informador",
			'.$tmp_cad1.' "CHK_checkValue",
			c.INFO_LEIDO as "HID_RADI_LEIDO"
 		from radicado a,
 			sgd_tpr_tpdcumento b,
 			informados c,
 			usuario d
		where a.radi_nume_radi=c.radi_nume_radi and a.tdoc_codi=b.sgd_tpr_codigo
			and a.radi_usua_actu=d.usua_codi and a.radi_depe_actu=d.depe_codi
			and c.depe_codi='.$dependencia.' and c.usua_codi='.$codusuario.' '.$where_filtro .'
			and c.info_codi is null
		UNION
		select '.$radi_nume_radi.' "IMG_Numero Radicado",
			a.RADI_PATH  "HID_RADI_PATH",
			'.$sqlFecha.'  "DAT_Fecha Radicado",
			'.$radi_nume_radi.' "HID_RADI_NUME_RADI",
			c.info_desc "Asunto",
			b.sgd_tpr_descrip as "Tipo Documento",
			'.$redondeo.' as "Dias Restantes",
			d2.usua_nomb  AS "Informador",
			'.$tmp_cad2.' "CHK_checkValue",
			c.RTA_LEIDO as "HID_RADI_LEIDO"
 		from radicado a,
 			sgd_tpr_tpdcumento b,
 			informados c,
 			usuario d, usuario d2
		where a.radi_nume_radi=c.radi_nume_radi and a.tdoc_codi=b.sgd_tpr_codigo
			and a.radi_usua_actu=d.usua_codi and a.radi_depe_actu=d.depe_codi
			and c.depe_codi='.$dependencia.' and c.usua_codi='.$codusuario.' '.$where_filtro .'
			and c.info_codi is not null and d2.usua_doc = c.rta_codi
		order by '.$order.' '.$orderTipo;		
	}break;
	case 'oracle':
	case 'oci8':
	// Modificado SGD 21-Septiembre-2007
	// Modificado IDRD Noviembre 13
	case 'postgres':
	{ 	$radi_nume_radi = "cast(a.RADI_NUME_RADI as varchar(14))";
		$tmp_cad1 = "cast( ".$db->conn->concat("'0'","'-'",$radi_nume_radi)." as varchar(20) )";
		$tmp_cad2 = "cast( ".$db->conn->concat("c.rta_codi","'-'",$radi_nume_radi)." as varchar(50) )";
		//$redondeo = round($sqlOffset."-".$systemDate);
		//$tmp_cad2 = "to_char(".$db->conn->concat('c.info_codi',"'-'",$radi_nume_radi).")";
		//$redondeo = $db->conn->round($sqlOffset."-".$systemDate);
		$concatenar = "CAST(DEPE_CODI AS VARCHAR(10))";
			
				//Modificado idrd para redondeo Marzo 11	
			$systemDate  = $db->conn->sysTimeStamp;
                        $redondeodia = "ROUND( ( ( EXTRACT( DAY FROM a.radi_fech_radi ) + ( b.sgd_tpr_termino * 7/5 ) )"." - EXTRACT( DAY FROM ".$systemDate." ) ) )";
                        $redondeomes = "ROUND( ( ( EXTRACT( MONTH FROM a.radi_fech_radi ) ) ) )";
                        $redonmesactu= "ROUND( ( ( EXTRACT( MONTH FROM ".$systemDate." ) ) ) )";
                        $redondeo="($redondeodia - (($redonmesactu-$redondeomes)*30) )";

		$isql = '
			select '.$radi_nume_radi.' 	AS "IMG_Numero Radicado",
			a.RADI_PATH 		AS "HID_RADI_PATH",
			'.$sqlFecha.'		AS "DAT_Fecha Radicado",
			'.$radi_nume_radi.' 	AS "HID_RADI_NUME_RADI",
			c.rta_desc 		AS "Asunto"
			,UPPER(a.RADI_ARCH4)  as "Palabra Clave"
			,UPPER(a.RADI_CUENTAI)  as "Cuenta Interna",
			('.$trd.') as "Serie/Subserie/Tipo Documental",
			ag.sgd_agen_fechplazo 	as "Fecha Agendado",
			d2.usua_nomb  		AS "Informador",
			'.$tmp_cad2.' 		AS "CHK_checkValue",
			c.RTA_LEIDO 		AS "HID_RADI_LEIDO"
 			from 	sgd_tpr_tpdcumento b,
 			rta_compartida c,
 			usuario d, usuario d2
			radicado a
			left join (SGD_RDF_RETDOCF r 
			left join (SGD_MRD_MATRIRD m
			left join SGD_SRD_SERIESRD sd on sd.sgd_srd_codigo=m.sgd_srd_codigo
			left join SGD_SBRD_SUBSERIERD sbr on sbr.sgd_sbrd_codigo=m.sgd_sbrd_codigo
			and sbr.sgd_srd_codigo=m.sgd_srd_codigo)
			on m.sgd_mrd_codigo=r.sgd_mrd_codigo )
			on r.radi_nume_radi=a.radi_nume_radi
			left join sgd_agen_agendados ag on ag.radi_nume_radi=a.radi_nume_radi
			where a.radi_nume_radi=c.radi_nume_radi and a.tdoc_codi=b.sgd_tpr_codigo
			and a.radi_usua_actu=d.usua_codi and a.radi_depe_actu=d.depe_codi
			and c.depe_codi='.$dependencia.' and c.usua_codi='.$codusuario.' '.$where_filtro .'
			and d2.usua_doc (+) = c.rta_codi 
			order by '.$order.' '.$orderTipo;		
	}break;
}

$isql = 'select '.$radi_nume_radi.' 		AS "IMG_Numero Radicado",
			a.RADI_PATH 		AS "HID_RADI_PATH",
			'.$sqlFecha.' 		AS "DAT_Fecha Radicado",
			'.$radi_nume_radi.' 	AS "HID_RADI_NUME_RADI",
			c.rta_desc 		AS "Asunto"
			,UPPER(a.RADI_ARCH4)  as "Palabra Clave"
			,UPPER(a.RADI_CUENTAI)  as "Cuenta Interna",
			('.$trd.') as "Serie/Subserie/Tipo Documental",
			ag.sgd_agen_fechplazo 	as "Fecha Agendado",
			'.chr(39).chr(39).'  	AS "Asignador",
			'.$tmp_cad1.' 		AS "CHK_checkValue",
			c.RTA_LEIDO 		as "HID_RADI_LEIDO"
 		from    sgd_tpr_tpdcumento b,
 			rta_compartida c,
 			usuario d,
			radicado a
			left join (SGD_RDF_RETDOCF r 
			left join (SGD_MRD_MATRIRD m
			left join SGD_SRD_SERIESRD sd on sd.sgd_srd_codigo=m.sgd_srd_codigo
			left join SGD_SBRD_SUBSERIERD sbr on sbr.sgd_sbrd_codigo=m.sgd_sbrd_codigo
			and sbr.sgd_srd_codigo=m.sgd_srd_codigo)
			on m.sgd_mrd_codigo=r.sgd_mrd_codigo )
			on r.radi_nume_radi=a.radi_nume_radi
			left join sgd_agen_agendados ag on ag.radi_nume_radi=a.radi_nume_radi
		where a.radi_nume_radi=c.radi_nume_radi and a.tdoc_codi=b.sgd_tpr_codigo
			and a.radi_usua_actu=d.usua_codi and a.radi_depe_actu=d.depe_codi
			and c.depe_codi='.$dependencia.' and c.usua_codi='.$codusuario.' '.$where_filtro .'
			and c.rta_codi is null
		UNION
	select '.$radi_nume_radi.' AS "IMG_Numero Radicado",
			a.RADI_PATH AS "HID_RADI_PATH",
			'.$sqlFecha.' AS "DAT_Fecha Radicado",
			'.$radi_nume_radi.' AS "HID_RADI_NUME_RADI",
			c.rta_desc AS "Asunto"
			,UPPER(a.RADI_ARCH4)  as "Palabra Clave"
			,UPPER(a.RADI_CUENTAI)  as "Cuenta Interna",
			('.$trd.') as "Serie/Subserie/Tipo Documental",
			ag.sgd_agen_fechplazo 	as "Fecha Agendado",
			d2.usua_nomb  AS "Asignador",
			'.$tmp_cad2.' AS "CHK_checkValue",
			c.rta_LEIDO as "HID_RADI_LEIDO"
 		from    sgd_tpr_tpdcumento b,
 			rta_compartida c,
 			usuario d, usuario d2,
			radicado a
			left join (SGD_RDF_RETDOCF r 
			left join (SGD_MRD_MATRIRD m
			left join SGD_SRD_SERIESRD sd on sd.sgd_srd_codigo=m.sgd_srd_codigo
			left join SGD_SBRD_SUBSERIERD sbr on sbr.sgd_sbrd_codigo=m.sgd_sbrd_codigo
			and sbr.sgd_srd_codigo=m.sgd_srd_codigo)
			on m.sgd_mrd_codigo=r.sgd_mrd_codigo )
			on r.radi_nume_radi=a.radi_nume_radi
			left join sgd_agen_agendados ag on ag.radi_nume_radi=a.radi_nume_radi
		where a.radi_nume_radi=c.radi_nume_radi and a.tdoc_codi=b.sgd_tpr_codigo
			and a.radi_usua_actu=d.usua_codi and a.radi_depe_actu=d.depe_codi
			and c.depe_codi='.$dependencia.' and c.usua_codi='.$codusuario.' '.$where_filtro .'
			and c.rta_codi is not null and d2.usua_doc = c.rta_codi
		order by '.$order.' '.$orderTipo;		
?>
