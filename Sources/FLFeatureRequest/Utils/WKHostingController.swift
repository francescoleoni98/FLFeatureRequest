//
//  WKHostingController.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 8/15/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//
#if canImport(UIKit)
import SwiftUI

final class WKHostingController<Content>: UIHostingController<Content> where Content: View {
	override init(rootView: Content) {
		super.init(rootView: rootView)
		applyTheme()
	}

	@MainActor required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func applyTheme() {
		let backgroundColorLight = FLFeatureRequest.theme.tertiaryColor?.light ?? PrivateTheme.systemBackgroundColor.light
		let backgroundColorDark = FLFeatureRequest.theme.tertiaryColor?.dark ?? PrivateTheme.systemBackgroundColor.dark

		if traitCollection.userInterfaceStyle == .light {
			view.backgroundColor = UIColor(backgroundColorLight)
		}

		if traitCollection.userInterfaceStyle == .dark {
			view.backgroundColor = UIColor(backgroundColorDark)
		}
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		guard
			let previousTraitCollection = previousTraitCollection
		else {
			return
		}

		// Needed this case where it's the same, there's a weird behaviour otherwise.
		if traitCollection.userInterfaceStyle == previousTraitCollection.userInterfaceStyle {
			if let bgColor = FLFeatureRequest.theme.tertiaryColor {
				if previousTraitCollection.userInterfaceStyle == .light {
					view.backgroundColor = UIColor(bgColor.light)
				} else if previousTraitCollection.userInterfaceStyle == .dark {
					view.backgroundColor = UIColor(bgColor.dark)
				}
			}
		} else {
			if let bgColor = FLFeatureRequest.theme.tertiaryColor {
				if previousTraitCollection.userInterfaceStyle == .dark {
					view.backgroundColor = UIColor(bgColor.light)
				} else if previousTraitCollection.userInterfaceStyle == .light {
					view.backgroundColor = UIColor(bgColor.dark)
				}
			} else {
				if traitCollection.userInterfaceStyle == .light {
					view.backgroundColor = UIColor(PrivateTheme.systemBackgroundColor.light)
				} else if traitCollection.userInterfaceStyle == .dark {
					view.backgroundColor = UIColor(PrivateTheme.systemBackgroundColor.dark)
				}
			}
		}
	}
}
#endif
