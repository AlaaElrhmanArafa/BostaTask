//
//  AlbumsResponse.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import Foundation


// MARK: - AlbumsResponseElement -
struct AlbumsResponseElement: Codable {
    let userID, id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

typealias AlbumsResponse = [AlbumsResponseElement]
