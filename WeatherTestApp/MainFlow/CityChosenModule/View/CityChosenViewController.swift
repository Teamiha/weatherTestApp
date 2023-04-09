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

        
    }
    
   
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
       
        content.text = "Test"
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        return cell
    }

}

extension CityChosenViewController: CityChosenViewProtocol {
    func succes() {
        return
    }
    
    func failure(error: Error) {
        return
    }
}





