//
//  ContentView.swift
//  PlannerApp
//
//  Created by Valerie Morales on 12/7/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var viewModel = AssignmentViewmodel()
    @State private var showingAlert = false
    @Environment(\.modelContext) var context
    @Query var assignment: [AddAssignment]
    @State var enteredAssignment: String = ""
    var body: some View {
        NavigationStack {
            Text("").padding()
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add assignment") {
                            showingAlert = true
                        }
                        .alert("Add assignment", isPresented: $showingAlert) {
                            VStack {
                                TextField ("Enter Assignment Name", text: $enteredAssignment)
                                TextField ("Enter Assignment Type", text: $enteredAssignment)
                                TextField ("Enter Class Name", text: $enteredAssignment)
                            }
                            Button("Add") {
                                showingAlert = true
                                let assignment = AddAssignment(name: enteredAssignment)
                                context.insert(assignment)
                                enteredAssignment = ""
                            }
                        }
                    }
                })
            
        }
        
    }
}

#Preview {
    ContentView()
}
