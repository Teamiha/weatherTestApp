//
//  CashManager.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 15.04.2023.
//

import UIKit
import CoreData


//MARK: - Protocol

protocol CacheManagerProtocol {
    func cacheSave(tempData: TemperatureData, cityName: String)
    func cacheLoad(cityName: String, completion: (Result<String, Error>) -> Void )
    var errorData: TemperatureData { get set }
    
}


//MARK: - Class

class CacheManager: CacheManagerProtocol {
    
    //MARK: - Core
    
    var errorData = TemperatureData(main: Main(temp: 0))
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TemperatureDataCache")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    let viewContext: NSManagedObjectContext

    init() {
        viewContext = persistentContainer.viewContext
    }
    
    
    //MARK: - Method
    
    func cacheSave(tempData: TemperatureData, cityName: String) {
        let fetchRequest = TemperatureDataCache.fetchRequest()
        let loadCache = try? self.viewContext.fetch(fetchRequest)
        let oldData = loadCache!.filter {$0.cityName == cityName}
        
        if oldData != [] {
            let deleteData = oldData[0] as NSManagedObject
            viewContext.delete(deleteData)
            
            let temperatureDataCache = TemperatureDataCache(context: viewContext)
            temperatureDataCache.temperatureData = String(tempData.main.temp)
            temperatureDataCache.cityName = cityName
            
            saveContext()
            
        } else {
            let temperatureDataCache = TemperatureDataCache(context: viewContext)
            temperatureDataCache.temperatureData = String(tempData.main.temp)
            temperatureDataCache.cityName = cityName

            saveContext()
        }
    }
    
    func cacheLoad(cityName: String, completion: (Result<String, Error>) -> Void ) {
        let fetchRequest = TemperatureDataCache.fetchRequest()
        do {
            var temperatureDataCache = try self.viewContext.fetch(fetchRequest)
            temperatureDataCache = temperatureDataCache.filter {$0.cityName == cityName}
            
            if temperatureDataCache != [] {
                let tempData = temperatureDataCache[0].temperatureData ?? "Data Error"
                completion(.success(tempData))
                
            } else {
                let errorData = "No Cache Data Available"
                completion(.success(errorData))
            }
           
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
