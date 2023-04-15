//
//  CashManager.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 15.04.2023.
//

import UIKit

final class TemperatureDataCache {
    static let shared = NSCache<AnyObject, AnyObject>()
    private init() {}
}
