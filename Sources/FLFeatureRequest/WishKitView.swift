//
//  WishKitView.swift
//
//
//  © 2024 Francesco Leoni <leonifrancesco.com> All rights reserved.
//  Created by Francesco Leoni on 08/02/24.
//

#if !os(visionOS)
import UIKit
import StoreKit
import Models

public enum WishKitView {

	public static func configure() {
    WishKit.configure(with: "956611C1-C5FE-46AB-8B0C-3A2B8502CFC1")
    WishKit.theme.primaryColor = .accentColor
    WishKit.config.buttons.addButton.textColor = .setBoth(to: .white)
    WishKit.config.buttons.saveButton.textColor = .setBoth(to: .white)
    WishKit.config.statusBadge = .show
    WishKit.config.commentSection = .hide
  }
  
	public static func wishList() -> UINavigationController {
    WishKit.viewController.withNavigation()
  }
  
	public static func setPurchase(userID: String, product: SKProduct?) {
    if let product {
      if product.productIdentifier == AppProduct.monthly.identifier {
				WishKit.updateUser(customID: userID)
				WishKit.updateUser(payment: .monthly(product.price.decimalValue, currencyCode: product.priceLocale.currencyCode))
      } else {
				WishKit.updateUser(customID: userID)
        WishKit.updateUser(payment: .yearly(product.price.decimalValue, currencyCode: product.priceLocale.currencyCode))
      }
		} else {
			WishKit.updateUser(customID: userID)
			WishKit.updateUser(payment: .yearly(0, currencyCode: Locale.current.currencyCode))
		}
  }
}
#endif
