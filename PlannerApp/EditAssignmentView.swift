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
    @State var oldAssignment: Assignment
    @Query var assignments : [Assignment]
    @State var newName = ""
    @State var newClass = ""
    @State var enteredStartDate: Date = Date.now
    @State var enteredDueDate: Date = Date.now
    @State private var selection = "Enter Assignment Type"
    let options = ["Enter Assignment Type", "Homework", "Quiz", "Test", "Classwork"]
    @Environment(\.dismiss) var dismiss
    @State var showDeleteAlert: Bool = false
    var body: some View {
        VStack {
            TextField("Enter Name", text: $newName)
                .padding()
            Picker("Enter Assignment Type", selection: $selection) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .padding()
            TextField("Enter Class", text: $newClass)
                .padding()
            DatePicker("Start Date", selection: $enteredStartDate)
                .padding()
            DatePicker("Due Date", selection: $enteredDueDate)
                .padding()
            Button("Confirm") {
                let assignment = Assignment(assignmentName: newName, assignmentType: selection, assignmentClass: newClass, startDate: enteredStartDate, dueDate: enteredDueDate)
                context.insert(assignment)
                context.delete(oldAssignment)
                dismiss()
            }
            .padding()
            Button("Delete") {
                showDeleteAlert = true
            }
            .foregroundStyle(.red)
            .padding()
        }
        .alert("Are you sure you want to delete \(oldAssignment.assignmentName)", isPresented: $showDeleteAlert, actions: {
            Button("Confirm") {
                context.delete(oldAssignment)
                dismiss()
            }
            
            Button("Cancel") {
                showDeleteAlert = false
            }
        })
        .onAppear {
            newName = oldAssignment.assignmentName
            newClass = oldAssignment.assignmentClass
            selection = oldAssignment.assignmentType
            enteredStartDate = oldAssignment.startDate
            enteredDueDate = oldAssignment.dueDate
        }
    }
}
