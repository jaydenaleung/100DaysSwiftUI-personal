//
//  EndeavorList.swift
//  AcademicWeapon
//
//  Created by Jayden Leung on 10/30/24.
//

import Foundation

@Observable class EndeavorList: ObservableObject {
    var academicEndeavors = [Endeavor]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(academicEndeavors) {
                UserDefaults.standard.set(encoded, forKey: "academic")
            }
        }
    }
    
    var reloadToggled = false
    
    func reload() {
        if let saved = UserDefaults.standard.data(forKey: "academic"),
           let decoded = try? JSONDecoder().decode([Endeavor].self, from: saved) {
            academicEndeavors = decoded
        } else {
            academicEndeavors = [] // Default to empty if there's no saved data
        }
    }
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "academic") {
            if let decoded = try? JSONDecoder().decode([Endeavor].self, from: saved) {
                academicEndeavors = decoded
                return
            }
        }
    }
}
