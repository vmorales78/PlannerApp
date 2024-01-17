//
//  ContentView.swift
//  PlannerApp
//
//  Created by Valerie Morales on 12/7/23.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = AssignmentViewmodel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
