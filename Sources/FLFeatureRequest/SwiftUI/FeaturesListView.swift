//
//  FeaturesListView.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 3/5/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

#if os(macOS) || os(visionOS)
struct FeaturesListView: View {
	
	@Environment(\.colorScheme)
	var colorScheme
	
	@ObservedObject
	var featureModel: FeatureModel
	
	@State
	var showingCreateSheet = false
	
	@State
	var selectedFeature: FeatureResponse? = nil
	
	@Binding
	var listType: FeatureState
	
	func getList() -> [FeatureResponse] {
		switch listType {
		case .approved:
			return featureModel.approvedFeatures
		case .implemented:
			return featureModel.implementedFeatures
		default:
			return []
		}
	}
	
	private func createFeatureAction() {
		self.showingCreateSheet.toggle()
	}
	
	var body: some View {
		ZStack {
			if featureModel.isLoading && !featureModel.hasFetched {
				ProgressView()
					.imageScale(.small)
			}
			
			if featureModel.hasFetched && !featureModel.isLoading && getList().isEmpty {
				Text(FLFeatureRequest.config.localization.noFeatureRequests)
			}

			if getList().count > 0 {
				SwiftUI.List {
					Section(String(localized: "Vote (▲) the feature you want to see on the app or add a new one.", bundle: .module)) {
						LazyVStack(spacing: 8) {
							ForEach(getList(), id: \.id) { feature in
								Button(action: { selectFeature(feature: feature) }) {
									FeatureView(featureResponse: feature, viewKind: .list, voteActionCompletion: { featureModel.fetchList() })
//										.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
								}
								.listRowSeparatorCompat(.hidden)
								.buttonStyle(.plain)
							}
						}
						.padding(.vertical, 4)
					}

					Text("\(FLFeatureRequest.config.localization.poweredBy) FLFeatureRequest")
						.font(.footnote)
						.foregroundStyle(.secondary)
						.padding(.top)
						.padding(.bottom, 30)
				}
				.transition(.opacity)
				.scrollIndicatorsCompat(.hidden)
				.scrollContentBackgroundCompat(.hidden)
				.listStyle(.plain)
				.background(.clear)
				.sheet(item: $selectedFeature, onDismiss: { featureModel.fetchList() }) { feature in
					DetailFeatureView(
						featureResponse: feature,
						voteActionCompletion: { featureModel.fetchList() },
						closeAction: { self.selectedFeature = nil }
					)
					.frame(minWidth: 500, idealWidth: 500, minHeight: 450, maxHeight: 600)
					.background(backgroundColor)
				}
				.onAppear {
					featureModel.fetchList()
				}
			}
			
			VStack {
				Spacer()

				HStack {
					Spacer()
					AddButton(buttonAction: createFeatureAction)
						.padding(.bottom, 20)
						.sheet(isPresented: $showingCreateSheet) {
							CreateFeatureView(
								createActionCompletion: { featureModel.fetchList() },
								closeAction: { self.showingCreateSheet = false }
							)
							.frame(minWidth: 500, idealWidth: 500, minHeight: 400, maxHeight: 600)
							.background(backgroundColor)
						}
				}
			}
		}
	}
	
	private func selectFeature(feature: FeatureResponse) {
		self.selectedFeature = feature
	}
	
	var backgroundColor: Color {
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
			if let color = FLFeatureRequest.theme.tertiaryColor {
				return color.light
			}
			
			return PrivateTheme.systemBackgroundColor.light
		}
	}
}
#endif
