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
    @State var calendarView = CustomCalendarView(showDateRange: false)
    
    var body: some View {
        VStack {
            calendarView
                .padding()
            
            Spacer()
            
            VStack {
                VStack(alignment: .leading) {
                    ForEach(currentClasses, id: \.self) { className in
                        Text(className)
                            .underline()
                            .font(.title)
                            .padding()
                        List {
                            ForEach(assignmentList, id: \.self) { assignment in
                                if(assignment.assignmentClass == className) {
                                    Button {
                                        calendarView.setDateRange(from: assignment.startDate, to: assignment.dueDate)
                                    } label: {
                                        Text(assignment.assignmentName + " - Due " + assignment.dueDate.formatted())
                                            .font(.title2)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .onDisappear {
            calendarView.hideDateRange()
        }
        .onAppear {
            calendarView.hideDateRange()
            for assignment in assignmentList {
                if(!currentClasses.contains(assignment.assignmentClass)) {
                    currentClasses.append(assignment.assignmentClass)
                }
            }
        }
    }
}

//Below is mostly copied from HorizonCalendar github
struct CustomCalendarView: UIViewRepresentable {
    @State var lowerDate: Date = Date.now
    @State var upperDate: Date = Date.now
    @State var showDateRange: Bool
    
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

    
    func hideDateRange() {
        showDateRange = false
    }
    
    func setDateRange(from: Date, to: Date) {
        lowerDate = from
        upperDate = to
        showDateRange = true
    }
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: DateComponents(year: 2023, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))!
        
        let dateRangeToHighlight = lowerDate...upperDate
        
        return CalendarViewContent (
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        .dayRangeItemProvider(for: [dateRangeToHighlight]) { dayRangeLayoutContext in
            DayRangeIndicatorView.calendarItemModel(
                invariantViewProperties: .init(),
                content: .init(framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame }))
        }
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

final class DayRangeIndicatorView: UIView {
    let color: UIColor
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .infinite)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var framesOfDaysToHighlight = [CGRect]() {
        didSet {
            guard framesOfDaysToHighlight != oldValue else { return }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.withAlphaComponent(0.15).cgColor)
        
        // Get frames of day rows in the range
        var dayRowFrames = [CGRect]()
        var currentDayRowMinY: CGFloat?
        for dayFrame in framesOfDaysToHighlight {
            if dayFrame.minY != currentDayRowMinY {
                currentDayRowMinY = dayFrame.minY
                dayRowFrames.append(dayFrame)
            } else {
                let lastIndex = dayRowFrames.count - 1
                dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
            }
        }
        
        // Draw rounded rectangles for each day row
        for dayRowFrame in dayRowFrames {
            let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: 12)
            context?.addPath(roundedRectanglePath.cgPath)
            context?.fillPath()
        }
    }
    
}


extension DayRangeIndicatorView: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        let indicatorColor = UIColor.blue.withAlphaComponent(0.15)
    }
    
    struct Content: Equatable {
        let framesOfDaysToHighlight: [CGRect]
    }
    
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> DayRangeIndicatorView
    {
        DayRangeIndicatorView(color: UIColor(Color.accentColor))
    }
    
    static func setContent(_ content: Content, on view: DayRangeIndicatorView) {
        view.framesOfDaysToHighlight = content.framesOfDaysToHighlight
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

