//
//  Bundle+AppIcon.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 4/30/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension Bundle {
	public var appIcon: UIImage? {
		if
			let appIcons = infoDictionary?["CFBundleIcons"] as? [String: Any],
			let primaryAppIcon = appIcons["CFBundlePrimaryIcon"] as? [String: Any],
			let appIconFiles = primaryAppIcon["CFBundleIconFiles"] as? [String],
			let lastAppIcon = appIconFiles.last
		{
			return UIImage(named: lastAppIcon)
		}
		
		return nil
	}
}
#endif
