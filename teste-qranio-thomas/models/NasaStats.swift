//
//  NasaStatus.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation

class NasaStats {

    var nearEarthObjectCount: Int
    var closeApproachCout: Int
    var lastUpdated: String
    var source: String
    var nasaJplUrl: String
    
    init?(_ data: [String: Any]) {
        
        guard let nearEarthObjectCount = data[Constants.NEAR_EARTH_OBJECT_COUNT] as? Int else { return nil }
        guard let closeApproachCout = data[Constants.CLOSE_APPROACH_COUNT] as? Int else { return nil }
        guard let lastUpdated = data[Constants.LAST_UPDATED] as? String else { return nil }
        guard let source = data[Constants.SOURCE] as? String else { return nil }
        guard let nasaJplUrl = data[Constants.NASA_JAPA_URL] as? String else { return nil }
        
        self.nearEarthObjectCount = nearEarthObjectCount
        self.closeApproachCout = closeApproachCout
        self.lastUpdated = lastUpdated
        self.source = source
        self.nasaJplUrl = nasaJplUrl
    }
    
}
