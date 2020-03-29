//
//  MovieClient.MoviesResponse.swift
//  StanLib
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

extension MovieClient {
    
    public struct MoviesResponse: Decodable {
        
        public var total: Int?
        public var movies: [Movie]?
        
        enum CodingKeys: String, CodingKey {
            
            case total
            case movies = "entries"
        }
    }
}
