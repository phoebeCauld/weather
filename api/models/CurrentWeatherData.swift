//
//  CurrentWeatherData.swift
//  api
//
//  Created by F1xTeoNtTsS on 16.07.2021.
//

import Foundation

struct CurrentWeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double

    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let id: Int
}

    struct Wind: Codable {
        let speed: Double
    }

struct Sys: Codable {
    let sunrise, sunset: Int
}
