//
//  CityNameListDecoder.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 10.04.2023.
//

import Foundation

protocol CityNameListDecoderProtocol {
    func getListCityName(JSONfile: String)
}

class CityNameListDecoder: CityNameListDecoderProtocol {
    func getListCityName(JSONfile: String) {
        if let localData = self.readLocalFile(forName: JSONfile) {
            self.parse(jsonData: localData)
        }
    }
    
    func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([CityData].self,
                                                       from: jsonData)
            
            print("NameCity: ", decodedData[0].name)
            print("===================================")
        } catch {
            print("decode error")
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
