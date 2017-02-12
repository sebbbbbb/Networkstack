//
//  TipsAPI.swift
//  Networkstack
//
//  Created by Sebastien on 12/02/2017.
//  Copyright © 2017 Sebastien. All rights reserved.
//

import Foundation
import Alamofire

enum TipsAPI: URLRequestConvertible {
    
    case getTips
    case addTips(tip: Parameters)
    
    
    static let baseURL = "http://localhost:8000/"
    
    var method: HTTPMethod {
        switch self {
        case .getTips:
            return .get
        default:
            return .post
        }
    }
    
    var path: String {
        return "tips"
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try TipsAPI.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getTips:
            break
        case .addTips(let param):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        default:
            break
        }
        
        return urlRequest
    }
    
}
