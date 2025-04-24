//
//  FeatureListViewIOS+iOS.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/15/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

#if os(iOS)
import SwiftUI
import Combine

extension View {
	// MARK: Public - Wrap in Navigation

	@ViewBuilder
	public func withNavigation() -> some View {
		NavigationView {
			self
		}
		.navigationViewStyle(.stack)
	}
}

struct FeatureListViewIOS: View {

	@Environment(\.colorScheme)
	private var colorScheme

	@State
	private var selectedFeatureState: FeatureState = .approved

	@ObservedObject
	var featureModel: FeatureModel

	@State
	var selectedFeature: FeatureResponse? = nil

	var showDismissButton: Bool

	private var isInTabBar: Bool {
		let rootViewController = if #available(iOS 15, *) {
			UIApplication
				.shared
				.connectedScenes
				.compactMap { ($0 as? UIWindowScene)?.keyWindow }
				.first?
				.rootViewController
		} else {
			UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController
		}

		return rootViewController is UITabBarController
	}

	private var addButtonBottomPadding: CGFloat {
		let basePadding: CGFloat = isInTabBar ? 80 : 30
		switch FLFeatureRequest.config.buttons.addButton.bottomPadding {
		case .small:
			return basePadding + 15
		case .medium:
			return basePadding + 30
		case .large:
			return basePadding + 60
		}
	}

	private func getList() -> [FeatureResponse] {
		switch selectedFeatureState {
		case .approved:
			return featureModel.approvedFeatures
		case .implemented:
			return featureModel.implementedFeatures
		default:
			return []
		}
	}

	var body: some View {
		ZStack {
			if featureModel.isLoading && !featureModel.hasFetched {
				ProgressView()
					.imageScale(.large)
			}

			if featureModel.hasFetched && !featureModel.isLoading && getList().isEmpty {
				Text(FLFeatureRequest.config.localization.noFeatureRequests)
			}

			ScrollView(showsIndicators: false) {
				VStack {
					if FLFeatureRequest.config.buttons.segmentedControl.display == .show {
						Spacer(minLength: 15)

						SegmentedView(selectedFeatureState: $selectedFeatureState)
							.frame(maxWidth: 200)
					}

					Spacer(minLength: 15)

					if selectedFeatureState == .approved {
						Text("Vote (▲) the feature you want to see on the app or add a new one.", bundle: .module)
							.font(.footnote)
					}

					if getList().count > 0 {
						ForEach(getList()) { feature in
							NavigationLink(destination: {
								DetailFeatureView(featureResponse: feature, voteActionCompletion: { featureModel.fetchList() })
							}, label: {
								FeatureView(featureResponse: feature, viewKind: .list, voteActionCompletion: { featureModel.fetchList() })
									.padding(.all, 5)
									.frame(maxWidth: 700)
							})
						}.transition(.opacity)
					} else if !featureModel.hasFetched {
						FLButton(
							text: String(localized: "Load features", bundle: .module), action: {
								featureModel.fetchList()
							},
							style: .primary,
							isLoading: .constant(false),
							size: CGSize(width: 100, height: 50)
						)
						.padding(.vertical)
					}
				}

				Text("\(FLFeatureRequest.config.localization.poweredBy) FLFeatureRequest")
					.font(.footnote)
					.foregroundStyle(.secondary)
					.padding(.top)

				Spacer(minLength: isInTabBar ? 100 : 25)
			}
			.refreshableCompat {
				await featureModel.fetchList()
			}
			.padding([.leading, .bottom, .trailing])

			HStack {
				Spacer()

				VStack(alignment: .trailing) {
					Spacer()

					VStack {
						NavigationLink(destination: CreateFeatureView { featureModel.fetchList() }) {
							AddButton(size: CGSize(width: 60, height: 60))
						}
					}
					.padding(.bottom, addButtonBottomPadding)
				}
				.padding(.trailing, 20)
			}
			.frame(maxWidth: 700)
		}
		.frame(maxWidth: .infinity)
		.background(backgroundColor)
		.ignoresSafeArea(edges: [.leading, .bottom, .trailing])
		.navigationTitle(FLFeatureRequest.config.localization.featureFeaturelist)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) {
				getRefreshButton()
			}

			ToolbarItem(placement: .topBarTrailing) {
				if FLFeatureRequest.config.buttons.doneButton.display == .show && showDismissButton {
					Button(FLFeatureRequest.config.localization.done) {
						UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController?.dismiss(animated: true)
					}
				}
			}
		}
	}

	// MARK: - View

	func getRefreshButton() -> some View {
		if #unavailable(iOS 15) {
			return Button(action: featureModel.fetchList) {
				Image(systemName: "arrow.clockwise")
			}
		} else {
			return EmptyView()
		}
	}
}

extension FeatureListViewIOS {

	var arrowColor: Color {
		let userUUID = UUIDManager.getUUID()

		if let selectedFeature,
			 selectedFeature.votingUsers.contains(where: { user in user.uuid == userUUID }) {
			return FLFeatureRequest.theme.primaryColor
		}

		switch colorScheme {
		case .light:
			return FLFeatureRequest.config.buttons.voteButton.arrowColor.light
		case .dark:
			return FLFeatureRequest.config.buttons.voteButton.arrowColor.dark
		@unknown default:
			return FLFeatureRequest.config.buttons.voteButton.arrowColor.light
		}
	}

	var cellBackgroundColor: Color {
		switch colorScheme {
		case .light:
			if let color = FLFeatureRequest.theme.secondaryColor {
				return color.light
			}

			return PrivateTheme.elementBackgroundColor.light
		case .dark:
			if let color = FLFeatureRequest.theme.secondaryColor {
				return color.dark
			}

			return PrivateTheme.elementBackgroundColor.dark
		@unknown default:
			if let color = FLFeatureRequest.theme.secondaryColor {
				return color.light
			}

			return PrivateTheme.elementBackgroundColor.light
		}
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

#Preview {
	FeatureListViewIOS(featureModel: .init())
}
#endif
