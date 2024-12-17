//
//  Order.swift
//  Cupcake Corner
//
//  Created by Student on 11/6/24.
//

import Foundation

@Observable class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            if let encodedN = try? JSONEncoder().encode(name) {
                UserDefaults.standard.set(encodedN, forKey: "name")
            }
        }
    }
    var streetAddress = "" {
        didSet {
            if let encodedA = try? JSONEncoder().encode(streetAddress) {
                UserDefaults.standard.set(encodedA, forKey: "address")
            }
        }
    }
    var city = "" {
        didSet {
            if let encodedC = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(encodedC, forKey: "city")
            }
        }
    }
    var zip = "" {
        didSet {
            if let encodedZ = try? JSONEncoder().encode(zip) {
                UserDefaults.standard.set(encodedZ, forKey: "zip")
            }
        }
    }
    
    var hasValidAddress: Bool {
        if name.isEmpty ||
            streetAddress.isEmpty ||
            city.isEmpty ||
            zip.isEmpty ||            
            name.starts(with: " ") ||
            streetAddress.starts(with: " ") ||
            city.starts(with: " ") ||
            zip.starts(with: " ") {
            return false
        } else {
            return true
        }
    }
    
    var cost: Decimal {
        // $2/cake
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type)/2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity)/2
        }
        
        return cost
    }
    
    func reload() {
        if let savedN = UserDefaults.standard.data(forKey: "name") {
            if let decodedN = try? JSONDecoder().decode(String.self, from: savedN) {
                name = decodedN
            }
        }
        if let savedA = UserDefaults.standard.data(forKey: "address") {
            if let decodedA = try? JSONDecoder().decode(String.self, from: savedA) {
                streetAddress = decodedA
            }
        }
        if let savedC = UserDefaults.standard.data(forKey: "city") {
            if let decodedC = try? JSONDecoder().decode(String.self, from: savedC) {
                city = decodedC
            }
        }
        if let savedZ = UserDefaults.standard.data(forKey: "zip") {
            if let decodedZ = try? JSONDecoder().decode(String.self, from: savedZ) {
                zip = decodedZ
            }
        }
    }
    
    init() {
        reload()
    }
}
