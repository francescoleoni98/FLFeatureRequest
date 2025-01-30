//
//  UserApi.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 8/5/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct UserApi: RequestCreatable {

  static let ref = Database.database().reference().child("users")

  static func updateUser(userRequest: UserRequest, completionHandler: @escaping (ApiResult<Void, Error>) -> Void) {
    let id = UUIDManager.getUUID()

		var params: [String : Any] = [:]

    if let customID = userRequest.customID {
      params["customID"] = customID
    }

    if let email = userRequest.email, !email.trimmed.isEmpty {
      params["email"] = email.trimmed
    }

    if let name = userRequest.name, !name.trimmed.isEmpty {
      params["name"] = name.trimmed
    }

    if let paymentPerMonth = userRequest.paymentPerMonth {
      params["paymentPerMonth"] = paymentPerMonth
			params["currencyCode"] = userRequest.currencyCode
    }

    ref.child(id).setValue(params) { error, _ in
      if let error {
        completionHandler(.failure(error))
      } else {
        completionHandler(.success(()))
      }
    }
  }
}
