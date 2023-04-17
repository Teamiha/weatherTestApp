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
        static let fromCityNameToTop: CGFloat = 10
        static let CityNameLeadingSpace: CGFloat = 10
        static let CityNameTrailingSpace: CGFloat = 10
        static let fromCityNameToBottom: CGFloat = 10
        
        static let fromTemperatureNumberTopToCityNameBottom: CGFloat = 10
        static let TemperatureNumberLeadingSpace: CGFloat = 10
        static let TemperatureNumberTrailingSpace: CGFloat = 10
        static let TemperatureNumberToBottom: CGFloat = 10
    }
    
    //MARK: - Views
    
    var presenter: CityTemperaturePresenterProtocol!
    
//    let alert = UIAlertController(title: "ALERT", message: "Are you sure you want to remove this photo from your favorites?", preferredStyle: .alert)
    
    lazy var alert: UIAlertController = {
        let alert = UIAlertController(
        title: "Data is old",
        message: "Test",
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
        label.font = .systemFont(ofSize: 30)
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
        cityName.text = presenter.cityName
        if let test = presenter.temperatureData {
            curentTemperature.text = """
Current temperature:
\(test)
"""
        }
        if presenter.isDataLoadError == true {
            present(alert, animated: true)
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
            cityName.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.fromCityNameToTop),
            cityName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.CityNameLeadingSpace),
            cityName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.CityNameTrailingSpace),
            cityName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.fromCityNameToBottom)
        ])
        
        NSLayoutConstraint.activate([
            curentTemperature.topAnchor.constraint(equalTo: view.topAnchor),
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
        print(error)
        return
    }
    
    
    
}
