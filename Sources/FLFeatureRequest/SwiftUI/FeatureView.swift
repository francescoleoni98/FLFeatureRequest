//
//  FeatureView.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 8/12/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

struct FeatureView: View {
	
	// Helps differentiate where this view is used (in the list or in detail view).
	enum ViewKind {
		case list
		case detail
	}
	
	@Environment(\.colorScheme)
	private var colorScheme
	
	@ObservedObject
	private var alertModel = AlertModel()
	
	@State
	private var voteCount = 0
	
	@State
	private var hasVoted = false
	
	private let featureResponse: FeatureResponse
	
	private let voteActionCompletion: () -> Void
	
	private let viewKind: ViewKind
	
	private var descriptionLineLimit: Int? {
		if viewKind == .detail {
			return nil
		}
		
		return FLFeatureRequest.config.expandDescriptionInList ? nil : 1
	}
	
	init(featureResponse: FeatureResponse, viewKind: ViewKind, voteActionCompletion: @escaping (() -> Void)) {
		self.featureResponse = featureResponse
		self.viewKind = viewKind
		self.voteActionCompletion = voteActionCompletion
		self._voteCount = State(wrappedValue: featureResponse.votingUsers.count)
	}
	
	var body: some View {
		HStack(spacing: 0) {
			Button(action: voteAction) {
				VStack(spacing: 5) {
					Image(systemName: "arrowtriangle.up.fill")
						.imageScale(.medium)
						.foregroundColor(arrowColor)
					Text(String(describing: voteCount))
						.font(.system(size: 17, weight: .medium))
						.foregroundColor(textColor)
						.frame(width: 35)
				}
				.padding([.leading, .trailing], 12)
				.cornerRadius(12)
			}
			.buttonStyle(.plain) // makes sure it looks good on macOS.
			.alert(isPresented: $alertModel.showAlert) {
				var title = Text(FLFeatureRequest.config.localization.youCanNotVoteForYourOwnFeature)
				switch alertModel.alertReason {
				case .alreadyVoted:
					title = Text(FLFeatureRequest.config.localization.youCanOnlyVoteOnce)
				case .alreadyImplemented:
					title = Text(FLFeatureRequest.config.localization.youCanNotVoteForAnImplementedFeature)
				case .voteReturnedError(let error):
					title = Text("Something went wrong during your vote. Try again later.\n\n\(error)", bundle: .module)
				case .none:
					title = Text(FLFeatureRequest.config.localization.youCanNotVoteForYourOwnFeature)
				default:
					title = Text("Something went wrong during your vote. Try again later.", bundle: .module)
				}
				
				return Alert(title: title)
			}
			
			VStack(spacing: 5) {
				HStack {
					Text(featureResponse.title)
						.foregroundColor(textColor)
						.font(.body)
						.fontWeight(.semibold)
						.multilineTextAlignment(.leading)
						.lineLimit(viewKind == .list ? 1 : nil)
					
					Spacer()
					
					if viewKind == .list && FLFeatureRequest.config.statusBadge == .show {
						Text(featureResponse.state.description.uppercased())
							.font(.footnote)
							.fontWeight(.medium)
							.padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5))
							.foregroundColor(badgeColor(for: featureResponse.state))
							.background(badgeColor(for: featureResponse.state).opacity(0.1))
							.cornerRadius(6)
					}
				}
				
				HStack {
					Text(featureResponse.description)
						.foregroundColor(textColor)
						.font(.subheadline)
						.multilineTextAlignment(.leading)
						.lineLimit(descriptionLineLimit)

					Spacer()
				}
			}
		}
		.padding([.top, .bottom, .trailing], 10)
		.background(colorScheme == .dark ? .white.opacity(0.05) : .black.opacity(0.05))
		.clipShape(RoundedRectangle(cornerRadius: FLFeatureRequest.config.cornerRadius, style: .continuous))
		.wkShadow()
	}
	
	func badgeColor(for featureState: FeatureState) -> Color {
		switch featureState {
		case .pending:
			return FLFeatureRequest.theme.badgeColor.pending
		case .approved:
			return FLFeatureRequest.theme.badgeColor.approved
		case .implemented:
			return FLFeatureRequest.theme.badgeColor.implemented
		case .rejected:
			return FLFeatureRequest.theme.badgeColor.rejected
		}
	}
	
	private func voteAction() {
		let userUUID = UUIDManager.getUUID()
		
		if featureResponse.state == .implemented {
			alertModel.alertReason = .alreadyImplemented
			alertModel.showAlert = true
			return
		}
		
		if featureResponse.votingUsers.contains(where: { user in user.uuid == userUUID }) || hasVoted {
			alertModel.alertReason = .alreadyVoted
			alertModel.showAlert = true
			return
		}
		
		FLFeatureRequest.api.voteFeature(feature: featureResponse) { result in
			switch result {
			case .success:
				voteCount += 1
				hasVoted = true
				voteActionCompletion()
			case .failure(let error):
				alertModel.alertReason = .voteReturnedError(error.localizedDescription)
				alertModel.showAlert = true
			}
		}
	}
}

// MARK: - Darkmode

extension FeatureView {
	var arrowColor: Color {
		let userUUID = UUIDManager.getUUID()
		if featureResponse.votingUsers.contains(where: { user in user.uuid == userUUID }) || hasVoted {
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
