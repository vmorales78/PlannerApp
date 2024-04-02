//
//  SettingsView.swift
//  PlannerApp
//
//  Created by Calvin Rice on 4/2/24.
//

import SwiftUI

struct SettingsView: View {
    @State var showPushNotifications: Bool = true
    var body: some View {
        List {
            Toggle("Show Push Notifications", isOn: $showPushNotifications)
        }
        .navigationTitle("Settings")
    }
}
