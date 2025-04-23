//
//  SeparatorView.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 8/12/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

struct SeparatorView: View {
	var body: some View {
		HStack(alignment: .center) {
			VStack { Divider() }
			Text(FLFeatureRequest.config.localization.comments.uppercased()).font(.caption2)
			VStack { Divider() }
		}
	}
}
