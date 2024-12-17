//
//  ValidatingDisablingView.swift
//  Cupcake Corner
//
//  Created by Student on 11/5/24.
//

import SwiftUI

struct ValidatingDisablingView: View {
    @State private var user = ""
    @State private var email = ""
    
    var disabledForm: Bool {
        user.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $user)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating acc...")
                }
            }
            .disabled(disabledForm)
        }
    }
}

#Preview {
    ValidatingDisablingView()
}
