//
//  WeatherDownloader.swift
//  WeatherApp
//
//  Created by Daniil KOZYR on 7/17/19.
//  Copyright © 2019 Daniil KOZYR. All rights reserved.
//

import Foundation
import DarkSkyKit

class WeatherDownloader {
    private let darkSkyToken = "c70c432174c9652d6fe82ac8dfc16a11"
    private var weatherClient: DarkSkyKit?

    init() {
        self.weatherClient = DarkSkyKit(apiToken: darkSkyToken)
    }

    func makeRequest(location: City, completion: @escaping (Result<Temperature, Error>) -> Void) {
        weatherClient?.current(latitude: location.latitude, longitude: location.longitude) { result in
            switch result {
            case .success(let forecast):
                guard let current = forecast.currently,
                      let temp = current.temperature?.convertFromFahrenheitToCelsius(),
                      let summary = current.summary else {
                    completion(.failure(DownloaderError.noConnectionWithAPI))
                    return
                }
                
                let temperature = Temperature(
                    tmp: temp,
                    summary: summary,
                    icon: current.icon
                )
                completion(.success(temperature))
                
            case .failure:
                completion(.failure(DownloaderError.noConnectionWithAPI))
            }
        }
    }
}
