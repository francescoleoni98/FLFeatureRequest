//
//  FLFeatureRequestApiInterface.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 23/04/25.
//

import Foundation

public protocol FLFeatureRequestApiInterface {

	func fetchFeaturesList(completionHandler: @escaping (Result<[FeatureResponse], ApiError>) -> Void)
	func createFeature(createRequest: CreateFeatureRequest, completionHandler: @escaping (Result<Void, Error>) -> Void)
	func voteFeature(feature: FeatureResponse, completionHandler: @escaping (Result<Void, Error>) -> Void)
	func createComment(request: CreateCommentRequest) async -> ApiResult<CommentResponse, ApiError>
	func updateUser(userRequest: UserRequest, completionHandler: @escaping (ApiResult<Void, Error>) -> Void)
}
