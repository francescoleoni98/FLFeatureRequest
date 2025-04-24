//
//  FeatureListView.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 24/01/25.
//

import SwiftUI

/// FeatureListView that renders the list of feedback.
public struct FeatureListView: View {

	private let featureModel = FeatureModel()

	var showDismissButton: Bool

	public init(showDismissButton: Bool = true) {
		self.showDismissButton = showDismissButton
	}

	public var body: some View {
		list
			.navigationTitle(String(localized: "Request a feature", bundle: .module))
	}

	var list: some View {
#if os(macOS) || os(visionOS)
		FeatureListContainer(featureModel: featureModel, showDismissButton: showDismissButton)
			.frame(width: 500, height: 400)
#else
		FeatureListViewIOS(featureModel: featureModel, showDismissButton: showDismissButton)
			.navigationBarTitleDisplayMode(.inline)
			.onAppear {
				featureModel.fetchList()
			}
#endif
	}
}
