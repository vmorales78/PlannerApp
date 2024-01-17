//
//  PlannerAppApp.swift
//  PlannerApp
//
//  Created by Valerie Morales on 12/7/23.
//

import SwiftUI
import SwiftData

@main
struct PlannerAppApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Assignment.self)
        } catch {
            fatalError("Failed to create model")
        }
    }
}
