/**
 * 
 * DontHaveKeyExeption.java Creado 4/10/2005 
 * <A href="http://comunidad.qhatu.net">(http://comunidad.qhatu.net)</A>
 *
 * E-Maku es Software Libre; usted puede redistribuirlo y/o realizar
 * modificaciones bajo los terminos de la Licencia Publica General
 * GNU GPL como esta publicada por la Fundacion del Software Libre (FSF);
 * tanto en la version 2 de la licencia, o cualquier version posterior.
 *
 * E-Maku es distribuido con la expectativa de ser util, pero
 * SIN NINGUNA GARANTIA; sin ninguna garantia aun por COMERCIALIZACION
 * o por un PROPOSITO PARTICULAR. Consulte la Licencia Publica General
 * GNU GPL para mas detalles.
 * <br>
 * Definicion de la clase
 * <br>
 * @author <A href='mailto:felipe@qhatu.net'>Luis Felipe Hernandez</A>
 */
package com.kazak.comeet.server.database.sql;

import com.kazak.comeet.lib.misc.Language;

public class DontHaveKeyException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4154494042707025992L;
	private String message;


	/**
	 * 
	 */
	public DontHaveKeyException(String message) {
		this.message=message;
	}
	
	public String getMessage() {
		return Language.getWord("ERR_DONT_HAVE_KEY_EXCEPTION") + this.message;
	}

}
