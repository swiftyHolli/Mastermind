//
//  GameView.swift
//  Mastermind
//
//  Created by Holger Becker on 22.08.23.
//

import SwiftUI

struct GameView: View {
    @AppStorage("Level") private var level: SettingsViewModel.Level = .Beginner
    @AppStorage("Background") private var myBackground: SettingsViewModel.Background = .background1

    @EnvironmentObject var vm: MastermindViewModel
    @State var showingSettings = false
    
    
    
    let gradient = LinearGradient(colors: [Color.orange,
                                           Color.green],
                                  startPoint: .top,
                                  endPoint: .bottom)
    var body: some View {
        NavigationStack {
            ZStack {
//                gradient
//                    .opacity(0.25)
//                    .ignoresSafeArea()
                
                VStack {
                    HStack() {
                        ZStack {
                            HStack {
                                ForEach($vm.model.codeField.row) {$pin in
                                    CodePin(color: $pin.pinColor)
                                }
                            }
                            if vm.model.won {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.brown)
                            }
                        }
                        
                        Divider()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(lineWidth: 2, antialiased: true)
                            Text("\(vm.model.tryFields.count)")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .frame(minWidth: 70)
                        }
                        .frame(maxWidth: 70)
                    }
                    .frame(maxHeight: 50)
                    
                    .padding(.horizontal)
                    .padding(.bottom, 5.0)
                    tryList
                    Spacer()
                    HStack {
                        HStack {
                            ForEach($vm.model.nextTry.row) {$pin in
                                GeometryReader { geometry in
                                    CodePin(color: $pin.pinColor)
                                        .onTapGesture {
                                            withAnimation {
                                                if !vm.model.pickerVisible {
                                                    if vm.model.pickers[pin] == false {
                                                        vm.model.pickers[pin] = true
                                                        vm.model.pickerVisible = true
                                                    }
                                                    else {
                                                        vm.model.pickers[pin] = false
                                                        vm.model.pickerVisible = false
                                                    }
                                                }
                                            }
                                        }
                                    if vm.model.pickers[pin] == true {
                                        let width = geometry.size.width
                                        let height = geometry.size.height
                                        
                                        PinPickerView(parent: $pin)
                                            .offset(y: (-(min(width, height)) - 8) * CGFloat(vm.model.numberOfColors) - 10)
                                            .frame(width: width, height: (min(width, height) + 8) * CGFloat(vm.model.numberOfColors))
                                    }
                                }
                            }
                        }
                        Divider()
                        checkButton
                            .fixedSize()
                            .frame(width: 70)
                            .background(Rectangle().stroke(lineWidth: 1))
                    }
                    .frame(maxHeight: 50)
                    .padding([.leading, .bottom, .trailing])
                }
                .frame(maxWidth: 600)
                .navigationTitle("Mastermind")
                .toolbar {
                    settingsButton
                }
            }.background {
                Image("\(myBackground)")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
            }
            .preferredColorScheme(.dark)
        }
    }
    
    var checkButton: some View {
        Button {
            withAnimation {
                vm.checkTry()
                vm.hidePickers()
            }
        } label: {
            VStack {
                Image(systemName: "checkmark")
                if vm.model.selectionComplete() {
                    Text("Check")
                }
                else {
                    Text("Fill")
                }
            }.padding()
        }.disabled(vm.model.tryFields.isEmpty && !vm.model.selectionComplete())
    }
    
    var settingsButton: some View {
        Button {
            showingSettings.toggle()
        } label: {
            Image(systemName: "gear")
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
    
    var tryList: some View {
        ScrollViewReader { scrollReader in
            ScrollView {
                ForEach(Array(vm.model.tryFields.enumerated()), id: \.1) { index, field in
                    HStack(alignment: .center) {
                        ForEach($vm.model.tryFields[index].row) { pin in
                            CodePin(color: pin.pinColor)
                        }
                        Divider()
                        if vm.model.numberOfPins > 4 {
                            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                                ForEach(vm.model.signalFields[index], id: \.self) {pin in
                                    SignalPin(pin: pin)
                                }
                            }
                            .aspectRatio(vm.model.numberOfPins > 4 ? 3 / 2 : 1 , contentMode: .fill)
                            .frame(minWidth: 70)
                            .frame(maxHeight: 50)
                        }
                        else {
                            LazyVGrid(columns: [GridItem(), GridItem()]) {
                                ForEach(vm.model.signalFields[index], id: \.self) {pin in
                                    SignalPin(pin: pin)
                                }
                            }
                            .aspectRatio(vm.model.numberOfPins > 4 ? 3 / 2 : 1 , contentMode: .fill)
                            .frame(minWidth: 70)
                            .frame(maxHeight: 50)
                            .fixedSize()
                        }
                    }
                    .frame(height: 50)
                    .id(field.id)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical, 5.0)
            .opacity(vm.model.pickerVisible ? 0.5 : 1)
            
            //.scrollContentBackground(.hidden)
            .onChange(of: vm.model.tryFields.last?.id) { id in
                withAnimation {
                scrollReader.scrollTo(vm.model.tryFields.last?.id, anchor: .bottom)
                }
            }
            .listStyle(.automatic)
        }
    }
}

struct SignalPin: View {
    let pin: MastermindModel.SignalPin
    let radius = 20.0
    
    var body: some View {
        switch pin.pinColor {
        case .black:
            Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 0.1999999881, green: 0.1999999881, blue: 0.1999999881, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))], center: .topLeading, startRadius: -radius * 0.5, endRadius: radius * 2.5))
                .frame(width: radius, height: radius)
        case .white:
            Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))], center: .topLeading, startRadius: -radius * 0.5, endRadius: radius * 2.5))
                .frame(width: radius, height: radius)
        case .empty:
            Circle().strokeBorder(lineWidth: 1, antialiased: true)
                .frame(width: radius, height: radius)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            GameView()
        .environmentObject(MastermindViewModel())
        .navigationTitle("Mastermind")
    }
}

