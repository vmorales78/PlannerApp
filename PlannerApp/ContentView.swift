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
    @State var enteredStartDate: Date = Date.now
    @State var enteredDueDate: Date = Date.now
    var body: some View {
        NavigationStack {
            Text("Upcoming Assignments")
            List {
                ForEach(assignments, id: \.self) { assignment in
//                    NavigationLink {
//                        
//                    } label: {
                        AssignmentListItem(myAssignment: assignment)
//                    }
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add assignment") {
                        showingAlert = true
                    }
                    .popover(isPresented: $showingAlert, content: {
                        VStack {
                            TextField ("Enter Assignment Name", text: $enteredName)
                                .padding()
                            TextField ("Enter Assignment Type", text: $enteredType)
                                .padding()
                            TextField ("Enter Class Name", text: $enteredClass)
                                .padding()
                            DatePicker("Start Date", selection: $enteredStartDate)
                                .padding()
                            DatePicker("Due Date", selection: $enteredDueDate)
                                .padding()
                        }
                        Button("Add") {
                            showingAlert = false
                            let assignment = Assignment(assignmentName: enteredName, assignmentType: enteredType, assignmentClass: enteredClass, startDate: enteredStartDate, dueDate: enteredDueDate)
                            context.insert(assignment)
                            enteredName = ""
                            enteredType = ""
                            enteredClass = ""
                            enteredStartDate = Date.now
                            enteredDueDate = Date.now
                        }
                    })
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink("View Calendar") {
                        CalendarView()
                    }
                }
            })
            
        }
        
    }
}

#Preview {
    ContentView()
}

struct AssignmentListItem: View {
    let myAssignment: Assignment
    var body: some View {
        VStack(alignment: .leading) {
            Text(myAssignment.assignmentName)
                .font(.title)
            Text("\(myAssignment.assignmentType) for \(myAssignment.assignmentClass)")
                .font(.title3)
            Text("Due \(myAssignment.dueDate.formatted())")
                .font(.title3)
        }
    }
}
