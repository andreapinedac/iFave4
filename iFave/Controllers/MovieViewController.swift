//
//  ViewController.swift
//  iFave
//
//  Created by Andrea Pineda on 10/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mainTableView: UITableView!
    
    //Laat de toegevoegde movies zien
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    //Array voor de favoriete movies
    var favoriteMovies: [Movie] = []
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of rows = aantal favoriete movies
        return favoriteMovies.count
    }
    
    //Binden van de verschillende movie elementen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviecell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewCell
        
        //Haal elke cell index op (per rij)
        let idx: Int = indexPath.row
        moviecell.tag = idx
        
        //Movie titel
        moviecell.movieTitle?.text = favoriteMovies[idx].title
        //Movie jaar
        moviecell.movieYear?.text = favoriteMovies[idx].year
        //Movie afbeelding
        displayMovieImage(idx, moviecell: moviecell)
        
        return moviecell
    }
    
    //Geselecteerde movie
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = favoriteMovies[indexPath.row]
    }
    
    //Laat de movie afbeelding zien
    func displayMovieImage(_ row: Int, moviecell: CustomTableViewCell) {
        let url: String = (URL(string: favoriteMovies[row].imageUrl)?.absoluteString)!
        //HTTP callen voor de movie afbeelding url
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            //DispatchQueue om niet aan de thread "vast te houden"
            DispatchQueue.main.async(execute: {
                //Wijs geroepen movie afbeelding naar de afbeelding cell
                let image = UIImage(data: data!)
                moviecell.movieImageView?.image = image
            })
        }).resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Haal de niewe View Controller door het gebruik maken van segue.destinationViewController
        //Geef het geselecteerde object door naar de nieuwe View Controller.
        
        //Segway searchMoviesSegue --> SearchViewController
        if segue.identifier == "searchMoviesSegue" {
            //Bestemming controller
            let controller = segue.destination as! SearchViewController
            controller.delegate = self
        }
        
        //Segway movieDetailSegue --> DetailViewController
        if segue.identifier == "movieDetailSegue" {
            //Bestemming controller
            let controller = segue.destination as! DetailViewController
            let cell = sender as! CustomTableViewCell
            controller.movie = favoriteMovies[cell.tag]
        }
    }
}
