//
//  CreateFeatureRequest.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 2/11/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

public struct CreateFeatureRequest: Codable {

	public let title: String
	public var description: String
	public var email: String?
	public var state: FeatureState

	public init(
		title: String,
		description: String,
		email: String? = nil,
		state: FeatureState = .pending
	) {
		self.title = title
		self.description = description
		self.email = email
		self.state = state
	}
}
