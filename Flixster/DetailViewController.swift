//
//  DetailViewController.swift
//  Flixster
//
//  Created by Derrick Ng on 3/4/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var voteAvgLabel: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
    
    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var findSimilarButton: UIButton!
    
    // A property to store the movie object.
    // We can set this property by passing along the movie object associated with the movie the user tapped in the table view.
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Load the image located at the `movie.backdropPath` URL and set it on backdrop image view.
        Nuke.loadImage(with: URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + movie.backdrop_path)!, into: backdropImageView)
        
        // Set background color
        view.backgroundColor = UIColor.black
        
        // Set labels with the associated movie values.
        titleLabel.text = movie.original_title
        voteAvgLabel.text = "\(movie.vote_average) Vote Avg"
        voteCountLabel.text = "\(movie.vote_count) Votes"
        popularityLabel.text = "\(movie.popularity)\nPopularity"
        overviewLabel.text = movie.overview

        // Set style for every label
        titleLabel.textColor = UIColor.white
        voteAvgLabel.textColor = UIColor.red
        voteCountLabel.textColor = UIColor.red
        popularityLabel.textColor = UIColor.red
        overviewLabel.textColor = UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushSimilar" {
            if let destinationVC = segue.destination as? ViewController {
                // Use the index path to get the associated track
                destinationVC.similarMovieId = movie.id
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
