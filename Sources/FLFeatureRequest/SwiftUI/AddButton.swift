//
//  AddButton.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 3/8/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

struct AddButton: View {

	@Environment(\.colorScheme)
	private var colorScheme

	@State
	private var showingSheet = false

	private let size: CGSize
	private let buttonAction: () -> ()

	init(size: CGSize = CGSize(width: 45, height: 45), buttonAction: (() -> ())? = nil) {
		self.size = size
		self.buttonAction = buttonAction ?? { }
	}

	var body: some View {
#if os(macOS) || os(visionOS)
		Button(action: buttonAction) {
			HStack {
				Image(systemName: "plus")
					.font(.system(size: 20, weight: .medium))

				Text(FLFeatureRequest.config.localization.submit)
					.fontWeight(.medium)
			}
			.foregroundColor(addButtonTextColor)
			.padding(12)
			.padding(.horizontal, 8)
			.background(FLFeatureRequest.theme.primaryColor, in: .capsule)
		}
		.buttonStyle(.plain)
#else
		HStack {
			Image(systemName: "plus")
				.font(.system(size: 22, weight: .bold))

			Text(FLFeatureRequest.config.localization.submit)
				.bold()
		}
		.foregroundColor(addButtonTextColor)
		.padding()
		.background(FLFeatureRequest.theme.primaryColor)
		.clipShape(.capsule)
		.shadow(color: .black.opacity(1/4), radius: 3, x: 0, y: 3)
#endif
	}

	var addButtonTextColor: Color {
		switch colorScheme {
		case .light:
			return FLFeatureRequest.config.buttons.addButton.textColor.light
		case .dark:
			return FLFeatureRequest.config.buttons.addButton.textColor.dark
		@unknown default:
			return FLFeatureRequest.config.buttons.addButton.textColor.light
		}
	}
}

struct RoundButtonStyle: ButtonStyle {

	func makeBody(configuration: Self.Configuration) -> some View {
		configuration
			.label
			.foregroundColor(configuration.isPressed ? .white.opacity(0.66) : .white)
			.background(FLFeatureRequest.theme.primaryColor)
	}
}

extension ButtonStyle where Self == RoundButtonStyle {
	static var roundButtonStyle: RoundButtonStyle {
		RoundButtonStyle()
	}
}

#Preview {
	AddButton {

	}
}
