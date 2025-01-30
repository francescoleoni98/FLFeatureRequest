//
//  WishKit.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 2/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

import SwiftUI
import Combine

public struct WishKit {

  private static var subscribers: Set<AnyCancellable> = []

  static var apiKey = "my-fancy-api-key"

  static var user = User()

  public static var theme = Theme()

  public static var config = Configuration()

#if canImport(UIKit) && !os(visionOS)
  /// (UIKit) The WishList viewcontroller.
  public static var viewController: UIViewController {
    UIHostingController(rootView: WishlistViewIOS(wishModel: WishModel()))
  }
#endif

  /// (SwiftUI) The WishList view.
  public static var view: some View {
#if os(macOS) || os(visionOS)
    return WishlistContainer(wishModel: WishModel())
#else
    return WishlistViewIOS(wishModel: WishModel())
#endif
  }

  public static func configure(with apiKey: String) {
    WishKit.apiKey = apiKey
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

// MARK: - Update User Logic

extension WishKit {
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
    UserApi.updateUser(userRequest: request) { result in
      switch result {
      case .success:
        break
      case .failure(let error):
        print("[WishKit]:", error)
      }
    }
  }
}
