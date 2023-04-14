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
    init(view: CityChosenViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol, cityNameListDecoder: CityNameListDecoderProtocol)
    var temperatureData: TemperatureData? { get set }
    var cityList: [CityData]? { get set }
    func getTemperatureData(city: String)
    func getListCityName()
    func showTemperatureChosenCity(cityName: String?)
    func editGoods(temperatureData: TemperatureData?)
}

class CityChosenPresenter: CityChosenPresenterProtocol {
    let networkManager: NetworkManagerProtocol!
    weak var view: CityChosenViewProtocol?
    var router: RouterProtocol?
    var cityNameListDecoder: CityNameListDecoderProtocol?
    var temperatureData: TemperatureData?
    var cityList: [CityData]?
    
    required init(view: CityChosenViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol, cityNameListDecoder: CityNameListDecoderProtocol) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        self.cityNameListDecoder = cityNameListDecoder
//        getTemperatureData(city: "Moscow")
        getListCityName()
    }
    
    func showTemperatureChosenCity(cityName: String?) {
        router?.showCityTemperature(cityName: cityName)
    }
    
    func getTemperatureData(city: String) {
        networkManager.getTemperatureData(city: city) { [weak self] result in
            
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
    
    func getListCityName() {
        cityNameListDecoder?.getListCityName(JSONfile: "CityList") { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case.success(let cityList):
                    self.cityList = cityList
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

