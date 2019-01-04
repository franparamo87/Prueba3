//
//  Artist.swift
//  Prueba
//
//  Created by Francisco Paramo Muñoz on 23/12/17.
//  Copyright © 2017 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class Artist: NSObject {
    var id = ""
    var name = ""
    var genre = ""
    var albums = [Album]()
    
    
    
    func initWithDic(dic : Dictionary<String, Any>) -> Artist{
        
        id = "\(dic["artistId"]!)"
        name = "\(dic["artistName"]!)"
        genre = "\(dic["primaryGenreName"]!)"
        
        return self
        
    }
}
