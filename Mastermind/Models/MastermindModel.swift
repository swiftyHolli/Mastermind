//
//  MastermindModel.swift
//  Mastermind
//
//  Created by Holger Becker on 22.08.23.
//

import Foundation

struct MastermindModel {    
    enum PinColor: Int {
        case red, yellow, green, blue, orange, brown, pink, purple, empty
        
        static func randomColor(numberOfColors number: Int)->PinColor {
            let randomNumber = Int.random(in: 0..<number - 1)
            return PinColor(rawValue: randomNumber) ?? .red
        }
    }

    enum SignalColors {
        case black, white, empty
    }
    
    var numberOfPins: Int
    var numberOfColors: Int
    var maxTries: Int
    var codeField: CodeField
    var signalFields: [[SignalPin]]
    var tryFields: [CodeField]
    var nextTry: CodeField
    var won = false
    var repeatedColors = false
    var pickers = [CodePin:Bool]()
    var pickerVisible = false

    init() {
        self.numberOfPins = 4
        self.maxTries = 8
        self.signalFields = [[SignalPin]]()
        self.tryFields = [CodeField]()
        self.codeField = CodeField.newCodeField(numberOfPins: numberOfPins, numberOfColors: 4, fromTry: nil)
        self.nextTry = CodeField.emptyCodeField(numberOfPins: numberOfPins)
        self.numberOfColors = 4
        newGame(level: 0)
    }
    
    mutating func newGame(level: Int) {
        signalFields.removeAll()
        tryFields.removeAll()
        switch level {
        case 0:
            numberOfPins = 4
        case 1:
            numberOfPins = 5
        case 2:
            numberOfPins = 6
        default:
            numberOfPins = 4
        }
        self.codeField = CodeField.newCodeField(numberOfPins: numberOfPins, numberOfColors: numberOfColors, fromTry: nil)
        self.nextTry = CodeField.emptyCodeField(numberOfPins: numberOfPins)
        for codePin in self.nextTry.row {
            pickers[codePin] = false
        }
        pickerVisible = false
    }
    
    struct CodePin: Identifiable, Hashable {
        var pinColor: PinColor
        var id: UUID
        var selection: PinColor {
            didSet {
                pinColor = selection
            }
        }
        
        static func random(numberOfColors number:Int, id: UUID)->CodePin {
            let randomNumber = Int.random(in: 0..<number)
            var pickerColors = [PinColor]()
            for index in 0..<number {
                pickerColors.append(PinColor(rawValue: index) ?? .red)
            }
            return CodePin(pinColor: PinColor(rawValue: randomNumber) ?? .red, id: UUID(), selection: PinColor(rawValue: randomNumber) ?? .red)
        }
    }
    
    struct CodeField: Identifiable, Hashable {
        
        var id: UUID
        var row: [CodePin]
        
        static func newCodeField(numberOfPins: Int, numberOfColors: Int, fromTry: CodeField?) -> CodeField {
            var newRow = [CodePin]()
            if let lastTry = fromTry {
                for index in 0..<numberOfPins {
                    var colors = [PinColor]()
                    for i in 0..<numberOfColors {
                        colors.append(PinColor(rawValue: i) ?? .red)
                    }
                    
                    newRow.append(CodePin(pinColor: lastTry.row[index].pinColor, id: UUID(), selection: lastTry.row[index].pinColor))
                }
            }
            else {
                for _ in 0..<numberOfPins {
                    newRow.append(CodePin.random(numberOfColors: numberOfColors, id: UUID()))
                }
            }
            return CodeField(id: UUID(), row: newRow)
        }
        static func emptyCodeField(numberOfPins: Int) -> CodeField {
            var newRow = [CodePin]()
            for _ in 0..<numberOfPins {
                newRow.append(CodePin(pinColor: .empty, id: UUID(), selection: .empty))
            }
            return CodeField(id: UUID(), row: newRow)
        }
    }
    
    struct SignalPin: Identifiable, Hashable {
        let pinColor: SignalColors
        let id: Int
    }
    
    struct SignalField: Identifiable {
        var id: UUID
        let row: [CodePin]
    }
    
    mutating func checkTry() {
        var rightColor = 0
        var rightPlace = 0
        
        if !selectionComplete() {
            takeOverNextTry()
            return
        }
        
        nextTry.id = UUID()
        tryFields.append(nextTry)
        
        for index in 0..<numberOfColors {
            let nextColor = nextTry.row.filter({$0.pinColor == PinColor(rawValue: index)}).count
            let codeColor = codeField.row.filter({$0.pinColor == PinColor(rawValue: index)}).count
            rightColor += min(nextColor, codeColor)
        }
                        
        for index in 0..<nextTry.row.count {
            if codeField.row[index].pinColor == nextTry.row[index].pinColor {
                rightPlace += 1
                rightColor -= 1
            }
        }
        var signalPins = [SignalPin]()
        for index in 0..<rightPlace {
            signalPins.append(SignalPin(pinColor: .black, id: index))
        }
        for index in 0..<rightColor {
            signalPins.append(SignalPin(pinColor: .white, id: index))
        }
        for index in (rightPlace + rightColor)..<numberOfPins {
            signalPins.append(SignalPin(pinColor: .empty, id: index))
        }

        signalFields.append(signalPins)
        nextTry = CodeField.emptyCodeField(numberOfPins: numberOfPins)
        for codePin in self.nextTry.row {
            pickers[codePin] = false
        }
        pickerVisible = false

        if rightPlace == numberOfPins {
            won = true
        }
        else {
            won = false
        }
    }
    
    func selectionComplete()->Bool {
        var selectionComplete = true
        for codePin in nextTry.row {
            if codePin.pinColor == .empty {
                selectionComplete = false
                break
            }
        }
        return selectionComplete
    }
    
    mutating private func takeOverNextTry() {
        if let lastTry = tryFields.last {
            var newRow = [CodePin]()
            for (index, pin) in nextTry.row.enumerated() {
                if pin.pinColor == .empty {
                    newRow.append(CodePin(pinColor: lastTry.row[index].pinColor, id: UUID(), selection: lastTry.row[index].pinColor))
                }
                else {
                    newRow.append(CodePin(pinColor: pin.pinColor, id: UUID(), selection: pin.pinColor))
                }
            }
            nextTry.row = newRow
            for codePin in self.nextTry.row {
                pickers[codePin] = false
            }
            pickerVisible = false
        }

    }
    
    mutating func hidePickers() {
        pickers.forEach { (key: CodePin, value: Bool) in
            pickers.updateValue(false, forKey: key)
        }
        pickerVisible = false
    }
}
