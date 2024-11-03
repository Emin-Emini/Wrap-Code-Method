//
//  ContentView.swift
//  Wrap Code Method
//
//  Created by Emin Emini on 3.11.24.
//

import SwiftUI

// MARK: - Tortilla (Main View Wrapper)
struct ContentView: View {
    
    // MARK: - Ingredients (State, Environment, Properties)
    @State private var isToggled: Bool = false
    @State private var offsetY: CGFloat = 0
    @State private var isHidden: Bool = false
    @State private var buttonOpacity: Double = 0
    @State private var emojiOpacity: Double = 0
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Fillings (Body)
    var body: some View {
        MainContentWrapper(
            isToggled: $isToggled,
            offsetY: $offsetY,
            isHidden: $isHidden,
            buttonOpacity: $buttonOpacity,
            emojiOpacity: $emojiOpacity,
            closeView: closeView,
            showCard: showCard
        )
        .onAppear {
            // Initial setup to position the card at the top
            offsetY = 0
        }
    }
}

// MARK: - Main Content Wrapper (Consider it as a Filling Component)
struct MainContentWrapper: View {
    @Binding var isToggled: Bool
    @Binding var offsetY: CGFloat
    @Binding var isHidden: Bool
    @Binding var buttonOpacity: Double
    @Binding var emojiOpacity: Double
    let closeView: () -> Void
    let showCard: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 20) {
                wrapTitle
                toggleSwitch
                actionButton
            }
            // MARK: - Sauces (Modifiers)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            .padding()
            .offset(y: offsetY) // Apply the offset
            
            Spacer() // Pushes the content to the top
            
            if isHidden {
                wrapEmoji
                    .opacity(emojiOpacity)
                    .animation(.easeIn(duration: 0.3), value: emojiOpacity)
                
                wrapTitleUnderEmoji
                    .opacity(emojiOpacity)
                    .animation(.easeIn(duration: 0.3), value: emojiOpacity)
                
                arrowUpButton
                    .opacity(buttonOpacity)
                    .animation(.easeIn(duration: 0.3), value: buttonOpacity)
                    .padding(.bottom, 30) // Adds space from the bottom of the screen
            }
        }
    }
}

// MARK: - Fillings (Body Components)
extension MainContentWrapper {
    
    var arrowUpButton: some View {
        Button(action: showCard) {
            Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
        }
    }
    
    var wrapTitle: some View {
        Text("Hello, SwiftUI!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
    
    var toggleSwitch: some View {
        Toggle(isOn: $isToggled) {
            Text("Wrap that code 🌯")
                .font(.headline)
                .foregroundColor(.white)
        }
        .toggleStyle(SwitchToggleStyle(tint: .black))
        .padding()
    }
    
    var actionButton: some View {
        Button(action: closeView) {
            Text("Wrap")
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(.orange)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
        }
        .padding(.horizontal)
    }
    
    var wrapEmoji: some View {
        Text("🌮")
            .font(.system(size: 150)) // Huge size for the emoji
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
            .padding(.bottom, 10) // Add some space below the emoji
    }
    
    var wrapTitleUnderEmoji: some View {
        Text("You Wrapped The Code!")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.gray)
            .padding(.bottom, 20) // Add some space below the title
    }
}

// MARK: - Extras (Helper Functions)
extension ContentView {
    func closeView() {
        withAnimation {
            // Move the card to the bottom of the screen, leaving 30 points visible
            offsetY = UIScreen.main.bounds.height - 30
            isHidden = true
        }
        // Delay the button's and emoji's fade-in effect until the card is fully moved
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                buttonOpacity = 1
                emojiOpacity = 1
            }
        }
    }
    
    func showCard() {
        withAnimation {
            // Bring the card back to its initial position
            offsetY = 0
            buttonOpacity = 0 // Hide the button
            emojiOpacity = 0  // Hide the emoji and title
            isHidden = false
        }
    }
}

// MARK: - Extras (Preview)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
