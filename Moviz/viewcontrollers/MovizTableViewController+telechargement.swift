//
//  MovizTableViewController+telechargement.swift
//  Moviz
//
//  Created by Yassine on 26/04/2018.
//  Copyright © 2018 Yassine. All rights reserved.
//

import UIKit


extension MovizTableViewController {
    
    func telechargerMovies(url: String, completion: @escaping (_ liste:[Movie])->()) {
        
        var moviz:[Movie] = []
        telecharger(url) { (resultats, resultat) in
            for resultat in resultats {
                //print("- \(resultat["title"] as! String)")
                
                let id = resultat["id"] as! Int
                let titre = resultat["title"] as! String
                let synopsis = resultat["overview"] as! String
                let dateSortie = resultat["release_date"] as! String
                let posterStr = "https://image.tmdb.org/t/p/w342\(resultat["poster_path"] as! String)"
                
                let movieUrl = "https://api.themoviedb.org/3/movie/\(id)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
                
                var imdbStr:String?
                
                self.telechargerDetailsMovie(movieDetailsUrlString: movieUrl, completion: { (imdbString) in
                    imdbStr = imdbString
                    let movie = Movie(id: id, titre: titre, synopsis: synopsis, poster: posterStr, date: dateSortie)
                    moviz.append(movie)
                    movie.imdbID = imdbStr!
                    //print(movie.imdbID)
                     completion(moviz)
                })

                //print(posterStr)
                
            }
            
           
            
        }
    }
    
    func telechargerImage(posterStr:String, completion:@escaping (_ imageData:Data)->()) {
        
        requeteDonnees(stringUrl: posterStr) { (data, response) in
            DispatchQueue.main.async {
                completion(data)
            }
        }
        
    }
    
    func telechargerDetailsMovie(movieDetailsUrlString:String, completion:@escaping (_ str:String)->()){
        
        var imdb:String?
        
        telecharger(movieDetailsUrlString) { (reultats, resultat) in
            print(resultat["imdb_id"] as! String)
            imdb = resultat["imdb_id"] as? String
            DispatchQueue.main.async {
                completion(imdb!)
            }
        }

    }
    
    func telecharger(_ url:String, completion:@escaping (_ dictionnaires:[Dictionary<String, Any>], _ dictonnaire:Dictionary<String, Any> )->()) {
        
        var results:[Dictionary<String, Any>] = []
        var result:Dictionary<String, Any> = [:]
        
        requeteDonnees(stringUrl: url) { (data, response) in
            
            if let jsonDictionnaire = try! JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any> {
                
                if  let resultats = jsonDictionnaire["results"] as? [Dictionary<String, Any>]{
                    results = resultats
                }
                if let resultat = jsonDictionnaire as? Dictionary<String, Any> {
                    result = resultat
                }
                
                DispatchQueue.main.async {
                    completion(results,result)
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
