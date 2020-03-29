//
//  StanUITests.swift
//  StanUITests
//
//  Created by Jay Salvador on 25/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import XCTest

class StanUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        
        self.app = XCUIApplication()
    }
    
    func testUI() {
        
        self.app.launch()
        
        let button = self.app.buttons["MoviesButton"]
        
        button.tap()
        
        let identifierToFind = "UnderTheGun"
        
        let cell = self.app.collectionViews.cells[identifierToFind]
        
        var identifier: String? = ""
        
        // Swipe down until it is visible
        while !cell.exists {
            
            let currentIdentifier = self.app.collectionViews.cells.allElementsBoundByIndex.last?.identifier
            
            if identifier != currentIdentifier {

                identifier = currentIdentifier
                
                self.app.swipeUp()
            }
            else {
                
                // end of swiping
                
                XCTAssert(false, "Unable to find Element \(identifierToFind)")
                
                break
            }
        }
        
        cell.tap()
        
        let title = self.app.staticTexts["movieTitle"].label
        
        XCTAssertEqual(title, "Under The Gun", "Invalid value (Under The Gun)")        
    }
}
