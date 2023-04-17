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
        static let fromCityNameToTop: CGFloat = -200
        static let CityNameLeadingSpace: CGFloat = 0
        static let CityNameTrailingSpace: CGFloat = 0
        static let fromCityNameToBottom: CGFloat = 0
        
        static let fromTemperatureNumberToTop: CGFloat = 0
        static let TemperatureNumberLeadingSpace: CGFloat = 0
        static let TemperatureNumberTrailingSpace: CGFloat = 0
        static let TemperatureNumberToBottom: CGFloat = 0
    }
    
    
    //MARK: - Views
    
    var presenter: CityTemperaturePresenterProtocol!
    
    lazy var alert: UIAlertController = {
        let alert = UIAlertController(
        title: "Outdated data",
        message: "Unable to retrieve new data",
        preferredStyle: .alert
        )
        let abortAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(abortAction)
        return alert
    }()
    
    lazy var cityName: UILabel = {
        let label = UILabel()
        var cityName = ""
        label.numberOfLines = 1
        label.text = "Loading"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var curentTemperature: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    }
}


private extension CityTemperatureViewController {
    
    
    //MARK: - Methods
    
    func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    func setupValues() {
        cityName.text = presenter.cityName
        if let temperature = presenter.temperatureData {
            curentTemperature.text = """
Current temperature:
\(temperature) °C
"""
        }
        
        if presenter.isDataLoadError == true {
            present(alert, animated: true)
        }
    }
    
    
    //MARK: - Constraints
    
    func setConstraints() {
        cityName.translatesAutoresizingMaskIntoConstraints = false
        curentTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.fromCityNameToTop),
            cityName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.CityNameLeadingSpace),
            cityName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.CityNameTrailingSpace),
            cityName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.fromCityNameToBottom)
        ])
        
        NSLayoutConstraint.activate([
            curentTemperature.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.fromTemperatureNumberToTop),
            curentTemperature.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.TemperatureNumberLeadingSpace),
            curentTemperature.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.TemperatureNumberTrailingSpace),
            curentTemperature.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.TemperatureNumberToBottom)
        ])
    }
}


//MARK: - Protocol

extension CityTemperatureViewController: CityTemperatureViewProtocol {
    
    func succes() {
        setupValues()
    }
    
    func failure(error: Error) {
        print(error)
        return
    }
}
