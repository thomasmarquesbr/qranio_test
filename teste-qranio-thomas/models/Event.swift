//
//  Event.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 05/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation

class Event {
    
    var id: Int
    var title: String
    var description: String
    var resourceUri: String?
    
    init?(_ data: [String: Any]) {
        guard let id = data[Constants.ID] as? Int else { return nil }
        guard let title = data[Constants.TITLE] as? String else { return nil }
        guard let description = data[Constants.DESCRIPTION] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.description = description
        self.resourceUri = data[Constants.RESOURCE_URI] as? String
    }
    
}
