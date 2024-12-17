//
//  SmartTextField.swift
//  AcademicWeapon
//
//  Created by Student on 11/3/24.
//

import SwiftUI

struct SmartTextField: View {
    var title: String
    var prompt: String
    @State private var input: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                TextField(prompt, text: $input)
            }
        }
    }
    
    init(_ title: String, _ prompt: String = "", _ input: String) {
        self.title = title
        self.prompt = prompt
        self.input = input
    }
}
