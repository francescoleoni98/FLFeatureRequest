//
//  FeatureListView.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 24/01/25.
//

import SwiftUI

/// FeatureListView that renders the list of feedback.
public struct FeatureListView: View {

	@Environment(\.dismiss) var dismiss

	let featureModel = FeatureModel()

	public init () { }

	public var body: some View {
		list
			.navigationTitle("Request a feature")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						dismiss()
					}
				}
			}
	}

	var list: some View {
#if os(macOS) || os(visionOS)
		FeatureListContainer(featureModel: featureModel)
			.frame(width: 500, height: 400)
#else
		FeatureListViewIOS(featureModel: featureModel)
			.navigationBarTitleDisplayMode(.inline)
			.task {
				await featureModel.fetchList()
			}
#endif
	}
}
