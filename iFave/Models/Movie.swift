//
//  Movie.swift
//  iFave
//
//  Created by Andrea Pineda on 10/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

import Foundation
import Firebase

//De class movie
class Movie {
    var id: String = ""
    var title: String = ""
    var year: String = ""
    var imageUrl: String = ""
    var plot: String = ""
    
    //Initializer voor de class movie
    init(id: String, title: String, year: String, imageUrl: String, plot: String = "") {
        self.id = id
        self.title = title
        self.year = year
        self.imageUrl = imageUrl
        self.plot = plot
    }
    
}


