//
//  AddView.swift
//  iExpense
//
//  Created by Jayden Leung on 8/6/24.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = "Expense name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var date = Date()
    
    //@Binding var showingAddExpense: Bool
    
    let types = ["Personal", "Business"]
    
    var expense: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
                
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount, date: date)
                        if item.type == "Personal" {
                            expense.itemsPersonal.append(item)
                        } else {
                            expense.itemsBusiness.append(item)
                        }
                        // showingAddExpense = false
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
