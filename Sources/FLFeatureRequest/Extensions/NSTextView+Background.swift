//
//  NSTextView+Background.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/28/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

#if os(macOS)
/// Removes default background color and allows custom color for TextEditor
extension NSTextView {
	open override var frame: CGRect {
		didSet {
			backgroundColor = .clear
			drawsBackground = true
		}
	}
}
#endif
