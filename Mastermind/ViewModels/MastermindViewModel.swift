//
//  MastermindViewModel.swift
//  Mastermind
//
//  Created by Holger Becker on 22.08.23.
//

import Foundation
import SwiftUI

class MastermindViewModel: ObservableObject {
    
    @AppStorage("NumberOfPins") private var numberOfPins: Int = 4
    @AppStorage("NumberOfColors") private var numberOfColors: Int = 4

    

    @Published var model: MastermindModel
    
    
    init() {
        self.model = MastermindModel()
        
        model.numberOfPins = numberOfPins
        model.numberOfColors = numberOfColors
        model.newGame()
        
    }
    
        
    //MARK: - Intents
    
    func newGame() {
        model.numberOfPins = numberOfPins
        model.numberOfColors = numberOfColors
        model.newGame()
    }
    
    func checkTry() {
        model.checkTry()
    }
    
    func hidePickers() {
        model.hidePickers()
    }
}
