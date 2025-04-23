//
//  URLRequest+XT.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 2/10/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

extension URLRequest {

	/// Adds User UUID and Bearer token to URLRequest if given.
	mutating func addAuth() {
//		self.setValue(FLFeatureRequest.apiKey, forHTTPHeaderField: "x-featurerequest-api-key")
		self.setValue(UUIDManager.getUUID(), forHTTPHeaderField: "x-featurerequest-uuid")
	}

	/// Adds User UUID and Bearer token to URLRequest if given.
	mutating func addSdkInfo() {
		let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "none"
		self.setValue(displayName, forHTTPHeaderField: "x-featurerequest-sdk-app-name")
		self.setValue("ios", forHTTPHeaderField: "x-featurerequest-sdk-kind")
		self.setValue(ProjectSettings.sdkVersion, forHTTPHeaderField: "x-featurerequest-sdk-version")
	}

	/// Encodes instance into JSON and stets json headers.
	mutating func jsonEncode<T: Encodable>(_ body: T) {
		httpBody = try? JSONEncoder().encode(body)
		addValue("application/json", forHTTPHeaderField: "Content-Type")
		addValue("application/json", forHTTPHeaderField: "Accept")
	}
}
