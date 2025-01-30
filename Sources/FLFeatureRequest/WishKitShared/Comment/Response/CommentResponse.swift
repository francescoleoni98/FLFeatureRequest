//
//  CreateCommentRequest.swift
//  wishkit-ios-shared
//
//  Created by Martin Lasek on 8/11/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
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
