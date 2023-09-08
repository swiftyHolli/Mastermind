//
//  StatisticsDataModel.swift
//  Mastermind
//
//  Created by Holger Becker on 08.09.23.
//

import Foundation
import CoreData

class StatisticDataModel: ObservableObject {
            
    let container: NSPersistentContainer
    @Published var savedGames: [GameResult] = []
    @Published var statistics: [Int] = []
    @Published var totalNumberOfGames = 1
    @Published var maxGamesNumber = 0
    
    @Published var numberOfPins = 4
    @Published var numberOfColors = 4

    
    init() {
        container = NSPersistentContainer(name: "StatisticsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data \(error)")
                return
            }
            else {
                print("Successfully loaded CoreDate")
            }
        }
    }
    
    func fetchGameResults() {
        var newStatistics:[Int] = []
        for index in 1..<10 {
            let request = NSFetchRequest<GameResult>(entityName: "GameResult")
            let predicate = NSPredicate(format: "numberOfTries == %@ && numberOfPins == %@ && numberOfColors == %@", argumentArray: ["\(index)", "\(numberOfPins)","\(numberOfColors)"])
            request.predicate = predicate
            do {
                savedGames = try container.viewContext.fetch(request)
            } catch let error {
                print("Error fetching. \(error)")
            }
            newStatistics.append(savedGames.count)
        }
        statistics = newStatistics
        newStatistics.sort(by: {$0 > $1})
        maxGamesNumber = newStatistics.first ?? 1
        
        print(statistics)
        
        let request = NSFetchRequest<GameResult>(entityName: "GameResult")
        let predicate = NSPredicate(format: "numberOfPins == %@ && numberOfColors == %@", "\(numberOfPins)", "\(numberOfColors)")
        
        request.predicate = predicate
        do {
            savedGames = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        totalNumberOfGames = savedGames.count
        print("Number of games: \(totalNumberOfGames), max tries number: \(maxGamesNumber)")
    }
    
    func addGameResult(numberOfPins: Int16, numberOfColors: Int16, numberOfTries: Int16, startDate: Date) {
        let duration = Date().timeIntervalSince(startDate)
        let newGameResult = GameResult(context: container.viewContext)
        newGameResult.numberOfPins = numberOfPins
        newGameResult.numberOfColors = numberOfColors
        newGameResult.numberOfTries = numberOfTries
        newGameResult.gameTime = duration
        saveData()
    }
    
    func clearStatistics() {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameResult")
        let predicate = NSPredicate(format: "numberOfPins == %@ && numberOfColors == %@", "\(numberOfPins)", "\(numberOfColors)")
        fetchRequest.predicate = predicate

        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try container.viewContext.execute(batchDeleteRequest)

        } catch {
            // Error Handling
        }
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
}
