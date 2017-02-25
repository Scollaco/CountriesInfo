//
//  CountriesResource.swift
//  CountriesInfo
//
//  Created by Saturnino Teixeira on 2/25/17.
//  Copyright © 2017 Green. All rights reserved.
//

import Foundation

enum CountriesResource {
    
    case name(name: String)
    case alphaCodes(codes: [String])
}

extension CountriesResource : Resource {
    
    var path: String {
        
        switch self {
        case let .name(name: name):
            return "name/\(name)"
        case .alphaCodes:
            return "alpha"
        }
    }
    
    var parameters: [String : String] {
    
        switch self  {
        case .name:
            return ["fullText" : "true"]
        case let .alphaCodes(codes: codes):
            return ["codes" : codes.joined(separator: ";")]
        }
    }
}
