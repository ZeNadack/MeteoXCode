//
//  API+Extensions.swift
//  Meteo
//
//  Created by Theo Blanchard on 9/13/24.
//

import Foundation

//classe crée afin de cacher la clé API

extension API {
    static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    
    static func getURLfor(lat: Double, lon: Double) -> String {
        return"\(baseURLString)oncall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)&units=imperial"
    }
}
