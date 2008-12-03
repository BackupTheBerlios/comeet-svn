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

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Tool {
	
    private static final char hexChars[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
    private MessageDigest md5;

    public MD5Tool(String text) {
        try {
                        md5 = MessageDigest.getInstance("MD5");
                } catch (NoSuchAlgorithmException e) {
                        e.printStackTrace();
                }
        md5.update(text.getBytes());
    }
  
    public String getDigest()  {
        return this.hexToString(md5.digest());
    }
   
    private String hexToString(byte buffer[]) {
        StringBuffer hexString = new StringBuffer(2 * buffer.length);
        for (int i = 0; i < buffer.length; i++) {
            this.appendHexPair(buffer[i], hexString);
        }

        return hexString.toString();
    }

    private void appendHexPair(byte b, StringBuffer hexString) {
        char firstByte = hexChars[(b & 0xF0) >> 4];
        char secondByte = hexChars[b & 0x0F];

        hexString.append(firstByte);
        hexString.append(secondByte);
    }
}
