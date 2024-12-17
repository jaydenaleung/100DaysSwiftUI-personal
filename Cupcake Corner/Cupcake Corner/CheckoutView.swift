//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Student on 11/7/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingError = false
    @State private var errors = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(filePath: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Error in contacting server.", isPresented: $showingError) {
            Button("OK") {}
        } message: {
            Text(errors)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            print("uploaded: \(data)")
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            errors = error.localizedDescription
            print("Checkout failed: \(errors)")
            showingError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
