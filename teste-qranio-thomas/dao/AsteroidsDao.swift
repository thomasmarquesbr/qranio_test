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
    
    static let BASE_URL_API = "https://api.nasa.gov/neo/rest/v1/"
    static let URL_ASTEROIDS = "\(BASE_URL_API)feed?start_date=\(Constants.START_DATE)&end_date=\(Constants.END_DATE)&api_key=\(Constants.API_KEY_NASA)"
    
    func getAsteroids(completion: @escaping([String]?, [String: [Asteroid]]?)-> Void) {
        AF.request(AsteroidsDao.URL_ASTEROIDS).responseJSON { response in
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
    
    func getAsteroidDetail(_ idAsteroid: Int, completion: @escaping(AsteroidDetail?)-> Void) {
        let url = "\(AsteroidsDao.BASE_URL_API)neo/\(idAsteroid)?api_key=\(Constants.API_KEY_NASA)"
        AF.request(url).responseJSON { response in
            guard let data = response.value as? [String: Any] else {
                completion(nil)
                return
            }
            guard let asteroidDetail = AsteroidDetail(data) else {
                completion(nil)
                return
            }
            completion(asteroidDetail)
        }
    }
    
}
