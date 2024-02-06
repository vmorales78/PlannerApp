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
    @Query(sort: \Assignment.dueDate) var assignmentsByDate: [Assignment]
    @Query(sort: \Assignment.assignmentClass) var assignmentsByClass: [Assignment]
    @State var currentList: [Assignment] = []
    @State var showSortMenu: Bool = false
    @State var enteredName: String = ""
    @State var enteredClass: String = ""
    //@State var enteredType: String = ""
    
    @State private var selection = "Type"
    let options = ["Enter Assignment Type", "Homework", "Quiz", "Test"]
    
    @State var enteredStartDate: Date = Date.now
    @State var enteredDueDate: Date = Date.now
    @State var updater: Bool = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Button(action: {
                    showSortMenu.toggle()
                }, label: {
                    Label("Sort", systemImage: "list.bullet.indent")
                })
                .padding()
                .popover(isPresented: $showSortMenu, content: {
                    VStack {
                        Button("Due Date") {
                            currentList = assignmentsByDate
                            showSortMenu = false
                        }
                        .padding()
                        
                        Button("Class") {
                            currentList = assignmentsByClass
                            showSortMenu = false
                        }
                        .padding()
                    }
                })
                
                List {
                    ForEach(currentList, id: \.self) { assignment in
    //                    NavigationLink {
    //
    //                    } label: {
                            AssignmentListItem(myAssignment: assignment)
    //                    }
                    }
                }
                .onAppear(perform: {
                    currentList = assignmentsByDate
                })
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
                            .padding()
                        })
                    }
                })
            }
            .navigationTitle("Upcoming Assignments")
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
