//
//  APIClientError.swift
//  CountriesInfo
//
//  Created by Saturnino Teixeira on 2/25/17.
//  Copyright © 2017 Green. All rights reserved.
//

import Foundation

enum APIClientError: Error {
    
    case couldNotDecodeJSON
    case badStatus(status: Int)
    case other(Error)
}

