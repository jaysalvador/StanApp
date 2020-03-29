//
//  MoviesViewModel.swift
//  Stan
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import StanLib

typealias ViewModelCallback = (() -> Void)

protocol MoviesViewModelProtocol {
    
    // MARK: - Data
    
    var movies: [Movie]? { get }
    
    var type: MovieType { get set }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func getMovies()
}

class MoviesViewModel: MoviesViewModelProtocol {
    
    // MARK: - Data
    
    private var movieClient: MovieClientProtocol?
    
    private(set) var movies: [Movie]?
    
    var type: MovieType = .series
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    // MARK: - Init
    
    convenience init() {
        
        self.init(movieClient: MovieClient())
    }
    
    init(movieClient _movieClient: MovieClientProtocol?) {
        
        self.movieClient = _movieClient
    }
    
    // MARK: - Functions
    
    func getMovies() {
    
        self.movieClient?.getMovies { [weak self] (response) in
            
            switch response {
            case .success(let movieData):
                
                self?.movies = movieData.movies
                
                self?.onUpdated?()
            case .failure:
                
                self?.onError?()
            }
            
        }
    }
}
