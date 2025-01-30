//
//  VoteWishRequest.swift
//  wishkit-ios-shared
//
//  Created by Martin Lasek on 2/13/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation

public struct VoteWishRequest: Codable {

    public let wishId: UUID

    public init(wishId: UUID) {
        self.wishId = wishId
    }
}
