//
//  APIError.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import Foundation

enum APIErrors: Error {
    case forbidden  // code 403
    case notfount   // code 404
    case conflict   // code 409
    case internalServerError    // code 500
}
