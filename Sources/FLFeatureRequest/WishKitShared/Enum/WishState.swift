//
//  WishState.swift
//  wishkit-ios-shared
//
//  Created by Martin Lasek on 2/11/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

public enum WishState: String, Codable, CaseIterable {
    case pending
    case approved
    case implemented
    case rejected
}
