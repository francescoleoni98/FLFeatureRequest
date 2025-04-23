//
//  Configuraton.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 3/8/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import Foundation

public class Configuration {

	/// Hides/Shows the status badge of a feature e.g. "Approved" or "Implemented".
	public var statusBadge: Display

	public var localization: Localization

	public var buttons = Configuration.Buttons()

	public var tabBar = TabBar()

	public var expandDescriptionInList: Bool = false

	public var dropShadow: Display = .show

	public var cornerRadius: CGFloat = 16

	public var emailField: EmailField = .optional

	public var commentSection: Display = .show

	init(
		statusBadgeDisplay: Display = .hide,
		localization: Localization = .default()
	) {
		self.statusBadge = statusBadgeDisplay
		self.localization = localization
	}
}

// MARK: - Display

extension Configuration {
	public enum Display {
		case show
		case hide
	}
}

// MARK: - Email Field

extension Configuration {
	public enum EmailField {
		case none
		case optional
		case required
	}
}
