//
//  DetailFeatureView+iOS.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 8/13/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI
import Combine

struct DetailFeatureView: View {
	
	// MARK: - Private
	
	@Environment(\.colorScheme)
	private var colorScheme
	
	@ObservedObject
	private var commentModel = CommentModel()
	
	@State
	private var commentList: [CommentResponse] = []
	
	private let featureResponse: FeatureResponse
	
	private let voteActionCompletion: () -> Void
	
	private let closeAction: (() -> Void)?
	
	init(
		featureResponse: FeatureResponse,
		voteActionCompletion: @escaping (() -> Void),
		closeAction: (() -> Void)? = nil
	) {
		self.featureResponse = featureResponse
		self.voteActionCompletion = voteActionCompletion
		self.closeAction = closeAction
		self._commentList = State(wrappedValue: featureResponse.commentList)
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
				VStack {
					
					Spacer(minLength: 15)
					
					FeatureView(featureResponse: featureResponse, viewKind: .detail, voteActionCompletion: voteActionCompletion)
						.frame(maxWidth: 700)
					
					Spacer(minLength: 15)
					
					if FLFeatureRequest.config.commentSection == .show {
						SeparatorView()
							.padding([.top, .bottom], 15)
						
						//                        CommentFieldView($commentModel.newCommentValue, isLoading: $commentModel.isLoading) {
						//                            let request = CreateCommentRequest(featureId: featureResponse.id, description: commentModel.newCommentValue)
						//
						//                            commentModel.isLoading = true
						//														let response = await FLFeatureRequest.api.createComment(request: request)
						//                            commentModel.isLoading = false
						//
						//                            switch response {
						//                            case .success(let commentResponse):
						//                                withAnimation {
						//                                    commentList.insert(commentResponse, at: 0)
						//                                }
						//
						//                                commentModel.newCommentValue = ""
						//                            case .failure(let error):
						//                                print("❌ \(error.localizedDescription)")
						//                            }
						//                        }.frame(maxWidth: 700)
						
						Spacer(minLength: 20)
						
						CommentListView(commentList: $commentList)
							.frame(maxWidth: 700)
					}
				}.padding([.leading, .bottom, .trailing])
			}.ignoresSafeArea(edges: [.bottom, .leading, .trailing])
			
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(backgroundColor)
	}
	
	private func showCloseButton() -> Bool {
#if os(macOS) || os(visionOS)
		return true
#else
		return false
#endif
	}
}

// MARK: - Color Scheme

extension DetailFeatureView {
	
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
