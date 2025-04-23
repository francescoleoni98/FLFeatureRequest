//
//  ProgressView+Compat.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/28/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

extension ProgressView {
	
	@ViewBuilder
	func controlSizeCompat(_ controlSize: Compatability.ControlSize) -> some View {
		if #available(iOS 15, *) {
			switch controlSize {
			case .mini:
				self.controlSize(.mini)
			case .small:
				self.controlSize(.small)
			case .regular:
				self.controlSize(.regular)
			case .large:
				self.controlSize(.large)
			}
		} else {
			self
		}
	}
}
