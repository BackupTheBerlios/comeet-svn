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
/* Copyright (c) 2007 por :	  	  	                                     */
/* SSPS "Superintendencia de Servicios Publicos Domiciliarios"                       */
/*   Jairo Hernan Losada  jlosada@gmail.com                Desarrollador             */
/*   Johnny gonzales      jgonzal@superservicios.gov.co                              */
/* C.R.A.  "COMISION DE REGULACION DE AGUAS Y SANEAMIENTO AMBIENTAL"                 */
/*   Liliana Gomez        lgomezv@gmail.com                Desarrolladora            */
/*   Lucia Ojeda          lojedaster@gmail.com             Desarrolladora            */
/* D.N.P. "Departamento Nacional de PlaneaciÃ³n"                                     */
/*   Cmauricio Parra      Desarrollador   */
/* IYU                                                                               */
/*   Hollman Ladino       hollmanlp@gmail.com                Desarrollador           */
/*                                                                                   */
/* Colocar desde esta lInea las Modificaciones Realizadas                            */
/*  Nombre Desarrollador   Correo     Fecha   Modificacion                           */
/*************************************************************************************/
	include_once ("$ruta_raiz/include/db/ConnectionHandler.php");
	include ("$ruta_raiz/config.php");
	include("$ruta_raiz/autenticaLDAP.php");
	$db = new ConnectionHandler("$ruta_raiz");
        $db->conn->debug = false;
	$db->conn->SetFetchMode(ADODB_FETCH_NUM);
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	if (!defined('ADODB_ASSOC_CASE')) define('ADODB_ASSOC_CASE', 1);
	$krd = strtoupper($krd);
	$fechah = date("Ymd") . "_". time("hms");
	$check = 1;
	$numeroa = 0;
	$numero  = 0;
	$numeros = 0;
	$numerot = 0;
	$numerop = 0;
	$numeroh = 0;
	$ValidacionKrd = "";
	
	$queryDep = "SELECT DEPE_CODI FROM usuario WHERE USUA_LOGIN ='$krd'";
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	$rs = $db->query($queryDep);
	$dependencia = $rs->fields['DEPE_CODI'];

	$query = "SELECT a.SGD_TRAD_CODIGO,
				a.SGD_TRAD_DESCR,
				a.SGD_TRAD_ICONO
			FROM SGD_TRAD_TIPORAD a
			ORDER BY a.SGD_TRAD_CODIGO";
	
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	//$db->conn->debug = true;
	$rs = $db->query($query);
	//$numRegs = "! ".$rs->RecordCount();
	$varQuery = $query;
	$comentarioDev = ' Busca todos los tipos de Radicado Existentes ';
	//include "$ruta_raiz/include/tx/ComentarioTx.php";
	$iTpRad = 0;
	$queryTip3 = "";
	$tpNumRad = array();
	$tpDescRad = array();
	$tpImgRad = array();
	
	while(!$rs->EOF) {
		$numTp = $rs->fields["SGD_TRAD_CODIGO"];
		$sqlCarpDep = "SELECT SGD_CARP_DESCR
				FROM SGD_CARP_DESCRIPCION
				WHERE SGD_CARP_DEPECODI = $dependencia AND
				SGD_CARP_TIPORAD = $numTp";

		$rsCarpDesc = $db->query($sqlCarpDep);
		$descripcionCarpeta =  $rsCarpDesc->fields["SGD_CARP_DESCR"];
		
		if ( $descripcionCarpeta ) {
			$descTp = $descripcionCarpeta;
		} else {
			$descTp = $rs->fields["SGD_TRAD_DESCR"];
		}
		
		$imgTp = $rs->fields["SGD_TRAD_ICONO"];
		$queryTRad .= ",a.USUA_PRAD_TP$numTp";
		$queryDepeRad .= ",b.DEPE_RAD_TP$numTp";
		$queryTip3 .= ",a.SGD_TPR_TP$numTp";
		$tpNumRad[$iTpRad]=$numTp;
		$tpDescRad[$iTpRad]=$descTp;
		$tpImgRad[$iTpRad]=$imgTp;
		$iTpRad++;
		$rs->MoveNext();
	}
	/**
	 * BUSQUEDA DE ICONOS Y NOMBRES PARA LOS TERCEROS (Remitentes/Destinarios) AL RADICAR
	 * @param	$tip3[][][]  Array  Contiene los tipos de radicacion existentes.  
	 * En la primera dimencion indica la posicion dependiendo del tipo de rad. 
	 * (ej. salida -> 1, ...). En la segunda dimencion almacenara los datos de nombre del tipo de rad. inidicado, 
	 * Para la tercera dimencion indicara la descripcion del tercero y en la cuarta dim. 
	 * contiene el nombre del archio imagen del tipo de tercero. 
	 **/
	
	$query = "SELECT a.SGD_DIR_TIPO,
    			a.SGD_TIP3_CODIGO,
			a.SGD_TIP3_NOMBRE,
			a.SGD_TIP3_DESC,
			a.SGD_TIP3_IMGPESTANA
			$queryTip3
		FROM SGD_TIP3_TIPOTERCERO a";
	
	$rs = $db->query($query);
	while(!$rs->EOF) {
		$dirTipo = $rs->fields["SGD_DIR_TIPO"];
		$nombTip3 = $rs->fields["SGD_TIP3_NOMBRE"];
		$descTip3 = $rs->fields["SGD_TIP3_DESC"];
		$imgTip3 = $rs->fields["SGD_TIP3_IMGPESTANA"];
		for($iTp=0;$iTp<$iTpRad;$iTp++) {
			$numTp =  $tpNumRad[$iTp];
			$campoTip3 = "SGD_TPR_TP$numTp";
			$numTpExiste = $rs->fields[$campoTip3];
			if($numTpExiste>=1) {
				$tip3Nombre[$dirTipo][$numTp] = $nombTip3;
				$tip3desc[$dirTipo][$numTp] = $descTip3;
				$tip3img[$dirTipo][$numTp] = $imgTip3;
				//echo "<hr> $ tip3img[$dirTipo][$numTp] =". $tip3img[$dirTipo][$numTp] ."<hr>";
			}
		}
		$rs->MoveNext();
	}
	
	if($recOrfeo=="Seguridad") {
		$queryRec = "AND USUA_SESION='".str_replace(".","o",$REMOTE_ADDR)."o$krd' ";
	} else {
		//Consulta rapida para saber si el usuario se autentica por LDAP o por DB
		$myQuery = "SELECT USUA_AUTH_LDAP from usuario where USUA_LOGIN ='$krd'";
		$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
		$rs = $db->query($myQuery);
		$autenticaPorLDAP = $rs->fields['USUA_AUTH_LDAP'];
		
		if($autenticaPorLDAP == 0){
			$queryRec = "AND (USUA_PASW ='". SUBSTR(md5($drd),1,26) ."' or USUA_NUEVO=0)";	
                        //echo "CLAVE: " . SUBSTR(md5($drd),1,26);
		} else {
			$queryRec = '';
		}	
	}

	//Analiza la opcion de que se trate de un requerimieento de sesiÃ³n desde una mÃ¡quina segura
	if ( $REMOTE_ADDR==$host_log_seguro ) {
		$REMOTE_ADDR=$ipseguro;
		$queryRec = "";
		$swSessSegura =1;
	}

	$query = "SELECT a.*,
				b.DEPE_NOMB,
				a.USUA_ESTA,
				a.USUA_CODI,
				a.USUA_LOGIN,
				b.DEPE_CODI_TERRITORIAL,
				b.DEPE_CODI_PADRE,
				a.USUA_PERM_ENVIOS,
				a.USUA_PERM_MODIFICA,
				a.USUA_PERM_EXPEDIENTE,
				a.USUA_EMAIL,
				a.USUA_AUTH_LDAP
				$queryTRad
				$queryDepeRad
			FROM USUARIO a,
				DEPENDENCIA b
			WHERE USUA_LOGIN ='$krd' AND 
				a.depe_codi=b.depe_codi
				$queryRec";
	
	/** Procedimiento forech que encuentra los numeros de secuencia para las radiciones
	*	 @param tpDepeRad[]	array 	Muestra las dependencias que contienen las secuencias para radicion.
	*/

	$varQuery = $query;
	$comentarioDev = ' Busca Permisos de Usuarios ...';
	//include "$ruta_raiz/include/tx/ComentarioTx.php";
	$db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
	$rs = $db->query($query);
		
	//Si no se autentica por LDAP segun los permisos de DB
	if (!$autenticaPorLDAP) {
	 	if(trim($rs->fields["USUA_LOGIN"])==$krd){ 
		 	$validacionUsuario = '';
		} else { //Password no concuerda con el de la DB, luego no puede ingresar
			$mensajeError = "USUARIO O CONTRASE&Ntilde;A INCORRECTOS";
			$validacionUsuario = 'No Pasa Validacion Base de Datos';
		}
	} else {//El usuario tiene Validación por LDAP
		$correoUsuario = $rs->fields['USUA_EMAIL'];
		//Verificamos que tenga correo en la DB, si no tiene no se puede validar por LDAP
		if ( $correoUsuario == '' ) { //No tiene correo, entonces error LDAP
		 	$validacionUsuario = 'No Tiene Correo';
	 		$mensajeError = "EL USUARIO NO TIENE CORREO ELECTR&Oacute;NICO REGISTRADO";
	 	} else { //Tiene correo, luego lo verificamos por LDAP
	 		$validacionUsuario = checkldapuser( $correoUsuario, $drd, $ldapServer );
	 		$mensajeError = $validacionUsuario;
	 	}
	}
		
	if ( !$validacionUsuario ) {
		 /*if($rs->fields["USUA_ENCUESTA"]!="1"){
		 	echo"
                                                <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
                                                                        \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
                                                <html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\" xml:lang=\"en\">
                                                <head>
                                                <title>Encuesta</title>
                                                </head>
                                                <body>
                                                <form method=\"post\" id=\"encuesta\" action=\"http://www.superservicios.gov.co/encuesta/cedula.jsp\">
                                                <input type=\"hidden\" name=\"cc\" id=\"cc\" value=\"".$rs->fields['USUA_DOC']."\" />
                                                <input type=\"hidden\" name=\"url\" id=\"url\" value=\"".( $HTTP_HOST.$PHP_SELF)."\" />
                                                </form>
                                                <script type=\"text/javascript\"> 
                                                        document.getElementById('encuesta').submit();
                                                </script>
i                                               </body>
                        i                       </html>";
                                        }*/
		
		$perm_radi_salida_tp = 0;
		foreach ($tpNumRad as $key => $valueTp) {
			$campo  = "DEPE_RAD_TP$valueTp";
			$campoPer  = "USUA_PRAD_TP$valueTp";
			$tpDepeRad[$valueTp] = $rs->fields[$campo];
			$tpPerRad[$valueTp] = $rs->fields[$campoPer];
			if($tpPerRad[$valueTp]>=1) {
				$perm_radi_salida_tp = 1;
			}
			$tpDependencias .= "<".$rs->fields[$campo].">";
		}

		//die("<hr>$queryTRad , $queryDepeRad <hr>$tpDependencias<hr>");
		//include "$ruta_raiz/include/tx/ComentarioTx.php";
		if (trim($rs->fields["USUA_LOGIN"])==$krd) {
			if (trim($rs->fields["USUA_ESTA"])==1) {
				$fechah = date("dmy") . "_" . time("hms");
				$dependencia=$rs->fields["DEPE_CODI"];
				$dependencianomb=$rs->fields["DEPE_NOMB"];
				$codusuario =$rs->fields["USUA_CODI"];
				$usua_doc =$rs->fields["USUA_DOC"];
				$usua_nomb =$rs->fields["USUA_NOMB"];
				$usua_piso =$rs->fields["USUA_PISO"];
				$usua_nacim =$rs->fields["USUA_NACIM"];
				$usua_ext =$rs->fields["USUA_EXT"];
				$usua_at =$rs->fields["USUA_AT"];
				$usua_nuevo = $rs->fields["USUA_NUEVO"];
				$usua_email =$rs->fields["USUA_EMAIL"];
				$nombusuario =$rs->fields["USUA_NOMB"];
				$contraxx=$rs->fields["USUA_PASW"];
				$depe_nomb=$rs->fields["DEPE_NOMB"];
				$crea_plantilla=$rs->fields["USUA_ADM_PLANTILLA"];
				$usua_admin_archivo = $rs->fields["USUA_ADMIN_ARCHIVO"];
				$usua_perm_trd      = $rs->fields["USUA_PERM_TRD"];
				$usua_perm_estadistica = $rs->fields["SGD_PERM_ESTADISTICA"];
				$usua_admin_sistema = $rs->fields["USUA_ADMIN_SISTEMA"];
				$perm_radi = $rs->fields["PERM_RADI"];
				//$perm_radi_sal = $rs->fields["PERM_RADI_SAL"];
				// 1 asignar radicado, 2 carpeta Impresion, 3 uno y 2.
				$usua_perm_impresion = $rs->fields["USUA_PERM_IMPRESION"];
				$perm_tipif_anexo = $rs->fields["PERM_TIPIF_ANEXO"];
				$perm_borrar_anexo = $rs->fields["PERM_BORRAR_ANEXO"];

				if($usua_perm_impresion==1) {
					if($perm_radi_salida_tp>=1) $perm_radi_sal = 3; else $perm_radi_sal = 1;
				} else {
					if($perm_radi_salida_tp>=1) $perm_radi_sal = 1;
				}
				$usua_masiva = $rs->fields["USUA_MASIVA"];
				$depe_codi_padre = $rs->fields["DEPE_CODI_PADRE"];
				$usua_perm_numera_res = $rs->fields["USUA_PERM_NUMERA_RES"];
				$depe_codi_territorial = $rs->fields["DEPE_CODI_TERRITORIAL"];
				$usua_perm_dev = $rs->fields["USUA_PERM_DEV"];
				$usua_perm_anu = $rs->fields["SGD_PANU_CODI"];
				$usua_perm_envios= $rs->fields["USUA_PERM_ENVIOS"];
				$usua_perm_modifica = $rs->fields["USUA_PERM_MODIFICA"];
				$usuario_reasignacion = $rs->fields["USUARIO_REASIGNAR"];
				$usua_perm_sancionad = $rs->fields["USUA_PERM_SANCIONADOS"];
				$usua_perm_intergapps =  $rs->fields["USUA_PERM_INTERGAPPS"];
				$usua_perm_firma  = $rs->fields["USUA_PERM_FIRMA"];
				$usua_perm_prestamo = $rs->fields["USUA_PERM_PRESTAMO"];
				$usua_perm_notifica = $rs->fields["USUA_PERM_NOTIFICA"];
				$usuaPermExpediente = $rs->fields["USUA_PERM_EXPEDIENTE"];
				
				//Traemos el campo que indica si el usuario puede utilizar el administrador de flujos o no
				$usua_perm_adminflujos =  $rs->fields["USUA_PERM_ADMINFLUJOS"];
				$mostrar_opc_envio = 0;
				//if($drd){$drde=md5($drd);}
				/** cerrar session */
				$nivelus = $rs->fields["CODI_NIVEL"];
				
				$isql = "select b.MUNI_NOMB from dependencia a,municipio b
						where a.muni_codi=b.muni_codi
							and a.dpto_codi=b.dpto_codi
							and a.muni_codi=b.muni_codi
							and a.depe_codi='$dependencia'";
				$rs = $db->query($isql);
				$depe_municipio= $rs->fields["MUNI_NOMB"];
				/**
				 *   Consulta que a?ade los nombres y codigos de carpetas del Usuario
				 **/

				$isql = "SELECT CARP_CODI, CARP_DESC FROM carpeta";
				$rs = $db->query($isql);
				//$rs = $db->query($query);
				$iC = 0;
				while(!$rs->EOF) {
					$iC = $rs->fields["CARP_CODI"];
					$descCarpetasGen[$iC] = $rs->fields["CARP_DESC"];
					$rs->MoveNext();
				}
				$isql = "SELECT CODI_CARP, DESC_CARP 
						FROM carpeta_per
						WHERE usua_codi=$codusuario AND
						depe_codi = $dependencia";
				$rs = $db->query($isql);
				//$rs = $db->query($query);
				$iC = 0;
				while(!$rs->EOF) {
					$iC = $rs->fields["CODI_CARP"];
					$descCarpetasPer[$iC] = $rs->fields["DESC_CARP"];
					$rs->MoveNext();
				}
				
				//Busca si el usuario puede integrar aplicativos
				$sqlIntegraApp = "SELECT a.SGD_APLI_DESCRIP,
							a.SGD_APLI_CODI,
							u.SGD_APLUS_PRIORIDAD 
						FROM SGD_APLI_APLINTEGRA a,
							SGD_APLUS_PLICUSUA  u
						WHERE u.USUA_DOC = '$usua_doc' AND 
							a.SGD_APLI_CODI <> 0 AND
							a.SGD_APLI_CODI =  u.SGD_APLI_CODI";
				
				$rsIntegra = $db->conn->query($sqlIntegraApp);
				
				if ($rsIntegra && !$rsIntegra->EOF)
					$usua_perm_intergapps=1;
		
				// Fin Consulta de carpetas
				/*	Creada por HLP.											*
				 *	Query para construir $cod_local. La cual contiene ID_CONTinente+ID_PAIS+id_dpto+id_mncpio.	*
				 *	Si $cod_local=0, significa que NO hay un municipio como local. ORFEO DEBE TENER localidad.	*
				 */
				$ADODB_COUNTRECS = true;
			
				$isql = "SELECT d.ID_CONT,
						d.ID_PAIS,
						d.DPTO_CODI,
						d.MUNI_CODI,
						m.MUNI_NOMB
					FROM dependencia d,
						municipio m
					WHERE d.ID_CONT = m.ID_CONT AND
						d.ID_PAIS = m.ID_PAIS AND
						d.DPTO_CODI = m.DPTO_CODI AND
						d.MUNI_CODI = m.MUNI_CODI AND
						d.DEPE_CODI = $dependencia";
				
				$rs_cod_local = $db->query("$isql");
				$ADODB_COUNTRECS = false;
			
				if ($rs_cod_local && !$rs_cod_local->EOF) {	//$ADODB_COUNTRECS
					$cod_local= $rs_cod_local->fields['ID_CONT'] . "-" . 
							str_pad($rs_cod_local->fields['ID_PAIS'],3,0,STR_PAD_LEFT) . "-" .
							str_pad($rs_cod_local->fields['DPTO_CODI'],3,0,STR_PAD_LEFT) . "-" . 
							str_pad($rs_cod_local->fields['MUNI_CODI'],3,0,STR_PAD_LEFT);
					$depe_municipio= $rs_cod_local->fields["MUNI_NOMB"];
					$rs_cod_local->Close();
				} else {
					$cod_local = 0;
					$depe_municipio = "CONFIGURAR EN SESSION_ORFEO.PHP";
	        		}
				
				$recOrfeoOld = $recOrfeo;
				session_id(str_replace(".","o",$_SERVER['REMOTE_ADDR'])."o$krd");
				session_start();
				$recOrfeo = $recOrfeoOld;
				//session_id(str_replace(".","o",$REMOTE_ADDR)."o$krd");
				$fechah = date("Ymd"). "_". time("hms");
				$carpeta = 0;
				$dirOrfeo = str_replace("login.php","",$PHP_SELF);
				$_SESSION["entidad"] = $entidad;
                                				
				if ($archivado_requiere_exp)
					$_SESSION["archivado_requiere_exp"] = true;
				
				$_SESSION["dirOrfeo"] = $dirOrfeo;
				$_SESSION["drde"] = $contraxx;
				$_SESSION["usua_doc"] = trim($usua_doc);
				$_SESSION["dependencia"] = $dependencia;
				$_SESSION["codusuario"] = $codusuario;
				$_SESSION["depe_nomb"] = $depe_nomb;
				$_SESSION["cod_local"] = $cod_local;
				$_SESSION["depe_municipio"] = $depe_municipio;
				$_SESSION["usua_doc"] = $usua_doc;
				$_SESSION["usua_email"] = $usua_email;
				$_SESSION["usua_at"] = $usua_at;
				$_SESSION["usua_ext"] = $usua_ext;
				$_SESSION["usua_piso"] = $usua_piso;
				$_SESSION["usua_nacim"] = $usua_nacim;
				$_SESSION["usua_nomb"] = $usua_nomb;
				$_SESSION["usua_nuevo"] = $usua_nuevo;
				$_SESSION["usua_admin_archivo"] = $usua_admin_archivo;
				$_SESSION["usua_masiva"] = $usua_masiva;
				$_SESSION["usua_perm_dev"] = $usua_perm_dev;
				$_SESSION["usua_perm_anu"] = $usua_perm_anu;
				$_SESSION["usua_perm_numera_res"] = $usua_perm_numera_res;
				$_SESSION["perm_radi_sal"] = $perm_radi_sal;
				$_SESSION["depecodi"] = $dependencia;
				$_SESSION["fechah"] = $fechah;
				$_SESSION["crea_plantilla"] = $crea_plantilla;
				$_SESSION["verrad"] = 0;
				$_SESSION["menu_ver"] = 3;
				$_SESSION["depe_codi_padre"] = $depe_codi_padre;
				$_SESSION["depe_codi_territorial"] = $depe_codi_territorial;
				$_SESSION["nivelus"] = $nivelus;
				$_SESSION["tpNumRad"] = $tpNumRad;
				$_SESSION["tpDescRad"] = $tpDescRad;
				$_SESSION["tpImgRad"] = $tpImgRad;
				$_SESSION["tpDepeRad"] = $tpDepeRad;
				$_SESSION["tpPerRad"] = $tpPerRad;
				$_SESSION["usua_perm_envios"] = $usua_perm_envios;
				$_SESSION["usua_perm_modifica"] = $usua_perm_modifica;
				$_SESSION["usuario_reasignacion"] = $usuario_reasignacion;
				$_SESSION["descCarpetasGen"] = $descCarpetasGen;
				$_SESSION["tip3Nombre"] = $tip3Nombre;
				$_SESSION["tip3desc"] = $tip3desc;
				$_SESSION["tip3img"] = $tip3img;
				$_SESSION["usua_admin_sistema"] = $usua_admin_sistema;
				$_SESSION["perm_radi"] = $perm_radi;
				$_SESSION["usua_perm_sancionad"] = $usua_perm_sancionad;
				$_SESSION["usua_perm_impresion"] = $usua_perm_impresion;
				$_SESSION["usua_perm_intergapps"] = $usua_perm_intergapps;
				$_SESSION["usua_perm_estadistica"] = $usua_perm_estadistica;
				$_SESSION["usua_perm_trd"] = $usua_perm_trd;
				$_SESSION["usua_perm_firma"] = $usua_perm_firma;
				$_SESSION["usua_perm_prestamo"] = $usua_perm_prestamo;
				$_SESSION["usua_perm_notifica"] = $usua_perm_notifica;
				$_SESSION["usuaPermExpediente"] = $usuaPermExpediente;
				$_SESSION["perm_tipif_anexo"] = $perm_tipif_anexo;
				$_SESSION["perm_borrar_anexo"] = $perm_borrar_anexo;
				$_SESSION["autentica_por_LDAP"] = $autenticaPorLDAP;
	  /**
          *  En esta seccion se incluyen las Variables locales del sistema
          **/
                         include "$ruta_raiz/include/local/varSession.php";
                         // Fin Inclusion Variables Locales del Sistemas

				if( $archivado_requiere_exp ){
					$_SESSION["archivado_requiere_exp"] = $archivado_requiere_exp;
				}
				
				//Se pone el permiso de administración de flujos en la sesion para su posterior consulta
				$_SESSION["usua_perm_adminflujos"] = $usua_perm_adminflujos;
				$_SESSION["krd"] = $krd;		
				
				//$_SESSION["mostrar_opc_envio"]=$mostrar_opc_envio;
				$nomcarpera = "ENTRADA";
				if(!$orno) $orno = 0;
				$sysdateORFEO = date('Y-m-d');
				$query = "update usuario set usua_sesion='" . 
						substr(session_id(),0,29) . 
						"',usua_fech_sesion='$sysdateORFEO' where  USUA_LOGIN ='$krd' ";
				

				$recordSet["USUA_SESION"] = " '".session_id()."' ";
				$recordSet["USUA_FECH_SESION"] = $db->conn->OffsetDate(0,$db->conn->sysTimeStamp);
				$recordWhere["USUA_LOGIN"] = "'$krd'";
				$db->update("USUARIO", $recordSet,$recordWhere);
				$ValidacionKrd = "Si";
			} else {
				$ValidacionKrd="Errado .... jejejejejejejej";
				if($recOrfeo=="loginWeb") {
				?>
				<script language="JavaScript" type="text/JavaScript">
					alert("EL USUARIO <?=$krd?> ESTA INACTIVO \n por favor consulte con el administrador del sistema");
				</script>
				<?
				}
				else die (include "$ruta_raiz/paginaError.php");
			}
		} else {
			if($recOrfeo=="loginWeb") {
			?>
			<script language="JavaScript" type="text/JavaScript">
				alert("USUARIO O PASSWORD INCORRECTOS \n INTENTE DE NUEVO");
			</script>
			<?
			} else {
				$ValidacionKrd="Errado .... jejejejejejejej";
				if($recOrfeo=="Seguridad") die (include "$ruta_raiz/paginaError.php");
				?>
		<BR>
		<B>
			<CENTER>
				<font face="Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">U
					SUARIO O CONTRASE&Ntilde;A INCORRECTOS<BR><BR>INTENTE DE NUEVO
				</font>
			</CENTER>
		</B>
				<?
			}
		}
	} else {
		if($recOrfeo=="loginWeb") {
		?>
		<script language="JavaScript" type="text/JavaScript">
		alert("USUARIO O PASSWORD INCORRECTOS \n INTENTE DE NUEVO");
		</SCRIPT>
		<?
		} else {
			$ValidacionKrd="Errado .... jejejejejejejej";
			if($recOrfeo=="Seguridad") die (include "$ruta_raiz/paginaError.php");
			if (!$autenticaPorLDAP) {
			?>
		<BR>
  			<B><CENTER><font face='Arial, Helvetica, sans-serif' size='2' color='#000000'>FALLA VERIFICACI&Oacute;N CON BASE DE DATOS
  			<BR><BR><?=$mensajeError?>
  			<BR><BR>INTENTE DE NUEVO</font></CENTER></B>
			<?
			} else {
			?>
		<BR>
  			<B><CENTER><font face='Arial, Helvetica, sans-serif' size='2' color='#000000'>FALLA VERIFICACI&Oacute;N LDAP
  			<BR><BR><?=$mensajeError?>
  			<BR><BR>INTENTE DE NUEVO</font></CENTER></B>
		<?
			}
		}
	}
?>
