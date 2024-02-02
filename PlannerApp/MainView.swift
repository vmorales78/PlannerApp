//
//  MainView.swift
//  PlannerApp
//
//  Created by Calvin Rice on 2/2/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Upcoming", systemImage: "list.bullet")
                    
                }
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    MainView()
}
