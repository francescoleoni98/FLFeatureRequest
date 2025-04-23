//
//  ScrollView+Compat.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/27/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

extension ScrollView {
	
	func refreshableCompat(action: @escaping @Sendable () async -> Void) -> some View {
		if #available(iOS 15, *) {
			return self.refreshable(action: action)
		}
		
		return self
	}
}
