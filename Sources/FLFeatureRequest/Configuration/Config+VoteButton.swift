//
//  Config+VoteButton.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 4/25/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

extension Configuration {
	public struct VoteButton {
		
		public var arrowColor: Theme.Scheme = .setBoth(to: .gray)
		
		public var textColor: Theme.Scheme = .set(light: .black, dark: .white)
	}
}
