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

package com.kazak.comeet.admin.gui.table.models;

import java.awt.*;
import javax.swing.*;

public class ArrowIcon implements Icon {
	public static final int UP    = 0;         // direction
	public static final int DOWN  = 1;

	private static final int DEFAULT_SIZE = 8;

	private Color edge1;
	private Color edge2;
	private Color fill;
	private int size;
	private int direction;

	public ArrowIcon(int direction, boolean isRaisedView, boolean isPressedView) {
		if (isRaisedView) {
			if (isPressedView) {
				init( UIManager.getColor("controlLtHighlight"),
						UIManager.getColor("controlDkShadow"),
						UIManager.getColor("controlShadow"),
						DEFAULT_SIZE, direction);
			} else {
				init( UIManager.getColor("controlHighlight"),
						UIManager.getColor("controlShadow"),
						UIManager.getColor("control"),
						DEFAULT_SIZE, direction);
			}
		} else {
			if (isPressedView) {
				init( UIManager.getColor("controlDkShadow"),
						UIManager.getColor("controlLtHighlight"),
						UIManager.getColor("controlShadow"),
						DEFAULT_SIZE, direction);
			} else {
				init( UIManager.getColor("controlShadow"),
						UIManager.getColor("controlHighlight"),
						UIManager.getColor("control"),
						DEFAULT_SIZE, direction);
			}
		}
	}

	public ArrowIcon(Color edge1, Color edge2, Color fill,
			int size, int direction) {
		init(edge1, edge2, fill, size, direction);
	}

	public void paintIcon(Component c, Graphics g, int x, int y) {
		switch (direction) {
		case DOWN: drawDownArrow(g, x+5, y); break;
		case   UP: drawUpArrow(g, x+5, y);   break;
		}
	}

	public int getIconWidth() {
		return size;
	}

	public int getIconHeight() {
		return size;
	}


	private void init(Color edge1, Color edge2, Color fill,
			int size, int direction) {
		this.edge1 = edge1;
		this.edge2 = edge2;
		this.fill = fill;
		this.size = size;
		this.direction = direction;
	}

	private void drawDownArrow(Graphics g, int xo, int yo) {
		g.setColor(edge1);
		g.drawLine(xo, yo,   xo+size-1, yo);
		g.drawLine(xo, yo+1, xo+size-3, yo+1);
		g.setColor(edge2);
		g.drawLine(xo+size-2, yo+1, xo+size-1, yo+1);
		int x = xo+1;
		int y = yo+2;
		int dx = size-6;      
		while (y+1 < yo+size) {
			g.setColor(edge1);
			g.drawLine(x, y,   x+1, y);
			g.drawLine(x, y+1, x+1, y+1);
			if (0 < dx) {
				g.setColor(fill);
				g.drawLine(x+2, y,   x+1+dx, y);
				g.drawLine(x+2, y+1, x+1+dx, y+1);
			}
			g.setColor(edge2);
			g.drawLine(x+dx+2, y,   x+dx+3, y);
			g.drawLine(x+dx+2, y+1, x+dx+3, y+1);
			x += 1;
			y += 2;
			dx -= 2;     
		}
		g.setColor(edge1);
		g.drawLine(xo+(size/2), yo+size-1, xo+(size/2), yo+size-1); 
	}

	private void drawUpArrow(Graphics g, int xo, int yo) {
		g.setColor(edge1);
		int x = xo+(size/2);
		g.drawLine(x, yo, x, yo); 
		x--;
		int y = yo+1;
		int dx = 0;
		while (y+3 < yo+size) {
			g.setColor(edge1);
			g.drawLine(x, y,   x+1, y);
			g.drawLine(x, y+1, x+1, y+1);
			if (0 < dx) {
				g.setColor(fill);
				g.drawLine(x+2, y,   x+1+dx, y);
				g.drawLine(x+2, y+1, x+1+dx, y+1);
			}
			g.setColor(edge2);
			g.drawLine(x+dx+2, y,   x+dx+3, y);
			g.drawLine(x+dx+2, y+1, x+dx+3, y+1);
			x -= 1;
			y += 2;
			dx += 2;     
		}
		g.setColor(edge1);
		g.drawLine(xo, yo+size-3,   xo+1, yo+size-3);
		g.setColor(edge2);
		g.drawLine(xo+2, yo+size-2, xo+size-1, yo+size-2);
		g.drawLine(xo, yo+size-1, xo+size, yo+size-1);
	}
}
