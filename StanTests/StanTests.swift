//
//  StanTests.swift
//  StanTests
//
//  Created by Jay Salvador on 25/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import XCTest
@testable import Stan
@testable import StanLib

class StanTests: XCTestCase {
    
    func testMovies() {
        
        let movies = self.getMockMovies()
        
        let filtered = movies.filter {
            
            $0.programType == .movie && ($0.releaseYear ?? 0) >= 2010
        }
        .sorted {
            
            ($0.title ?? "") < ($1.title ?? "")
        }
        
        let lastMovie = filtered.last
        
        let title = lastMovie?.title?.replacingOccurrences(of: " ", with: "")
        
        XCTAssertTrue(movies.count > 0, "No media retrieved from the API")
        
        XCTAssertTrue(filtered.count == 28, "Total Movies from 2010 must be 28")
        
        XCTAssertEqual(title, "Victoria", "Last Movie title should be Victoria")
        
        XCTAssertEqual(lastMovie?.releaseYear, 2015, "Last Movie release date should be 2015")
    }

    func getMockMovies() -> [Movie] {
        
        let expectation = self.expectation(description: "no data recieved")
        
        var movies = [Movie]()
        
        DataHelper.getMockMovies { (response) in
            
            switch response {
                
            case .success(let _movies):
                
                movies = _movies
                
            case .failure:
                
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
        return movies
    }
}
