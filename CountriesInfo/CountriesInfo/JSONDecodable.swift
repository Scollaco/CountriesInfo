//
//  JSONDecodable.swift
//  CountriesInfo
//
//  Created by Saturnino Teixeira on 2/25/17.
//  Copyright © 2017 Green. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String : Any]

protocol JSONDecodable {
    
    init?(dictionary: JSONDictionary)
}

func decode<T: JSONDecodable>(dictionaries: [JSONDictionary]) -> [T]? {
    return dictionaries.flatMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
}

func decode<T: JSONDecodable>(data: Data) -> [T]? {

    guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
          let dictionaries = jsonObject as? [JSONDictionary],
          let objects: [T] = decode(dictionaries: dictionaries) else {
                return nil
    }
    return objects
}
