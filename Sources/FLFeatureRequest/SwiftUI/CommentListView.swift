//
//  SwiftUIView.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 8/12/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

struct CommentListView: View {
	
	@Binding
	var commentList: [CommentResponse]
	
	var body: some View {
		LazyVStack {
			ForEach(self.commentList, id: \.id) { comment in
				SingleCommentView(
					comment: comment.description,
					createdAt: comment.createdAt,
					isAdmin: comment.isAdmin
				)
				.padding(.bottom, 10)
			}
		}
		.padding(1)
		.padding(.bottom, 30)
	}
}
