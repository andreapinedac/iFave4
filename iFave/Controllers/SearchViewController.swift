//
//  SearchViewController.swift
//  iFave
//
//  Created by Andrea Pineda on 12/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

//Hulp van tutorials:
//https://app.pluralsight.com/player?course=play-by-play-ios-swift-from-scratch&author=brian-clark&name=play-by-play-ios-swift-from-scratch-m3&clip=0&mode=live
//https://www.simplifiedios.net/firebase-realtime-database-tutorial/

import UIKit
import Foundation
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Maak connectie tot Firebase
    var refMovies: DatabaseReference!

    //ViewController delegate
    weak var delegate: ViewController!
    //Search results returnt movies
    var searchResults: [Movie] = []
    var movie: Movie!
    var userID = Auth.auth().currentUser?.uid
    var user = Auth.auth().currentUser!
    
    
    //Outlets
    @IBOutlet var searchText: UITextField!
    @IBOutlet var tableView: UITableView!
    
    //Functie voor het zoeken van movies
    @IBAction func search(sender: UIButton) {
        var searchTerm = searchText.text!
        //Constraint voor de term van het zoeken van movies (minimaal 1 letter geven)
        if searchTerm.characters.count > 1 {
            //Haal de movie termen op
            retrieveMoviesByTerm(searchTerm: searchTerm)
        }
    }
    
    //Voeg toe aan de favoriete movies
    @IBAction func addFav (sender: UIButton) {
        self.delegate.favoriteMovies.append(self.searchResults[sender.tag])
        addMovies()
        
    }
    
    //Return aantal rijen = aantal movie results
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    //Hoogte voor header in sectie
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    //Titel TableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    
    //Een sectie (gegroepeerde verticale secties)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviecell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewCell
        
        //Favoriete movie toevoegen-button
        let idx: Int = indexPath.row
        //Index welke movie geselecteerd was voor favorieten
        moviecell.favButton.tag = idx
        
        //Titel movie
        moviecell.movieTitle?.text = searchResults[idx].title
        //Jaar movie
        moviecell.movieYear?.text = searchResults[idx].year
        //Afbeelding movie
        displayMovieImage(idx, moviecell: moviecell)
        
        return moviecell
    }
    
    //Haal movie afbeelding info en plaats het in de cell
    func displayMovieImage(_ row: Int, moviecell: CustomTableViewCell) {
        let url: String = (URL(string: searchResults[row].imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                moviecell.movieImageView?.image = image
            })
        }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getting a reference to the node artists
        refMovies = Database.database().reference().child("Movies");
    }
    
    //Voeg movies toe aan Firebase
    func addMovies(){
        let key = refMovies.childByAutoId().key
        
        let Movie = ["id":key,
                     "email": user.email!,
                         "MovieName": searchResults[0].title,
            
            ] as [String : Any]
        
        refMovies.child(key).setValue(Movie)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //Parse de movie data
    func parseDataIntoMovies(data: Data?) -> Void {
        //Zorg ervoor dat er data is
        if let data = data {
            //Gebruik de JSON parser
            let object = JSONParser.parse(data: data)
            if let object = object {
                //Searchresults is de movie array (van de moviedataprocessor)
                self.searchResults = MovieDataProcessor.mapJsonToMovies(object: object, moviesKey: "Search")
                DispatchQueue.main.async {
                    //Closure = wanneer movie gegevens worden gearchiveerd
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //Wanneer er gezocht wordt naar een movie term, zoek deze op OMBD
    func retrieveMoviesByTerm(searchTerm: String) {
        //Zoek term in de OMDB API
        let url = "https://www.omdbapi.com/?s=\(searchTerm)&apikey=c61e7697&plot=short&r=json"
        //Parse de data met de parseDataIntoMovies functie
        HTTPHandler.getJson(urlString: url, completionHandler: parseDataIntoMovies)
    }
    

}

