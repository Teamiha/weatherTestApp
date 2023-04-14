//
//  CityChosenViewController.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

class CityChosenViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    
    
    
    //MARK: - Properties
    
    
    var presenter: CityChosenPresenterProtocol!
    private let cellID = "ID"
    var cityNames: [String] = []
    var filtredCityList: [CityData] = []
    var isSearching = false
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        
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
    
    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredCityList = (presenter.cityList?.filter({$0.name.prefix(searchText.count) == searchText}))!
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
        

    

    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filtredCityList.count
        } else {
            return presenter.cityList?.count ?? 0
        }
          
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if isSearching {
            let city = filtredCityList[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = city.name
            cell.contentConfiguration = content
            cell.selectionStyle = .none
        } else {
            let city = presenter.cityList?[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = city?.name
            cell.contentConfiguration = content
            cell.selectionStyle = .none
        }
        
        
//        var content = cell.defaultContentConfiguration()
//
//        content.text = city?.name
//        cell.contentConfiguration = content
//        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - MOK
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching {
            let city = filtredCityList[indexPath.row].name
            presenter.showTemperatureChosenCity(cityName: city)
        } else {
            let city = presenter.cityList?[indexPath.row].name
            presenter.showTemperatureChosenCity(cityName: city)
        }
        
//        let city =
        
       
//
//        presenter.showTemperatureChosenCity(cityName: city)
//
//        print(city)
//        print(presenter.temperatureData)
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
    




