//
//  NSErrorExtensions.swift
//  SampleA
//
//  Created by Garrett Richards on 12/16/16.
//  Copyright © 2016 Acme. All rights reserved.
//

import Foundation

private struct ErrorConstants {
    static let domain = "com.acme"
}

enum ErrorCode: Int {
    case generic
    case `internal`
    case userInput
    case networkResponseParsingError
    case networkResourceNotFound    // 404
    case networkInternal    // 500
    case networkUnavailable
}

extension NSError {
    static func error(message: String, code: ErrorCode = .generic) -> NSError {
        return NSError(domain: ErrorConstants.domain, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    static func internalError(message: String) -> NSError {
        return NSError(domain: ErrorConstants.domain, code: ErrorCode.internal.rawValue, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
