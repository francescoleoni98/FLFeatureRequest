//
//  User.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 8/4/25.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

final class User {
	
	var customID: String?
	var email: String?
	var name: String?
	var payment: Payment?
	
	init(customID: String? = nil, email: String? = nil, name: String? = nil, payment: Payment? = nil) {
		self.customID = customID
		self.email = email
		self.name = name
		self.payment = payment
	}
	
	func createRequest() -> UserRequest {
		let userRequest = UserRequest(
			customID: customID,
			email: email,
			name: name,
			paymentPerMonth: payment?.amount,
			currencyCode: payment?.currencyCode
		)
		
		return userRequest
	}
}
