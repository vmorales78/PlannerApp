//
//  EditAssignmentView.swift
//  PlannerApp
//
//  Created by Valeria Morales on 1/23/24.
//

import SwiftUI
import SwiftData
struct EditAssignmentView: View {
    @Environment(\.modelContext) var context
    @State var modelAssign = ContentView()
    @Query var assignments : [Assignment]
    @State var newName = ""
    @State var newClass = ""
    @State var enteredStartDate: Date = Date.now
    @State var enteredDueDate: Date = Date.now
    @State private var selection = "Type"
    let options = ["Enter Assignment Type", "Homework", "Quiz", "Test"]
            var body: some View {
            VStack {
                TextField("enter new name", text: $newName)
                Picker("Enter Assignment Type", selection: $selection) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
            TextField("enter new class", text: $newClass)
            DatePicker("Start Date", selection: $enteredStartDate)
            DatePicker("Due Date", selection: $enteredDueDate)
                Button("Add") {
                    let assignment = Assignment(assignmentName: newName, assignmentType: selection, assignmentClass: newClass, startDate: enteredStartDate, dueDate: enteredDueDate)
                    context.insert(assignment)
                    newName = ""
                    newClass = ""
                }
            
        }
    }
}
