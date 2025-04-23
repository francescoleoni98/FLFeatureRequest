//
//  Bundle+APpName.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 4/30/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

extension Bundle {
	var displayName: String? {
		let displayName = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
		let name = object(forInfoDictionaryKey: "CFBundleName") as? String
		return displayName ?? name ?? nil
	}
}
