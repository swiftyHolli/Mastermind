//
//  GameView.swift
//  Mastermind
//
//  Created by Holger Becker on 22.08.23.
//

import SwiftUI

struct GameView: View {
    @AppStorage("Background") private var myBackground: SettingsViewModel.Background = .background1
    @AppStorage("NumberOfPins") private var numberOfPins: Int = 4
    @AppStorage("NumberOfColors") private var numberOfColors: Int = 4

    @EnvironmentObject var vm: MastermindViewModel
    @State var showingSettings = false
    @State var showingStatistics = false
    
    let gradient = LinearGradient(colors: [Color.orange,
                                           Color.green],
                                  startPoint: .top,
                                  endPoint: .bottom)
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack() {
                        ZStack {
                            HStack {
                                ForEach($vm.model.codeField.row) {$pin in
                                    GeometryReader {geometry in
                                        if !vm.model.won {
                                            ZStack {
                                                CodePin(color: .constant(.empty))
                                                CodePin(color: $pin.pinColor)
                                            }
                                        }
                                        else {
                                            ZStack {
                                                CodePin(color: .constant(.empty))
                                                Text("?")
                                                    .foregroundColor(.black)
                                                    .font(.title)
                                                    .fontWeight(.semibold)
                                                    .position(x: geometry.size.width / 2 - 5, y: geometry.size.height / 2)
                                            }
                                        }
                                    }
                                }
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
                                    ZStack{
                                        if pin.pinColor != .empty {
                                            CodePin(color: .constant(MastermindModel.PinColor.empty))
                                        }
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
                    ToolbarItem(placement: .navigationBarLeading) {
                        statisticsButton
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        settingsButton
                    }
                }
            }.background {
                Image("\(myBackground)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
            .preferredColorScheme(.dark)
        }
    }
    
    var checkButton: some View {
        Button {
            withAnimation {
                if vm.model.won {
                    vm.model.newGame()
                }
                else {
                    if vm.model.selectionComplete() {
                        if vm.model.startDate == nil {
                            vm.model.startDate = Date()
                        }
                    }
                    vm.checkTry()
                    vm.hidePickers()
                    if vm.model.won {
                        showingStatistics.toggle()
                        vm.model.statisticsPinNumber = vm.model.numberOfPins
                        vm.model.statisticsColorNumber = vm.model.statisticsColorNumber
                        vm.model.statisticsDataModel.addGameResult(numberOfPins: Int16(vm.model.numberOfPins),
                                                          numberOfColors: Int16(vm.model.numberOfColors),
                                                          numberOfTries: Int16(vm.model.tryFields.count),
                                                          startDate: vm.model.startDate ?? Date())
                    }
                }
            }
        } label: {
            VStack {
                Image(systemName: "checkmark")
                if vm.model.won {
                    Text("New")
                }
                else {
                    if vm.model.selectionComplete() {
                        Text("Check")
                    }
                    else {
                        Text("Fill")
                    }
                }
            }.padding()
        }
        .disabled((vm.model.tryFields.isEmpty && !vm.model.selectionComplete()))
        .sheet(isPresented: $showingStatistics) {
            StatisticsView()
                .presentationDetents([.medium])
                .presentationBackground(.thinMaterial)
        }
    }
    
    var settingsButton: some View {
        Button {
            showingSettings.toggle()
        } label: {
            Image(systemName: "gear")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
    
    var statisticsButton: some View {
        Button {
            showingStatistics.toggle()
        } label: {
            Image(systemName: "chart.bar.xaxis")
                .font(.title2)
                .fontWeight(.semibold)
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
                    .padding(.vertical, 5.0)
                }
                Rectangle()
                    .stroke(lineWidth: 0)
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)
                    .id("Hallo")
            }
            .padding(.vertical, 5.0)
            .opacity(vm.model.pickerVisible ? 0.5 : 1)
            
            //.scrollContentBackground(.hidden)
            .onChange(of: vm.model.tryFields.last?.id) { id in
                withAnimation {
                    scrollReader.scrollTo("Hallo", anchor: .bottom)

                //scrollReader.scrollTo(vm.model.tryFields.last?.id, anchor: .bottom)
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

