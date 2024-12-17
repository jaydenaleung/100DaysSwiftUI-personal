//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Jayden Leung on 8/1/24.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expenses.self)
    }
}
