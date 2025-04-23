//
//  FeatureState.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 2/11/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

public enum FeatureState: String, Codable, CaseIterable {

    case pending
    case approved
    case implemented
    case rejected
}
