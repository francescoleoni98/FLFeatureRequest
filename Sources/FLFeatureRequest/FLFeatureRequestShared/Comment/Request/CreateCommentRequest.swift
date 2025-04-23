//
//  CreateCommentRequest.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 8/11/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

public struct CreateCommentRequest: Codable {
	
	public let featureId: UUID
	public let description: String

	public init(featureId: UUID, description: String) {
		self.featureId = featureId
		self.description = description
	}
}
