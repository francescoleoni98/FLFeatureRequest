//
//  CommentModel.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/27/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

final class CommentModel: ObservableObject {
	
    @Published
    var newCommentValue = ""

    @Published
    var isLoading = false
}
