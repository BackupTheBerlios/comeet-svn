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

import java.awt.Toolkit;

public interface ClientConstants {

	public final String KeyClient = "client";
	public final String winConfigPath = "C:\\comeet\\";
	public final String unixConfigPath = "/etc/";
	public final String HOME = System.getProperty("user.home");
    public final String SEPARATOR = System.getProperty("file.separator");
    public final String TMP = System.getProperty("java.io.tmpdir");
	public final String CONF = HOME+SEPARATOR+".comeet"+SEPARATOR;
	public final String iconsPath = "/icons/";

    public final int ERROR = 0;
    public final int WARNING = 1;
    public final int MESSAGE = 2;
    public final long MAX_SIZE_FILE_LOG = 5242880;
    public static int MAX_WIN_SIZE_HEIGHT = (int) Toolkit.getDefaultToolkit().getScreenSize().getHeight();
    public static int MAX_WIN_SIZE_WIDTH = (int) Toolkit.getDefaultToolkit().getScreenSize().getWidth();
}