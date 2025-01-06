//
//  ContentView.swift
//  MyfoodChioce
//
//  Created by 刘超 on 16/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                // ...
            }
            .toolbar {
                // ...
                ToolbarItem {
                    NavigationLink(destination: LoginView()) {
                        Label("Login", systemImage: "person.fill")
                    }
                }
                ToolbarItem {
                    NavigationLink(destination: SignUpView()) {
                        Label("Sign Up", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
