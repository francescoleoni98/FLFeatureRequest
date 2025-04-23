//
//  Button+Compat.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/28/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

extension Button {
	
	@ViewBuilder
	func listRowSeparatorCompat(_ visibility: Compatability.Visibility) -> some View {
		if #available(macOS 13.0, iOS 15, visionOS 1, *) {
			switch visibility {
			case .automatic:
				self.listRowSeparator(.automatic)
			case .visible:
				self.listRowSeparator(.visible)
			case .hidden:
				self.listRowSeparator(.hidden)
			}
		}
	}
}
