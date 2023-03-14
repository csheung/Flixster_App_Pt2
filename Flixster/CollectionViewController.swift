//
//  CollectionViewController.swift
//  Flixster
//
//  Created by Derrick Ng on 3/7/23.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource {
    
    var movies: [Movie] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set movie-related background image for collection view and behind the cells
        let backgroundImage = UIImage(named: "movie_bg_image")
        let backgroundImageView = UIImageView(image: backgroundImage)
        self.collectionView.backgroundView = backgroundImageView
        
        // Create a URL for the request
        // In this case, the custom search URL you created in in part 1
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=3f1eed3a3310a2d9d908001898d4b5b9&language=en-US&page=2")!

        // Use the URL to instantiate a request
        let request = URLRequest(url: url)

        // Create a URLSession using a shared instance and call its dataTask method
        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            
            do {
                // Create a JSON Decoder
                let decoder = JSONDecoder()
                
                // Use the JSON decoder to try and map the data to our custom model.
                // MoviesResponse.self is a reference to the type itself, tells the decoder what to map to.
                let response = try decoder.decode(MoviesResponse.self, from: data)
                
                // Access the array of tracks from the `results` property
                let movies = response.results
                
                // Execute UI updates on the main thread when calling from a background callback
                DispatchQueue.main.async {

                    // Set the view controller's tracks property as this is the one the table view references
                    self?.movies = movies

                    // Make the table view reload now that we have new data
                    self?.collectionView.reloadData()
                }
                print("✅ \(movies)")
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        // Initiate the network request
        task.resume()
        
        // view.addSubview(collectionView)
        collectionView.dataSource = self

        // Get a reference to the collection view's layout
        // We want to dynamically size the cells for the available space and desired number of columns.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        layout.minimumInteritemSpacing = 2

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        layout.minimumLineSpacing = 3

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width * 4 / 3)
        
        // Assign Movie objects into movies array (hardcoded data)
        // movies = Movie.mockMovies
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the cell that triggered the segue
        if let cell = sender as? UICollectionViewCell,
           
            // Get the index path of the cell from the collection view
            let indexPath = collectionView.indexPath(for: cell),
           
            // Get the detail view controller
            let detailViewController = segue.destination as? DetailViewController {

            // Use the index path to get the associated track
            let movie = movies[indexPath.row]

            // Set the track on the detail view controller
            detailViewController.movie = movie
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // the number of items shown should be the number of movies we have.
            movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let posterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
            // Get the track that corresponds to the table view row
            let movie = movies[indexPath.row]
            // Configure the cell with its associated track
            posterCell.configure(with: URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + movie.poster_path)!)
            
            cell = posterCell
        }
        
        return cell
    }

}
