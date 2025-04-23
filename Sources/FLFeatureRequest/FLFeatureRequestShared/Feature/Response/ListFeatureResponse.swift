//
//  ListFeatureResponse.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 2/10/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

public struct ListFeatureResponse: Codable {

    public let list: [FeatureResponse]
    public let shouldShowWatermark: Bool

    public init(list: [FeatureResponse], shouldShowWatermark: Bool) {
        self.list = list
        self.shouldShowWatermark = shouldShowWatermark
    }
}
