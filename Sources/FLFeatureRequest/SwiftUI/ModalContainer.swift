//
//  SwiftUIView.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 28/11/25.
//

import SwiftUI

struct ModalContainer<Content: View, ConfirmationButton: View>: View {

	var title: String
	var height: CGFloat = 500
	@ViewBuilder var confirmationButton: () -> ConfirmationButton
	@ViewBuilder var content: () -> Content
	var onClose: (() -> Void)? = nil

	var body: some View {
#if os(macOS)
		VStack(spacing: 16) {
			HStack {
				if let onClose {
					Button(FLFeatureRequest.config.localization.cancel) {
						onClose()
					}
					.buttonStyle(SecondaryModalButtonStyle())
				}

				Spacer()

				confirmationButton()
					.buttonStyle(PrimaryModalButtonStyle())
			}
			.overlay {
				Text(title)
					.bold()
					.frame(maxWidth: 400)
			}

			if #available(macOS 13.0, *) {
				content()
					.clipShape(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 16, topTrailing: 16)))
			} else {
				content()
			}
		}
		.padding([.top, .horizontal])
//		.presentationBackground(Color("white"))
		.frame(height: height)
#else
		content()
			.navigationTitle(title)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					if let onClose {
						Button(FLFeatureRequest.config.localization.cancel) {
							onClose()
						}
					}
				}

				ToolbarItem(placement: .confirmationAction) {
					confirmationButton()
				}
			}
#endif
	}
}

struct PrimaryModalButtonStyle: ButtonStyle {

	func makeBody(configuration: ButtonStyleConfiguration) -> some View {
		configuration.label
			.padding(6)
			.padding(.horizontal, 6)
			.opacity(configuration.isPressed ? 0.7 : 1)
			.foregroundStyle(.white)
			.background(FLFeatureRequest.theme.primaryColor, in: .rect(cornerRadius: 12))
	}
}

struct SecondaryModalButtonStyle: ButtonStyle {

	func makeBody(configuration: ButtonStyleConfiguration) -> some View {
		configuration.label
			.padding(6)
			.padding(.horizontal, 6)
			.opacity(configuration.isPressed ? 0.7 : 1)
			.foregroundStyle(.primary)
			.background(FLFeatureRequest.theme.primaryColor.opacity(0.05), in: .rect(cornerRadius: 12))
	}
}
