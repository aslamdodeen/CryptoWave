//
//  PortfolioDataService.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 21/12/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntites: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading CoreData! \(error)")
            }
            self.getDataPortfolio()
        }
    }
    
    func updatePortfolio(coin:Coin, amount: Double) {
        
        // check if coin is already in portfolio
        if let entity = savedEntites.first(where: {$0.coinID == coin.id }) {
            
            if amount > 0 {
                update(entitiy: entity, amount: amount)
            } else {
                delete(entity:entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
        
    }
    
    // MARK: PRIVATE
    
    private func getDataPortfolio() {
        let requst = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntites =  try container.viewContext.fetch(requst)
        } catch let err {
            print("Error fetching Portfolio Entities \(err.localizedDescription)")
        }
    }
    
    private func add(coin: Coin,amount:Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entitiy:PortfolioEntity,amount: Double) {
        entitiy.amount = amount
        applyChanges()
    }
    
    private func delete(entity:PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    func applyChanges() {
        save()
        getDataPortfolio()
    }
}
