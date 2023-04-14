//
//  CityTemperatureViewController.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

class CityTemperatureViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        
    }
    
    //MARK: - Views
    
    var presenter: CityTemperaturePresenterProtocol!
    
    lazy var cityName: UILabel = {
        let label = UILabel()
        var cityName = ""
        label.numberOfLines = 1
        label.text = "Error Name"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    lazy var curentTemperature: UILabel = {
        let label = UILabel()
        var curentTemperature = ""
        label.numberOfLines = 1
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(cityName, curentTemperature)
        setConstraints()
//        setupProp()
        

       
    }
    

   

}

private extension CityTemperatureViewController {
    
    //MARK: - Methods
    
    func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    func setupProp() {
        cityName.text = presenter.temperatureData?.name
        if let test = presenter.temperatureData?.main.temp {
            curentTemperature.text = String(test)
        }
        print("^^^^^^^^^^^^^^^^")
        print(presenter.cityName)
        print(presenter.temperatureData)
        print("^^^^^^^^^^^^^^^^")
    }
    
    //MARK: - Constraints
    
    func setConstraints() {
        cityName.translatesAutoresizingMaskIntoConstraints = false
        curentTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            cityName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cityName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            cityName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            curentTemperature.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            curentTemperature.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            curentTemperature.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            curentTemperature.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
    
}

extension CityTemperatureViewController: CityTemperatureViewProtocol {
    func succes() {
        setupProp()
        
    }
    
    func failure(error: Error) {
        return
    }
    
    
    
}
