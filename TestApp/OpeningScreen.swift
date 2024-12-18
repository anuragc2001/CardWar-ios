//
//  OpeningScreen.swift
//  TestApp
//
//  Created by Anurag Chakraborty on 18/12/24.
//


import SwiftUI

struct OpeningScreen: View {
    @Binding var isActive: Bool // Binding variable to control when to navigate to the main view
    
    var body: some View {
        ZStack {
            // Background color or image
            Image("background-cloth")
                .resizable()
                .ignoresSafeArea(edges: .all)
            
            VStack {
                Spacer()
                // Your Logo or Text
                Image("logo") // Replace with your actual logo image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250) // 
                
                Spacer()
            }
            
        }
        .onAppear {
            // Transition to main view after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
    }
}
