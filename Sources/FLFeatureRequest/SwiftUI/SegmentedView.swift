//
//  SegmentedView.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/15/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

struct SegmentedView: View {

	@Binding
	var selectedFeatureState: FeatureState

	var body: some View {
		if FLFeatureRequest.config.buttons.segmentedControl.display == .show {
			Picker("", selection: $selectedFeatureState) {
				ForEach([FeatureState.approved, FeatureState.implemented]) { state in
					Text(state.description)
				}
			}
			.pickerStyle(.segmented)
		}
	}
}

extension FeatureState: Identifiable {
	public var id: Self { self }

	@MainActor
	public var description: String {
		switch self {
		case .approved:
			return FLFeatureRequest.config.localization.approved
		case .implemented:
			return FLFeatureRequest.config.localization.implemented
		case .pending:
			return FLFeatureRequest.config.localization.pending
		default:
			return ""
		}
	}
}
