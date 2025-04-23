//
//  UIViewController+Navigation.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/30/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIViewController {
	public func withNavigation() -> UINavigationController {
		return UINavigationController(rootViewController: self)
	}
}
#endif
