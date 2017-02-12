//
//  Tips.swift
//  Networkstack
//
//  Created by Sebastien on 12/02/2017.
//  Copyright © 2017 Sebastien. All rights reserved.
//

import Foundation
import ObjectMapper

class Tips: SWGOutput {
    
    var id: String?
    var name: String?
    
    //required init?(map: Map) {}
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["_id"]
        name <- map["name"]
    }
    
}
