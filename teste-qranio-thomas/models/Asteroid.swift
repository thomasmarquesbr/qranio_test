//
//  Asteroid.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation

class Asteroid {
    
    var id: Int
    var name: String
    var absoluteMagnitude: Double
    
    init?(_ data: [String: Any]) {
        guard let idStr = data[Constants.ID] as? String, let id = Int(idStr) else { return nil }
        guard let name = data[Constants.NAME] as? String else { return nil }
        guard let absoluteMagnitude = data[Constants.ABSOLUTE_MAGNITUDE_H] as? Double else { return nil }
        
        self.id = id
        self.name = name
        self.absoluteMagnitude = absoluteMagnitude
    }
    
}
