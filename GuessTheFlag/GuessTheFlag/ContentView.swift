//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jayden Leung on 7/2/24.
//
/*

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        /* Button("Show Alert") {
            showingAlert = true
        }
        
        .alert("Alerted", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) {}
            Button("Cancel", role:.cancel) {}
        } message: {
            Text("My message")
        } */
        
        /* VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
        }
        
        Button {
            print("Button was tapped")
        } label: {
            Label("Edit", systemImage: "pencil")
                .padding()
        }
        
        Image(systemName: "pencil.circle")
            .foregroundStyle(.red)
            .font(.largeTitle) */
        
        /* LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
        AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
            .ignoresSafeArea()
        
        Text("Hello, world!")
            .frame(maxWidth: .infinity,  maxHeight: .infinity)
            .foregroundStyle(.white)
            .background(.pink.gradient) */
        
        /* ZStack {
            Color.purple
                .frame(minWidth: 200, minHeight: 200, maxHeight: .infinity)
                .ignoresSafeArea()
            Color.primary
                .frame(width: 300, height: 400)
            Color.yellow
                .frame(width: 200, height: 200)
            VStack (spacing: 0) {
                Color.red
                Color.blue
            }
            
            
            Text("Hello, World!")
                .background(.red)
            Text("What's up!")
                .background(.green)
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        } */
    }
}

#Preview {
    ContentView()
}

*/


import SwiftUI

struct ContentView: View {
    
    // constants and variables
    
    // @State
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingEndScreen = true
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var wrongAnswer = ""
    @State private var correctState: Bool = true
    @State private var questionNumber = 1
    @State private var animationAmount = 0.0
    @State private var fadeAmount = 1.00
    @State private var overlayAmount = 0.00
    @State private var buttonTappedIndex = 0
    
    // constants
    let correctString = "added"
    let wrongString = "deducted"
    
    
    // functions
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            correctState = true
            score += 1
        } else {
            scoreTitle = "Wrong!"
            correctState = false
            score -= 1
            wrongAnswer = countries[number]
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionNumber += 1
        isShowingEndScreen()
        animationAmount = 0.0
        fadeAmount = 1.00
        overlayAmount = 0.00
        buttonTappedIndex = 0
    }
    
    func addedOrDeducted() -> String {
        if correctState {
            return correctString
        } else {
            return wrongString
        }
    }
    
    func isShowingEndScreen() {
        if questionNumber > 8 {
            showingEndScreen = false
        }
    }
    
    // MAIN
    
    var body: some View {
        ZStack {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.yellow.gradient)
            
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Text("Question \(questionNumber)/8")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation {
                                buttonTappedIndex = number
                                animationAmount += 360.0
                                fadeAmount -= 0.75
                                overlayAmount += 0.75
                            }
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 3))
                                .shadow(radius: 5)
                                .rotation3DEffect(.degrees(number == buttonTappedIndex ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(number != buttonTappedIndex ? fadeAmount : 1.00)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .foregroundStyle(number == buttonTappedIndex ? .green : .red)
                                        .rotation3DEffect(.degrees(number == buttonTappedIndex ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                                        .opacity(overlayAmount)
                                )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            
            //psuedocode
            VStack {
                Text("Congratulations!")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Text("Your score is:")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text("\(score) out of 8")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                
                Button("Play Again") {
                    showingEndScreen = true
                    score = 0
                    questionNumber = 1
                }
                .frame(maxWidth: 150, maxHeight: 50)
                .background(.white.gradient)
                .clipShape(.capsule)
            }
            .frame(maxWidth: 300, maxHeight: 200)
            .padding(.vertical, 30)
            .background(.red.gradient)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .opacity(showingEndScreen ? 0 : 1)
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if correctState {
                Text("One point \(addedOrDeducted()). Your score is \(score).")
            } else {
                Text("That was the flag of \(wrongAnswer). One point \(addedOrDeducted()). Your score is \(score).")
            }
        }
    }
}


// Preview
#Preview {
    ContentView()
}
