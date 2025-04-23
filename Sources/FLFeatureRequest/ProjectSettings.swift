//
//  ProjectSettings.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 2/10/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

struct ProjectSettings {
	static var apiUrl: String {
		let featureRequestUrl = ProcessInfo.processInfo.environment["featurerequest-url"]
		return featureRequestUrl ?? "https://featurerequest.com/api"
	}
	static let sdkVersion = "4.1.0"
}
