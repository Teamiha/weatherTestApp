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
    init(view: CityChosenViewProtocol, router: RouterProtocol)
    var goods: [TemperatureData]? { get set }
    func addGoods(temperatureData: TemperatureData?)
    func editGoods(temperatureData: TemperatureData?)
}

class CityChosenPresenter: CityChosenPresenterProtocol {
    weak var view: CityChosenViewProtocol?
    var router: RouterProtocol?
    var goods: [TemperatureData]?
    
    required init(view: CityChosenViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func addGoods(temperatureData: TemperatureData?) {
        
    }
    
    func editGoods(temperatureData: TemperatureData?) {
        
    }
    
    
}

