//
//  MastermindViewModel.swift
//  Mastermind
//
//  Created by Holger Becker on 22.08.23.
//

import Foundation

class MastermindViewModel: ObservableObject {

    @Published var model: MastermindModel
    
    init() {
        self.model = MastermindModel()
        model.newGame(level: 0)
        
    }
    
        
    //MARK: - Intents
    func checkTry() {
        model.checkTry()
    }
    func hidePickers() {
        model.hidePickers()
    }
}
