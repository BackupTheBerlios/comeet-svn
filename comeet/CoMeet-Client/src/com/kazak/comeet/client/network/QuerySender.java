/**
 *  This file is part of CoMeet: Tiny IM.
 *
 *  CoMeet is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  CoMeet is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with CoMeet.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * @author Luis Felipe Hernandez
 * @author Cristian David Cepeda
 * 
 * Contact: comeet@kazak.com.co
 */

package com.kazak.comeet.client.network;

import java.io.IOException;
import java.nio.channels.SocketChannel;
import java.util.Hashtable;

import org.jdom.Document;
import org.jdom.Element;


public class QuerySender {

    private static Hashtable <String,Document> poolTransactionsHash = new Hashtable<String,Document>();
    private static long id = 0;
     
    /**
     * Este metodo es invocado en caso de que la consulta solicitada no se encuentre en
     * cache.
     * @param key identifica si la solicituid de esta clase es de JMClient o de JMAdmin
     * @param doc envia la peticion de una transaccion o una solicitud de un query
     * @return returna la transaccion o query solicitado.
     * @throws QuerySenderException
     */
    public static Document getResultSetFromST(Document doc) throws QuerySenderException {
    	
        String id = "Q"+getId();
        doc.getRootElement().addContent(new Element("id").setText(id));
        SocketChannel socket = SocketHandler.getSock();
        try {
        	SocketWriter.writing(socket,doc);
        } catch (IOException e) {
			System.out.println("ERROR: Error de entrada y salida");
			System.out.println("Causa: " + e.getMessage());
			e.printStackTrace();
		}    
        int i=0;
        while (!poolTransactionsHash.containsKey(id)) {
            try {
                Thread.sleep(100);
                i++;
                if (i>300) {
                    throw new QuerySenderException();
                }
            }
            catch(InterruptedException e) {
                throw new QuerySenderException();
            }
        }
    	
        Document result = (Document)poolTransactionsHash.get(id);
        poolTransactionsHash.remove(id);
        return result;
    }

    public static Document getResultSetFromST(String code, String[] argsArray)
    throws QuerySenderException {
        Document doc = new Document();
        doc.setRootElement(new Element("QUERY"));
        doc.getRootElement().addContent(new Element("sql").setText(code));
        
        if( argsArray != null ) {
            Element element = new Element("params");
            for (int i=0; i< argsArray.length ; i++) {
                element.addContent(new Element("arg").setText(argsArray[i]));
            }
            doc.getRootElement().addContent(element);
        }
        return getResultSetFromST(doc);
    }
    
    /**
     * Este metodo adiciona retorno paquetes answer, success o error provenientes de la
     * solicitud de una consulta o una transaccion
     * @param id identificador de solicitud de consulta.
     * @param doc paquete answer,success o error retornado por el ST.
     */
    public static void putResultOnPool(String id, Document doc) {
        poolTransactionsHash.put(id,doc);
    }
    
    public static synchronized String getId() {
        return String.valueOf(++id);
    }
}