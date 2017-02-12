//
//  TipsAPI.swift
//  Networkstack
//
//  Created by Sebastien on 12/02/2017.
//  Copyright © 2017 Sebastien. All rights reserved.
//

import Foundation
import Alamofire

enum OperationAPI: URLRequestConvertible {
    
    case getOperation
    
    
    static let baseURL = "http://localhost:8000/"
    
    var method: HTTPMethod {
       return .get
    }
    
    var path: String {
        return "operation"
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try OperationAPI.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}
