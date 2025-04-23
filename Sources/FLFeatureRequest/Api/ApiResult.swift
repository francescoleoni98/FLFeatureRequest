//
//  ApiResult.swift
//  FLFeatureRequest
//
//  Created by Francesco Leoni on 23/04/25.
//

import Foundation

public enum ApiResult<Success, Error> {
	case success(Success)
	case failure(Error)
}
