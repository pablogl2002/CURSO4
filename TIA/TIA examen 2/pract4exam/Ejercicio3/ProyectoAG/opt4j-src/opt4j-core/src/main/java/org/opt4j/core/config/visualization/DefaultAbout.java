/*******************************************************************************
 * Copyright (c) 2014 Opt4J
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *******************************************************************************/
 

package org.opt4j.core.config.visualization;

import java.awt.Color;

import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.WindowConstants;

import com.google.inject.Singleton;

/**
 * The {@link DefaultAbout} panel.
 * 
 * @author lukasiewycz
 * 
 */
@Singleton
public class DefaultAbout implements About {

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.opt4j.config.visualization.AboutFrame#getDialog(org.opt4j.config.
	 * visualization.ApplicationFrame)
	 */
	@Override
	public JDialog getDialog(ApplicationFrame frame) {
		JDialog dialog = new JDialog(frame, "About Configurator", true);
		dialog.setBackground(Color.WHITE);
		dialog.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
		dialog.setResizable(false);

		dialog.add(new JLabel("Void Frame"));
		dialog.pack();
		dialog.setVisible(false);

		return dialog;
	}

}
