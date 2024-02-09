//
//  ModelAssignment.swift
//  PlannerApp
//
//  Created by xcode on 12/22/23.
//

import Foundation
import SwiftData

@Model
class Assignment {
    var assignmentName: String
    var assignmentType: String
    var assignmentClass: String
    var startDate: Date!
    var dueDate: Date!
   
    init(assignmentName: String, assignmentType: String, assignmentClass: String, startDate: Date, dueDate: Date) {
        self.assignmentName = assignmentName
        self.assignmentType = assignmentType
        self.assignmentClass = assignmentClass
        self.startDate = startDate
        self.dueDate = dueDate
    }
}
