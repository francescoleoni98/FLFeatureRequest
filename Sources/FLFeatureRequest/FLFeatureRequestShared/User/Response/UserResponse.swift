//
//  UserResponse.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 2/10/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

public struct UserResponse: Codable {
	
	public let uuid: String
	
	public init(uuid: String) {
		self.uuid = uuid
	}
}
