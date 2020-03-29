//
//  Movie.swift
//  StanLib
//
//  Created by Jay Salvador on 29/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation

public enum MovieType: String, Codable {
    
    case movie
    case series
}

public struct Movie: Codable {
    
    public var title: String?
    public var description: String?
    public var programType: MovieType?
    public var images: [Image]?
    public var releaseYear: Int?

    enum CodingKeys: String, CodingKey {
        
        case title
        case description
        case programType
        case images
        case releaseYear
    }
    
    /// Handles custom dynamic keys
    private struct CustomCodingKeys: CodingKey {
        
        var stringValue: String
        
        var intValue: Int?
        
        init?(stringValue: String) {
            
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            
            return nil
        }
    }
    
    /// Decoded override to bind all currencies into an array
    /// - Parameter decoder: `Decoder ` object
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.programType = try container.decodeIfPresent(MovieType.self, forKey: .programType)
        self.releaseYear = try container.decodeIfPresent(Int.self, forKey: .releaseYear)
        self.images = [Image]()
        
        if let imagesContainer = try? container.nestedContainer(keyedBy: CustomCodingKeys.self, forKey: .images) {
            
            for key in imagesContainer.allKeys {
                
                let image = try imagesContainer.decode(Image.self, forKey: key)

                self.images?.append(image)
            }
        }
    }
}
