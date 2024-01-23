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
    var assignmentName : String
    var assignmentType : String
    var className : String
    
    init(assignmentName: String, assignmentType: String, className: String) {
        self.assignmentName = assignmentName
        self.assignmentType = assignmentType
        self.className = className
    }
}
