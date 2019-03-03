//
//  AsteroidsDao.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation
import Alamofire

class AsteroidsDao {
    
    let urlAsteroids = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(Constants.START_DATE)&end_date=\(Constants.END_DATE)&api_key=\(Constants.API_KEY_NASA)"
    
    func getAsteroids(completion: @escaping([String]?, [String: [Asteroid]]?)-> Void) {
        
        AF.request(urlAsteroids).responseJSON { response in
            guard let data = response.value as? [String: Any] else {
                completion(nil, nil)
                return
            }
            guard let daysData = data["near_earth_objects"] as? [String: [Any]] else {
                completion(nil, nil)
                return
            }
            
            var days = [String]()
            var asteroids = [String: [Asteroid]]()
            
            for day in daysData {
                
                days.append(day.key)
                var asteroidsInDay = [Asteroid]()
                
                for asteroidData in day.value {
                    if let asteroid = Asteroid(asteroidData as? [String: Any] ?? [:]) {
                        asteroidsInDay.append(asteroid)
                    }
                }
                
                asteroids[day.key] = asteroidsInDay
            }
            completion(days, asteroids)
        }
    }
    
}
