//
//  Movie.swift
//  Flixster
//
//  Created by Derrick Ng on 3/3/23.
//

import Foundation

// Create a MoviesResponse Struct
struct MoviesResponse: Decodable {
    let results: [Movie]
}

// TODO: Create a Movie model struct
struct Movie: Decodable {
    
//    enum CodingKeys: String, CodingKey {
//        case movieTitle = "original_title"
//        case movieOverview = "overview"
//        case posterPath = "poster_path"
//        // Detail properties
//        case backdropPath = "backdrop_path"
//        case releaseDate = "release_date"
//        case popularity
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
    
    let id: Int // add id to use API to find similar movies
    let original_title: String
    let overview: String
    let poster_path: String
    // Detail properties
    let backdrop_path: String
    // let release_date: Date
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
}

// TODO: Create an extension with a mock movies static var
extension Movie {

    /// An array of mock movies for hardcoded data
//    static var mockMovies: [Movie] = [
//        Movie(movieTitle: "Knock at the Cabin", movieOverview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", posterPath: URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg")!, backdropPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/22z44LPkMyf5nyyXvv8qQLsbom.jpg")!, releaseDate: Date(), popularity: 4112.616, voteAverage: 6.5, voteCount: 670),
//        Movie(movieTitle: "Black Panther: Wakanda Forever", movieOverview: "Queen Ramonda, Shuri, M’Baku, Okoye and the Dora Milaje fight to protect their nation from intervening world powers in the wake of King T’Challa’s death.  As the Wakandans strive to embrace their next chapter, the heroes must band together with the help of War Dog Nakia and Everett Ross and forge a new path for the kingdom of Wakanda.", posterPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/sv1xJUazXeYqALzczSZ3O6nkH75.jpg")!, backdropPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/xDMIl84Qo5Tsu62c9DGWhmPI67A.jpg")!, releaseDate: Date(), popularity: 2678.485, voteAverage: 7.4, voteCount: 3708),
//        Movie(movieTitle: "Puss in Boots: The Last Wish", movieOverview: "Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.", posterPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/kuf6dutpsT0vSVehic3EZIqkOBt.jpg")!, backdropPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/b1Y8SUb12gPHCSSSNlbX4nB3IKy.jpg")!, releaseDate: Date(), popularity: 2311.833, voteAverage: 8.4, voteCount: 4159),
//        Movie(movieTitle: "Plane", movieOverview: "After a heroic job of successfully landing his storm-damaged aircraft in a war zone, a fearless pilot finds himself between the agendas of multiple militias planning to take the plane and its passengers hostage.", posterPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qi9r5xBgcc9KTxlOLjssEbDgO0J.jpg")!, backdropPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/9Rq14Eyrf7Tu1xk0Pl7VcNbNh1n.jpg")!, releaseDate: Date(), popularity: 2001.922, voteAverage: 6.9, voteCount: 717),
//        Movie(movieTitle: "Little Dixie", movieOverview: "Erstwhile Special Forces operative Doc Alexander is asked to broker a truce with the Mexican drug cartel in secrecy. When Oklahoma Governor Richard Jeffs celebrates the execution of a high-ranking cartel member on TV, his Chief of Staff and Doc inform him about the peace he just ended. But it’s too late, as Cuco, the cartel’s hatchet man, has set his vengeful sights on Doc’s daughter Dixie.", posterPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/cmWTZj9zzT9KFt3XyL0gssL7Ig8.jpg")!, backdropPath: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/k4V6EvpcOsu8CX10JD0H53lFXLq.jpg")!, releaseDate: Date(), popularity: 1538.518, voteAverage: 6.2, voteCount: 33)
//    ]

}
