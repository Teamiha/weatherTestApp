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
    init(view: CityTemperatureViewProtocol, router: RouterProtocol)
    var goods: [TemperatureData]? { get set }
    func addGoods(temperatureData: TemperatureData?)
    func editGoods(temperatureData: TemperatureData?)
}

class CityTemperaturePresenter: CityTemperaturePresenterProtocol {
    weak var view: CityTemperatureViewProtocol?
    var router: RouterProtocol?
    var goods: [TemperatureData]?
    
    required init(view: CityTemperatureViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func addGoods(temperatureData: TemperatureData?) {
        
    }
    
    func editGoods(temperatureData: TemperatureData?) {
        
    }
    
    
}

