//
//  NetworkManager.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 08.04.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getTemperatureData(city: String, completion: @escaping (Result<TemperatureData?, Error>) -> Void)
    func replaceSpacesWithPercentEncoding(inputString: String) -> String
}

class NetworkManager: NetworkManagerProtocol {
    
    func replaceSpacesWithPercentEncoding(inputString: String) -> String {
        return inputString.replacingOccurrences(of: " ", with: "%20")
    }
    
    func getTemperatureData(city: String, completion: @escaping (Result<TemperatureData?, Error>) -> Void) {
        let correctCity = replaceSpacesWithPercentEncoding(inputString: city)
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(correctCity)&appid=\(TokenContainer().token)&units=metric"
        guard let url = URL(string: urlString) else { return }
        print("***********")
        print(url)
        print("***********")

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(TemperatureData.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
