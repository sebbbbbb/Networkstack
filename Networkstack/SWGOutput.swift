//
//  SWGOutput.swift
//  Networkstack
//
//  Created by Sebastien on 12/02/2017.
//  Copyright © 2017 Sebastien. All rights reserved.
//

import Foundation
import ObjectMapper

class SWGOutput: Mappable {
    
    var error: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.error <- map["error"]
    }
    
    
}
