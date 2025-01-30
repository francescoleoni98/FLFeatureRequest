//
//  WishApi.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 2/10/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct WishApi: RequestCreatable {

  static let ref = Database.database().reference().child("wishes")

  // MARK: - Api Requests

  static func fetchWishList(completionHandler: @escaping (Result<[WishResponse], ApiError>) -> Void) {
    ref.observeSingleEvent(of: .value) { snapshot in
      guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
        completionHandler(.failure(ApiError(reason: .couldNotDecodeBackendResponse)))
        return
      }

      let list = children.compactMap { snapshot in
        do {
          return try snapshot.data(as: WishResponse.self)
        } catch {
          print("[WishKit]: ", error)
          return nil
        }
      }

      completionHandler(.success(list))
    }
  }

  static func createWish(createRequest: CreateWishRequest, completionHandler: @escaping (Result<Void, Error>) -> Void) {
    let id = UUID().uuidString

    var params = ["id" : id,
                  "userUUID" : UUIDManager.getUUID(),
                  "title" : createRequest.title.trimmed,
                  "description" : createRequest.description.trimmed,
                  "state" : createRequest.state.rawValue]

    if let email = createRequest.email, !email.trimmed.isEmpty {
      params["email"] = email.trimmed
    }

    ref.child(id).setValue(params) { error, _ in
      if let error {
        completionHandler(.failure(error))
      } else {
        completionHandler(.success(()))
      }
    }
  }

  static func voteWish(wish: WishResponse, completionHandler: @escaping (Result<Void, Error>) -> Void) {
    wish.votingUsers.append(UserResponse(uuid: UUIDManager.getUUID()))

    ref.child(wish.id.uuidString).updateChildValues(["votingUsers" : wish.votingUsers.map { $0.uuid }]) { error, _ in
      if let error {
        completionHandler(.failure(error))
      } else {
        completionHandler(.success(()))
      }
    }
  }
}

extension DataSnapshot {

  var data: Data? {
    guard let value = value, !(value is NSNull) else { return nil }
    return try? JSONSerialization.data(withJSONObject: value)
  }
}
