//
//  Operations.swift
//  Networkstack
//
//  Created by Sebastien on 12/02/2017.
//  Copyright © 2017 Sebastien. All rights reserved.
//

import Foundation
import ObjectMapper

class Operation: SWGOutput {
    
    var valeur: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.valeur <- map["valeur"]
    }
    
    
}
