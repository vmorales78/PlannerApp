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

//Below is mostly copied from HorizonCalendar github
struct CustomCalendarView: UIViewRepresentable {
    typealias UIViewType = CalendarView
    
    func makeUIView(context: Context) -> CalendarView {
        return CalendarView(initialContent: makeContent())
    }
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        
        //Date Range
        let lowerDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 20))!
        let upperDate = calendar.date(from: DateComponents(year: 2020, month: 02, day: 07))!
        let dateRangeToHighlight = lowerDate...upperDate
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        .dayRangeItemProvider(for: [dateRangeToHighlight]) { dayRangeLayoutContext in
            DayRangeIndicatorView.calendarItemModel(
                invariantViewProperties: .init(),
                content: .init(framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame }))
        }
        .dayItemProvider { day in
            theDay.calendarItemModel(
                invariantViewProperties: .init(
                    font: UIFont.systemFont(ofSize: 18),
                    textColor: .darkGray,
                    backgroundColor: .clear),
                content: .init(day: day))
        }
    }
    
    func updateUIView(_ uiView: CalendarView, context: Context) {
    }
}

final class DayRangeIndicatorView: UIView {
    
    init() {
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
        context?.setFillColor(UIColor(Color.accentColor).withAlphaComponent(0.15).cgColor)
        
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
        DayRangeIndicatorView()
    }
    
    static func setContent(_ content: Content, on view: DayRangeIndicatorView) {
        view.framesOfDaysToHighlight = content.framesOfDaysToHighlight
    }
    
}

struct theDay: CalendarItemViewRepresentable {
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        let textColor: UIColor
        let backgroundColor: UIColor
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

