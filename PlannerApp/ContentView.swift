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
    @Query var assignments: [Assignment]
    @State var enteredName: String = ""
    @State var enteredClass: String = ""
    @State var enteredType: String = ""
        var body: some View {
        NavigationStack {
            List(assignments) { assignment in
                HStack {
                    Text(assignment.assignmentName)
                    NavigationLink("edit", destination: EditAssignmentView())
                }
            }
                .padding()
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add assignment") {
                            showingAlert = true
                        }
                        .alert("Add assignment", isPresented: $showingAlert) {
                            VStack {
                                TextField ("Enter Assignment Name", text: $enteredName)
                                TextField ("Enter Assignment Type", text: $enteredType)
                                TextField ("Enter Class Name", text: $enteredClass)
                            }
                            Button("Add") {
                                showingAlert = false
                                let assignment = Assignment(assignmentName: enteredName, assignmentType: enteredType, className: enteredClass)
                                context.insert(assignment)
                                enteredName = ""
                                enteredType = ""
                                enteredClass = ""
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
