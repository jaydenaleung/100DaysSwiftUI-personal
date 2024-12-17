//
//  SmartText.swift
//  AcademicWeapon
//
//  Created by Student on 11/3/24.
//

import SwiftUI

struct SmartText: View {
    var title: String
    var text: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(text)
            }
        }
    }
    
    init(_ title: String, _ text: String) {
        self.title = title
        self.text = text
    }
}
