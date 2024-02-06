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
    @State var newType = ""
    @State var newClass = ""
        var body: some View {
        VStack {
            TextField("enter new name", text: $newName)
            TextField("enter new type", text: $newType)
            TextField("enter new class", text: $newClass)
                Button("Add") {
//                    let assignment = Assignment(assignmentName: newName, assignmentType: newType, className: newClass)
//                    context.insert(assignment)
                    newType = ""
                    newName = ""
                    newClass = ""
                }
            NavigationLink("back to list", destination: ContentView())
        }
    }
}

#Preview {
    EditAssignmentView()
}

