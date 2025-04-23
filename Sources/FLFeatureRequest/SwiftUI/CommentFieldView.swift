//
//  SwiftUIView.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 8/14/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

struct CommentFieldView: View {

    @Environment(\.colorScheme)
    private var colorScheme

    @Binding
    private var textFieldValue: String

    @Binding
    private var isLoading: Bool

    private let submitAction: () async throws -> ()

    init(
        _ textFieldValue: Binding<String>,
        isLoading: Binding<Bool>,
        submitAction: @escaping () async throws -> ()
    ) {
        self._textFieldValue = textFieldValue
        self._isLoading = isLoading
        self.submitAction = submitAction
    }

    var body: some View {
        ZStack {
            TextField(FLFeatureRequest.config.localization.writeAComment, text: $textFieldValue)
                .textFieldStyle(.plain)
                .font(.footnote)
                .padding([.top, .leading, .bottom], 15)
                .padding([.trailing], 40)
                .foregroundColor(textColor)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            HStack {
                Spacer()
                if isLoading {
                    ProgressView()
                        .controlSizeCompat(.small)
                        .padding(10)
                } else {
                    Button {
                      Task {
                        try await submitAction()
                      }
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .padding(10)
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(FLFeatureRequest.theme.primaryColor)
                    .disabled(textFieldValue.replacingOccurrences(of: " ", with: "").isEmpty)
                }
            }
        }
    }
}

extension CommentFieldView {

    var textColor: Color {
        switch colorScheme {
        case .light:
            if let color = FLFeatureRequest.theme.textColor {
                return color.light
            }

            return .black
        case .dark:
            if let color = FLFeatureRequest.theme.textColor {
                return color.dark
            }

            return .white
				@unknown default:
					if let color = FLFeatureRequest.theme.textColor {
							return color.light
					}

					return .black
				}
    }

    var backgroundColor: Color {
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
}
