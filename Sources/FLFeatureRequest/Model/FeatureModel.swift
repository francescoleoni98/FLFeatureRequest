//
//  FeatureModel.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 3/11/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

@MainActor
public final class FeatureModel: ObservableObject {

	@Published
	public var approvedFeatures: [FeatureResponse] = []

	@Published
	public var implementedFeatures: [FeatureResponse] = []

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
		DispatchQueue.main.async {
			self.isLoading = true
		}

		FLFeatureRequest.api.fetchFeaturesList { result in
			switch result {
			case .success(let response):
				DispatchQueue.main.async {
					withAnimation {
						self.updateApprovedFeatures(with: response)
						self.updateImplementedFeatures(with: response)
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

	private func updateApprovedFeatures(with list: [FeatureResponse]) {
		let userUUID = UUIDManager.getUUID()

		var filteredList = list.filter { feature in
			let ownPendingFeature = (feature.state == .pending && feature.userUUID == userUUID)
			let approvedFeature = feature.state == .approved

			return ownPendingFeature || approvedFeature
		}

		filteredList.sort { $0.votingUsers.count > $1.votingUsers.count }

		self.approvedFeatures = filteredList
	}

	private func updateImplementedFeatures(with list: [FeatureResponse]) {
		var filteredList = list.filter { feature in feature.state == .implemented }
		filteredList.sort { $0.votingUsers.count > $1.votingUsers.count }
		self.implementedFeatures = filteredList
	}
}

