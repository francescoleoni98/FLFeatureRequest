//
//  CreateFeatureView.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 8/26/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI
import Combine

struct CreateFeatureView: View {
	
	@Environment(\.presentationMode) var presentationMode
	
	@Environment(\.colorScheme)
	private var colorScheme
	
	@Environment(\.dismiss)
	private var dismiss
	
	@ObservedObject
	private var alertModel = AlertModel()
	
	@State
	private var titleCharCount = 0
	
	@State
	private var titleText = ""
	
	@State
	private var emailText = ""
	
	@State
	private var descriptionText = ""
	
	@State
	private var isButtonDisabled = true
	
	@State
	private var isButtonLoading: Bool? = false
	
	let createActionCompletion: () -> Void
	
	var closeAction: (() -> Void)? = nil
	
	var saveButtonSize: CGSize {
#if os(macOS) || os(visionOS)
		return CGSize(width: 100, height: 30)
#else
		return CGSize(width: 200, height: 45)
#endif
	}
	
	var body: some View {
		VStack(spacing: 0) {
			if showCloseButton() {
				HStack {
					Spacer()
					CloseButton(closeAction: { closeAction?() })
				}
			}
			
			ScrollView {
				VStack(spacing: 12) {
					VStack(spacing: 0) {
						HStack {
							Text(FLFeatureRequest.config.localization.title)
							Spacer()
							//                            Text("\(titleText.count)/50")
						}
						.font(.body)
						.padding([.leading, .trailing, .bottom], 5)
						
						TextField(String(localized: "Feature name", bundle: .module), text: $titleText)
							.padding(10)
							.textFieldStyle(.plain)
							.foregroundColor(textColor)
							.background(fieldBackgroundColor)
							.clipShape(RoundedRectangle(cornerRadius: FLFeatureRequest.config.cornerRadius, style: .continuous))
							.onReceive(Just(titleText)) { _ in handleTitleAndDescriptionChange() }
					}
					
					VStack(spacing: 0) {
						HStack {
							Text(FLFeatureRequest.config.localization.description)
							Spacer()
							//                            Text("\(descriptionText.count)/500")
						}
						.font(.body)
						.padding([.leading, .trailing, .bottom], 5)
						
						if #available(iOS 16, *) {
							TextEditor(text: $descriptionText)
								.padding([.leading, .trailing], 5)
								.padding([.top, .bottom], 10)
								.lineSpacing(3)
								.frame(height: 100)
								.foregroundColor(textColor)
								.scrollContentBackgroundCompat(.hidden)
								.background(fieldBackgroundColor)
								.clipShape(RoundedRectangle(cornerRadius: FLFeatureRequest.config.cornerRadius, style: .continuous))
								.onReceive(Just(descriptionText)) { _ in handleTitleAndDescriptionChange() }
						} else {
							TextField(String(localized: "Describe the feature", bundle: .module), text: $descriptionText)
								.padding([.leading, .trailing], 15)
								.padding([.top, .bottom], 10)
								.foregroundColor(textColor)
								.background(fieldBackgroundColor)
								.clipShape(RoundedRectangle(cornerRadius: FLFeatureRequest.config.cornerRadius, style: .continuous))
								.onReceive(Just(descriptionText)) { _ in handleTitleAndDescriptionChange() }
						}
					}
					
					if FLFeatureRequest.config.emailField != .none {
						VStack(spacing: 0) {
							HStack {
								if FLFeatureRequest.config.emailField == .optional {
									Text(FLFeatureRequest.config.localization.emailOptional)
										.font(.body)
										.padding([.leading, .trailing, .bottom], 5)
								}
								
								if FLFeatureRequest.config.emailField == .required {
									Text(FLFeatureRequest.config.localization.emailRequired)
										.font(.caption2)
										.padding([.leading, .trailing, .bottom], 5)
								}
								
								Spacer()
							}
							
							TextField(String(localized: "Email", bundle: .module), text: $emailText)
								.padding(10)
								.textFieldStyle(.plain)
								.foregroundColor(textColor)
								.background(fieldBackgroundColor)
								.clipShape(RoundedRectangle(cornerRadius: FLFeatureRequest.config.cornerRadius, style: .continuous))
						}
					}

					FLButton(
						text: FLFeatureRequest.config.localization.submit,
						action: submitAction,
						style: .primary,
						isLoading: $isButtonLoading,
						size: saveButtonSize
					)
					.disabled(isButtonDisabled)
					.alert(isPresented: $alertModel.showAlert) {
						switch alertModel.alertReason {
						case .successfullyCreated:
							let button = Alert.Button.default(
								Text(FLFeatureRequest.config.localization.ok),
								action: {
									createActionCompletion()
									dismissAction()
								}
							)
							
							return Alert(
								title: Text(FLFeatureRequest.config.localization.info),
								message: Text(FLFeatureRequest.config.localization.successfullyCreated),
								dismissButton: button
							)
						case .createReturnedError(let errorText):
							let button = Alert.Button.default(Text(FLFeatureRequest.config.localization.ok))
							
							return Alert(
								title: Text(FLFeatureRequest.config.localization.info),
								message: Text(errorText),
								dismissButton: button
							)
						case .emailRequired:
							let button = Alert.Button.default(Text(FLFeatureRequest.config.localization.ok))
							
							return Alert(
								title: Text(FLFeatureRequest.config.localization.info),
								message: Text(FLFeatureRequest.config.localization.emailRequiredText),
								dismissButton: button
							)
						case .emailFormatWrong:
							let button = Alert.Button.default(Text(FLFeatureRequest.config.localization.ok))
							
							return Alert(
								title: Text(FLFeatureRequest.config.localization.info),
								message: Text(FLFeatureRequest.config.localization.emailFormatWrongText),
								dismissButton: button
							)
						case .none:
							let button = Alert.Button.default(Text(FLFeatureRequest.config.localization.ok))
							return Alert(title: Text(""), dismissButton: button)
						default:
							let button = Alert.Button.default(Text(FLFeatureRequest.config.localization.ok))
							return Alert(title: Text(""), dismissButton: button)
						}
						
					}
				}
				.frame(maxWidth: 700)
				.padding()
				
#if os(iOS)
				Spacer()
#endif
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(backgroundColor)
		.ignoresSafeArea(edges: [.leading, .trailing])
		.toolbarKeyboardDoneButton()
	}
	
	private func showCloseButton() -> Bool {
#if os(macOS) || os(visionOS)
		return true
#else
		return false
#endif
	}
	
	private func handleTitleAndDescriptionChange() {
		
		// Keep characters within limits
		//        let titleLimit = 50
		//        let descriptionLimit = 500
		
		//        if titleText.count > titleLimit {
		//            titleText = String(titleText.prefix(titleLimit))
		//        }
		
		//        if descriptionText.count > descriptionLimit {
		//            descriptionText = String(descriptionText.prefix(descriptionLimit))
		//        }
		
		// Enable/Disable button
		isButtonDisabled = titleText.isEmpty //|| descriptionText.isEmpty
	}
	
	private func submitAction() {
		if FLFeatureRequest.config.emailField == .required && emailText.isEmpty {
			alertModel.alertReason = .emailRequired
			alertModel.showAlert = true
			return
		}
		
		let isInvalidEmailFormat = (emailText.count < 6 || !emailText.contains("@") || !emailText.contains("."))
		if !emailText.isEmpty && isInvalidEmailFormat {
			alertModel.alertReason = .emailFormatWrong
			alertModel.showAlert = true
			return
		}
		
		isButtonLoading = true
		
		let createRequest = CreateFeatureRequest(title: titleText, description: descriptionText, email: emailText)
		FLFeatureRequest.api.createFeature(createRequest: createRequest) { result in
			isButtonLoading = false
			DispatchQueue.main.async {
				switch result {
				case .success:
					//					alertModel.alertReason = .successfullyCreated
					//					alertModel.showAlert = true
					dismiss()
					
				case .failure(let error):
					alertModel.alertReason = .createReturnedError(error.localizedDescription)
					alertModel.showAlert = true
				}
			}
		}
	}
	
	private func dismissAction() {
		presentationMode.wrappedValue.dismiss()
	}
}

// MARK: - Color Scheme

extension CreateFeatureView {
	
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
	
	var fieldBackgroundColor: Color {
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
			if let color = FLFeatureRequest.theme.tertiaryColor {
				return color.light
			}
			
			return PrivateTheme.systemBackgroundColor.light
		}
	}
}
