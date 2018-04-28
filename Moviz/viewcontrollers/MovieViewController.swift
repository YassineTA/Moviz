//
//  ViewController.swift
//  Moviz
//
//  Created by Yassine on 21/04/2018.
//  Copyright © 2018 Yassine. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var movieWebView: UIWebView!
    var movieSelectionne:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        afficherDetailsMovie()
        updateUI()
 
    }
    func updateUI(){
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.tintColor = .yellow
    }
    
    func afficherDetailsMovie(){
        let imdbUrl = "http://www.imdb.com/title/\(movieSelectionne!.imdbID)/"
        self.title =  movieSelectionne!.titre
        let url = URL(string: imdbUrl)
        let request = URLRequest(url: url!)
        print(url!)
        movieWebView.loadRequest(request)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

