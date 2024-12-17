//
//  ContentView.swift
//  Better Rest
//
//  Created by Jayden Leung on 7/9/24.
//
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var sleepAmount = 8.0
//    @State private var wakeUp = Date.now
//    
//    func exampleDates() {
//        let now = Date.now
//        let tomorrow = Date.now.addingTimeInterval(86400)
//        let range = now...tomorrow
//        
//        //        var components = DateComponents()
//        //        components.hour = 8
//        //        components.minute = 0
//        //        let date = Calendar.current.date(from: components) ?? .now
//        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
//        let hour = components.hour ?? 0
//        let minute = components.minute ?? 0
//    }
//    var body: some View {
//        Form {
//            Section {
//                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...16, step: 0.25)
//                DatePicker("Bedtime", selection: $wakeUp, in: Date.now..., displayedComponents: .hourAndMinute)
//                DatePicker("Wake Up", selection: $wakeUp, in: Date.now..., displayedComponents: .hourAndMinute)
//                
//                Text(Date.now.formatted(date: .long, time: .shortened))
//            }
//            
//            Section {
//                
//            }
//            
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}


import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60  // in seconds
            let minute = (components.minute ?? 0) * 60   // in seconds
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem. Try again?"
        }
        
        //showingAlert = true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding(3)
                }
                        
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                        
                Section {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1...12, id: \.self) { amount in
                            Text("^[\(amount) cup](inflect:true)")
                        }
                    }
                    .bold()
                }
                .onAppear {
                    self.calculateBedtime()
                }
                
                VStack {
                    Text("Your ideal bedtime is:")
                        .font(.title)
                        .bold()
                    Text(alertMessage)
                        .font(.title)
                }
                        
            }
            .navigationTitle("Better Rest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
