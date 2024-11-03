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
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Fillings (Body)
    var body: some View {
        VStack {
            wrapTitle
            toggleSwitch
            actionButton
        }
        // MARK: - Sauces (Modifiers)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding()
    }
}

// MARK: - Fillings (Body Components)
extension ContentView {
    
    var wrapTitle: some View {
        Text("Hello, SwiftUI!")
            .font(.largeTitle)
            .padding()
    }
    
    var toggleSwitch: some View {
        Toggle(isOn: $isToggled) {
            Text("Wrap that code 🌯")
        }
        .padding()
    }
    
    var actionButton: some View {
        Button(action: closeView) {
            Text("Close")
        }
    }
}

// MARK: - Extras (Helper Functions)
extension ContentView {
    func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Extras (Preview)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
