//
//  ModuleBilder.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

protocol AssemblyBilderProtocol {
    
    func createCityChosenModule(router: RouterProtocol) -> UIViewController
    func createShowCityTemperatureModule(temperatureData: TemperatureData?, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: AssemblyBilderProtocol {
    
    func createCityChosenModule(router: RouterProtocol) -> UIViewController {
        let view = CityChosenViewController()
        let networkManager = NetworkManager()
        let cityNameListDecoder = CityNameListDecoder()
        let presenter = CityChosenPresenter(view: view, networkManager: networkManager, router: router, cityNameListDecoder: cityNameListDecoder)
        view.presenter = presenter
        return view
    }
    
    func createShowCityTemperatureModule(temperatureData: TemperatureData?, router: RouterProtocol) -> UIViewController {
        let view = CityTemperatureViewController()
        let presenter = CityTemperaturePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}


