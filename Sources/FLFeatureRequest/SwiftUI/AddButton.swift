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
			Image(systemName: "plus")
				.font(.system(size: 22, weight: .bold))
				.frame(width: size.width, height: size.height)
				.foregroundColor(addButtonTextColor)
				.background(FLFeatureRequest.theme.primaryColor)
				.clipShape(.circle)
		}
		.buttonStyle(.plain)
		.buttonStyle(.roundButtonStyle)
		.frame(width: size.width, height: size.height)
		.background(FLFeatureRequest.theme.primaryColor)
		.clipShape(.circle)
		.shadow(color: .black.opacity(0.33), radius: 5, x: 0, y: 5)
#else
		VStack {
			Image(systemName: "plus")
				.font(.system(size: 22, weight: .bold))
				.foregroundColor(addButtonTextColor)
		}
		.frame(width: size.width, height: size.height)
		.background(FLFeatureRequest.theme.primaryColor)
		.clipShape(.circle)
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
