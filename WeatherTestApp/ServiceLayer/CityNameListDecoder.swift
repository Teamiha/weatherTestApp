//
//  CityNameListDecoder.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 10.04.2023.
//

import Foundation


//MARK: - Protocol

protocol CityNameListDecoderProtocol {
    func getListCityName(JSONfile: String,
                         completion: @escaping (Result<[CityData]?, Error>) -> Void
                        )
}


//MARK: - Class

class CityNameListDecoder: CityNameListDecoderProtocol {
    
    func getListCityName(JSONfile: String,
                         completion: @escaping (Result<[CityData]?, Error>) -> Void
                        ) {
        
        if let localData = self.readLocalFile(forName: JSONfile) {
            do {
                let decodedData = try JSONDecoder().decode([CityData].self,
                                                           from: localData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
                print("decode error")
            }
        }
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
