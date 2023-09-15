//
//  StatisticsSelectionView.swift
//  Mastermind
//
//  Created by Holger Becker on 08.09.23.
//

import SwiftUI

//
//  SettingsView.swift
//  Mastermind
//
//  Created by Holger Becker on 27.08.23.
//

import SwiftUI

struct StatisticsSelectionView: View {
    @EnvironmentObject var vm: MastermindViewModel
    @Environment(\.dismiss) var dismiss
        
    @State var myNumberOfPins = 4
    @State var myNumberOfColors = 4
    @State var level = 0

    var lightgreen = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Number of Pins")
                        .fontWeight(.semibold)
                        .listRowSeparator(.hidden)
                    Picker(selection: $level) {
                        ForEach(0..<3) {level in
                            Text("\(level + 4)")
                        }
                    } label: {
                        HStack(alignment: .center) {
                            ForEach (0..<level + 4, id: \.self) {id in
                                CodePin(color: .constant(.empty))
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
            .toolbar(content: {
                Button {
                    myNumberOfPins = level + 4
                    vm.model.statisticsPinNumber = myNumberOfPins
                    vm.model.statisticsColorNumber = myNumberOfColors
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            })
            .navigationTitle("Settings")
        }
        
    }
    
    var fourColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                myNumberOfColors = 4
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(myNumberOfColors == 4 ? Color(lightgreen) : Color.secondary)
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
                }.frame(width: 70, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(myNumberOfColors != 4 ? .secondary : .primary)
        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: myNumberOfColors != 4 ? 10 : 5, x: myNumberOfColors != 4 ? 10 : 2, y: myNumberOfColors != 4 ? 10 : 2)
        .buttonStyle(.plain)
    }
    
    var sixColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                myNumberOfColors = 6
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(myNumberOfColors == 6 ? Color(lightgreen) : Color.secondary)
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
                }.frame(width: 70, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(myNumberOfColors == 6 ? Color.primary : Color.secondary)
            
        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: myNumberOfColors != 6 ? 10 : 5, x: myNumberOfColors != 6 ? 10 : 2, y: myNumberOfColors != 6 ? 10 : 2)
        .buttonStyle(.plain)
    }
    var eightColorsButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.8)) {
                myNumberOfColors = 8
            }
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(myNumberOfColors == 8 ? Color(lightgreen) : Color.secondary)
                    .padding(.top, 7)
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
                }.frame(width: 70, height: 30, alignment: .center)
                    .padding([.leading, .bottom, .trailing])
            }
            .foregroundColor(myNumberOfColors != 8 ? .secondary : .primary)
        }
        .fixedSize()
        .background(
            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black, radius: myNumberOfColors != 8 ? 10 : 5, x: myNumberOfColors != 8 ? 10 : 2, y: myNumberOfColors != 8 ? 10 : 2)
        .buttonStyle(.plain)
    }
}
    
struct StatisticsSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSelectionView()
            .environmentObject(MastermindViewModel())
        
    }
}
