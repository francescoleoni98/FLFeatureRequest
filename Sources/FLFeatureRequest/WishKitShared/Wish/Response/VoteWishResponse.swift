//
//  VoteWishResponse.swift
//  wishkit-ios-shared
//
//  Created by Martin Lasek on 2/18/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation

public struct VoteWishResponse: Codable {

    public let wishId: UUID

    public let votingUsers: [UserResponse]

    public init(wishId: UUID, votingUsers: [UserResponse]) {
        self.wishId = wishId
        self.votingUsers = votingUsers
    }
}
