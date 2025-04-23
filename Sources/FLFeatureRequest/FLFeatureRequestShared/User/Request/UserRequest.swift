//
//  UserRequest.swift
//  FLFeatureReequest-shared
//
//  Created by Francesco Leoni on 8/5/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

public struct UserRequest: Codable {

	public let customID: String?
	public let email: String?
  public let name: String?
	public let paymentPerMonth: Int?
	public let currencyCode: String

	public init(
		customID: String? = nil,
		email: String? = nil,
		name: String? = nil,
		paymentPerMonth: Int? = nil,
		currencyCode: String? = nil
	) {
		self.customID = customID
		self.email = email
		self.name = name
		self.paymentPerMonth = paymentPerMonth
		self.currencyCode = currencyCode ?? ""
	}
}
