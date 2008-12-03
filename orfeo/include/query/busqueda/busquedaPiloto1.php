<?PHP 

if (!$db->driver){	$db = $this->db; print "Aqui";}	//Esto sirve para cuando se llama este archivo dentro de clases donde no se conoce $db.

switch($db->driver)
{	case 'mssql':
		{	$radi_nume_radi		= " convert(varchar(15), r.radi_nume_radi) ";
			$usua_doc_c			= " convert(varchar(8), c.USUA_DOC) ";
			$radi_nume_salida	= " convert(varchar(15), RADI_NUME_SALIDA) ";
			$radi_nume_sal		= " convert(varchar(15), RADI_NUME_SAL) ";
			$systemDate = $db->conn->sysTimeStamp;
			$redondeo = $db->conn->round("(r.radi_fech_radi+(td.sgd_tpr_termino * 7/5))"."-".$systemDate);
		}break;
	case 'oracle':
		 case 'oci8':
		case 'oci805':
		case 'ocipo':
		{	$radi_nume_radi = " r.RADI_NUME_RADI ";
			$usua_doc_c			= " convert(varchar(8), c.USUA_DOC) ";
			$radi_nume_salida = " RADI_NUME_SALIDA ";
			$radi_nume_sal = " RADI_NUME_SAL ";
			$systemDate = $db->conn->sysTimeStamp;
			$redondeo = "round(((r.RADI_FECH_RADI+(td.SGD_TPR_TERMINO * 7/5))-".$systemDate."))";
		}break;
		// Modificado SGD 06-Septiembre-2007
		// Modificado SGD 12-Septiembre-2007
		//case 'postgresql':
	case 'postgres':
			$radi_nume_radi		= "cast(r.radi_nume_radi as varchar(15)) ";
			$usua_doc_c		= "cast(c.USUA_DOC as varchar(8)) ";
			$radi_nume_salida	= "cast(RADI_NUME_SALIDA as varchar(15)) ";
			$radi_nume_sal		= "cast(RADI_NUME_SAL as varchar(15)) ";
			
			//Modificado idrd			
			$systemDate = $db->conn->sysTimeStamp;			
			$redondeodia = "ROUND( ( ( EXTRACT( DAY FROM r.radi_fech_radi ) + ( td.sgd_tpr_termino * 7/5 ) )"." - EXTRACT( DAY FROM ".$systemDate." ) ) )";
			$redondeomes = "ROUND( ( ( EXTRACT( MONTH FROM r.radi_fech_radi ) ) ) )";
			$redonmesactu= "ROUND( ( ( EXTRACT( MONTH FROM ".$systemDate." ) ) ) )";
			$redondeo="($redondeodia - (($redonmesactu-$redondeomes)*30) )";
			break;
}
?>
