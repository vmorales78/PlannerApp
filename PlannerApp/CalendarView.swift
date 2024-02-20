//
//  CalendarView.swift
//  PlannerApp
//
//  Created by Calvin Rice on 1/25/24.
//

import SwiftUI
import HorizonCalendar
import SwiftData

struct AssignmentCalendarView: View {
    @Query(sort: [SortDescriptor(\Assignment.assignmentClass), SortDescriptor(\Assignment.dueDate)]) var assignmentList: [Assignment]
    @State var currentClasses: [String] = []
    var body: some View {
        VStack {
            //Replace this with the calendar
            ZStack {
                Rectangle()
                    .frame(width: 800, height: 600)
                    .padding()
                Text("Calendar Placeholder")
                    .foregroundStyle(.red)
                    .font(.title)
            }
            
            Spacer()
            
            List {
                VStack(alignment: .leading) {
                    ForEach(currentClasses, id: \.self) { className in
                        Text(className)
                            .underline()
                            .font(.title)
                        VStack(alignment: .leading) {
                            ForEach(assignmentList, id: \.self) { assignment in
                                if(assignment.assignmentClass == className) {
                                    Text(assignment.assignmentName + " - Due " + assignment.dueDate.formatted())
                                        .font(.title2)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            for assignment in assignmentList {
                if(!currentClasses.contains(assignment.assignmentClass)) {
                    currentClasses.append(assignment.assignmentClass)
                }
            }
        }
    }
}

