//
//  SettingsView.swift
//  Mastermind
//
//  Created by Holger Becker on 27.08.23.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var level: Level
    @Published var myBackground: Background

    enum Level: String, CaseIterable, Identifiable, Hashable {
        var id: Self {
            return self
        }
        case Beginner = "Beginner 🔰"
        case Professional = "Professional"
        case Master = "Master 👩‍🎓"
    }
    enum Background: String, CaseIterable, Identifiable, Hashable {
        var id: Self {
            return self
        }
        case background1 = "background1"
        case background2 = "background2"
        case background3 = "background3"
        case background4 = "background4"
        case background5 = "background5"
        case background6 = "background6"
        case background7 = "background7"
    }

    init() {
        self.level = Level.Beginner
        self.myBackground = Background.background1
    }

}

struct SettingsView: View {
    @EnvironmentObject var vm: MastermindViewModel
    
    @Environment(\.dismiss) var dismiss
    @AppStorage("Level") private var level: SettingsViewModel.Level = .Beginner
    @AppStorage("Background") private var myBackground: SettingsViewModel.Background = .background1
    var lightgreen = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)

    var body: some View {
        NavigationStack {
            Picker("Background", selection: $myBackground) {
                ForEach(SettingsViewModel.Background.allCases) {background in
                    Text(background.rawValue)
                }
            }
            Picker("Level", selection: $level) {
                ForEach(SettingsViewModel.Level.allCases) {level in
                    Text(level.rawValue)
                }
            }.pickerStyle(.automatic)
            VStack(spacing: 30) {
                HStack(spacing: 30){
                    fourColorsButton
                    sixColorsButton
                }
                HStack(spacing: 30) {
                    eightColorsButton
                    repeatColorsButton
                }
            }
            Button("Done") {
                switch level {
                case .Beginner:
                    vm.model.newGame(level: 0)
                case .Professional:
                    vm.model.newGame(level: 1)
                case .Master:
                    vm.model.newGame(level: 2)
                }
                dismiss()
            }
            .navigationTitle("Settings")
        }
    }
    
    var fourColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                vm.model.numberOfColors = 4
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(vm.model.numberOfColors == 4 ? Color(lightgreen) : Color.secondary)
                    .padding(.top, 7.0)
                    .padding(.horizontal)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                Text("4 Colors")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(alignment: .center, spacing: -15) {
                    CodePin(color: .constant(.red))
                    CodePin(color: .constant(.yellow))
                    CodePin(color: .constant(.green))
                    CodePin(color: .constant(.blue))
                }.frame(width: 100, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(vm.model.numberOfColors != 4 ? .secondary : .primary)
        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: vm.model.numberOfColors != 4 ? 10 : 5, x: vm.model.numberOfColors != 4 ? 10 : 2, y: vm.model.numberOfColors != 4 ? 10 : 2)
    }
    var sixColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                vm.model.numberOfColors = 6
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(vm.model.numberOfColors == 6 ? Color(lightgreen) : Color.secondary)
                    .padding(.top, 7.0)
                    .padding(.horizontal)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                Text("6 Colors")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(alignment: .center, spacing: -15) {
                    CodePin(color: .constant(.red))
                    CodePin(color: .constant(.yellow))
                    CodePin(color: .constant(.green))
                    CodePin(color: .constant(.blue))
                    CodePin(color: .constant(.orange))
                    CodePin(color: .constant(.brown))
                }.frame(width: 100, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(vm.model.numberOfColors == 6 ? Color.primary : Color.secondary)

        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: vm.model.numberOfColors != 6 ? 10 : 5, x: vm.model.numberOfColors != 6 ? 10 : 2, y: vm.model.numberOfColors != 6 ? 10 : 2)
    }
    var eightColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                vm.model.numberOfColors = 8
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(vm.model.numberOfColors == 8 ? Color(lightgreen) : Color.secondary)
                    .padding(.top, 7.0)
                    .padding(.horizontal)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                Text("8 Colors")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(alignment: .center, spacing: -15) {
                    CodePin(color: .constant(.red)
                    )
                    CodePin(color: .constant(.yellow))
                    CodePin(color: .constant(.green))
                    CodePin(color: .constant(.blue))
                    CodePin(color: .constant(.orange))
                    CodePin(color: .constant(.brown))
                    CodePin(color: .constant(.purple))
                    CodePin(color: .constant(.pink))
                }.frame(width: 100, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(vm.model.numberOfColors != 8 ? .secondary : .primary)
        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: vm.model.numberOfColors != 8 ? 10 : 5, x: vm.model.numberOfColors != 8 ? 10 : 2, y: vm.model.numberOfColors != 8 ? 10 : 2)
    }
    
    var repeatColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                vm.model.repeatedColors.toggle()
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(!vm.model.repeatedColors ? Color(lightgreen) : Color.secondary)
                    .padding(.top, 7.0)
                    .padding(.horizontal)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                Text("Repeat")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(alignment: .center, spacing: -15) {
                    CodePin(color: .constant(.red))
                    CodePin(color: .constant(.blue))
                    CodePin(color: .constant(.blue))
                    CodePin(color: .constant(.red))
                }.frame(width: 100, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(vm.model.repeatedColors ? .secondary : .primary)
        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: vm.model.repeatedColors ? 10 : 5, x: vm.model.repeatedColors ? 10 : 2, y: vm.model.repeatedColors ? 10 : 2)
        }
    }


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()        .environmentObject(MastermindViewModel())
        
    }
}
