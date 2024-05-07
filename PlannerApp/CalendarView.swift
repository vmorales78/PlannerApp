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
    @State var endDate: Date = Date.now.advanced(by: 1)
    @State var startDate: Date = Date.now
    @State var calendarView: Any = CustomCalendarView(startDate: Date.now, endDate: Date.now.advanced(by: 1))
    
    func setDates(start: Date, end: Date) {
        startDate = start
        endDate = end
        calendarView = CustomCalendarView(startDate: start, endDate: end) as CustomCalendarView
    }
    
    var body: some View {
        VStack {
            calendarView as! View
//                .padding()
            
            Text("Started \(startDate) - Due \(endDate)")
            
            Spacer()
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(currentClasses, id: \.self) { className in
                        Text(className)
                            .underline()
                            .font(.title)
                            .padding()
                        ForEach(assignmentList, id: \.self) { assignment in
                            if(assignment.dueDate > Date.now) {
                                if(assignment.assignmentClass == className) {
                                    Button {
                                        setDates(start: assignment.startDate, end: assignment.dueDate)
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
            .defaultScrollAnchor(.top)
        }
        .onAppear {
            for assignment in assignmentList {
                if(!currentClasses.contains(assignment.assignmentClass) && assignment.dueDate > Date.now) {
                    currentClasses.append(assignment.assignmentClass)
                }
            }
        }
    }
}

struct CustomCalendarView: UIViewRepresentable {
    @State var startDate: Date
    @State var endDate: Date
    
    typealias UIViewType = CalendarView
    @State var selectedDay: DayComponents?
    
    func makeUIView(context: Context) -> CalendarView {
        let calendarView = CalendarView(initialContent: makeContent())
        calendarView.daySelectionHandler = { day in
            guard case self.selectedDay = day else { return }
        }
        return calendarView
    }
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        
        return CalendarViewContent (
            calendar: calendar,
            visibleDateRange: Date.now.advanced(by: -10000)...Date.now.advanced(by: 500000000),
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        .dayRangeItemProvider(for: [startDate...endDate]) { context in
            CalendarItemModel<DayRangeIndicatorView>(
                invariantViewProperties: .init(),
                content: .init(framesOfDaysToHighlight: context.daysAndFrames.map { $0.frame }))
        }
        .dayItemProvider { day in
            var invariantViewProperties = theDay.InvariantViewProperties(
                font: UIFont.systemFont(ofSize: 18),
                textColor: .darkGray,
                backgroundColor: .clear)
            
            if day == selectedDay {
                invariantViewProperties.textColor = .white
                invariantViewProperties.backgroundColor = .blue
            }
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
    private var indicatorColor: UIColor = UIColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 0.15)
    
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
        context?.setFillColor(indicatorColor.cgColor)
        
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

