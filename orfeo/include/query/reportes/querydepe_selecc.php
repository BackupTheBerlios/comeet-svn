<?
	/**
	  * CONSULTA VERIFICACION PREVIA A LA RADICACION
	  */
	switch($db->driver)
	{  
	 case 'mssql':
			$where_depe = " and ".$db->conn->substr."(convert(char(15),a.radi_nume_sal, 5, 3) in ($lista_depcod)";
	break;		
	case 'oracle':
	case 'oci8':
	case 'oci805':		
			$where_depe = "and ".$db->conn->substr."(a.radi_nume_sal, 5, 3) in ($lista_depcod)";
	break;		
	
	//Modificado skina
	default:
		$where_depe = "and ".$db->conn->substr."(a.radi_nume_sal, 5, 3) in ($lista_depcod)";
	}
?>
