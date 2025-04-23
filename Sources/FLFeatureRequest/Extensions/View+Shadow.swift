//
//  View+Shadow.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 8/15/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

extension View {
	func wkShadow() -> some View {
		if FLFeatureRequest.config.dropShadow == .show {
			return AnyView(self.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 0))
		} else {
			return AnyView(self)
		}
	}
}
