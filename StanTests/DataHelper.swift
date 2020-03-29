//
//  DataHelper.swift
//  StanTests
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import StanLib

typealias HelperCompletionClosure = ((Result<[Movie], Error>) -> Void)

class DataHelper {

    class func getMockMovies(completion: HelperCompletionClosure?) {

        let dataPath = Bundle(for: DataHelper.self).path(forResource: "data", ofType: "json") ?? ""
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: dataPath))
            
            let decoder = JSONDecoder()
                        
            let decoded = try decoder.decode(MovieClient.MoviesResponse.self, from: data)
            
            completion?(.success(decoded.movies ?? []))
        }
        catch {

            completion?(.failure(error))
        }
    }
}

