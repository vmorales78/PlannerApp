//
//  ModelAssignment.swift
//  PlannerApp
//
//  Created by xcode on 12/22/23.
//

import Foundation
import SwiftData

@Model
class Assignment: Hashable {
    var assignmentName: String = ""
    var assignmentType: String = ""
    var assignmentClass: String = ""
    var startDate: Date! = Date.now
    var dueDate: Date! = Date.now
   
    init(assignmentName: String, assignmentType: String, assignmentClass: String, startDate: Date, dueDate: Date) {
        self.assignmentName = assignmentName
        self.assignmentType = assignmentType
        self.assignmentClass = assignmentClass
        self.startDate = startDate
        self.dueDate = dueDate
    }
}
