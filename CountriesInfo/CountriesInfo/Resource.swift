//
//  Resource.swift
//  CountriesInfo
//
//  Created by Saturnino Teixeira on 2/25/17.
//  Copyright © 2017 Green. All rights reserved.
//

import Foundation

enum Method : String {

    case get = "GET"
    case post = "POST"
}

protocol Resource {

    var method: Method { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension Resource {

    var method: Method {
        return .get
    }

    func requestWithBaseURL(baseURL : URL) -> URLRequest {
    
        let url = baseURL.appendingPathComponent(path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(url)")
        }
        components.queryItems = parameters.map {
            URLQueryItem.init(name: String($0), value: String($1))
        }
        
        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        var request = URLRequest.init(url: finalURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}
