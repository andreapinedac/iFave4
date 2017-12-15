//
//  DetailViewController.swift
//  iFave
//
//  Created by Andrea Pineda on 12/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

//Hulp van tutorial:
////https://app.pluralsight.com/player?course=play-by-play-ios-swift-from-scratch&author=brian-clark&name=play-by-play-ios-swift-from-scratch-m3&clip=0&mode=live

import UIKit
import Firebase


class DetailViewController: UIViewController {
    
    //Movie
    var movie:Movie!
    
    //Outles
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var plotTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Voer een extra setup uit nadat de view is geladen
        titleLabel!.text = self.movie.title
        getMovieDetails(movie: movie)
    }
    
    //Haal de movie details met de URL & API key
    func getMovieDetails(movie: Movie) {
        let url = "https://www.omdbapi.com/?t=\(movie.id)?apikey=c61e7697&plot=short&r=json"
        HTTPHandler.getJson(urlString: url, completionHandler: movieDetailsCompletion)
    }
    
    //Parse de JSON OMDB movie data
    func movieDetailsCompletion (data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parse(data: data)
            if let object = object {
                guard let plot = object["Plot"] as? String else { return }
                DispatchQueue.main.async {
                    self.plotTextView.text = plot
                }
            }
        }
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
