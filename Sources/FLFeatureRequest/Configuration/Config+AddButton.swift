//
//  Config+AddButton.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 4/25/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

extension Configuration {

	public struct AddButton {

		public var textColor = Theme.Scheme(light: .black, dark: .white)
		public var bottomPadding: Padding

		init(bottomPadding: Padding = .small) {
			self.bottomPadding = bottomPadding
		}
	}
}

extension Configuration.AddButton {
	public enum Padding {
		case small
		case medium
		case large
	}
}
