<?
	/**
	  * CONSULTA VERIFICACION PREVIA A LA RADICACION
	  */
	switch($db->driver)
	{  
	 case 'mssql':
			$sqlConcat = $db->conn->Concat("RTRIM(depe_codi)","'-'","depe_nomb");
	break;		
	case 'oracle':
	case 'oci8':
	case 'oci805':	
			$sqlConcat = $db->conn->Concat("depe_codi","'-'","depe_nomb");
	break;		

	//Modificacion Skina
	default:
			$sqlConcat = $db->conn->Concat("depe_codi","'-'","depe_nomb");

	}
?>
