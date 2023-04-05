//
//  Router.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBilder: AssemblyBilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
//    func initialViewController()
    func showCityChosen(temperatureData: TemperatureData?)
    func showCityTemperature(temperatureData: TemperatureData?)
    
    
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBilder: AssemblyBilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBilder: AssemblyBilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBilder = assemblyBilder
    }
    
    
    func showCityChosen(temperatureData: TemperatureData?) {
        if let navigationController = navigationController {
            guard let cityChosenViewController = assemblyBilder?.createCityChosenModule(temperatureData : temperatureData, router: self) else {return}
            navigationController.viewControllers = [cityChosenViewController]
        }
    }
    
    func showCityTemperature(temperatureData: TemperatureData?) {
        if let navigationController = navigationController {
            guard let showCityTemperatureViewController = assemblyBilder?.createShowCityTemperatureModule(temperatureData: temperatureData, router: self) else {return}
            navigationController.pushViewController(showCityTemperatureViewController, animated: true)
        }
    }
    
    
}


