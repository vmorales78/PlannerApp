//
//  ModelAssignment.swift
//  PlannerApp
//
//  Created by xcode on 12/22/23.
//

import Foundation

class Assignment {
    var nameAssign : String
    var typeAssign : String
    var className : String
    
    init(nameAssign: String, typeAssign: String, className: String) {
        self.nameAssign = nameAssign
        self.typeAssign = typeAssign
        self.className = className
    }
}
