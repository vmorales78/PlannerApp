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
                    Image(systemName: "list.bullet")
                }
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                }
        }
    }
}

#Preview {
    MainView()
}
