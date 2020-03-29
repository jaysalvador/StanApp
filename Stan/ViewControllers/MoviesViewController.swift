//
//  MoviesViewController.swift
//  Stan
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import StanLib

enum MoviesSection: Equatable {
    
    case section
}

enum MoviesItem: Equatable {
    
    case item(Movie)
}

class MoviesViewController: JCollectionViewController<MoviesSection, MoviesItem> {

    @IBOutlet
    private var seriesButton: UIButton?
    
    @IBOutlet
    private var moviesButton: UIButton?
    
    // MARK: - View model
    
    private var viewModel: MoviesViewModelProtocol? = MoviesViewModel()
    
    private var refreshControl = UIRefreshControl()
    
    /// generates the items based on the data given by the `ViewModel` that will be rendered on the `CollectionView`
    override var sectionsAndItems: Array<SectionAndItems> {
        
        var items = [MoviesItem]()
        
        let type = self.viewModel?.type
        
        self.viewModel?.movies?
            .filter {
                
                $0.programType == type && ($0.releaseYear ?? 0) >= 2010
            }
            .sorted {
                
                ($0.title ?? "") < ($1.title ?? "")
            }
            .forEach {
            
                items.append(.item($0))
            }
        
        return [(.section, items)]
    
    }
    
    // MARK: - Setup
    
    /// setup the ViewModel callbacks and their behaviours
    private func setupViewModel() {
        
        self.viewModel?.onUpdated = { [weak self] in

            DispatchQueue.main.async {

                self?.updateSectionsAndItems()
            }
        }
    }
    
    /// Pull-to-refresh
    private func setupPullToRefresh() {
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        
        self.refreshControl.addTarget(self, action: #selector(onRefresh), for: UIControl.Event.valueChanged)
        
        self.collectionView?.refreshControl = self.refreshControl
    }
    
    /// Register cells
    override func setupCollectionView() {
        
        super.setupCollectionView()
        
        self.collectionView?.register(cell: MovieCell.self)
    }
    
    private func setButtons() {
        
        if let type = self.viewModel?.type {
            
            self.setActiveButton(type == .series, button: self.seriesButton)
            
            self.setActiveButton(type == .movie, button: self.moviesButton)
        }
    }
    
    private func setActiveButton(_ active: Bool, button: UIButton?) {
        
        button?.borderColor = active ? .systemBlue : .lightGray
        
        button?.setTitleColor(active ? .systemBlue : .lightGray, for: .normal)
    }
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupViewModel()

        self.setupPullToRefresh()
        
        self.setButtons()
        
        self.viewModel?.getMovies()
    }
    
    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
    
    /// Renders all the items
    override func collectionView(_ collectionView: UICollectionView, cellForSection section: MoviesSection, item: MoviesItem, indexPath: IndexPath) -> UICollectionViewCell? {
        
        if case .item(let movie) = item,
            let cell = self.collectionView?.dequeueReusable(cell: MovieCell.self, for: indexPath){
            
            return cell.prepare(movie: movie)
        }
        
        return nil
    }
    
    /// handles currency selection to show in `CurrencyDetailViewController`
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAtSection section: MoviesSection, item: MoviesItem) {

    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSection section: MoviesSection, item: MoviesItem, indexPath: IndexPath) -> CGSize? {
        
        let orientation = UIDevice.current.orientation
        
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            
            return CGSize(width: 320.0, height: collectionView.frame.height)
        }
        else {
            
            return CGSize(width: collectionView.frame.width, height: 320.0)
        }
    }
    
    // MARK: - Actions
    
    @objc
    func onRefresh() {
        
        self.viewModel?.getMovies()
        
        self.refreshControl.endRefreshing()
    }
    
    override func orientationChanged() {
        
        let orientation = UIDevice.current.orientation
        
        if orientation == .landscapeLeft || orientation == .landscapeRight {

            self.collectionView?.flowLayout?.scrollDirection = .horizontal
        }
        else {

            self.collectionView?.flowLayout?.scrollDirection = .vertical
        }
        
        super.orientationChanged()
    }
    
    @IBAction func movieTypeTouchUpInside(_ sender: UIButton) {
    
        self.viewModel?.type = sender == self.seriesButton ? .series : .movie
        
        self.setButtons()
        
        self.updateSectionsAndItems()
    }
}