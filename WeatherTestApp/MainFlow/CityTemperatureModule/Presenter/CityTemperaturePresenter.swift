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
    init(view: CityTemperatureViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol, cityName: String? )
    var temperatureData: TemperatureData? { get set }
    var cityName: String? { get set }
    func getTemperatureChosenCity(cityName: String?)
}

class CityTemperaturePresenter: CityTemperaturePresenterProtocol {
    weak var view: CityTemperatureViewProtocol?
    var router: RouterProtocol?
    let networkManager: NetworkManagerProtocol!
    var temperatureData: TemperatureData?
    var cityName: String?
    
    required init(view: CityTemperatureViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol, cityName: String?) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        self.cityName = cityName
        getTemperatureChosenCity(cityName: cityName)
    }
    
    func getTemperatureChosenCity(cityName: String?) {
        networkManager.getTemperatureData(city: cityName ?? "Moscow") { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case.success(let temp):
                    self.temperatureData = temp
                    self.view?.succes()
                    
                case.failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    
}

