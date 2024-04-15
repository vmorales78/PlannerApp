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
    @State var upperDate: Date = Date.now.advanced(by: 100000)
    @State var lowerDate: Date = Date.now
    @State var showDateRange: Bool = false
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Upcoming", systemImage: "list.bullet")
                    
                }
            
            AssignmentCalendarView(upperDate: $upperDate, lowerDate: $lowerDate, calendarView: CustomCalendarView(lowerDate: $lowerDate, upperDate: $upperDate, showDateRange: $showDateRange))
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                    
                }
        }
        
//  ADDS EXAMPLE DATA TO ASSIGNMENTS ARRAY - UNCOMMENT IF THE ARRAY NEEDS STUFF IN IT FOR TESTING
//
//        .onAppear {
//            context.insert(Assignment(assignmentName: "Math Worksheet", assignmentType: "Homework", assignmentClass: "Math", startDate: Date.now, dueDate: Date.now.advanced(by: 345600)))
//            context.insert(Assignment(assignmentName: "History Quiz", assignmentType: "Quiz", assignmentClass: "History", startDate: Date.now, dueDate: Date.now.advanced(by: 432000)))
//            context.insert(Assignment(assignmentName: "Science Worksheet", assignmentType: "Homework", assignmentClass: "Science", startDate: Date.now, dueDate: Date.now.advanced(by: 86400)))
//            context.insert(Assignment(assignmentName: "Presentation", assignmentType: "Classwork", assignmentClass: "History", startDate: Date.now, dueDate: Date.now.advanced(by: 691200)))
//            context.insert(Assignment(assignmentName: "Math Test", assignmentType: "Test", assignmentClass: "Math", startDate: Date.now, dueDate: Date.now.advanced(by: 604800)))
//        }
    }
}
