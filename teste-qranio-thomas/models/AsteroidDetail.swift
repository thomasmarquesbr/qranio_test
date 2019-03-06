//
//  AsteroidDetail.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation

struct orbitalData {
    
    
    
}

class AsteroidDetail {
    
    var isPotentiallyHazardousAsteroid: Bool?
    var isSentryObject: Bool?
    var name: String?
    var nameLimited: String?
    var designation: String?
    var nasaJplUrl: String?
    var absoluteMagnitudeH: Double?
    var estimatedDiameter: [String: Any]?
    var orbitalData: OrbitalData?
    
    init?(_ data: [String: Any]) {
        self.isPotentiallyHazardousAsteroid = data[Constants.IS_POTENTIALLY_HAZARDOUS_ASTEROID] as? Bool
        self.isSentryObject = data[Constants.IS_SENTRY_OBJECT] as? Bool
        self.name = data[Constants.NAME] as? String
        self.nameLimited = data[Constants.NAME_LIMITED] as? String
        self.designation = data[Constants.DESIGNATION] as? String
        self.nasaJplUrl = data[Constants.NASA_JAPA_URL] as? String
        self.absoluteMagnitudeH = data[Constants.ABSOLUTE_MAGNITUDE_H] as? Double
        self.estimatedDiameter = data[Constants.ESTIMATED_DIAMETER] as? [String: Any]
        self.orbitalData = OrbitalData(data[Constants.ORBITAL_DATA] as? [String: Any] ?? [:])
    }
    
}
