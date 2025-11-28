//
//  FLButton.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 3/10/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

struct FLButton: View {

	@Environment(\.colorScheme)
	var colorScheme

	private let text: String
	private let action: () -> ()
	private let style: FeatureButtonStyle
	private let size: CGSize

	@Binding
	var isLoading: Bool?

	public init(
		text: String,
		action: @escaping () -> (),
		style: FeatureButtonStyle = .primary,
		isLoading: Binding<Bool?> = Binding.constant(nil),
		size: CGSize = CGSize(width: 100, height: 30)
	) {
		self.text = text
		self.action = action
		self.style = style
		self._isLoading = isLoading
		self.size = size
	}

	var body: some View {
		Button(action: action) {
			if isLoading ?? false {
				ProgressView()
					.scaleEffect(0.5)
			} else {
				Text(text)
					.bold()
					.padding(12)
					.padding(.horizontal, 8)
					.foregroundColor(textColor)
					.multilineTextAlignment(.center)
					.background(getColor(for: style), in: .capsule)
			}
		}
		.buttonStyle(.plain)
		.disabled(isLoading ?? false)
	}

	func getColor(for style: FeatureButtonStyle) -> Color {
		switch style {
		case .primary:
			return FLFeatureRequest.theme.primaryColor
		case .secondary:
			return backgroundColor
		}
	}

	var textColor: Color {
		switch colorScheme {
		case .light:
			return FLFeatureRequest.config.buttons.saveButton.textColor.light
		case .dark:
			return FLFeatureRequest.config.buttons.saveButton.textColor.dark
		@unknown default:
			return FLFeatureRequest.config.buttons.saveButton.textColor.light
		}
	}

	var backgroundColor: Color {
		switch colorScheme {
		case .light:
			return PrivateTheme.elementBackgroundColor.light
		case .dark:
			return PrivateTheme.elementBackgroundColor.dark
		@unknown default:
			return PrivateTheme.elementBackgroundColor.light
		}
	}
}

// MARK: - ButtonStyle

extension FLButton {
	enum FeatureButtonStyle {
		case primary
		case secondary
	}
}

#Preview {
	FLButton(text: "Save") {

	}
}
