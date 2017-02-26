//
//  APIClient.swift
//  CountriesInfo
//
//  Created by Saturnino Teixeira on 2/25/17.
//  Copyright © 2017 Green. All rights reserved.
//

import Foundation
import RxSwift

final class APIClient {

    fileprivate let baseURL: URL
    fileprivate let session: URLSession

    
    init(baseURL: URL, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: configuration)
    }
    
    fileprivate func data(resource: Resource) -> Observable<Data> {
    
        let request = resource.requestWithBaseURL(baseURL: baseURL)
        
        return Observable.create { observer in
            
            let task = self.session.dataTask(with: request) { data, response, error in
            
                if let error = error {
                    observer.onError(APIClientError.other(error))
                } else {
                
                    guard let httpResponse = response as? HTTPURLResponse else {
                        fatalError("Couldn't get HTTP response")
                    }
                    
                    if 200..<300 ~= httpResponse.statusCode {
                        
                        observer.onNext(data ?? Data())
                        observer.onCompleted()
                    } else {
                    
                        observer.onError(APIClientError.badStatus(status: httpResponse.statusCode))
                    }
                }
            }
            
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func objects<T: JSONDecodable>(resource: Resource) -> Observable<[T]> {
    
        return data(resource: resource).map { data in
        
            guard let objects: [T] = decode(data: data) else {
            
                throw APIClientError.couldNotDecodeJSON
            }
        
            return objects
        }
    }
}


extension APIClient {

    func countryWithName(name: String) -> Observable<Country> {
        return objects(resource: CountriesResource.name(name: name)).map { $0[0] }
    }
    
    func countriesWithCodes(codes: [String]) -> Observable<[Country]> {
        return objects(resource: CountriesResource.alphaCodes(codes: codes))
    }
}

















