//
//  ViewController.swift
//  AsyncTesting
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let movieView = MovieView()
    var movies = [Movie]() {
        didSet {
            self.movieView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(movieView)
        movieView.tableView.dataSource = self
        loadMovies()
    }

    func loadMovies() {
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
               let mvs = try decoder.decode(MovieSearch.self, from: data)
                
              self.movies = mvs.results.filter({$0.contentAdvisoryRating == "Unrated"})
                } catch {
                    print("decoding error: \(error)")
                }
            }
            if let error = error {
                print("Error getting data: \(error)")
            }
        }
    }


}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        cell.textLabel?.text = self.movies[indexPath.row].trackName
        cell.detailTextLabel?.text = self.movies[indexPath.row].contentAdvisoryRating
        let imageUrl = self.movies[indexPath.row].artworkUrl100

        
        ImageAPIClient.manager.getImages(from: imageUrl) { (image, error) in
            if let error = error {
                print("error loading images: \(error)")
            }
            if let image = image {
                cell.imageView?.image = image
            }
        }
        
        return cell
    }
}

