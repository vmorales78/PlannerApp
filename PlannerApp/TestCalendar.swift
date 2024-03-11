////
////  TestCalendar.swift
////  PlannerApp
////
////  Created by Valeria Morales on 2/22/24.
////
//
//import UIKit
//import HorizonCalendar
//import SwiftUI
//
//final class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        createCalendar()
//    }
//
//    func createCalendar() {
//        let calendar = Calendar.current
//        let startDate = calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))!
//        let endDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))!
//        let theContent = CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
//        
//        var calendarView = CalendarView(initialContent: theContent)
//
//        calendarView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(calendarView)
//        NSLayoutConstraint.activate([
//            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            calendarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            calendarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//
//        ])
//    }
//}
