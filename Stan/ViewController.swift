//
//  ViewController.swift
//  Stan
//
//  Created by Jay Salvador on 25/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import StanLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let client = MovieClient()
        
        client?.getMovies { response in
            
            switch response {

            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
        
    }


}

