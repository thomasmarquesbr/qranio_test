//
//  AsteroidsDao.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation

class AsteroidsDao {
    
    let urlAsteroids = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(Constants.START_DATE)&end_date=\(Constants.END_DATE)&api_key=\(Constants.API_KEY_NASA)"
    
    func getAsteroids(completion: @escaping([Asteroid])-> Void) {
        
    }
    
}
