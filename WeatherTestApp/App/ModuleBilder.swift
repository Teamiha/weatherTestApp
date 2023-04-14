//
//  ModuleBilder.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

protocol AssemblyBilderProtocol {
    
    func createCityChosenModule(router: RouterProtocol) -> UIViewController
    func createShowCityTemperatureModule(cityName: String?, router: RouterProtocol) -> UIViewController
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
    
    func createShowCityTemperatureModule(cityName: String?, router: RouterProtocol) -> UIViewController {
        let view = CityTemperatureViewController()
        let networkManager = NetworkManager()
//        var cityName = "Moscow"
        let presenter = CityTemperaturePresenter(view: view,  networkManager: networkManager, router: router, cityName: cityName )
        view.presenter = presenter
        return view
    }
}


