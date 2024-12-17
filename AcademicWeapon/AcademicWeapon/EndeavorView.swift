//
//  EndeavorView.swift
//  AcademicWeapon
//
//  Created by Student on 11/2/24.
//

import SwiftUI

struct EndeavorView: View {
    var endeavor: Endeavor
    
    @Binding var name: String
    var desc: String
    var date: Date
    var timeTaking: Int
    var timeEndGoal: Int
    var timeNextGoal: Int
    var goalIsMet: [Bool]
    var daysLeft = 0
//    var daysLeft: Int {
//        var timeIntervalSince = Date().timeIntervalSince(date) / 86400
//        
//        if Int(7 - timeIntervalSince) < 0 {
//            timeIntervalSince -= 7
//        }
//        return Int(7 - timeIntervalSince)
//    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Basic Info") {
                    SmartText("Name", name)
                    SmartText("Date", date.formatted(date: .abbreviated, time: .omitted))
                    SmartText("Description", desc)
                }
                
                Section("Initial") {
                    SmartText("Initial Time It Took", "\(timeTaking) minutes")
                    SmartText("Final Goal", "\(timeEndGoal) minutes")
                }
                
                Section("This Week") {
                    SmartText("This Week's Goal", timeNextGoal == 0 ? "Finished!" : "\(timeNextGoal) minutes")
                    SmartText("Days Left", "\(daysLeft) days")
                    
                    (daysLeft == 0) ?
                    VStack {
                        Text("0 days left in week. Completed your goal?")
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        
                        
                        GeometryReader { geometry in
                            HStack {
                                Button("Yes") { print("yes") }
                                    .frame(width: geometry.size.width * 0.4, height: 75)
                                    .background(.green)
                                    .clipShape(.capsule)
                                
                                Spacer()
                                
                                Button("No") { print("no") }
                                    .frame(width: geometry.size.width * 0.4, height: 75)
                                    .background(.red)
                                    .clipShape(.capsule)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding(.bottom, 80)
                    }
                    .buttonStyle(.plain)
                    : nil
                }
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var text = "English"
    EndeavorView(endeavor: Endeavor(name: "English", desc: "III, SY 2024-2025", timeTaking: 60, timeEndGoal: 45, date: Date(), id: UUID(), goalIsMet: []), name: $text, desc: "III, SY 2024-2025", date: Date(), timeTaking: 60, timeEndGoal: 45, timeNextGoal: 55, goalIsMet: [])
}
