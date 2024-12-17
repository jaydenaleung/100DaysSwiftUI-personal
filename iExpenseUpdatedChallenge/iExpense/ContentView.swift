//
//  ContentView.swift
//  iExpense
//
//  Created by Jayden Leung on 8/1/24.
//

import SwiftUI
import SwiftData

@Model class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    var date: Date
    
    var id = UUID()
    
    init(name: String, type: String, amount: Double, date: Date, id: UUID = UUID()) {
        self.name = name
        self.type = type
        self.amount = amount
        self.date = date
        self.id = id
    }
}

@Model class Expenses {
    var itemsPersonal = [ExpenseItem]() {
        didSet {
//            if let encoded = try? JSONEncoder().encode(itemsPersonal) {
//                UserDefaults.standard.set(encoded, forKey: "Personal Items")
//            }
            modelContext.insert(itemsPersonal)
        }
    }
    
    var itemsBusiness = [ExpenseItem]() {
        didSet {
//            if let encoded = try? JSONEncoder().encode(itemsBusiness) {
//                UserDefaults.standard.set(encoded, forKey: "Business Items")
//            }
            modelContext.insert(itemsBusiness)
        }
    }
    
    init() {
//        if let savedItems = UserDefaults.standard.data(forKey: "Personal Items") {
//            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
//                itemsPersonal = decodedItems
//                return
//            }
//        }
//        
//        if let savedItems = UserDefaults.standard.data(forKey: "Business Items") {
//            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
//                itemsBusiness = decodedItems
//                return
//            }
//        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var expenses = Expenses()
    @Query(filter: #Predicate<Expenses> { item in
        item.itemsPersonal
    }) var itemsPersonal: [ExpenseItem]
    @Query var itemsBusiness: [ExpenseItem]
    @State private var showingAddExpense = false
    @State private var sorted = [SortDescriptor(\ExpenseItem.name),SortDescriptor(\ExpenseItem.amount)]
    @State private var filtered = ["Personal","Business","All"]
    
    @State private var spendingSelectionDuration = "Month"
    @State private var spendingSelectionTypes = ["Day", "Month", "3 Months", "6 Months", "Year", "2 Years", "5 Years", "All Time"]
    
    let today = Date()
    
    var totalSpendingPerTime: Double {
        var tempTotalSpending = 0.0
        
        switch spendingSelectionDuration {
        
        case "All Time":
            for item in expenses.itemsPersonal {
                tempTotalSpending += item.amount
            }
            
            for item in expenses.itemsBusiness {
                tempTotalSpending += item.amount
            }
            
            return tempTotalSpending
            
        case "5 Years":
            let fiveYearsAgo = Calendar.current.date(byAdding: .year, value: -5, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if fiveYearsAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if fiveYearsAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            return tempTotalSpending
            
        case "2 Years":
            let twoYearsAgo = Calendar.current.date(byAdding: .year, value: -2, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if twoYearsAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if twoYearsAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            return tempTotalSpending
            
        case "Year":
            let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if oneYearAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if oneYearAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            return tempTotalSpending
            
        case "6 Months":
            let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if sixMonthsAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if sixMonthsAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            return tempTotalSpending
            
        case "3 Months":
            let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if threeMonthsAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if threeMonthsAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            return tempTotalSpending
            
        case "Months":
            let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if oneMonthAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if oneMonthAgo...today ~= item.date {
                    tempTotalSpending += item.amount
                }
            }
            
            return tempTotalSpending
            
        case "Day":
            for item in expenses.itemsPersonal {
                if item.date == Date() {
                    tempTotalSpending += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if item.date == Date() {
                    tempTotalSpending += item.amount
                }
            }
            
            return tempTotalSpending
            
        default:
            return 0.0
            
        }
    }

    var spendingChangePerTime: String {
        var tempPrevAmount = 0.0
        var tempPrevPercent = 0.0
        
        switch spendingSelectionDuration {
        
        case "All Time":
            tempPrevAmount += totalSpendingPerTime
            tempPrevPercent = tempPrevAmount / 1 * 100
            
            return "\(tempPrevAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))) / \(tempPrevPercent.formatted(.percent))"
            
        case "5 Years":
            let fiveYearsAgo = Calendar.current.date(byAdding: .year, value: -5, to: today) ?? today
            let tenYearsAgo = Calendar.current.date(byAdding: .year, value: -10, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if tenYearsAgo...fiveYearsAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if tenYearsAgo...fiveYearsAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            tempPrevPercent = totalSpendingPerTime / tempPrevAmount * 100
            
            return "\(tempPrevAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))) / \(tempPrevPercent.formatted(.percent))"
            
        case "2 Years":
            let twoYearsAgo = Calendar.current.date(byAdding: .year, value: -2, to: today) ?? today
            let fourYearsAgo = Calendar.current.date(byAdding: .year, value: -4, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if fourYearsAgo...twoYearsAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if fourYearsAgo...twoYearsAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            tempPrevPercent = totalSpendingPerTime / tempPrevAmount * 100
            
            return "\(tempPrevAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))) / \(tempPrevPercent.formatted(.percent))"
            
        case "Year":
            let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: today) ?? today
            let twoYearsAgo = Calendar.current.date(byAdding: .year, value: -2, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if twoYearsAgo...oneYearAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if twoYearsAgo...oneYearAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            tempPrevPercent = totalSpendingPerTime / tempPrevAmount * 100
            
            return "\(tempPrevAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))) / \(tempPrevPercent.formatted(.percent))"
            
        case "6 Months":
            let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: today) ?? today
            let twelveMonthsAgo = Calendar.current.date(byAdding: .month, value: -12, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if twelveMonthsAgo...sixMonthsAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if twelveMonthsAgo...sixMonthsAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            tempPrevPercent = totalSpendingPerTime / tempPrevAmount * 100
            
            return "\(tempPrevAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))) / \(tempPrevPercent.formatted(.percent))"
            
        case "3 Months":
            let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: today) ?? today
            let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if sixMonthsAgo...threeMonthsAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if sixMonthsAgo...threeMonthsAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            tempPrevPercent = totalSpendingPerTime / tempPrevAmount * 100
            
            return "\(tempPrevAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))) / \(tempPrevPercent.formatted(.percent))"
            
        case "Months":
            let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: today) ?? today
            let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if twoMonthsAgo...oneMonthAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if twoMonthsAgo...oneMonthAgo ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            tempPrevPercent = totalSpendingPerTime / tempPrevAmount * 100
            
            return "\(tempPrevAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))) / \(tempPrevPercent.formatted(.percent))"
            
        case "Day":
            let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: today) ?? today
            
            for item in expenses.itemsPersonal {
                if oneDayAgo...today ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            for item in expenses.itemsBusiness {
                if oneDayAgo...today ~= item.date {
                    tempPrevAmount += item.amount
                }
            }
            
            tempPrevPercent = totalSpendingPerTime / tempPrevAmount * 100
            
            return "\(tempPrevAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))) / \(tempPrevPercent.formatted(.percent))"
            
        default:
            return "$0.00 / 0.0%"
            
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        expenses.itemsPersonal.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        expenses.itemsBusiness.remove(atOffsets: offsets)
    }
    
    var body: some View { 
        NavigationStack {
            List {
                Section("Summary: At a Glance") {
                    Text("Total Spending: \(totalSpendingPerTime, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    
                    Picker("Total Spending This \(spendingSelectionDuration): \(totalSpendingPerTime, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))", selection: $spendingSelectionDuration) {
                        ForEach(spendingSelectionTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Spending Change From Last \(spendingSelectionDuration): \(spendingChangePerTime)", selection: $spendingSelectionDuration) {
                        ForEach(spendingSelectionTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Personal") {
                    ForEach(expenses.itemsPersonal) { item in
                        // Text("\(item.name) (\(item.type)) on \(item.date.formatted(date: .abbreviated, time: .omitted)) - $\(String(format: "%.2f", item.amount))")
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text("\(item.date.formatted(date: .abbreviated, time: .omitted))")
                                    .italic()
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle((item.amount < 10000) ? ((item.amount < 1000) ? ((item.amount < 100) ? ((item.amount < 10) ? .green : .black) : .orange) : .red) : .red)
                                .bold((item.amount >= 10000) ? true : false)
                            // green if $10 or under, orange if $100 or above, red if $1000 or above, bold red if $10000 or above
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section("Business") {
                    ForEach(expenses.itemsBusiness) { item in
                        // Text("\(item.name) (\(item.type)) on \(item.date.formatted(date: .abbreviated, time: .omitted)) - $\(String(format: "%.2f", item.amount))")
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text("\(item.date.formatted(date: .abbreviated, time: .omitted))")
                                    .italic()
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle((item.amount < 10000) ? ((item.amount < 1000) ? ((item.amount < 100) ? ((item.amount < 10) ? .green : .black) : .orange) : .red) : .red)
                                .bold((item.amount >= 10000) ? true : false)
                            // green if $10 or under, orange if $100 or above, red if $1000 or above, bold red if $10000 or above
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink(destination: AddView(expense: expenses)) {
                    Image(systemName: "plus")
                }
                
                Menu("Sort by", systemImage:"arrow.up.arrow.down") {
                    Picker("Sort by", selection: $sorted) {
                        Text("Sort by name")
                            .tag([SortDescriptor(\ExpenseItem.name),SortDescriptor(\ExpenseItem.amount)])
                        Text("Sort by amount")
                            .tag([SortDescriptor(\ExpenseItem.name),SortDescriptor(\ExpenseItem.amount)])
                    }
                }
                
                Menu("Filter by", systemImage:"line.3.horizontal.decrease.circle") {
                    Picker("Filter by", selection: $filtered) {
                        Text("Filter by personal")
                            .tag([SortDescriptor(\ExpenseItem.name),SortDescriptor(\ExpenseItem.amount)])
                        Text("Filter by business")
                            .tag([SortDescriptor(\ExpenseItem.name),SortDescriptor(\ExpenseItem.amount)])
                        Text("Filter by all")
                            .tag([SortDescriptor(\ExpenseItem.name),SortDescriptor(\ExpenseItem.amount)])
                    }
                }
                
                /*
                Button("Add Expense", systemImage: "plus") {
                    
                    showingAddExpense = true
                }
            */}/*
            .sheet(isPresented: $showingAddExpense) {
                //AddView(showingAddExpense: $showingAddExpense, expense: expenses)
            }*/
        }
    }
}

#Preview {
    ContentView()
}
