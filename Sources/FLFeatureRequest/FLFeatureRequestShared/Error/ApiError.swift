//
//  ApiError.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 4/7/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

public struct ApiError: Error, Codable {

	public let reason: Reason

	public init(reason: Reason) {
		self.reason = reason
	}

	public enum Reason: String, Codable, Sendable {
		case requestResultedInError
		case wrongBearerToken
		case unknown
		case couldNotCreateRequest
		case couldNotDecodeBackendResponse
		case missingApiHeaderKey
		case missingUUIDHeaderKey

		public var description: String {
			switch self {
			case .requestResultedInError:
				return "Backend responded with an error."
			case .wrongBearerToken:
				return "Wrong Bearer Token."
			case .unknown:
				return "An unknown error occured."
			case .couldNotCreateRequest:
				return "Could not create request."
			case .couldNotDecodeBackendResponse:
				return "Could not decode backend response."
			case .missingApiHeaderKey:
				return "Missing api header key."
			case .missingUUIDHeaderKey:
				return "Missing user header key."
			}
		}
	}
}
