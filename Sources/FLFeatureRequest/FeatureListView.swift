//
//  FeatureListView.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 24/01/25.
//

import SwiftUI

/// FeatureListView that renders the list of feedback.
public struct FeatureListView: View {

	@Environment(\.dismiss) private var dismiss

	public static var isTesting: Bool = false

	private let featureModel = FeatureModel()

	var showDismissButton: Bool
	var onDismiss: (() -> Void)?

	public init(showDismissButton: Bool = true, onDismiss: (() -> Void)? = nil) {
		self.showDismissButton = showDismissButton
		self.onDismiss = onDismiss
	}

	public var body: some View {
		list
	}

	@ViewBuilder
	var list: some View {
		let onDismissClosure: (() -> Void)? = showDismissButton ? {
			if let onDismiss {
				onDismiss()
			} else {
#if os(macOS) || os(visionOS)
				dismiss()
#else
				UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController?.dismiss(animated: true) {
					self.dismiss()
				}
#endif
			}
		} : nil

		ModalContainer(title: String(localized: "Request a feature", bundle: .module), height: 500, confirmationButton: {
			EmptyView()
		}, content: {
#if os(macOS) || os(visionOS)
		FeatureListContainer(featureModel: featureModel, showDismissButton: showDismissButton, onDismiss: onDismiss)
#else
		FeatureListViewIOS(featureModel: featureModel, showDismissButton: showDismissButton, onDismiss: onDismiss)
			.onAppear {
				featureModel.fetchList()
			}
#endif
		}, onClose: onDismissClosure)
	}
}
