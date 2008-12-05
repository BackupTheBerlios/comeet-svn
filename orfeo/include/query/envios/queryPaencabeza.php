<?
	/**
	  * Consulta para paEncabeza.php
	  */
	//MODIFICACION POSTGRES SKINA
	switch($db->driver)
	{
		case 'mssql':
			$conversion = "CONVERT (CHAR(5), depe_codi)"; 		
		break;
		default:
			$conversion = "depe_codi";
	}
?>
