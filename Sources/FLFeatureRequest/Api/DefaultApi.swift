//
//  DefaultApi.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 8/4/25.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DefaultApi: FLFeatureRequestApiInterface {

	let featuresRef = Database.database().reference().child("wishes")
	let usersRef = Database.database().reference().child("users")

	func fetchFeaturesList(completionHandler: @escaping (Result<[FeatureResponse], ApiError>) -> Void) {
		featuresRef.observeSingleEvent(of: .value) { snapshot in
			guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
				completionHandler(.failure(ApiError(reason: .couldNotDecodeBackendResponse)))
				return
			}

			let list = children.compactMap { snapshot in
				do {
					return try snapshot.data(as: FeatureResponse.self)
				} catch {
					print("[FLFeatureRequest]: ", error)
					return nil
				}
			}

			completionHandler(.success(list))
		}
	}

	func createFeature(createRequest: CreateFeatureRequest, completionHandler: @escaping (Result<Void, Error>) -> Void) {
		let id = UUID().uuidString

		var params = ["id" : id,
									"userUUID" : UUIDManager.getUUID(),
									"title" : createRequest.title.trimmed,
									"description" : createRequest.description.trimmed,
									"state" : createRequest.state.rawValue]

		if let email = createRequest.email, !email.trimmed.isEmpty {
			params["email"] = email.trimmed
		}

		featuresRef.child(id).setValue(params) { error, _ in
			if let error {
				completionHandler(.failure(error))
			} else {
				completionHandler(.success(()))
			}
		}
	}

	func voteFeature(feature: FeatureResponse, completionHandler: @escaping (Result<Void, Error>) -> Void) {
		feature.votingUsers.append(UserResponse(uuid: UUIDManager.getUUID()))

		featuresRef.child(feature.id.uuidString).updateChildValues(["votingUsers" : feature.votingUsers.map { $0.uuid }]) { error, _ in
			if let error {
				completionHandler(.failure(error))
			} else {
				completionHandler(.success(()))
			}
		}
	}

	func createComment(request: CreateCommentRequest) async -> ApiResult<CommentResponse, ApiError> {
		.failure(ApiError(reason: .couldNotCreateRequest))
	}

	func updateUser(userRequest: UserRequest, completionHandler: @escaping (ApiResult<Void, any Error>) -> Void) {
		let id = UUIDManager.getUUID()

		var params: [String : Any] = [:]

		if let customID = userRequest.customID {
			params["customID"] = customID
		}

		if let email = userRequest.email, !email.trimmed.isEmpty {
			params["email"] = email.trimmed
		}

		if let name = userRequest.name, !name.trimmed.isEmpty {
			params["name"] = name.trimmed
		}

		if let paymentPerMonth = userRequest.paymentPerMonth {
			params["paymentPerMonth"] = paymentPerMonth
			params["currencyCode"] = userRequest.currencyCode
		}

		usersRef.child(id).setValue(params) { error, _ in
			if let error {
				completionHandler(.failure(error))
			} else {
				completionHandler(.success(()))
			}
		}
	}
}

extension DataSnapshot {

	var data: Data? {
		guard let value = value, !(value is NSNull) else { return nil }
		return try? JSONSerialization.data(withJSONObject: value)
	}
}
