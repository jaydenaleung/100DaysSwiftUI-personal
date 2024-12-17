//
//  ContentView.swift
//  Animations
//
//  Created by Jayden Leung on 7/17/24.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
        let anchor: UnitPoint

        func body(content: Content) -> some View {
            content
                .rotationEffect(.degrees(amount), anchor: anchor)
                .clipped()
        }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var letters = Array("Hello SwiftUI")
    
    var body: some View {
        /*
        Button("Tap Me") {
//            animationAmount += 0.5
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
//        .scaleEffect(animationAmount)
//        .blur(radius: ((animationAmount - 1) * 3))
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
        
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            Spacer()
            Button("Tap me too") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
        }
        
        
        Button("Tap me too") {
            withAnimation {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationAmount), axis: (x: Double.random(in: -1.0...1.0), y: Double.random(in: -1.0...1.0), z: Double.random(in: -1.0...1.0))
        )
         
        
        Button("Hey there!") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .foregroundStyle(.white)
        .animation(nil, value: enabled)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
        
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmount)
                        .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        dragAmount = .zero
                        enabled.toggle()
                    }
            )
            .padding(20)
            
            
            ZStack {
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                
                VStack {
                    Text("Jayden Leung")
                        .bold()
                        .font(.title2)
                    Text("Government-Issued ID")
                }
            }
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            dragAmount = .zero
                        }
                    }
            )
        }
         */
        
        VStack {
            Button("Tap me againnnnnn") {
                withAnimation {
                    enabled.toggle()
                }
            }
            
            if enabled {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                enabled.toggle()
            }
        }        
    }
}

#Preview {
    ContentView()
}
