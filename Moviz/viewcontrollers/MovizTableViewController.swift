//
//  MovizTableViewController.swift
//  Moviz
//
//  Created by Yassine on 21/04/2018.
//  Copyright © 2018 Yassine. All rights reserved.
//

import UIKit

class MovizTableViewController: UITableViewController {
    
    var movies:[Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Moviz"
        //telecharger()
        let urlMoviz = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        telechargerMovies(url: urlMoviz) { (movies) in
            self.movies = movies
            self.tableView.reloadData()
        }
      
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovizTableViewCell

        // Configure the cell...
        
        let movie = movies[indexPath.row]
        cell.movieTitreLabel.text = movie.titre
        cell.movieDateLabel.text = movie.dateStr
        cell.movieSynopsisLabel.text = movie.synopsis.tronquerString()
        
        telechargerImage(posterStr: movie.posterStr) { (data) in
            cell.movieImageView.image = UIImage(data:data)
        }
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieVC = segue.destination as! MovieViewController
        let indexPath = tableView.indexPathForSelectedRow
        let movie = movies[indexPath!.row] 
        movieVC.movieSelectionne = movie
    }


}
// extensions
extension String {
    func tronquerString() -> String {
        if self.characters.count > 100 {
            let charCount = self.characters.count
            return "\(String(self.dropLast(charCount - 100))) ..."
    }else {
            return self
        }
        
    }//func
}


