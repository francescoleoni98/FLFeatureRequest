//
//  FeedbackListView.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 24/01/25.
//

import SwiftUI

/// FeedbackView that renders the list of feedback.
public struct FeedbackListView: View {

	@Environment(\.dismiss) var dismiss

	let wishModel = WishModel()

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
		WishlistContainer(wishModel: wishModel)
			.frame(width: 500, height: 400)
#else
		WishlistViewIOS(wishModel: wishModel)
			.navigationBarTitleDisplayMode(.inline)
			.task {
				await wishModel.fetchList()
			}
#endif
	}
}
