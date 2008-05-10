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

package com.kazak.comeet.admin.misc;

import java.awt.Toolkit;

import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.PlainDocument;

public class NumericDataValidator extends PlainDocument {

	private static final long serialVersionUID = 4060866073050927871L;
	private int limit;
    public NumericDataValidator(int limit) {
        super();
        setLimit(limit);
    }
    
    public final int getLimit() {
        return limit;
    }
    
    public void insertString(int offset, String string, AttributeSet attributeSet) throws BadLocationException {
    	int size = string.length();
        if (this.getLength() < limit) {
            if (size <= limit - offset) {
                if (offset < limit) {
                    String finalString = new String();
                    try {
                        for (int i = 0; i < string.length(); i++) {
                            finalString = finalString + string.substring(i, i + 1);
                        }
                        Integer.parseInt(finalString);
                        super.insertString(offset, string, attributeSet);
                    }
                    catch (NumberFormatException NFEe) {
                  		Toolkit.getDefaultToolkit().beep();
                    }
                } else {
                    Toolkit.getDefaultToolkit().beep();
                }
            } else {
                Toolkit.getDefaultToolkit().beep();
            }
        } else {
            Toolkit.getDefaultToolkit().beep();
        }
    }


    public final void setLimit(int newValue) {
        this.limit = newValue;
    }
}
