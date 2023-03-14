//
//  MovieCell.swift
//  Flixster
//
//  Created by Derrick Ng on 3/3/23.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    /// Configures the cell's UI for the given movie.
    func configure(with movie: Movie) {
        // set text and style for movieTitleLabel
        movieTitleLabel.text = movie.original_title
        movieTitleLabel.font = UIFont(name: "Helvetica-Bold", size: 18)
        movieTitleLabel.textColor = UIColor.white
        
        // set text and style for movieTitleLabel
        movieOverviewLabel.text = movie.overview
        movieOverviewLabel.textColor = UIColor.white
        
        // Load image async via Nuke library image loading helper method
        Nuke.loadImage(with: URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + movie.poster_path)!, into: movieImageView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
