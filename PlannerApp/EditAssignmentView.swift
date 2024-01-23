//
//  EditAssignmentView.swift
//  PlannerApp
//
//  Created by Valeria Morales on 1/23/24.
//

import SwiftUI
struct EditAssignmentView: View {
    @State var modelAssign = Assignment(assignmentName: "", assignmentType: "", assignmentClass: "")
    @State var newName = ""
    @State var newType = ""
    @State var newClass = ""
    
    var body: some View {
        VStack {
            TextField("enter new name", text: $newName)
            TextField("enter new type", text: $newType)
            TextField("enter new class", text: $newClass)
            Button("update") {
                let updatedAssign = Assignment(assignmentName: newName, assignmentType: newType, assignmentClass: newClass)
            }
        }
    }
}

#Preview {
    EditAssignmentView()
}

