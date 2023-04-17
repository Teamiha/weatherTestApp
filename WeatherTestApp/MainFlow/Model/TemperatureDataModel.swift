//
//  TemperatureDataModel.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import Foundation

struct TemperatureData: Codable {
    let main: Main
}

struct Main: Codable {
    let temp: Double
}


