//
//  DefaultApi.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 8/4/25.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

class MockApi: FLFeatureRequestApiInterface {

	func fetchFeaturesList(completionHandler: @escaping (Result<[FeatureResponse], ApiError>) -> Void) {
		completionHandler(.success([
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Dark Mode", description: "Add a dark mode option for the app", state: .approved),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Push Notifications", description: "Enable push notifications for user updates", state: .implemented),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Profile Customization", description: "Allow users to customize their profile", state: .pending),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Offline Mode", description: "Allow app usage without internet connection", state: .rejected),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Search Functionality", description: "Add search functionality to the app", state: .approved),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Analytics Dashboard", description: "Create an analytics dashboard for user activity", state: .approved),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Multi-language Support", description: "Add support for multiple languages", state: .approved),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Social Sharing", description: "Allow users to share content to social media", state: .implemented),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "In-app Chat", description: "Implement real-time chat between users", state: .implemented),
			FeatureResponse(id: UUID(), userUUID: UUID().uuidString, title: "Two-Factor Authentication", description: "Add 2FA for enhanced security", state: .approved)
		]))
	}

	func createFeature(createRequest: CreateFeatureRequest, completionHandler: @escaping (Result<Void, Error>) -> Void) {
		completionHandler(.success(()))
	}

	func voteFeature(feature: FeatureResponse, completionHandler: @escaping (Result<Void, Error>) -> Void) {
		completionHandler(.success(()))
	}

	func createComment(request: CreateCommentRequest) async -> ApiResult<CommentResponse, ApiError> {
		.failure(ApiError(reason: .couldNotCreateRequest))
	}

	func updateUser(userRequest: UserRequest, completionHandler: @escaping (ApiResult<Void, any Error>) -> Void) {
		completionHandler(.success(()))
	}
}
