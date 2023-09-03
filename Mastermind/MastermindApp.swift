//
//  MastermindApp.swift
//  Mastermind
//
//  Created by Holger Becker on 22.08.23.
//

import SwiftUI

@main
struct MastermindApp: App {
    let vm = MastermindViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GameView()
            }
            .environmentObject(vm)
            .navigationTitle("Mastermind")
        }
    }
}
