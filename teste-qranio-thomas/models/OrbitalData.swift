//
//  OrbitalData.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation

class OrbitalData {
    
    var orbitDeterminationDate: String?
    var firstObservationDate: String?
    var lastObservationDate: String?
    var dataArcInDays: String?
    var observationsUsed: String?
    var orbitUncertainty: String?
    var minOrbitIntersec: String?
    var eccentricity: String?
    var semiMajorAxis: String?
    var inclination: String?
    var orbitalPeriod: String?
    
    init(_ data: [String: Any]) {
        self.orbitDeterminationDate = data[Constants.ORBIT_DETERMINATION_DATE] as? String
        self.firstObservationDate = data[Constants.FIRST_OBSERVATION_DATE] as? String
        self.lastObservationDate = data[Constants.LAST_OBSERVATION_DATE] as? String
        self.dataArcInDays = data[Constants.DATA_ARC_IN_DAYS] as? String
        self.observationsUsed = data[Constants.OBESERVATIONS_USED] as? String
        self.orbitUncertainty = data[Constants.ORBIT_UNCERTAINTY] as? String
        self.minOrbitIntersec = data[Constants.MINIMUM_ORBIT_INTERSECTION] as? String
        self.eccentricity = data[Constants.ECCENTRICITY] as? String
        self.semiMajorAxis = data[Constants.SEMI_MAJOR_AXIS] as? String
        self.inclination = data[Constants.INCLINATION] as? String
        self.orbitalPeriod = data[Constants.ORBITAL_PERIOD] as? String
    }
    
}


