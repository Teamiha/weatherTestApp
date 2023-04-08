//
//  CityChosenViewController.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

class CityChosenViewController: UITableViewController {
    
    //MARK: - Properties
    
    var presenter: CityChosenPresenterProtocol!
    private let cellID = "ID"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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




