<?php
class Radicacion
{
  /** Aggregations: */

  /** Compositions: */

   /*** Attributes: ***/
	 /**
   * Clase que maneja los Historicos de los documentos
   *
   * @param int Dependencia Dependencia de Territorial que Anula
   * @db Objeto conexion
   * @access public
   */

	/**
	  *  VARIABLES DE DATOS PARA LOS RADICADOS
		*/
	var $db;
	var $tipRad;
	var $radiTipoDeri;
	var $radiCuentai;
	var $eespCodi;
	var $mrecCodi;
	var $radiFechOfic;
	var $radiNumeDeri;
	var $tdidCodiRadi;
	var $descAnex;
	var $radiNumeHoja;
	var $radiPais;
	var $raAsun;
	var $radiDepeRadi;
	var $radiUsuaActu;
	var $radiDepeActu;
	var $carpCodi;
	var $radiNumeRadi;
	var $trteCodi;
	var $radiNumeIden;
	var $radiFechRadi;
	var $sgd_apli_codi;
	var $tdocCodi;
	var $estaCodi;
	var $radiPath;

	/**
	  *  VARIABLES DEL USUARIO ACTUAL
	*/
	var $dependencia;
	var $usuaDoc;
	var $usuaLogin;
	var $usuaCodi;
	var $codiNivel;
	var $noDigitosRad;

function Radicacion($db)
{
	/**
  	* Constructor de la clase Historico
	* @db variable en la cual se recibe el cursor sobre el cual se esta trabajando.
	*
	*/
	global $HTTP_SERVER_VARS,$PHP_SELF,$HTTP_SESSION_VARS,$HTTP_GET_VARS,$krd;
	//global $HTTP_GET_VARS;
	$this->db=$db;

	$this->noDigitosRad = 6;
	$curr_page = $id.'_curr_page';
	$this->dependencia= $_SESSION['dependencia'];
	$this->usuaDoc    = $_SESSION['usua_doc'];
	$this->usuaLogin  = $krd;
	$this->usuaCodi   = $_SESSION['codusuario'];
	isset($_GET['nivelus']) ? $this->codiNivel = $_GET['nivelus'] : $this->codiNivel = $_SESSION['nivelus'];
	$this->db->conn->SetFetchMode(ADODB_FETCH_ASSOC);
}

function newRadicado($tpRad, $tpDepeRad)
{
	/** FUNCION QUE INSERTA UN RADICADO NUEVO
		*
		*/

/**
	* Busca el Nivel de Base de datos.
	*
	*/
		$whereNivel = "";
		$sql = "SELECT CODI_NIVEL FROM USUARIO WHERE USUA_CODI = ".$this->radiUsuaActu." AND DEPE_CODI=".$this->radiDepeActu;
		# Busca el usuairo Origen para luego traer sus datos.
		$rs = $this->db->conn->query($sql); # Ejecuta la busqueda
		// Campo adicionado por Cmauricio para que coja la secuencia de la dependencia de referencia
		$sqlSec = "SELECT DEPE_RAD_TP$tpRad FROM DEPENDENCIA WHERE DEPE_CODI = $tpDepeRad";
		$rsSec = $this->db->conn->Execute($sqlSec);

		// Si no hay resultado entonces sigue con la misma dependencia que se envio
		$tpDepeRad = (!$rsSec->EOF) ? $rsSec->fields["DEPE_RAD_TP$tpRad"] : $tpDepeRad;
		// Modificacion SKINA-IDRD variable en minuscula
		$usNivel = $rs->fields["CODI_NIVEL"];
		// Busca el usuairo Origen para luego traer sus datos.
		$SecName = "SECR_TP$tpRad"."_".$tpDepeRad;
		$secNew  = $this->db->nextId($SecName);

		if($secNew==0) {
			$secNew=$this->db->nextId($SecName);
			if($secNew==0) die("<hr><b><font color=red><center>Error no genero un Numero de Secuencia<br>SQL: $secNew</center></font></b><hr>");
		}
		$newRadicado = date("Y") . $this->dependencia . str_pad($secNew,$this->noDigitosRad,"0", STR_PAD_LEFT) . $tpRad;
		if(!$this->radiTipoDeri)
		{
		    $recordR["radi_tipo_deri"]= "0";
		}
		else
		{
			$recordR["radi_tipo_deri"]= $this->radiTipoDeri;
		}
		if(!$this->carpCodi) $this->carpCodi = 2;
		if(!$this->radiNumeDeri) $this->radiNumeDeri = 0;
		$recordR["RADI_CUENTAI"] =  $this->radiCuentai;
		$recordR["EESP_CODI"]    =	$this->eespCodi?$this->eespCodi:0;
		$recordR["MREC_CODI"]    =	$this->mrecCodi;
		$recordR["radi_fech_ofic"]=	$this->db->conn->DBDate($this->radiFechOfic);
		//$recordR["radi_tipo_deri"]=$this->radiTipoDeri;
		$recordR["RADI_NUME_DERI"]=	$this->radiNumeDeri;
		$recordR["RADI_USUA_RADI"]=	$this->usuaCodi;
		$recordR["RADI_PAIS"]    =	"'".$this->radiPais."'";
		$recordR["RA_ASUN"]			= $this->db->conn->qstr($this->raAsun);
		$recordR["radi_desc_anex"]	= $this->db->conn->qstr($this->descAnex);
		$recordR["RADI_DEPE_RADI"]= $this->radiDepeRadi;
		$recordR["RADI_USUA_ACTU"]=$this->radiUsuaActu;
		$recordR["carp_codi"]=$this->carpCodi;
		$recordR["CARP_PER"]=0;
		$recordR["RADI_NUME_RADI"]=$newRadicado;
		$recordR["TRTE_CODI"]=$this->trteCodi;
		$recordR["RADI_FECH_RADI"]=$this->db->conn->OffsetDate(0,$this->db->conn->sysTimeStamp);
		$recordR["RADI_DEPE_ACTU"]=$this->radiDepeActu;
		$recordR["TDOC_CODI"]=$this->tdocCodi;
		$recordR["TDID_CODI"]=$this->tdidCodi;
		$recordR["CODI_NIVEL"]=$usNivel;
		$recordR["SGD_APLI_CODI"]=$this->sgd_apli_codi;
		$recordR["RADI_PATH"] = "$this->radiPath";
		
		$whereNivel = "";
		$insertSQL = $this->db->conn->Replace("RADICADO", $recordR, "RADI_NUME_RADI", false);
		if(!$insertSQL)
		{
			echo "<hr><b><font color=red>Error no se inserto sobre radicado<br></font></b><hr>";
		}
		//$this->db->conn->CommitTrans();
		return ($insertSQL == 0) ? $insertSQL : $newRadicado;
  }

  function updateRadicado($radicado, $radPathUpdate = null)
  {
		$recordR["radi_cuentai"] = $this->radiCuentai;
		$recordR["eesp_codi"] 	= $this->eespCodi;
		$recordR["mrec_codi"] 	= $this->mrecCodi;
		$recordR["radi_fech_ofic"] = $this->db->conn->DBDate($this->radiFechOfic);
		$recordR["radi_pais"]     = "'".$this->radiPais."'";
		$recordR["ra_asun"]       = $this->db->conn->qstr($this->raAsun);
		$recordR["radi_desc_anex"]= $this->db->conn->qstr($this->descAnex);
		$recordR["trte_codi"]	= $this->trteCodi;
		$recordR["tdid_codi"]	= $this->tdidCodi;
		$recordR["radi_nume_radi"] = $radicado;
		$recordR["SGD_APLI_CODI"] = $this->sgd_apli_codi;
		
		// Linea para realizar radicacion Web de archivos pdf
		if(!empty($radPathUpdate) && $radPathUpdate != ""){
			$archivoPath = explode(".", $radPathUpdate);
			// Sacando la extension del archivo
			$extension = array_pop($archivoPath);
			if($extension == "pdf"){
				$recordR["radi_path"] = "'" . $radPathUpdate . "'";
			}
		}
		$insertSQL = $this->db->conn->Replace("RADICADO", $recordR, "radi_nume_radi", false);
		return $insertSQL;
  }

    /** FUNCION DATOS DE UN RADICADO
    * Busca los datos de un radicado.
    * @param $radicado int Contiene el numero de radicado a Buscar
    * @return Arreglo con los datos del radicado
    * Fecha de creaci�n: 29-Agosto-2006
    * Creador: Supersolidaria
    * Fecha de modificaci�n:
    * Modificador:
    */
    function getDatosRad( $radicado )
    {
        $query  = 'SELECT RAD.RADI_FECH_RADI, RAD.RADI_PATH, TPR.SGD_TPR_DESCRIP,';
        $query .= ' RAD.RA_ASUN';
        $query .= ' FROM RADICADO RAD';
        $query .= ' LEFT JOIN SGD_TPR_TPDCUMENTO TPR ON TPR.SGD_TPR_CODIGO = RAD.TDOC_CODI';
        $query .= ' WHERE RAD.RADI_NUME_RADI = '.$radicado;
        // print $query;
        $rs = $this->db->conn->query( $query );
        
        $arrDatosRad['fechaRadicacion'] = $rs->fields['RADI_FECH_RADI'];
        $arrDatosRad['ruta'] = $rs->fields['RADI_PATH'];
        $arrDatosRad['tipoDocumento'] = $rs->fields['SGD_TPR_DESCRIP'];
        $arrDatosRad['asunto'] = $rs->fields['RA_ASUN'];
            
        return $arrDatosRad;
    }

} // Fin de Class Radicacion
?>
