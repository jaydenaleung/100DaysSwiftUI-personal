//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Jayden Leung on 10/3/24.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
//        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
//            fatalError("Failed to decode \(file) from bundle.")
//        }
//        
//        return loaded
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to messing key '\(key.stringValue)' \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to value not found of type '\(type)' \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle due to data corruption")
        } catch {
            fatalError("Failed to decode \(file) from bundle due to error: \(error.localizedDescription)")
        }
    }
}
