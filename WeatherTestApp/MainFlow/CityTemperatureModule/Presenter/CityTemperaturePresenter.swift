//
//  CityTemperaturePresenter.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import Foundation

protocol CityTemperatureViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol CityTemperaturePresenterProtocol: AnyObject {
    init(view: CityTemperatureViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol, cacheManager: CacheManagerProtocol, cityName: String?, isDataLoadError: Bool? )
    var temperatureData: TemperatureData? { get set }
    var cityName: String? { get set }
    func getTemperatureChosenCity(cityName: String?)
    var isDataLoadError: Bool? { get set }
}

class CityTemperaturePresenter: CityTemperaturePresenterProtocol {
    weak var view: CityTemperatureViewProtocol?
    var router: RouterProtocol?
    let networkManager: NetworkManagerProtocol!
    let cacheManager: CacheManagerProtocol!
    var temperatureData: TemperatureData?
    var cityName: String?
    var isDataLoadError: Bool?
    
    required init(view: CityTemperatureViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol, cacheManager: CacheManagerProtocol, cityName: String?, isDataLoadError: Bool?) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        self.cacheManager = cacheManager
        self.cityName = cityName
        self.isDataLoadError = isDataLoadError
        getTemperatureChosenCity(cityName: cityName)
    }
    
    func getTemperatureChosenCity(cityName: String?) {
        // MAIKE ERROR CITY
        print("!!!!")
        print(cityName)
        print("!!!!")
//        if let cacheData = TemperatureDataCache.shared.object(forKey: cityName as AnyObject) {
//
//            DispatchQueue.main.async {
//                self.temperatureData = cacheData as? TemperatureData
//                self.view?.succes()
//            }
//
//                    print("Data from cache: ", cacheData)
//            self.temperatureData = cacheData as? TemperatureData
//
//            print(temperatureData?.main.temp)
//                    return
//                }
        
        networkManager.getTemperatureData(city: cityName ?? "Moscow") { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case.success(let temp):
                    self.isDataLoadError = false
                    self.temperatureData = temp
                    self.view?.succes()
                    self.cacheManager.cacheSave(tempData: temp ?? self.cacheManager.errorData, cityName: cityName ?? "Moscow")
                    print("Start Load Data")
                    self.cacheManager.cacheLoad(cityName: cityName ?? "Moscow") { [weak self] result in
                        
                        DispatchQueue.main.async {
                            switch result {
                                
                            case .success(let tempData):
                                print("Load From Cache Yaaa!!", tempData)
                            case .failure(let error):
                                print("Error For Load Cache")
                            }
                        }
                    }
                    
                case.failure(let error):
//                    self.view?.failure(error: error)
                    print("Network Failure")
//                    self.getCachedData()
//                    self.view?.succes()
                }
            }
        }
    }
    
    
}

