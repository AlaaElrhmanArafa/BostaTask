//
//  Service.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import Foundation
import Moya

enum Service{
    case albums
    case photos(albumId:String)
    case users
}

extension Service:TargetType{
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .albums:
            return "albums"
        case .photos:
            return "photos"
        case .users:
            return "users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .albums:
            return .get
        case .photos:
            return .get
        case .users:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .albums:
            let userId = UserDefaults.standard.integer(forKey: "userId")
            return .requestParameters(parameters: ["userId": "\(userId)"],encoding: URLEncoding.default)
        case .photos(albumId: let albumId):
            return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.default)
        case .users:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
