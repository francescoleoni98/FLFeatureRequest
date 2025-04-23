//
//  FeatureListContainer+macOS.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 3/11/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

#if os(macOS) || os(visionOS)
import SwiftUI

struct FeatureListContainer: View {

	@Environment(\.colorScheme)
	private var colorScheme

	@State
	private var listType: FeatureState = .approved

	@State
	private var isRefreshing = false

	@ObservedObject
	private var featureModel: FeatureModel

	init(featureModel: FeatureModel) {
		self.featureModel = featureModel
		self.featureModel.fetchList()
	}

	func refreshList() {
		isRefreshing = true
		featureModel.fetchList {
			DispatchQueue.main.async {
				isRefreshing = false
			}
		}
	}

	var body: some View {
		VStack {
			switch FLFeatureRequest.config.buttons.segmentedControl.display {
			case .show:
				segmentedControlView
			case .hide:
				noSegmentedControlView
			}

			FeaturesListView(featureModel: featureModel, listType: $listType)
				.background(systemBackgroundColor)

		}
		.background(systemBackgroundColor)
	}

	var segmentedControlView: some View {
		ZStack {
			SegmentedView(selectedFeatureState: $listType)
				.padding()
				.frame(maxWidth: 300)

			HStack {
				Button(action: refreshList) {
					if isRefreshing {
						ProgressView()
							.scaleEffect(0.4)
							.progressViewStyle(CircularProgressViewStyle())
					} else {
						Image(systemName: "arrow.clockwise")
					}
				}
				.buttonStyle(PlainButtonStyle())
				.frame(width: 20, height: 20)
				.padding(EdgeInsets(top: 0, leading: 315, bottom: 0, trailing: 0))
			}
		}
	}

	var noSegmentedControlView: some View {
		Button(action: refreshList) {
			if isRefreshing {
				ProgressView()
					.scaleEffect(0.4)
					.progressViewStyle(CircularProgressViewStyle())
			} else {
				Image(systemName: "arrow.clockwise")
			}
		}
		.buttonStyle(PlainButtonStyle())
		.frame(width: 20, height: 20)
		.padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
	}

	var systemBackgroundColor: Color {
		switch colorScheme {
		case .light:
			if let color = FLFeatureRequest.theme.tertiaryColor {
				return color.light
			}

			return PrivateTheme.systemBackgroundColor.light
		case .dark:
			if let color = FLFeatureRequest.theme.tertiaryColor {
				return color.dark
			}

			return PrivateTheme.systemBackgroundColor.dark

		@unknown default:
			return PrivateTheme.systemBackgroundColor.light
		}
	}
}
#endif
