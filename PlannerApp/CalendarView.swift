//
//  CalendarView.swift
//  PlannerApp
//
//  Created by Calvin Rice on 1/25/24.
//

import SwiftUI
import HorizonCalendar
import SwiftData
import UIKit

struct AssignmentCalendarView: View {
    @Query(sort: [SortDescriptor(\Assignment.assignmentClass), SortDescriptor(\Assignment.dueDate)]) var assignmentList: [Assignment]
    @State var currentClasses: [String] = []
    
    var body: some View {
        VStack {
            CustomCalendarView()
                .padding()
            
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

struct CustomCalendarView: UIViewRepresentable {
    typealias UIViewType = CalendarView

    func makeUIView(context: Context) -> CalendarView {
        return CalendarView(initialContent: makeContent())
    }
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        
        let lowerDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 20))!
         let upperDate = calendar.date(from: DateComponents(year: 2020, month: 02, day: 07))!
         let dateRangeToHighlight = lowerDate...upperDate
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
    }
    
    func updateUIView(_ uiView: CalendarView, context: Context) {

    }
}
