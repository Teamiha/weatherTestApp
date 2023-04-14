//
//  CityChosenViewController.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

class CityChosenViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Properties
    
    
    var presenter: CityChosenPresenterProtocol!
    private let cellID = "ID"
    var cityNames: [String] = []
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        
        return searchBar
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
//        presenter.getListCityName()
//        tableView.reloadData()
        
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cityList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let city = presenter.cityList?[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = city?.name
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - MOK
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = presenter.cityList?[indexPath.row].name
        
       
        
        presenter.showTemperatureChosenCity(cityName: city)
        
        print(city)
        print(presenter.temperatureData)
//        print(presenter.temperatureData?.main.feels_like)
        
        
    }
    
}
    
    
    extension CityChosenViewController: CityChosenViewProtocol {
        func succes() {
            tableView.reloadData()
        }
        
        func failure(error: Error) {
            print(error.localizedDescription)
        }
    }
    




