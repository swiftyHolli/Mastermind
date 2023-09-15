//
//  SettingsView.swift
//  Mastermind
//
//  Created by Holger Becker on 27.08.23.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var level: Int = 0
    @Published var colors : Int = 0
    @Published var myBackground: Background = .background1
    
    @AppStorage("NumberOfPins") var numberOfPins: Int = 4
    @AppStorage("NumberOfColors") var numberOfColors: Int = 4
    @AppStorage("Background") var background: Background = .background1


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
        level = self.numberOfPins - 4
        colors = self.numberOfColors
        myBackground = self.background
    }
    
    func settingsDone() {
        numberOfPins = level + 4
        numberOfColors = colors
        background = myBackground
    }

}

struct SettingsView: View {
    @EnvironmentObject var vm: MastermindViewModel
    @Environment(\.dismiss) var dismiss
    
    @StateObject var settingsModel = SettingsViewModel()
                
    @State var colors: Int = 4
    
    var lightgreen = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)

    var body: some View {
        NavigationStack {
            Form {
                Section(){
                    Text("Background Image")
                        .fontWeight(.semibold)
                        .listRowSeparator(.hidden)
                    ScrollView(.horizontal){
                        ScrollViewReader { proxy in
                            HStack(alignment: .center){
                                ForEach(SettingsViewModel.Background.allCases) {background in
                                    Image("\(background)")
                                        .resizable()
                                        //.frame(width: 100)
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFill()
                                        .frame(maxHeight: 200)
                                        .overlay(alignment: .topTrailing) {
                                            if background == settingsModel.myBackground {
                                                Image(systemName: "checkmark.circle")
                                                    //.resizable()
                                                    //.aspectRatio(contentMode: .fit)
                                                    .font(.largeTitle)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.green)
                                            }
                                        }
                                        .onTapGesture {
                                            withAnimation {
                                                settingsModel.myBackground = background
                                                proxy.scrollTo(settingsModel.myBackground, anchor: .center)
                                            }
                                        }
                                        .onAppear {
                                            proxy.scrollTo(settingsModel.myBackground, anchor: .center)
                                        }
                                }
                            }

                        }
                    }
                }
                Section {
                    Text("Number of Pins")
                        .fontWeight(.semibold)
                        .listRowSeparator(.hidden)
                    Picker(selection: $settingsModel.level) {
                        ForEach(0..<3) {level in
                            Text("\(level + 4)")
                        }
                    } label: {
                        HStack(alignment: .center) {
                            ForEach (0..<settingsModel.level + 4, id: \.self) {id in
                                CodePin(color: .constant(.empty), withQuestionMark: false)
                                    .frame(maxWidth: 30)
                            }
                            Spacer()
                        }
                    }
                }

                Section {
                    Text("Colors")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .listRowSeparator(.hidden)
                    HStack(alignment:.center ,spacing: 15){
                        fourColorsButton
                        sixColorsButton
                        eightColorsButton
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        settingsModel.settingsDone()
                        vm.newGame()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        vm.model.statisticsDataModel.clearStatistics()
                    } label: {
                        Text("Reset")
                    }
                }
            }
            .navigationTitle("Settings")
        }

    }
    
    var fourColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                settingsModel.colors = 4
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(settingsModel.colors == 4 ? Color(lightgreen) : Color.secondary)
                    .padding(.top, 7.0)
                    .padding(.horizontal)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                Text("4 Colors")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(alignment: .center, spacing: -15) {
                    CodePin(color: .constant(.red), withQuestionMark: false)
                    CodePin(color: .constant(.yellow), withQuestionMark: false)
                    CodePin(color: .constant(.green), withQuestionMark: false)
                    CodePin(color: .constant(.blue), withQuestionMark: false)
                }.frame(width: 70, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(settingsModel.colors != 4 ? .secondary : .primary)
        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: settingsModel.colors != 4 ? 10 : 5, x: settingsModel.colors != 4 ? 10 : 2, y: settingsModel.colors != 4 ? 10 : 2)
        .buttonStyle(.plain)
    }
    
    var sixColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                settingsModel.colors = 6
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(settingsModel.colors == 6 ? Color(lightgreen) : Color.secondary)
                    .padding(.top, 7.0)
                    .padding(.horizontal)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                Text("6 Colors")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(alignment: .center, spacing: -15) {
                    CodePin(color: .constant(.red), withQuestionMark: false)
                    CodePin(color: .constant(.yellow), withQuestionMark: false)
                    CodePin(color: .constant(.green), withQuestionMark: false)
                    CodePin(color: .constant(.blue), withQuestionMark: false)
                    CodePin(color: .constant(.orange), withQuestionMark: false)
                    CodePin(color: .constant(.brown), withQuestionMark: false)
                }.frame(width: 70, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(settingsModel.colors == 6 ? Color.primary : Color.secondary)

        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: settingsModel.colors != 6 ? 10 : 5, x: settingsModel.colors != 6 ? 10 : 2, y: settingsModel.colors != 6 ? 10 : 2)
        .buttonStyle(.plain)
    }
    var eightColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                settingsModel.colors = 8
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(settingsModel.colors == 8 ? Color(lightgreen) : Color.secondary)
                    .padding(.top, 7)
                    .padding(.horizontal)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                Text("8 Colors")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack(alignment: .center, spacing: -15) {
                    CodePin(color: .constant(.red), withQuestionMark: false)
                    CodePin(color: .constant(.yellow), withQuestionMark: false)
                    CodePin(color: .constant(.green), withQuestionMark: false)
                    CodePin(color: .constant(.blue), withQuestionMark: false)
                    CodePin(color: .constant(.orange), withQuestionMark: false)
                    CodePin(color: .constant(.brown), withQuestionMark: false)
                    CodePin(color: .constant(.purple), withQuestionMark: false)
                    CodePin(color: .constant(.pink), withQuestionMark: false)
                }.frame(width: 70, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(settingsModel.colors != 8 ? .secondary : .primary)
        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: settingsModel.colors != 8 ? 10 : 5, x: settingsModel.colors != 8 ? 10 : 2, y: settingsModel.colors != 8 ? 10 : 2)
        .buttonStyle(.plain)
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
                    CodePin(color: .constant(.red), withQuestionMark: false)
                    CodePin(color: .constant(.blue), withQuestionMark: false)
                    CodePin(color: .constant(.blue), withQuestionMark: false)
                    CodePin(color: .constant(.red), withQuestionMark: false)
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
        .buttonStyle(.plain)
        }
    }


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(MastermindViewModel())
        
    }
}
