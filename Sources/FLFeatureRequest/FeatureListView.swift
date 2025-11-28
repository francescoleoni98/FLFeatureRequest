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
	var onDismiss: (() -> Void)?

	public init(showDismissButton: Bool = true, onDismiss: (() -> Void)? = nil) {
		self.showDismissButton = showDismissButton
		self.onDismiss = onDismiss
	}

	public var body: some View {
		list
			.navigationTitle(String(localized: "Request a feature", bundle: .module))
	}

	var list: some View {
#if os(macOS) || os(visionOS)
		FeatureListContainer(featureModel: featureModel, showDismissButton: showDismissButton, onDismiss: onDismiss)
			.frame(width: 500, height: 400)
#else
		FeatureListViewIOS(featureModel: featureModel, showDismissButton: showDismissButton, onDismiss: onDismiss)
			.navigationBarTitleDisplayMode(.inline)
			.onAppear {
				featureModel.fetchList()
			}
#endif
	}
}
