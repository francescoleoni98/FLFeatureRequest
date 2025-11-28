//
//  FLFeatureRequest.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 2/9/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

import SwiftUI
import Combine
import StoreKit

@MainActor
public enum FLFeatureRequest {

	static var apiKey = "api-key"

	static var user = User()

	public static var theme = Theme()

	public static var config = Configuration()

	public static var api: FLFeatureRequestApiInterface = FeatureListView.isTesting ? MockApi() : DefaultApi()

	public static func configure(with apiKey: String) {
		Self.apiKey = apiKey
	}

	public static func configure(api: FLFeatureRequestApiInterface) {
		Self.api = api
	}

	public static func configure(brandColor: Color, foregroundColor: Color = .white) {
		//  configure(with: "<key>")
		theme.primaryColor = brandColor
		config.buttons.addButton.textColor = .setBoth(to: foregroundColor)
		config.buttons.saveButton.textColor = .setBoth(to: foregroundColor)
		config.statusBadge = .show
		config.commentSection = .hide
	}

	public static func setPurchase(userID: String, product: SKProduct?) {
		updateUser(customID: userID)

		if let product {
			if product.subscriptionPeriod?.unit == .week {
				updateUser(payment: .weekly(product.price.decimalValue, currencyCode: product.priceLocale.currencyCode))
			} else if product.subscriptionPeriod?.unit == .month {
				updateUser(payment: .monthly(product.price.decimalValue, currencyCode: product.priceLocale.currencyCode))
			} else {
				updateUser(payment: .yearly(product.price.decimalValue, currencyCode: product.priceLocale.currencyCode))
			}
		} else {
			updateUser(payment: .yearly(0, currencyCode: Locale.current.currencyCode))
		}
	}

	public static func updateUser(customID: String) {
		let id = customID.replacingOccurrences(of: "[.#$\\[\\]]", with: "", options: .regularExpression)
		self.user.customID = id
		UUIDManager.store(uuid: id)
		sendUserToBackend()
	}

	public static func updateUser(email: String) {
		self.user.email = email
		sendUserToBackend()
	}

	public static func updateUser(name: String) {
		self.user.name = name
		sendUserToBackend()
	}

	public static func updateUser(payment: Payment) {
		self.user.payment = payment
		sendUserToBackend()
	}

	static func sendUserToBackend() {
		let request = user.createRequest()

		FLFeatureRequest.api.updateUser(userRequest: request) { result in
			switch result {
			case .success:
				break
			case .failure(let error):
				print("[FLFeatureRequest]:", error)
			}
		}
	}
}

// MARK: - Payment Model

class RoundUp: NSDecimalNumberBehaviors {

	func scale() -> Int16 {
		return 0
	}

	func exceptionDuringOperation(_ operation: Selector, error: NSDecimalNumber.CalculationError, leftOperand: NSDecimalNumber, rightOperand: NSDecimalNumber?) -> NSDecimalNumber? {
		return 0
	}

	func roundingMode() -> NSDecimalNumber.RoundingMode {
		.up
	}
}

public struct Payment {

	let amount: Int
	let currencyCode: String?

	// MARK: - Weekly

	/// Accepts a price expressed in `Decimal` e.g: 2.99 or 11.49
	public static func weekly(_ amount: Decimal, currencyCode: String?) -> Payment {
		let amount = NSDecimalNumber(decimal: amount * 100).intValue
		let amountPerMonth = amount * 4
		return Payment(amount: amountPerMonth, currencyCode: currencyCode)
	}

	// MARK: - Monthly

	/// Accepts a price expressed in `Decimal` e.g: 6.99 or 19.49
	public static func monthly(_ amount: Decimal, currencyCode: String?) -> Payment {
		let amount = NSDecimalNumber(decimal: amount * 100).intValue
		return Payment(amount: amount, currencyCode: currencyCode)
	}

	// MARK: - Yearly

	/// Accepts a price expressed in `Decimal` e.g: 6.99 or 19.49
	public static func yearly(_ amount: Decimal, currencyCode: String?) -> Payment {
		let amountPerMonth = NSDecimalNumber(decimal: (amount * 100) / 12).rounding(accordingToBehavior: RoundUp()).intValue
		return Payment(amount: amountPerMonth, currencyCode: currencyCode)
	}
}
