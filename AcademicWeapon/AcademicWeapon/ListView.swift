//
//  ContentView.swift
//  AcademicWeapon
//
//  Created by Jayden Leung on 10/30/24.
//

/*
 
    PLAN:
    - Track user-inputs for quality of homework and time spent on homework, compared to average times
    - Show different subjects and "endeavors"
    - Have a total daily time spent and work to decrease those times (to the user's goal) by adding/subtracting 5 minutes each week
    - Have a daily quote that explains why you should academically lock in and add/subtract 5 minutes each week to your study amount
 
    HOW:
    - (similar to iExpense) List displaying different user-added academic endeavors, with an add button
    - Endeavor parameters should include name and desc of endeavor, how long it's taking, what the user's time goal is, (if they've been successful,
      what the goal for next week looks like, etc.)
    - Define a struct type Endeavor, and a class type (with @Observable macro) EndeavorList; see iExpense for example
    - Then it's basically just iExpense
    - But the EndeavorView should have a stepper to set the time spent on a subject on average this week (or how many times the user thinks
      they completed last week's goal), and therefore what the goal is
 
    EXTRA CREDIT:
    - Use Codable and UserDefaults to save and archive/unarchive the JSON file for the endeavor
    - Add some animations to say "locked in" and stuff like that!
    - Add motivational daily quotes
    - Add a toolbar on the bottom to switch between views; ZStack with toolbar overlay but view on bottom
 
 */


import SwiftUI

struct ListView: View {
    @State private var endeavors = EndeavorList()
    
    func removeItem(at offsets: IndexSet) {
        endeavors.academicEndeavors.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Endeavors") {
                    ForEach(endeavors.academicEndeavors) { endeavor in
                        @State var tempName = endeavor.name // tempName must be @State in order to be passed in as a binding value
                        
                        NavigationLink(destination: EndeavorView(endeavor: endeavor, name: $tempName, desc: endeavor.desc, date: endeavor.date, timeTaking: endeavor.timeTaking, timeEndGoal: endeavor.timeEndGoal, timeNextGoal: endeavor.timeNextGoal, goalIsMet: endeavor.goalIsMet)) {
                            HStack {
                                // JUST LIKE IEXPENSE - NAME AND COMPLETION PERCENTAGE
                                VStack(alignment: .leading) {
                                    Text(endeavor.name)
                                        .bold()
                                    Text(endeavor.date.formatted(date: .abbreviated, time: .omitted))
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("Current: \(endeavor.timeTaking) min")
                                        .italic()
                                    Text("Goal: \(endeavor.timeEndGoal) min")
                                        .italic()
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeItem)
                }
            }
            .navigationTitle("Academic Weapon")
            .toolbar {
                NavigationLink(destination: NewView()) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear(perform: endeavors.reload)
    }
}

#Preview {
    ListView()
}
