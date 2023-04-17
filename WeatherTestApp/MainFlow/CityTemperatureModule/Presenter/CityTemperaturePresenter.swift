//
//  CityTemperaturePresenter.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import Foundation


//MARK: - Protocol

protocol CityTemperatureViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol CityTemperaturePresenterProtocol: AnyObject {
    init(view: CityTemperatureViewProtocol,
         networkManager: NetworkManagerProtocol,
         router: RouterProtocol,
         cacheManager: CacheManagerProtocol,
         cityName: String?,
         isDataLoadError: Bool?
         )
    var temperatureData: String? { get set }
    var cityName: String? { get set }
    func getTemperatureChosenCity(cityName: String?)
    var isDataLoadError: Bool? { get set }
}


//MARK: - Class

class CityTemperaturePresenter: CityTemperaturePresenterProtocol {
    weak var view: CityTemperatureViewProtocol?
    var router: RouterProtocol?
    let networkManager: NetworkManagerProtocol!
    let cacheManager: CacheManagerProtocol!
    var temperatureData: String?
    var cityName: String?
    var isDataLoadError: Bool?
    
    required init(view: CityTemperatureViewProtocol,
                  networkManager: NetworkManagerProtocol,
                  router: RouterProtocol,
                  cacheManager: CacheManagerProtocol,
                  cityName: String?,
                  isDataLoadError: Bool?
                 ) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        self.cacheManager = cacheManager
        self.cityName = cityName
        self.isDataLoadError = isDataLoadError
        getTemperatureChosenCity(cityName: cityName)
    }
    
    func getTemperatureChosenCity(cityName: String?) {
        networkManager.getTemperatureData(city: cityName ?? "Error load city name") {
            [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                    
                case.success(let currentTemperature):
                    self.isDataLoadError = false
                    self.temperatureData = String(currentTemperature?.main.temp ?? 0)
                    self.view?.succes()
                    self.cacheManager.cacheSave(
                        tempData: currentTemperature ?? self.cacheManager.errorData,
                        cityName: cityName ?? "Error load city name"
                                               )
                    
                case.failure(let error):
                    self.isDataLoadError = true
                    self.cacheManager.cacheLoad(cityName: cityName ?? "Moscow") {
                        [weak self] result in
                        switch result {
                            
                        case .success(let currentTemperature):
                            self?.temperatureData = currentTemperature
                            self?.view?.succes()
                        case .failure(let error):
                            print("Error For Load Cache \(error)")
                        }
                    }
                    print("Network Failure \(error)")
                }
            }
        }
    }
}

