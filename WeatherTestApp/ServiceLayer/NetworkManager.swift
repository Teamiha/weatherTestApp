//
//  NetworkManager.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 08.04.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getTemperatureData(city: String, completion: @escaping (Result<TemperatureData?, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func getTemperatureData(city: String, completion: @escaping (Result<TemperatureData?, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=c15037d38c54c1f3f3ad6e0fc353f03b&units=metric"
        guard let url = URL(string: urlString) else { return }
        
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
