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
				return String(localized: "Backend responded with an error.", bundle: .module)
			case .wrongBearerToken:
				return String(localized: "Wrong Bearer Token.", bundle: .module)
			case .unknown:
				return String(localized: "An unknown error occured.", bundle: .module)
			case .couldNotCreateRequest:
				return String(localized: "Could not create request.", bundle: .module)
			case .couldNotDecodeBackendResponse:
				return String(localized: "Could not decode backend response.", bundle: .module)
			case .missingApiHeaderKey:
				return String(localized: "Missing api header key.", bundle: .module)
			case .missingUUIDHeaderKey:
				return String(localized: "Missing user header key.", bundle: .module)
			}
		}
	}
}
