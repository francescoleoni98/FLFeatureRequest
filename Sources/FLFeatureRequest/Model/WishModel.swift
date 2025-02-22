//
//  WishModel.swift
//  wishkit-ios
//
//  Created by Martin Lasek on 3/11/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

@MainActor
public final class WishModel: ObservableObject {

	@Published
	public var approvedWishlist: [WishResponse] = []

	@Published
	public var implementedWishlist: [WishResponse] = []

	@Published
	var shouldShowWatermark: Bool = false

	@Published
	public var isLoading: Bool = false

	// Used to differentiate empty list from fetch vs. from initial instance creation.
	@Published
	public var hasFetched: Bool = false

	public init() { }
	
	@MainActor
	public func fetchList(completion: (() -> ())? = nil) {
		isLoading = true

		WishApi.fetchWishList { result in
			switch result {
			case .success(let response):
				DispatchQueue.main.async {
					withAnimation {
						self.updateApprovedWishlist(with: response)
						self.updateImplementedWishlist(with: response)
						self.shouldShowWatermark = false
					}
				}
			case .failure(let error):
				printError(self, error.reason.description)
			}

			DispatchQueue.main.async {
				self.isLoading = false
				self.hasFetched = true
			}

			completion?()
		}
	}

	@MainActor
	func fetchList() {
		fetchList(completion: nil)
	}

	private func updateApprovedWishlist(with list: [WishResponse]) {
		let userUUID = UUIDManager.getUUID()

		var filteredList = list.filter { wish in
			let ownPendingWish = (wish.state == .pending && wish.userUUID == userUUID)
			let approvedWish = wish.state == .approved

			return ownPendingWish || approvedWish
		}

		filteredList.sort { $0.votingUsers.count > $1.votingUsers.count }

		self.approvedWishlist = filteredList
	}

	private func updateImplementedWishlist(with list: [WishResponse]) {
		var filteredList = list.filter { wish in wish.state == .implemented }
		filteredList.sort { $0.votingUsers.count > $1.votingUsers.count }
		self.implementedWishlist = filteredList
	}
}
