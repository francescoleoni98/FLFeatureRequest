//
//  CreateCommentRequest.swift
//  wishkit-ios-shared
//
//  Created by Martin Lasek on 8/11/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation

public struct CreateCommentRequest: Codable {

    public let wishId: UUID

    public let description: String

    public init(wishId: UUID, description: String) {
        self.wishId = wishId
        self.description = description
    }
}
