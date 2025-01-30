//
//  UUIDManager.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 2/10/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation

struct UUIDManager {

	private static let slug = "wishkit"

	private static let userUUIDKey = "\(slug)-user-uuid"

	static func store(uuid: String) {
		UserDefaults.standard.set(uuid, forKey: userUUIDKey)
	}

	static func getUUID() -> String {
		if let uuidString = UserDefaults.standard.string(forKey: userUUIDKey) {
			return uuidString
		}

		let uuid = UUID().uuidString

		store(uuid: uuid)

		return uuid
	}

	static func deleteUUID() {
		UserDefaults.standard.removeObject(forKey: userUUIDKey)
	}
}
