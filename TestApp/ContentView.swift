//
//  ContentView.swift
//  TestApp
//
//  Created by Anurag Chakraborty on 18/12/24.
//


import SwiftUI

struct ContentView: View {
    @State private var isActive = false // State variable to control the transition
    
    var body: some View {
        // If isActive is false, show the OpeningScreen, otherwise show MainView
        if isActive {
            MainView() // Your main game screen
        } else {
            OpeningScreen(isActive: $isActive) // Show the opening screen
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
