import SwiftUI

struct MainView: View {
    
    @State var playerCard = "back"
    @State var cpuCard = "back"
    
    @State var playerScore = 0
    @State var cpuScore = 0
    
    @State private var playerCardRotationAngle: Double = 0.0 // Angle for player's card (clockwise)
    @State private var cpuCardRotationAngle: Double = 0.0    // Angle for CPU's card (anticlockwise)
    
    @State private var playerCardScale: CGFloat = 1.0 // Scale factor for player's card
    @State private var cpuCardScale: CGFloat = 1.0    // Scale factor for CPU's card
    
    @State private var playerCardGlow: Bool = false // Control the yellow glow for player's card
    @State private var cpuCardGlow: Bool = false    // Control the yellow glow for CPU's card
    
    @State private var playerCardRedGlow: Bool = false // Control the red glow for losing player's card
    @State private var cpuCardRedGlow: Bool = false    // Control the red glow for losing CPU's card
    
    var body: some View {
        
        ZStack {
            Image("background-cloth")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                Image("logo")
                
                Spacer()
                
                HStack {
                    Spacer()
                    Image("\(playerCard)")
                        .rotation3DEffect(
                            .degrees(playerCardRotationAngle),
                            axis: (x: 0.0, y: 1.0, z: 0.0) // Rotate around Z-axis (clockwise)
                        )
                        .scaleEffect(playerCardScale) // Apply scaling effect
                        .shadow(color: playerCardGlow ? .yellow : (playerCardRedGlow ? .red : .clear), radius: 10, x: 0, y: 0) // Glow effect (yellow for win, red for loss)
                        .animation(.easeInOut(duration: 1), value: playerCardRotationAngle)
                    Spacer()
                    Image(cpuCard)
                        .rotation3DEffect(
                            .degrees(cpuCardRotationAngle),
                            axis: (x: 0.0, y: 1.0, z: 0.0) // Rotate around Z-axis (anticlockwise)
                        )
                        .scaleEffect(cpuCardScale) // Apply scaling effect
                        .shadow(color: cpuCardGlow ? .yellow : (cpuCardRedGlow ? .red : .clear), radius: 10, x: 0, y: 0) // Glow effect (yellow for win, red for loss)
                        .animation(.easeInOut(duration: 1), value: cpuCardRotationAngle)
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    deal()
                } label: {
                    Image("button")
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    VStack {
                        Text("YOU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                .foregroundColor(Color.white)
                
                Spacer()
            }
        }
    }
    
    func deal() {
        // Reset the cards to the back cover before spinning
        playerCard = "back"
        cpuCard = "back"
        
        // Reset glow effect for both cards
        playerCardGlow = false
        cpuCardGlow = false
        playerCardRedGlow = false
        cpuCardRedGlow = false
        
        // Animate the player's card (clockwise)
        withAnimation {
            playerCardRotationAngle += 180 // Clockwise rotation (180 degrees)
            playerCardScale = 1.0 // Reset scale for player card
            cpuCardScale = 1.0 // Reset scale for CPU card
        }
        
        // Animate the CPU's card (anticlockwise)
        withAnimation {
            cpuCardRotationAngle -= 180 // Anticlockwise rotation (-180 degrees)
        }
        
        // Delay the card change slightly to let the animation finish
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let playerInt = Int.random(in: 2...14)
            let cpuInt = Int.random(in: 2...14)
            
            playerCard = "card" + String(playerInt)
            cpuCard = "card" + String(cpuInt)
            
            if playerInt > cpuInt {
                playerScore += 1
                // Player wins, make the player's card bigger and add yellow glow
                withAnimation {
                    playerCardScale = 1.3 // Scale up the player's card
                    cpuCardScale = 1.0   // Keep the CPU card at normal size
                    playerCardGlow = true // Apply the yellow glow to player's card
                    cpuCardGlow = false  // Remove glow from CPU's card
                    playerCardRedGlow = false // No red glow for player's card
                    cpuCardRedGlow = true  // Apply the red glow to CPU's card
                }
            } else if playerInt < cpuInt {
                cpuScore += 1
                // CPU wins, make the CPU's card bigger and add yellow glow
                withAnimation {
                    cpuCardScale = 1.3 // Scale up the CPU card
                    playerCardScale = 1.0 // Keep the player's card at normal size
                    cpuCardGlow = true // Apply the yellow glow to CPU's card
                    playerCardGlow = false // Remove glow from player's card
                    cpuCardRedGlow = false // No red glow for CPU's card
                    playerCardRedGlow = true  // Apply the red glow to player's card
                }
            } else {
                // It's a draw, make both cards bigger and add red glow
                withAnimation {
                    playerCardScale = 1.3 // Scale up the player's card
                    cpuCardScale = 1.3   // Scale up the CPU's card
                    playerCardRedGlow = true // Apply the red glow to both cards
                    cpuCardRedGlow = true  // Apply the red glow to both cards
                }
            }
        }
        
        // Reset the rotation to prepare for the next round
        withAnimation {
            playerCardRotationAngle += 180 // Rotate the player's card clockwise (again)
            cpuCardRotationAngle -= 180 // Rotate the CPU's card anticlockwise (again)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
