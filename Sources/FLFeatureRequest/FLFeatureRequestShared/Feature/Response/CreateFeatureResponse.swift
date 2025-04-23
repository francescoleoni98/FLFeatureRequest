//
//  CreateFeatureResponse.swift
//  FLFeatureReequest-example
//
//  Created by Francesco Leoni on 2/12/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

public struct CreateFeatureResponse: Codable {

	public let title: String
	public var description: String
	public var state: FeatureState

	public init(title: String, description: String, state: FeatureState) {
		self.title = title
		self.description = description
		self.state = state
	}
}
