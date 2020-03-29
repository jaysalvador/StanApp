//
//  MovieDetailsViewModel.swift
//  Stan
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import StanLib

protocol MovieDetailsViewModelProtocol {
    
    var movie: Movie? { get }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    private(set) var movie: Movie?
    
    // MARK: - Init
    
    init(movie _movie: Movie?) {
        
        self.movie = _movie
    }
    
}
