//
//  LocationDownloader.swift
//  WeatherApp
//
//  Created by Daniil KOZYR on 7/17/19.
//  Copyright © 2019 Daniil KOZYR. All rights reserved.
//

import Foundation
import RecastAI

enum DownloaderError: Error {
    case invalidCity
    case noInternetConnection
    case noConnectionWithAPI
}

class LocationDownloader {
    private let recastAIToken = "YOUR_RECAST_AI_API_KEY_HERE"
    private var recastClient: RecastAIClient?
    
    init() {
        self.recastClient = RecastAIClient(token: recastAIToken, language: "en")
    }
    
    func requestLocation(city: String, completion: @escaping (Result<City, DownloaderError>) -> Void) {
        recastClient?.textRequest(city, successHandler: { [weak self] response in
            guard let self = self,
                  let location = self.parseLocationFromResponse(response) else {
                completion(.failure(.invalidCity))
                return
            }
            completion(.success(location))
        }, failureHandle: { _ in
            completion(.failure(.noInternetConnection))
        })
    }
    
    private func parseLocationFromResponse(_ response: Response) -> City? {
        guard let locationArray = response.entities?["location"] as? [NSDictionary],
              let locationData = locationArray.first,
              var cityName = locationData.value(forKey: "raw") as? String,
              let latitude = locationData.value(forKey: "lat") as? NSNumber,
              let longitude = locationData.value(forKey: "lng") as? NSNumber else {
            return nil
        }
        
        if let countryState = locationData.value(forKey: "country") as? String {
            cityName += ", \(countryState.uppercased())"
        }
        
        return City(
            city: cityName,
            longitude: longitude.doubleValue,
            latitude: latitude.doubleValue
        )
    }
}

