//
//  PinPickerView.swift
//  Mastermind
//
//  Created by Holger Becker on 29.08.23.
//

import SwiftUI


struct PinPickerView: View {
    @EnvironmentObject var vm: MastermindViewModel
    @Binding var parent: MastermindModel.CodePin
    
    var backgroundColor = Color(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.05266970199))

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8) {
                ForEach (0..<vm.model.numberOfColors, id: \.self) {index in
                    CodePin(color: .constant(MastermindModel.PinColor(rawValue: index) ?? .red))
                        .onTapGesture {
                            withAnimation() {
                                parent.pinColor = MastermindModel.PinColor(rawValue: index) ?? .red
                                vm.model.pickers.updateValue(false, forKey: parent)
                                vm.model.pickerVisible = false
                            }
                        }
                }
            }
            .listRowBackground(Color.clear)
            .background() {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black.opacity(0.3))
                    .frame(width: geometry.size.width + 15, height: geometry.size.height + 10)
                    //.background(.thinMaterial)
                    //.offset(x:-3)
            }
        }
    }
}

struct PinPickerView_Previews: PreviewProvider {
    @EnvironmentObject var vm: MastermindViewModel
    static var previews: some View {
        PinPickerView(parent: .constant(MastermindModel.CodePin(pinColor: .red, id: UUID(), selection: .red)))
            .environmentObject(MastermindViewModel())
            .frame(width: 50, height: 50 * 4)
    }
}
