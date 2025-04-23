//
//  Config+SegmentedControl.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 4/25/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

extension Configuration {
	public struct SegmentedControl {
		
		/// Hides/Shows the segmented control to switch between 'Requested' and 'Implemented'.
		public var display: Display = .show
		
		public var defaultTextColor = Theme.Scheme(light: .black, dark: .white)
		
		public var activeTextColor = Theme.Scheme(light: .white, dark: .white)
	}
}
