<?

$idToChar =  $db->conn->numToString("fr.SGD_FIRRAD_ID"); 

switch ($db->driver) { 
	case 'oci8':
	case 'oracle':
	
		$query= ' 
				 select  1 as "HID_1",
				 to_char(r.RADI_NUME_RADI) as "IDT_Numero Radicado",
				 r.RADI_PATH as "HID_RADI_PATH",
				 uf.USUA_NOMB as "Fimante",
				  us.USUA_NOMB as "Solicitado Por",
				  fr.SGD_FIRRAD_FECHSOLIC as "Desde", 
				   to_char (r.RADI_NUME_RADI) AS "CHK_SOL_FIRMA"  
		         from usuario uf, usuario us,SGD_FIRRAD_FIRMARADS fr, radicado r
		         where  
		         fr.USUA_DOC = uf.USUA_DOC and
		         fr.SGD_FIRRAD_DOCSOLIC = us.USUA_DOC and
		         r.RADI_NUME_RADI = fr.RADI_NUME_RADI  
		         and fr.USUA_DOC = '."'$usua_doc'  
				 and SGD_FIRRAD_FIRMA is null 
		         ".
		         $whereFiltro;
	break;
	case 'mssql': 
		$query= ' 
				 select  1 as "HID_1",
				  uf.USUA_NOMB as "Fimante",
				  us.USUA_NOMB as "Solicitado Por",
				  fr.SGD_FIRRAD_FECHSOLIC as "Desde", 
				  convert(char(14),fr.SGD_FIRRAD_ID) AS "CHK_SOL_FIRMA"  
		         from usuario uf, usuario us,SGD_FIRRAD_FIRMARADS fr
		         where  
		         fr.USUA_DOC = uf.USUA_DOC and
		         fr.SGD_FIRRAD_DOCSOLIC = us.USUA_DOC '.
		         $filtroSelect;
		break;
	case 'postgres':
	/*
         $query= '
                                 select  1 as "HID_1",
                                  uf.USUA_NOMB as "Fimante",
                                  us.USUA_NOMB as "Solicitado Por",
                                  fr.SGD_FIRRAD_FECHSOLIC as "Desde",
                                  CAST(fr.SGD_FIRRAD_ID AS VARCHAR(14)) AS "CHK_SOL_FIRMA"
                         from usuario uf, usuario us,SGD_FIRRAD_FIRMARADS fr
                         where
                         fr.USUA_DOC = uf.USUA_DOC and
                         fr.SGD_FIRRAD_DOCSOLIC = us.USUA_DOC '.
                         $filtroSelect;
*/

		$query= ' 
				 select  1 as "HID_1",
				 cast(r.RADI_NUME_RADI as VARCHAR(15)) as "IDT_Numero Radicado",
				 r.RADI_PATH as "HID_RADI_PATH",
				 uf.USUA_NOMB as "Firmante",
				  us.USUA_NOMB as "Solicitado Por",
				  fr.SGD_FIRRAD_FECHSOLIC as "Desde", 
				   CAST(r.RADI_NUME_RADI AS VARCHAR(15)) AS "CHK_SOL_FIRMA"  
		         from usuario uf, usuario us,SGD_FIRRAD_FIRMARADS fr, radicado r
		         where  
		         fr.USUA_DOC = uf.USUA_DOC and
		         fr.SGD_FIRRAD_DOCSOLIC = us.USUA_DOC and
		         r.RADI_NUME_RADI = fr.RADI_NUME_RADI  
		         and fr.USUA_DOC = '."'$usua_doc'  
				 and SGD_FIRRAD_FIRMA is null 
		         ".
		         $whereFiltro;
	break;
	}
	
?>
