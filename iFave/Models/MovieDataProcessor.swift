//
//  MovieFileProcessor.swift
//  iFave
//
//  Created by Andrea Pineda on 12/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

//Hulp van tutorial:
////https://app.pluralsight.com/player?course=play-by-play-ios-swift-from-scratch&author=brian-clark&name=play-by-play-ios-swift-from-scratch-m3&clip=0&mode=live

import Foundation

class MovieDataProcessor {
    //Kaart de JSON movie data
    static func mapJsonToMovies(object: [String: AnyObject], moviesKey: String) -> [Movie] {
        var mappedMovies: [Movie] = []
        //Als er geen movies worden opgehaald, return lege array
        guard let movies = object[moviesKey] as? [[String: AnyObject]] else { return mappedMovies }
        //Check elke rij
        for movie in movies {
            //Als de movie geen property "imdb" ga niet 'guarden' en ga door naar de volgende movie
            guard let id = movie["imdbID"] as? String,
                let name = movie["Title"] as? String,
                let year = movie["Year"] as? String,
                let imageUrl = movie["Poster"] as? String else { continue }

            let movieClass = Movie(id: id, title: name, year: year, imageUrl: imageUrl)
            //Append de nieuwe movie array
            mappedMovies.append(movieClass)
        }
        //Movie array
        return mappedMovies
    }
    
    static func write(movies: [Movie]) {
    }
}


