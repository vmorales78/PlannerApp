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
                .onTapGesture {
//                    print("tapped")
                }
                .padding()
            
            Spacer()
            
//            List {
//                VStack(alignment: .leading) {
//                    ForEach(currentClasses, id: \.self) { className in
//                        Text(className)
//                            .underline()
//                            .font(.title)
//                        VStack(alignment: .leading) {
//                            ForEach(assignmentList, id: \.self) { assignment in
//                                if(assignment.assignmentClass == className) {
//                                    Text(assignment.assignmentName + " - Due " + assignment.dueDate.formatted())
//                                        .font(.title2)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
        }
//        .onAppear {
//            for assignment in assignmentList {
//                if(!currentClasses.contains(assignment.assignmentClass)) {
//                    currentClasses.append(assignment.assignmentClass)
//                }
//            }
//        }
    }
}

struct CustomCalendarView: UIViewRepresentable {
    typealias UIViewType = CalendarView
    @State var selectedDay: DayComponents?

    func makeUIView(context: Context) -> CalendarView {
        let calendarView = CalendarView(initialContent: makeContent())
        print("made UIView")
        calendarView.daySelectionHandler = { day in
            print("running")
            guard case self.selectedDay = day else {
                return print("didnt work")}
            if self.selectedDay == day {
                print("worked")
            }
        }
        
        return calendarView
        
    }

    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: DateComponents(year: 2023, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))!
        
        let lowerDate = calendar.date(from: DateComponents(year: 2023, month: 01, day: 20))!
         let upperDate = calendar.date(from: DateComponents(year: 2024, month: 02, day: 07))!
         let dateRangeToHighlight = lowerDate...upperDate
        let selectedDay = self.selectedDay
        print("made content")

        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        .dayItemProvider { day in
            var invariantViewProperties = theDay.InvariantViewProperties(
                   font: UIFont.systemFont(ofSize: 18),
                   textColor: .darkGray,
                   backgroundColor: .clear)

                 if day == selectedDay {
                   invariantViewProperties.textColor = .white
                   invariantViewProperties.backgroundColor = .blue
                     print("selected day")
                 }
//            print("returned day item")
                 return theDay.calendarItemModel(
                   invariantViewProperties: invariantViewProperties,
                   content: .init(day: day))

        }
        .interMonthSpacing(24)
        .verticalDayMargin(8)
        .horizontalDayMargin(8)
        
    }
    
    func updateUIView(_ uiView: CalendarView, context: Context) {

    }
}

struct theDay: CalendarItemViewRepresentable {
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        var textColor: UIColor
        var backgroundColor: UIColor
    }
    struct Content: Equatable {
        let day: DayComponents
    }
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> UILabel
    {
        let label = UILabel()
        
        label.backgroundColor = invariantViewProperties.backgroundColor
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor
        
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        
        return label
    }
    static func setContent(_ content: Content, on view: UILabel) {
        view.text = "\(content.day.day)"
    }
   

    
}
