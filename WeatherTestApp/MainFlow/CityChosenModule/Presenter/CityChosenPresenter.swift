//
//  CityChosenPresenter.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import Foundation



protocol CityChosenViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol CityChosenPresenterProtocol: AnyObject {
    init(view: CityChosenViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol)
    var temperatureData: TemperatureData? { get set }
    func getTemperatureData()
    func editGoods(temperatureData: TemperatureData?)
}

class CityChosenPresenter: CityChosenPresenterProtocol {
    let networkManager: NetworkManagerProtocol!
    weak var view: CityChosenViewProtocol?
    var router: RouterProtocol?
    var temperatureData: TemperatureData?
    
    required init(view: CityChosenViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        getTemperatureData()
    }
    
    func getTemperatureData() {
        
        
        networkManager.getTemperatureData(city: "Moscow") { [weak self] result in
            
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
    
    func editGoods(temperatureData: TemperatureData?) {
        
    }
    
    
}

