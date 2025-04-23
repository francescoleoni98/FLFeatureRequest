//
//  AlertModel.swift
//  FLFeatureReequest
//
//  Created by Francesco Leoni on 9/27/23.
//  Copyright © 2025 Francesco Leoni. All rights reserved.
//

import SwiftUI

final class AlertModel: ObservableObject {

    enum AlertReason {
        case alreadyVoted
        case alreadyImplemented
        case voteReturnedError(String)

        case successfullyCreated
        case createReturnedError(String)
        case emailRequired
        case emailFormatWrong
        
        case none
    }

    @Published
    var showAlert = false

    @Published
    var alertReason: AlertReason = .none
}
