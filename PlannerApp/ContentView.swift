//
//  ContentView.swift
//  PlannerApp
//
//  Created by Valerie Morales on 12/7/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingAlert = false
    @Environment(\.modelContext) var context
    @Query(sort: \Assignment.dueDate) var assignmentsByDate: [Assignment]
    @Query(sort: \Assignment.assignmentClass) var assignmentsByClass: [Assignment]
    @State var currentList: [Assignment] = []
    @State var showSortMenu: Bool = false
    @State var enteredName: String = ""
    @State var enteredClass: String = ""
    @State private var selection = "Type"
    let options = ["Enter Assignment Type", "Homework", "Quiz", "Test", "Classwork"]
    @State var enteredStartDate: Date = Date.now
    @State var enteredDueDate: Date = Date.now
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
                        HStack {
                            AssignmentListItem(myAssignment: assignment)
                            NavigationLink("") {
                                EditAssignmentView(oldAssignment: assignment)
                            }
                        }
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
                        .sheet(isPresented: $showingAlert, content: {
                            VStack {
                                TextField ("Enter Assignment Name", text: $enteredName)
                                    .padding()
                                Picker("Enter Assignment Type", selection: $selection) {
                                    ForEach(options, id: \.self) {
                                        Text($0)
                                    }
                                    .padding()
                                }
                                TextField ("Enter Class Name", text: $enteredClass)
                                    .padding()
                                DatePicker("Start Date", selection: $enteredStartDate)
                                    .padding()
                                DatePicker("Due Date", selection: $enteredDueDate)
                                    .padding()
                            }
                            Button("Add") {
                                showingAlert = false
                                let assignment = Assignment(assignmentName: enteredName, assignmentType: selection, assignmentClass: enteredClass, startDate: enteredStartDate, dueDate: enteredDueDate)
                                context.insert(assignment)
                                enteredName = ""
                                selection = ""
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


