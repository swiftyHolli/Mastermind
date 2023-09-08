//
//  StatisticsView.swift
//  Mastermind
//
//  Created by Holger Becker on 07.09.23.
//

import SwiftUI
import CoreData


struct StatisticsView: View {
    
    @EnvironmentObject var vm: MastermindViewModel
    @StateObject var statisticsViewModel = StatisticDataModel()
    var color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    
    var body: some View {
        VStack() {
            HStack {
                ResultField(name: "Games", value: statisticsViewModel.totalNumberOfGames)
                Spacer()
                ResultField(name: "Won", value: statisticsViewModel.totalNumberOfGames)
                Spacer()
                ResultField(name: "Lost", value: statisticsViewModel.totalNumberOfGames)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            VStack {
                Text("Number of Tries (%)")
                    .font(.headline)
                HStack {
                    ForEach(0..<statisticsViewModel.statistics.count, id: \.self) {index in
                        let percentValue = Float(statisticsViewModel.statistics[index]) / Float(statisticsViewModel.totalNumberOfGames == 0 ? 1 : statisticsViewModel.totalNumberOfGames)
                        let percentValueString = String(format: "%.0f", percentValue * 100)
                        let drawPercentValue = Float(statisticsViewModel.statistics[index]) / Float(statisticsViewModel.maxGamesNumber == 0 ? 1 : statisticsViewModel.maxGamesNumber)

                        GeometryReader { geometry in

                            VStack {
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.yellow)
                                Spacer()
                                
                                Text("\(percentValueString)")
                                    .font(.body)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Rectangle()
                                    .fill(Color.red)
                                    .frame(height: geometry.size.height * 0.7 * max(CGFloat(drawPercentValue) , 0.01))
                            }
                        }
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .shadow(color: .black, radius: 10, x: 10, y: 10)
            }
            .shadow(radius: 5)

        }
        .padding(.horizontal)
//        .foregroundStyle(.ultraThinMaterial)
//        .background (
//            Material.ultraThinMaterial
//            LinearGradient(colors: [Color(#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
//        )
        .onAppear {
            statisticsViewModel.numberOfPins = vm.model.statisticsPinNumber
            statisticsViewModel.numberOfColors = vm.model.statisticsColorNumber
            statisticsViewModel.fetchGameResults()
        }
    }
    
    struct ResultField: View {
        var name: String
        var value: Int
        var body: some View {
            VStack {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.bottom, 0.0)
                Text("\(value)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 80)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: .black, radius: 10, x: 10, y: 10)
                    }
                    .padding(.bottom, 8)
                    

            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(
                LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black, radius: 10, x: 10, y: 10)
        }
    }
}



struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
//        Text("Background").sheet(isPresented: .constant(true)) {
//            StatisticsView()
//                .presentationDetents([.medium, .large])
//                .environmentObject(MastermindViewModel())
//        }
                StatisticsView()
                    .environmentObject(MastermindViewModel())
    }
}
