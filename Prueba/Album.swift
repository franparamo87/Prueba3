//
//  Album.swift
//  Prueba
//
//  Created by Francisco Paramo Muñoz on 23/12/17.
//  Copyright © 2017 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class Album: NSObject {
    var id = ""
    var id_artist = ""
    var name = ""
    var year = ""
    var imageUrl = ""
    var image : UIImage?
    
    
    
    func initWithDic(dic : Dictionary<String, Any>) -> Album{
        
        id = "\(dic["collectionId"]!)"
        id_artist = "\(dic["artistId"]!)"
        name = "\(dic["collectionName"]!)"
        year = "\(dic["releaseDate"]!)"
        if dic["artworkUrl100"] != nil {
            imageUrl = dic["artworkUrl100"] as! String
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let newDate = dateFormatter.date(from: year)
        dateFormatter.dateFormat = "yyyy"
        if let newDate  = newDate{
            let dateStr = dateFormatter.string(from: newDate)
            year = dateStr
        }
        
        return self
        
    }
}
