//
//  Characters.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 05/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation

class Character {
    
    var id: Int
    var name: String
    var description: String?
    var modified: String?
    var resourceUri: String?
    var thumbnail: String
    
    init?(_ data: [String: Any]) {
        guard let id = data[Constants.ID] as? Int else { return nil }
        guard let name = data[Constants.NAME] as? String else { return nil }
        guard let description = data[Constants.DESCRIPTION] as? String else { return nil }
        guard let thumb = data[Constants.THUMBNAIL] as? [String: Any],
            let thumbnail = thumb[Constants.PATH] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.description = description
        self.modified = data[Constants.MODIFIED] as? String
        self.resourceUri = data[Constants.RESOURCE_URI] as? String
        self.thumbnail = thumbnail
    }
    
}
