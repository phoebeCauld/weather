//
//  ViewControllerExtensions.swift
//  api
//
//  Created by F1xTeoNtTsS on 16.07.2021.
//

import UIKit

extension ViewController {

   @objc func searchButtonPressed() {
    let alert = UIAlertController(title: "Enter city name", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { tf in
            let cities = ["Moscow", "Saint Petersburg", "Samara", "Paris"]
            tf.placeholder = cities.randomElement()
        })
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alert.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
           
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(search)
        alert.addAction(cancel)
    
    present(alert, animated: true)
    }
    
//MARK: Setup Constraints for Weather Labels
    
    func setupConstraints() {
        backgroundImage.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, center: view.centerXAnchor)
        
        weatherIconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                    bottom: nil,
                                    leading: nil,
                                    trailing: nil,
                                    padding: .zero,
                                    size: .init(width: 180, height: 181),
                                    center: view.centerXAnchor)
        temperatureLabel.anchor(top: weatherIconImageView.bottomAnchor,
                                bottom: nil,
                                leading: nil,
                                trailing: nil,
                                padding: .zero,
                                size: .init(width: 0, height: 83),
                                center: view.centerXAnchor)
        
        feelsLikeLabel.anchor(top: temperatureLabel.bottomAnchor,
                              bottom: nil,
                              leading: nil,
                              trailing: nil,
                              padding: .zero,
                              size: .init(width: 121, height: 20),
                              center: view.centerXAnchor)
        searchButton.anchor(top: nil,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            leading: nil,
                            trailing: view.safeAreaLayoutGuide.trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: -12),
                            size: .init(width: 30, height: 30), center: nil)
        cityLabel.anchor(top: nil,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         leading: nil, trailing: searchButton.leadingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: -12),
                         size: .init(width: 0, height: 30),
                         center: nil)
        
        windLabel.anchor(top: feelsLikeLabel.bottomAnchor,
                         bottom: nil,
                         leading: nil,
                         trailing: nil,
                         padding: .zero, size: .init(width: 180, height: 20),
                         center: view.centerXAnchor)
        maxTemperatureLabel.anchor(top: windLabel.bottomAnchor,
                                   bottom: nil,
                                   leading: nil,
                                   trailing: nil,
                                   padding: .zero,
                                   size: .init(width: 220, height: 20),
                                   center: view.centerXAnchor)
        minTemperatureLabel.anchor(top: maxTemperatureLabel.bottomAnchor,
                                   bottom: nil,
                                   leading: nil,
                                   trailing: nil,
                                   padding: .zero,
                                   size: .init(width: 220, height: 20),
                                   center: view.centerXAnchor)
        sunriseImage.anchor(top: nil,
                            bottom: nil,
                            leading: nil,
                            trailing: nil,
                            padding: .zero,
                            size: .init(width: 80, height: 70),
                            center: nil)
        sunriseLabel.anchor(top: nil,
                           bottom: nil,
                           leading: nil,
                           trailing: nil,
                           padding: .zero,
                           size: .zero,
                           center: sunriseImage.centerXAnchor)
        
        
        sunsetImage.anchor(top: nil,
                           bottom: nil,
                           leading: nil,
                           trailing: nil,
                           padding: .zero,
                           size: .init(width: 80, height: 70),
                           center: nil)
        sunsetLabel.anchor(top: nil,
                           bottom: nil,
                           leading: nil,
                           trailing: nil,
                           padding: .zero,
                           size: .zero,
                           center: sunsetImage.centerXAnchor)
        
//MARK: Create StackView for sunrise and sunset
        
        
        let sunriseStackView = UIStackView(arrangedSubviews: [sunriseImage,sunriseLabel])
        self.view.addSubview(sunriseStackView)
        sunriseStackView.axis = .vertical
        sunriseStackView.spacing = 1
        sunriseStackView.distribution = .fillEqually
        
        sunriseStackView.translatesAutoresizingMaskIntoConstraints = false
        sunriseStackView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sunriseStackView.topAnchor.constraint(lessThanOrEqualTo: maxTemperatureLabel.bottomAnchor, constant: 50).isActive = true
        sunriseStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        sunriseStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        

        let sunsetStackView = UIStackView(arrangedSubviews: [sunsetImage,sunsetLabel])
        self.view.addSubview(sunsetStackView)
        sunsetStackView.axis = .vertical
        sunsetStackView.spacing = 1
        sunsetStackView.distribution = .fillEqually
        
        
        sunsetStackView.translatesAutoresizingMaskIntoConstraints = false
        sunsetStackView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sunsetStackView.topAnchor.constraint(lessThanOrEqualTo: maxTemperatureLabel.bottomAnchor, constant: 50).isActive = true
        sunsetStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        sunsetStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true

    
    }
    
}


