//
//  WishResponse.swift
//  wishkit-ios-shared
//
//  Created by Martin Lasek on 2/10/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation

public class WishResponse: Codable {

  public let id: UUID

  public let userUUID: String

  public let title: String

  public let description: String

  public let state: WishState

  public var votingUsers: [UserResponse]

  public let commentList: [CommentResponse]

  public init(
    id: UUID,
    userUUID: String,
    title: String,
    description: String,
    state: WishState,
    votingUsers: [UserResponse],
    commentList: [CommentResponse]
  ) {
    self.id = id
    self.userUUID = userUUID
    self.title = title
    self.description = description
    self.state = state
    self.votingUsers = votingUsers
    self.commentList = commentList
  }

  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let id = try container.decode(String.self, forKey: .id)
    self.id = UUID(uuidString: id) ?? UUID()
    let userUUID = try container.decode(String.self, forKey: .userUUID)
    self.userUUID = userUUID
    self.title = try container.decode(String.self, forKey: .title)
    self.description = try container.decode(String.self, forKey: .description)
    let state = try container.decode(String.self, forKey: .state)
    self.state = WishState(rawValue: state) ?? .pending
    let votingUsers = try container.decodeIfPresent([String].self, forKey: .votingUsers) ?? []
    self.votingUsers = votingUsers.map { UserResponse(uuid: $0) }
//    let commentList = try container.decode([String].self, forKey: .commentList)
    self.commentList = []
  }
}
