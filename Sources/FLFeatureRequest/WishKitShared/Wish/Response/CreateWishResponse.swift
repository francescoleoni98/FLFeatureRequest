//
//  CreateWishResponse.swift
//  wishkit-ios-example
//
//  Created by Martin Lasek on 2/12/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

public struct CreateWishResponse: Codable {

    public let title: String

    public var description: String

    public var state: WishState

    public init(title: String, description: String, state: WishState) {
        self.title = title
        self.description = description
        self.state = state
    }
}
