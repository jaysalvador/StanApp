//
//  MovieCell.swift
//  Stan
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import StanLib
import Hero

class MovieCell: UICollectionViewCell {
    
    @IBOutlet
    private var view: UIView?
    
    @IBOutlet
    private var titleLabel: UILabel?
    
    @IBOutlet
    private var yearLabel: UILabel?
    
    @IBOutlet
    private var imageView: UIImageView?
    
    @IBOutlet
    private var darkView: UIView?
    
    func prepare(movie: Movie?) -> UICollectionViewCell {
        
        self.titleLabel?.text = movie?.title
        
        self.yearLabel?.text = String(movie?.releaseYear ?? 0)
        
        self.imageView?.setImage(movie?.images?.first?.url)
        
        if let id = movie?.id {

            self.view?.heroID = "\(id)_view"
            
            self.darkView?.heroID = "\(id)_darkView"

            self.titleLabel?.heroID = "\(id)_titleLabel"

            self.yearLabel?.heroID = "\(id)_yearLabel"

            self.imageView?.heroID = "\(id)_imageView"
            
            self.view?.hero.modifiers = [.spring(stiffness: 250, damping: 25)]
            
            self.darkView?.hero.modifiers = [.spring(stiffness: 250, damping: 25)]
            
            self.titleLabel?.hero.modifiers = [.spring(stiffness: 250, damping: 25)]
            
            self.yearLabel?.hero.modifiers = [.spring(stiffness: 250, damping: 25)]
            
            self.imageView?.hero.modifiers = [.spring(stiffness: 250, damping: 25)]
        }
        
        return self
    }
}
