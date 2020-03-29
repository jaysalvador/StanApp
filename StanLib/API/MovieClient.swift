//
//  MovieClient.swift
//  StanLib
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public protocol MovieClientProtocol {
    
    func getMovies(onCompletion: HttpCompletionClosure<MovieClient.MoviesResponse>?)
}

public class MovieClient: HttpClient, MovieClientProtocol {
    
    public func getMovies(onCompletion: HttpCompletionClosure<MovieClient.MoviesResponse>?) {
        
        let requestString = "/StreamCo/react-coding-challenge/master/feed/sample.json"

        self.request(
            MovieClient.MoviesResponse.self,
            endpoint: requestString,
            httpMethod: .get,
            headers: nil,
            onCompletion: onCompletion
        )
    }
}
