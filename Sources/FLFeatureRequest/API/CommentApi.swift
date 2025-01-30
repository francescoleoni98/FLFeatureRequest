//
//  CommentApi.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 8/14/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation

struct CommentApi: RequestCreatable {

  static func createComment(request: CreateCommentRequest) async -> ApiResult<CommentResponse, ApiError> {
    .failure(ApiError(reason: .couldNotCreateRequest))
  }
}

