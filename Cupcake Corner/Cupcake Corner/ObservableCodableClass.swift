//
//  ObservableCodableClass.swift
//  Cupcake Corner
//
//  Created by Student on 11/6/24.
//

import SwiftUI

@Observable class User: Codable {
    var name = "Taylor"
    
    enum CodingKeys: String, CodingKey {
        case _name = "name"
        
    }
}

struct ObservableCodableClass: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    ObservableCodableClass()
}
