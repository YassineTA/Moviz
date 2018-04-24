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
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)

        // Configure the cell...
        
        let movie = movies[indexPath.row]
        cell.textLabel!.text = movie.titre
        cell.detailTextLabel!.text = movie.dateStr
        telechargerImage(posterStr: movie.posterStr) { (data) in
            cell.imageView!.image = UIImage(data : data)
        }
        
        return cell
    }
    




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovizTableViewController {
    
    func telechargerMovies(url: String, completion: @escaping (_ liste:[Movie])->()) {
        
        var moviz:[Movie] = []
        telecharger(url) { (resultats) in
            for resultat in resultats {
                print("- \(resultat["title"] as! String)")
            
                let id = resultat["id"] as! Int
                let titre = resultat["title"] as! String
                let synopsis = resultat["overview"] as! String
                let dateSortie = resultat["release_date"] as! String
                let posterStr = "https://image.tmdb.org/t/p/w342\(resultat["poster_path"] as! String)"
                
                let movie = Movie(id: id, titre: titre, synopsis: synopsis, poster: posterStr, date: dateSortie)
                moviz.append(movie)
                
                print(posterStr)
                
                }
            
            completion(moviz)
        
            }
    }
    
    func telechargerImage(posterStr:String, completion:@escaping (_ imageData:Data)->()) {
        
        requeteDonnees(stringUrl: posterStr) { (data, response) in
            DispatchQueue.main.async {
                completion(data)
            }
        }
        
    }
    
    func telecharger(_ url:String, completion:@escaping (_ dictionnaires:[Dictionary<String, Any>])->()) {
        requeteDonnees(stringUrl: url) { (data, response) in
            
            if let jsonDictionnaire = try! JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any> {
                
                let resultats = jsonDictionnaire["results"] as? [Dictionary<String, Any>]
                
                DispatchQueue.main.async {
                    completion(resultats!)
                }
                
            } //if
        }
    }
    
    func requeteDonnees(stringUrl:String, completion:@escaping (_ data:Data,_ response:URLResponse)->()) {
        
        let url = URL(string:stringUrl)
        
        //requete
        let requete = URLRequest(url: url!)
        //session
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main)
        
        let task:URLSessionDataTask = session.dataTask(with: requete, completionHandler: { (data, response, error) in
            
            if error == nil {
                
                if let dataOk = data {
                    
                    completion(dataOk, response!)
                 
                        }
                        
            } else {
                    print(error!.localizedDescription)
                    print("erreur requête des données")
            }
        }) //task
        
        task.resume()
    }
}
