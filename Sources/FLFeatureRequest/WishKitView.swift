//
//  WishKitView.swift
//
//
//  © 2024 Francesco Leoni <leonifrancesco.com> All rights reserved.
//  Created by Francesco Leoni on 08/02/24.
//

import SwiftUI
import StoreKit

public enum FLFeatureRequest {

	@MainActor
	public static func configure(brandColor: Color) {
//    WishKit.configure(with: "956611C1-C5FE-46AB-8B0C-3A2B8502CFC1")
		WishKit.theme.primaryColor = brandColor
    WishKit.config.buttons.addButton.textColor = .setBoth(to: .white)
    WishKit.config.buttons.saveButton.textColor = .setBoth(to: .white)
    WishKit.config.statusBadge = .show
    WishKit.config.commentSection = .hide
  }

	@MainActor
	public static func setPurchase(userID: String, product: SKProduct?) {
		WishKit.updateUser(customID: userID)

    if let product {
			if product.subscriptionPeriod?.unit == .week {
				WishKit.updateUser(payment: .weekly(product.price.decimalValue, currencyCode: product.priceLocale.currencyCode))
			} else if product.subscriptionPeriod?.unit == .month {
				WishKit.updateUser(payment: .monthly(product.price.decimalValue, currencyCode: product.priceLocale.currencyCode))
      } else {
        WishKit.updateUser(payment: .yearly(product.price.decimalValue, currencyCode: product.priceLocale.currencyCode))
      }
		} else {
			WishKit.updateUser(payment: .yearly(0, currencyCode: Locale.current.currencyCode))
		}
  }
}
