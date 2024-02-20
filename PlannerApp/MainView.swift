//
//  MainView.swift
//  PlannerApp
//
//  Created by Calvin Rice on 2/2/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) var context
    @Query var assignments: [Assignment]
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Upcoming", systemImage: "list.bullet")
                    
                }
            
            AssignmentCalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
        
//  ADDS EXAMPLE DATA TO ASSIGNMENTS ARRAY - UNCOMMENT IF THE ARRAY NEEDS STUFF IN IT FOR TESTING
//        .onAppear {
//            context.insert(Assignment(assignmentName: "Math Worksheet", assignmentType: "Homework", assignmentClass: "Math", startDate: Date.now, dueDate: Date.now.advanced(by: 345600)))
//            context.insert(Assignment(assignmentName: "History Quiz", assignmentType: "Quiz", assignmentClass: "History", startDate: Date.now, dueDate: Date.now.advanced(by: 432000)))
//            context.insert(Assignment(assignmentName: "Science Worksheet", assignmentType: "Homework", assignmentClass: "Science", startDate: Date.now, dueDate: Date.now.advanced(by: 86400)))
//            context.insert(Assignment(assignmentName: "Presentation", assignmentType: "Classwork", assignmentClass: "History", startDate: Date.now, dueDate: Date.now.advanced(by: 691200)))
//            context.insert(Assignment(assignmentName: "Math Test", assignmentType: "Test", assignmentClass: "Math", startDate: Date.now, dueDate: Date.now.advanced(by: 604800)))
//        }
    }
}
