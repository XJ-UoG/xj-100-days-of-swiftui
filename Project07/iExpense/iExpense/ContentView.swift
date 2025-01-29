//
//  ContentView.swift
//  iExpense
//
//  Created by Tan Xin Jie on 28/1/25.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalExpenses: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationStack {
            List {
                if !expenses.personalExpenses.isEmpty {
                    Section(header: Text("Personal")) {
                        ForEach(expenses.personalExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            }
                        }
                        .onDelete { offsets in removeItems(from: expenses.personalExpenses, at: offsets) }
                    }
                }
                
                if !expenses.businessExpenses.isEmpty {
                    Section(header: Text("Business")) {
                        ForEach(expenses.businessExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            }
                        }
                        .onDelete{ offsets in removeItems(from: expenses.businessExpenses, at: offsets) }
                    }
                }
                
                if expenses.items.isEmpty {
                    ContentUnavailableView {
                        Label("No Expenses Found", systemImage: "exclamationmark.magnifyingglass")
                    } description: {
                        Text("Press + to add a new expense")
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(from section: [ExpenseItem], at offsets: IndexSet) {
        // Find global index from local section
        for index in offsets {
            if let globalIndex = expenses.items.firstIndex(where: { $0.id == section[index].id }) {
                expenses.items.remove(at: globalIndex)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}
