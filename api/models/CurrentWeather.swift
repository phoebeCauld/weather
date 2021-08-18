//
//  CurrentWeather.swift
//  api
//
//  Created by F1xTeoNtTsS on 16.07.2021.
//

import Foundation


struct CurrentWeather {
    
    init?(currentWeatherData: CurrentWeatherData) {
            cityName = currentWeatherData.name
            temperature = currentWeatherData.main.temp
            feelsLikeTemperature = currentWeatherData.main.feelsLike
            conditionCode = currentWeatherData.weather.first!.id
            wind = currentWeatherData.wind.speed
            minTemperature = currentWeatherData.main.tempMin
            maxTemperature = currentWeatherData.main.tempMax
            sunrise = currentWeatherData.sys.sunrise
            sunset = currentWeatherData.sys.sunset
        }
    
    let cityName: String
    
    let temperature: Double
    var temperatureString:String {
        return String(format: "%.0F", temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString:String {
        return String(format: "%.0F", feelsLikeTemperature)
    }
    
    let minTemperature: Double
    var minTemperatureString: String {
        return String(format: "%.0F", minTemperature)
    }
    let maxTemperature: Double
    var maxTemperatureString: String {
        return String(format: "%.0F", maxTemperature)
    }
    let wind: Double
    var windString: String {
        return String(format: "%.1F", wind)
    }
    
    let sunrise: Int
    var sunriseString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        let sunriseDate = Date(timeIntervalSince1970: Double(sunrise))
        let sunriseString = formatter.string(from: sunriseDate)
        return sunriseString
    }
    let sunset: Int
    var sunsetString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        let sunsetDate = Date(timeIntervalSince1970: Double(sunset))
        let sunsetString = formatter.string(from: sunsetDate)
        return sunsetString
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "snow"
        case 701...781: return "smoke.fill"
        case 800 : return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
        

}
