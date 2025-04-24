//
//  ToolbarCompat.swift
//
//
//  Created by Francesco Leoni on 11/22/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

extension View {
	@ViewBuilder
	func toolbarKeyboardDoneButton() -> some View {
#if canImport(UIKit) && !os(visionOS)
		if #available(macOS 13.0, iOS 15, *) {
			self.toolbar {
				ToolbarItem(placement: .keyboard) {
					HStack {
						Spacer()

						Button {
							UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
						} label: {
							Text("Done", bundle: .module)
						}
					}
				}
			}
		} else {
			self
		}
#else
		self
#endif
	}
}
