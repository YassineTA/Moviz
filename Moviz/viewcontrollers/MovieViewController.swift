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
        print(movieSelectionne!.titre)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

