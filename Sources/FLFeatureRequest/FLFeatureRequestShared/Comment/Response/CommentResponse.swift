//
//  CreateCommentRequest.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 8/11/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

public struct CommentResponse: Codable {

	public let id: UUID
	public let userId: UUID
	public let description: String
	public let createdAt: Date
	public let isAdmin: Bool

	public init(id: UUID, userId: UUID, description: String, createdAt: Date, isAdmin: Bool) {
		self.id = id
		self.userId = userId
		self.description = description
		self.createdAt = createdAt
		self.isAdmin = isAdmin
	}
}
