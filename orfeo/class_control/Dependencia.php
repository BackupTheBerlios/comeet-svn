<?php 
require_once("$ruta_raiz/include/db/ConnectionHandler.php");
require_once("$ruta_raiz/class_control/Municipio.php");
require_once($ruta_raiz.'/include/class/tipoRadicado.class.php');

/**
 * Esp es la clase encargada de gestionar las operaciones y los datos b�sicos referentes a una Dependencia
 * @author	Sixto Angel Pinz�n
 * @version	1.0
 */
 
class Dependencia {
	
	/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var string
   * @access public
   */
	var $depe_nomb;
	/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var string
   * @access public
   */
	var $dep_sigla;
	/**
   * Variable que almacena el nombre de la territorial ala que pertenece la dependencia instanciada
   * @var string
   * @access public
   */
	var $terr_nomb;
	/**
   * Variable que almacena el nombre del municipio de la territorial ala que pertenece la dependencia instanciada
   * @var string
   * @access public
   */
	var $terr_muni_nomb;
	/**
   * Variable que almacena el codigo del municipio de la territorial ala que pertenece la dependencia instanciada
   * @var numeric
   * @access public
   */
	var $terr_muni;
	/**
   * Variable que almacena el codigo del departamento de la territorial ala que pertenece la dependencia instanciada
   * @var numeric
   * @access public
   */
	var $terr_depto;
	var $terr_ciu_nomb;
	/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var string
   * @access public
   */
//	var $dep_sigla;
	/**
   * Variable que almacena la direccion de la territorial ala que pertenece la dependencia instanciada
   * @var string
   * @access public
   */
	var $terr_direccion;
	/**
   * Variable que almacena la sigla de la territorial ala que pertenece la dependencia instanciada
   * @var string
   * @access public
   */
	var $terr_sigla;
	/**
   * Variable que almacena la sigla de la territorial ala que pertenece la dependencia instanciada
   * @var string
   * @access public
   */
	var $terr_pais;
	/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var numeric
   * @access public
   */
	var $dep_central;
	/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var string
   * @access public
   */
	var $pais_codi;
	/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var numeric
   * @access public
   */
	var $dpto_codi;
		/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var numeric
   * @access public
   */
	var $muni_codi;
		/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var numeric
   * @access public
   */
	var $depe_codi_territorial;
		/**
   * Variable que se corresponde con su par, uno de los campos de la tabla dependencia
   * @var numeric
   * @access public
   */
	var $depe_rad_tpo = null;
	var $depe_rad_tp1 = null;
	var $depe_rad_tp2 = null;
	var $depe_rad_tp3 = null;
	var $depe_rad_tp4 = null;
	var $depe_rad_tp5 = null;
	var $depe_rad_tp6 = null;
	var $depe_rad_tp7 = null;
	var $depe_rad_tp8 = null;
	var $depe_rad_tp9 = null;	
	
	/**
   * Gestor de las transacciones con la base de datos
   * @var ConnectionHandler
   * @access public
   */
	var $depe_codi_padre;
	/**
   * Gestor de las transacciones con la base de datos
   * @var ConnectionHandler
   * @access public
   */
	var $cursor;


/** 
* Constructor encargado de obtener la conexion
* @return   void
*/
	function Dependencia($db) {
	$this->cursor = $db;
	}


/** 
* Retorna el valor string correspondiente al atributo nombre del la Dependencia, debe invocarse antes Dependencia_codigo() 
* @return	string
*/
	function getDepe_nomb() {
		return  $this->depe_nomb;
	}


/** 
* Retorna el valor string correspondiente al atributo sigla del la Dependencia, debe invocarse antes Dependencia_codigo() 
* @return	string
*/
	function getDepeSigla() {
		return  $this->dep_sigla;
	}

	
	/** 
* Retorna el valor string correspondiente al atributo nombre de la ciudad de la territorial, debe invocarse antes Dependencia_codigo() 
* @return	string
*/
	function getTerrCiuNomb() {
		return  $this->terr_ciu_nomb;
	}

	
	/** 
* Retorna el valor string correspondiente al atributo nombre corto de la territorial, debe invocarse antes Dependencia_codigo() 
* @return	string
*/
	function getTerrSigla() {
		return  $this->terr_sigla;
	}
	
		/** 
* Retorna el valor string correspondiente al atributo nombre largo de la territorial, debe invocarse antes Dependencia_codigo() 
* @return	string
*/
	function getTerrNombre() {
		return  $this->terr_nomb;
	}



		/** 
* Retorna el valor string correspondiente al atributo nombre corto de la territorial, debe invocarse antes Dependencia_codigo() 
* @return	string
*/
	function getTerrDireccion() {
		return  $this->terr_direccion;
	}
	
	
	/** 
	* Retorna el valor string correspondiente al atributo depe_codi_padre, debe invocarse antes Dependencia_codigo() 
	* @return	string
	*/
	function getDepe_codi_padre()
	{
	 	return  $this->depe_codi_padre;	
	}

	
	/** 
	* Retorna el valor string correspondiente al atributo codigo del campo depe_codi_territorial, debe invocarse antes Dependencia_codigo() 
	* @return	string
	*/	
	function getDepe_codi_territorial()
	{
	 	return  $this->depe_codi_territorial;
	}
	
	/**
	 * Retorna un vector con los datos de la dependencia enviada.
	 *
	 * @param integer $codigo Codigo de la dependencia
	 * @return array con datos de la dependencia. False on Error.
	 */
	function dependenciaArr($codigo)
	{
		$tmp_Objtrad = new TipRads($this->cursor);
		$tmp_Trad = $tmp_Objtrad->GetArrayIdTipRad();
		$q= "select * from dependencia where depe_codi =$codigo";
		$rs=$this->cursor->query($q);
		$retorno = array();
		if  (!$rs->EOF)
		{
			$retorno['depe_nomb']= $rs->fields['DEPE_NOMB'];
			$retorno['dep_sigla']= $rs->fields['DEP_SIGLA'];
			$retorno['depe_estado']= $rs->fields['DEPE_ESTADO'];
			$retorno['cont_codi']= $rs->fields['ID_CONT'];
			$retorno['pais_codi']= $rs->fields['ID_PAIS'];
			$retorno['dpto_codi'] = $rs->fields['DPTO_CODI'];   
			$retorno['muni_codi'] = $rs->fields['MUNI_CODI'];
			$retorno['dep_sigla'] = $rs->fields['DEP_SIGLA'];
			$retorno['dep_direccion']  = $rs->fields['DEP_DIRECCION'];
			$retorno['dep_central']   = $rs->fields['DEP_CENTRAL'];
			foreach ($tmp_Trad as $key=>$val)
			{
				$retorno['depe_rad_tp'.$val['ID']] =  $rs->fields['DEPE_RAD_TP'.$val['ID']];
			}
			unset($tmp_Trad); unset($tmp_Objtrad);
		}
		return ($retorno);
	}
	
	/** 
	* Retorna el valor string correspondiente al codigo de la dependencia que permitiria generar la secuencia de radicacion de acuerdo al tipo de radicaci�n sea esta (-1,-2,-3,-4,-5) , debe invocarse antes Dependencia_codigo() 
	* @return	string
	*/		
	function getDepSecRadic($tipoRadicacion)
	{
		if ($tipoRadicacion==1)
		return ($this->depe_rad_tp1);
	}

	/** 
	* Retorna el valor string correspondiente al codigo de la dependencia que permitiria generar la secuencia de radicacion de acuerdo al tipo de radicaci�n sea esta (-1,-2,-3,-4,-5) , debe invocarse antes Dependencia_codigo() 
	*  @param	$codDepe	numeric es el c�digo de la Dependencia
	*  @param	$tipoRadicacion	String es el tipo de radicacion a consultar
	*  @return	string
	*/		
	function getSecRadicTipDepe($codDepe,$tipoRadicacion)
	{
		$q = "select * from dependencia where depe_codi =$codDepe";
		$rs=$this->cursor->query($q);
		$retorno="noDefinido";
		if  (!$rs->EOF)
		{
			$retorno=$rs->fields["DEPE_RAD_TP$tipoRadicacion"];
		}
		return ($retorno);
	}

	
	/** 
	 * Carga los datos de la instacia incluyendo la informacion de la territorial, con referencia a un codigo de Dependencia suministrado retorna falso si no lo encuentra, de lo contrario true
	 * @param	$codigo	string es el codigo de la Dependencia
	 * @return   boolean
	 */
	function Dependencia_codigo($codigo)
	{
		$muni = & new Municipio($this->cursor);
		$q=  "select * from dependencia where depe_codi =$codigo";
		$rs=$this->cursor->query($q);
		
    	$terr="";
		if  (!$rs->EOF)
		{
			$this->depe_nomb	= $rs->fields['DEPE_NOMB'];
			$this->dep_sigla	= $rs->fields['DEP_SIGLA'];
			$this->muni_codi	= $rs->fields['MUNI_CODI'];   
			$this->dpto_codi	= $rs->fields['DPTO_CODI'];
			$this->pais_codi	= $rs->fields['ID_PAIS'];
			$this->dep_central	= $rs->fields['DEP_CENTRAL'];			
			$this->depe_nomb	= $rs->fields['DEPE_NOMB'];
			$this->dep_sigla	= $rs->fields['DEP_SIGLA'];
			$this->dep_central	= $rs->fields['DEP_CENTRAL'];
			$this->depe_rad_tp1	= $rs->fields['DEPE_RAD_TP1'];
			$this->depe_codi_padre = $rs->fields['DEPE_CODI_PADRE'];
			$this->depe_codi_territorial = $rs->fields['DEPE_CODI_TERRITORIAL']; 
			$datosTerr = array();  
			if ($this->dep_central==1)
			{
				$terr =  $rs->fields['DEPE_CODI_TERRITORIAL'];
				if (strlen ($terr)>1)
				{
					$datosTerr=$this->dependenciaArr($terr);
				}
			}else
			{	$terr =  $rs->fields['DEPE_CODI_TERRITORIAL'];	
				if (strlen ($terr)>1)
				{
					$datosTerr=$this->dependenciaArr($terr);
			}	}
			$this->terr_pais =  $datosTerr['pais_codi'];
			$this->terr_depto = $datosTerr['dpto_codi'];   
			$this->terr_nomb =  $datosTerr['depe_nomb'];
			$this->terr_muni =  $datosTerr['muni_codi'];
			$this->terr_sigla = $datosTerr['dep_sigla'];     
			$this->terr_direccion  = $datosTerr['dep_direccion'];
			$muni->municipio_codigo($datosTerr['dpto_codi'],$datosTerr['pais_codi'].'-'.$datosTerr['dpto_codi'].'-'.$datosTerr['muni_codi']); 
			$this->terr_ciu_nomb = $muni->get_muni_nomb(); 
			return true;
		}else
		return false;  
	}

}
?>