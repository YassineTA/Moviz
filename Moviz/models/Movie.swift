//
//  Movie.swift
//  Moviz
//
//  Created by Yassine on 22/04/2018.
//  Copyright © 2018 Yassine. All rights reserved.
//

import Foundation

class Movie {
    
    let id:Int
    let titre:String
    let synopsis:String
    let posterStr:String
    let dateStr:String?
    var imdbID:String = ""
    
    init(id:Int, titre:String, synopsis:String, poster:String, date:String) {
        self.id = id
        self.titre = titre
        self.synopsis = synopsis
        self.posterStr = poster
        self.dateStr = date
        
    }
    
}
