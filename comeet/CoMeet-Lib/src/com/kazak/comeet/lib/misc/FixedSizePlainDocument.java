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

package com.kazak.comeet.lib.misc;

import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.PlainDocument;

public class FixedSizePlainDocument extends PlainDocument {
	
	private static final long serialVersionUID = 3056490631903276108L;
	private int maxSize;
	
    public FixedSizePlainDocument(int limit) {
        maxSize = limit;
    }

    public void insertString(int offset, String string, AttributeSet attributeSet) throws BadLocationException {
        if ((getLength() + string.length()) <= maxSize) {
            super.insertString(offset, string, attributeSet);
        } else {
            throw new BadLocationException("ERROR: Insertion exceeds max size of document", offset);
        }
    }
}