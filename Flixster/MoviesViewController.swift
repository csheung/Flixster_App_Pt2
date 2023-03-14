//
//  ViewController.swift
//  Flixster
//
//  Created by Derrick Ng on 3/3/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var movies: [Movie] = []
    var similarMovieId: Int!
    var apiKey: String = "3f1eed3a3310a2d9d908001898d4b5b9"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default background color at the back of MovieCell
        tableView.backgroundColor = UIColor(red: 32/255, green: 115/255, blue: 152/255, alpha: 1.0)
        
        // Set movie-related background image for table view and behind the cells
        let backgroundImage = UIImage(named: "movie_bg_image")
        let backgroundImageView = UIImageView(image: backgroundImage)
        tableView.backgroundView = backgroundImageView
        
        // Assign Movie objects into movies array
        // movies = Movie.mockMovies
        
        // Create a URL for the request
        // In this case, the custom search URL you created in in part 1
        let url = similarMovieId != nil ? URL(string: "https://api.themoviedb.org/3/movie/\(similarMovieId!)/similar?api_key=\(apiKey)&language=en-US&page=1")! : URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=2")!
        print(url)
        // Use the URL to instantiate a request
        let request = URLRequest(url: url)

        // Create a URLSession using a shared instance and call its dataTask method
        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
        // When finished, it calls its completion handler (closure) passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if the request was unsuccessful)
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
                    self?.tableView.reloadData()
                }
                print("✅ \(movies)")
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        // Initiate the network request
        task.resume()

        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the cell that triggered the segue
        if let cell = sender as? UITableViewCell,
            // Get the index path of the cell from the table view
            let indexPath = tableView.indexPath(for: cell),
            // Get the detail view controller
            let detailViewController = segue.destination as? DetailViewController {

            // Use the index path to get the associated track
            let movie = movies[indexPath.row]

            // Set the track on the detail view controller
            detailViewController.movie = movie
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {

            // Deselect the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell with identifier, "MovieCell"
        // `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        // Get the track that corresponds to the table view row
        let movie = movies[indexPath.row]
        
        // set the background color as black
        cell.backgroundColor = UIColor.black
        
        // Configure the cell with its associated movie
        cell.configure(with: movie)
        
        // return the cell for display in the table view
        return cell
    }

}

/**
 TMDB API Key
 API Key (v3 auth)
 3f1eed3a3310a2d9d908001898d4b5b9
 API Request Example
 https://api.themoviedb.org/3/movie/550?api_key=3f1eed3a3310a2d9d908001898d4b5b9
 API Read Authorization (v4 auth)
 eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZjFlZWQzYTMzMTBhMmQ5ZDkwODAwMTg5OGQ0YjViOSIsInN1YiI6IjYzNjk2ZmI3OWYxYmU3MDA3ZWM4ZWI4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4-pQOaAuKP2s2eSaJ3hJz0BeycB5f79n3tLvOMerCFo
 
 Your request for an API key has been approved. You can start using this key immediately.

 API Key: 3f1eed3a3310a2d9d908001898d4b5b9

 Here's an example API request:
 https://api.themoviedb.org/3/movie/550?api_key=3f1eed3a3310a2d9d908001898d4b5b9
 
 Useful Links
 Documentation: https://developers.themoviedb.org/3/getting-started/introduction
 Support forum: https://www.themoviedb.org/talk/category/5047958519c29526b50017d6
 Wrappers & libraries: https://www.themoviedb.org/documentation/api/wrappers-libraries
 Service status: https://status.themoviedb.org
 */

