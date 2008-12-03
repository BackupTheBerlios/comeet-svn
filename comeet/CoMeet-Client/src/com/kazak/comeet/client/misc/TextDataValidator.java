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

package com.kazak.comeet.client.misc;


import java.awt.Toolkit;

import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.PlainDocument;

public class TextDataValidator extends PlainDocument {

	private static final long serialVersionUID = -5229828757349802786L;
	private int limit;
    
    public TextDataValidator(int limit) {
        super();
        setLimit(limit);
    }
    
    public final int getLimit() {
        return limit;
    }
    
    public void insertString(int position, String string, AttributeSet attributeSet) throws BadLocationException {
        
        int longitud = string.length();
        
        if (this.getLength() < limit) {
            if (longitud <= limit - position) {
                if(position < limit) { 
                    super.insertString(position,string,attributeSet);
                }
                else {
                    Toolkit.getDefaultToolkit().beep();
                }
            }
            else {
                Toolkit.getDefaultToolkit().beep();
            }
        }
        else {
            Toolkit.getDefaultToolkit().beep();
        }
    }
    
    public final void setLimit(int newValue) {
        this.limit = newValue;
    }
}