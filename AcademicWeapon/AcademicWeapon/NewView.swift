//
//  EndeavorView.swift
//  AcademicWeapon
//
//  Created by Jayden Leung on 10/30/24.
//

import SwiftUI

struct NewView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "New endeavor"
    @State private var desc = ""
    @State private var timeTaking: Int = 0
    @State private var timeEndGoal: Int = 45
    
    var endeavors = EndeavorList()
    
    func save() {
        let saved = Endeavor(name: name, desc: desc, timeTaking: timeTaking, timeEndGoal: timeEndGoal, date: Date())
        endeavors.academicEndeavors.append(saved)
        endeavors.reloadToggled = true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section { // basic info
                    HStack {
                        VStack {
                            Text("Name")
                        }
                        
                        VStack {
                            TextField("Name", text: $name)
                        }
                        .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        VStack {
                            Text("Description")
                        }
                        
                        VStack {
                            TextField("Description", text: $desc)
                        }
                        .multilineTextAlignment(.trailing)
                    }
                }
                
                Section { // times and goals
                    HStack {
                        VStack {
                            Text("How long's it taking right now?")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(timeTaking) minutes")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .italic()
                                .padding(.top, 3)
                        }
                        
                        VStack {
                            Stepper(value: $timeTaking, in: 0...1000, step: 5) {}
                        }
                        .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        VStack {
                            Text("What's your goal?")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(timeEndGoal) minutes")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .italic()
                                .padding(.top, 3)
                        }
                        
                        VStack {
                            Stepper(value: $timeEndGoal, in: 0...1000, step: 5) {}
                        }
                        .multilineTextAlignment(.trailing)
                    }
                }
                
                Section { // save
                    Button("It's go time, baby!") {
                        save()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewView()
}
