//
//  ViewController.swift
//  api
//
//  Created by F1xTeoNtTsS on 13.07.2021.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    
    var networkWeatherManager = NetworkWeatherManager()
    
    
//MARK: Location Manager
    
    
    lazy var locationManager: CLLocationManager = {
        let lM = CLLocationManager()
        lM.delegate = self
        lM.desiredAccuracy = kCLLocationAccuracyKilometer
        lM.requestWhenInUseAuthorization()
        return lM
    }()
    
//MARK: Interface
    
    
    let backgroundImage: UIImageView = {
        let bi = UIImageView()
        bi.image = UIImage(named: "background")
        
        return bi
    }()
    
    
    let sunriseLabel: UILabel = {
        let sunriseLabel = UILabel()
        sunriseLabel.text = "sunrise"
        sunriseLabel.numberOfLines = 0
        sunriseLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        sunriseLabel.textColor = UIColor(named: "InfoColor")
        sunriseLabel.textAlignment = .center
        return sunriseLabel
    }()
    
    let sunsetLabel: UILabel = {
        let sunsetLabel = UILabel()
        sunsetLabel.text = "sunset"
        sunsetLabel.numberOfLines = 0
        sunsetLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        sunsetLabel.textColor = UIColor(named: "InfoColor")
        sunsetLabel.textAlignment = .center
        return sunsetLabel
    }()
    
    let sunsetImage: UIImageView = {
        let sunset = UIImageView()
        if let sunsetImage = UIImage(systemName: "sunset") {
            sunset.image = sunsetImage.withRenderingMode(.alwaysTemplate)
            sunset.tintColor = UIColor(named: "InfoColor")
        }
        return sunset
    
    }()
    
    let sunriseImage: UIImageView = {
        let sunrise = UIImageView()
        if let sunriseImage = UIImage(systemName: "sunrise") {
            sunrise.image = sunriseImage.withRenderingMode(.alwaysTemplate)
            sunrise.tintColor = UIColor(named: "InfoColor")
        }
        return sunrise
    }()
    
    let windLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "25°C"
        temperatureLabel.numberOfLines = 0
        temperatureLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        temperatureLabel.textColor = UIColor(named: "InfoColor")
        temperatureLabel.textAlignment = .center
        

        return temperatureLabel
    }()
    
    
    
    let maxTemperatureLabel: UILabel = {
        let maxTemperatureLabel = UILabel()
        maxTemperatureLabel.text = "25°C"
        maxTemperatureLabel.numberOfLines = 0
        maxTemperatureLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        maxTemperatureLabel.textColor = UIColor(named: "InfoColor")
        maxTemperatureLabel.textAlignment = .center

        return maxTemperatureLabel
    }()
    
    let minTemperatureLabel: UILabel = {
        let minTemperatureLabel = UILabel()
        minTemperatureLabel.text = "25°C"
        minTemperatureLabel.numberOfLines = 0
        minTemperatureLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        minTemperatureLabel.textColor = UIColor(named: "InfoColor")
        minTemperatureLabel.textAlignment = .center

        return minTemperatureLabel
    }()


    let weatherIconImageView: UIImageView = {
        let weatherIcon = UIImageView()
        if let weatherIconImageView = UIImage(systemName: "cloud.rain.fill"){
            weatherIcon.image = weatherIconImageView.withRenderingMode(.alwaysTemplate)
            weatherIcon.tintColor = UIColor(named: "InfoColor")
        }

        return weatherIcon
    }()

    let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "25°C"
        temperatureLabel.numberOfLines = 0
        temperatureLabel.font = UIFont.systemFont(ofSize: 50.0, weight: .black)
        temperatureLabel.textColor = UIColor(named: "InfoColor")
        temperatureLabel.textAlignment = .center
        

        return temperatureLabel
    }()
    
    let feelsLikeLabel: UILabel = {
        let feelsLikeLabel = UILabel()
        feelsLikeLabel.text = "Feels like 23°C"
        feelsLikeLabel.numberOfLines = 0
        feelsLikeLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        feelsLikeLabel.textColor = UIColor(named: "InfoColor")
        return feelsLikeLabel
    }()
    
    
    let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "CITY"
        cityLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .black)
        cityLabel.textAlignment = .center
        cityLabel.textColor = UIColor(named: "InfoColor")
        return cityLabel
    }()

    let searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        searchButton.tintColor = UIColor(named: "InfoColor")
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return searchButton
    }()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        [backgroundImage,weatherIconImageView,temperatureLabel,feelsLikeLabel,windLabel, maxTemperatureLabel, minTemperatureLabel,sunriseImage,sunriseLabel,sunsetImage,sunsetLabel,cityLabel,searchButton].forEach { view.addSubview($0)}
        networkWeatherManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        setupConstraints()
        
        
    }
    
    
    

}

extension ViewController: NetworkWeatherManagerDelegate {
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = currentWeather.cityName
            self.temperatureLabel.text = "\(currentWeather.temperatureString)°C"
            self.feelsLikeLabel.text = "Feels like \(currentWeather.feelsLikeTemperatureString)°C"
            self.weatherIconImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
            self.windLabel.text = "Wind is \(currentWeather.windString) m/s"
            self.maxTemperatureLabel.text = "Max temperature will be \(currentWeather.maxTemperatureString)°C"
            self.minTemperatureLabel.text = "Min temperature will be \(currentWeather.minTemperatureString)°C"
            self.sunriseLabel.text = currentWeather.sunriseString
            self.sunsetLabel.text = currentWeather.sunsetString
        }
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
