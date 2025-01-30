//
//  ApiError.swift
//  wishkit-ios-shared
//
//  Created by Martin Lasek on 4/7/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

public struct ApiError: Error, Codable {

    public let reason: Reason

    public init(reason: Reason) {
        self.reason = reason
    }

    public enum Reason: String, Codable {
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
