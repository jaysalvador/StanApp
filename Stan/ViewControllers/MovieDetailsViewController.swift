//
//  MovieDetailsViewController.swift
//  Stan
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet
    private var titleLabel: UILabel?
    
    @IBOutlet
    private var yearLabel: UILabel?
    
    @IBOutlet
    private var imageView: UIImageView?
    
    @IBOutlet
    private var darkView: UIView?
    
    @IBOutlet
    private var descriptionLabel: UILabel?
    
    @IBOutlet
    private var typeLabel: UILabel?
    
    var viewModel: MovieDetailsViewModelProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.setup()
    }

    private func setup() {
        
        if let id = self.viewModel?.movie?.id {

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
        
        let movie = self.viewModel?.movie
        
        self.titleLabel?.text = movie?.title
        
        self.typeLabel?.text = movie?.programType?.rawValue.capitalized
        
        self.yearLabel?.text = String(movie?.releaseYear ?? 0)
        
        self.imageView?.setImage(movie?.images?.first?.url)
        
        self.descriptionLabel?.text = movie?.description
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieDetailsViewController {
    
    class func make(withViewModel viewModel: MovieDetailsViewModelProtocol) -> MovieDetailsViewController? {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {

            vc.viewModel = viewModel
            
            return vc
        }
        
        return nil
    }
}
