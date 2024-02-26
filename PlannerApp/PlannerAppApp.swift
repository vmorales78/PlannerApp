//
//  PlannerAppApp.swift
//  PlannerApp
//
//  Created by Valerie Morales on 12/7/23.
//

import SwiftUI
import SwiftData

//@main

struct PlannerAppApp: App {
//    let container: ModelContainer
//        
//    init() {
//        do {
//            container = try ModelContainer(for: Assignment.self)
//        } catch {
//            fatalError("Could not initialize ModelContainer")
//        }
//    }
//    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Assignment.self)
        
    }
    
}
