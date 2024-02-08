//
//  CalendarView.swift
//  PlannerApp
//
//  Created by Calvin Rice on 1/25/24.
//

import SwiftUI
import HorizonCalendar

struct AssignmentCalendarView: View {
    var body: some View {
        HorizonCalendar.CalendarViewRepresentable(visibleDateRange: Date.now...Date.now, monthsLayout: .horizontal, dataDependency: nil)
    }
}

