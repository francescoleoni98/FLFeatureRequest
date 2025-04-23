//
//  VoteFeatureResponse.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 2/18/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

public struct VoteFeatureResponse: Codable {

	public let featureId: UUID
	public let votingUsers: [UserResponse]

	public init(featureId: UUID, votingUsers: [UserResponse]) {
		self.featureId = featureId
		self.votingUsers = votingUsers
	}
}
