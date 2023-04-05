//
//  CityTemperatureViewController.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

class CityTemperatureViewController: UIViewController {
    
    var presenter: CityTemperaturePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

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

}


extension CityTemperatureViewController: CityTemperatureViewProtocol {
    func succes() {
        return
    }
    
    func failure(error: Error) {
        return
    }
    
    
    
}
