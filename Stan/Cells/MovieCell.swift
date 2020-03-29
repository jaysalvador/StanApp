//
//  MovieCell.swift
//  Stan
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import StanLib

class MovieCell: UICollectionViewCell {

    @IBOutlet
    private var titleLabel: UILabel?
    
    @IBOutlet
    private var yearLabel: UILabel?
    
    @IBOutlet
    private var imageView: UIImageView?
    
    func prepare(movie: Movie?) -> UICollectionViewCell {
        
        self.titleLabel?.text = movie?.title
        
        self.yearLabel?.text = String(movie?.releaseYear ?? 0)
        
        self.imageView?.setImage(movie?.images?.first?.url)
        
        return self
    }
}
