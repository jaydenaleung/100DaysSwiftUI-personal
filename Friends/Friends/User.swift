//
//  User.swift
//  Friends
//
//  Created by Student on 12/5/24.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}
