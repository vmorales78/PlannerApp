//
//  ModelAssignment.swift
//  PlannerApp
//
//  Created by xcode on 12/22/23.
//

import Foundation

class Assignemnt {
    var nameAssign : String
    var typeAssign : String
    var timeAssign : Date
    var className : String
    var reminder : Bool
    init(nameAssign: String, typeAssign: String, timeAssign: Date, className: String, reminder: Bool) {
        self.nameAssign = nameAssign
        self.typeAssign = typeAssign
        self.timeAssign = timeAssign
        self.className = className
        self.reminder = reminder
    }
}
