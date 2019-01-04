//
//  ConnectArtists.swift
//  Prueba
//
//  Created by Francisco Paramo Muñoz on 23/12/17.
//  Copyright © 2017 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class ConnectArtists: ConnectBase {
    
    var artists = [Artist]()
    
    func getArtists(word : String) {
        let word = word.URLEncodedString()
        identifier = "artists"
        if word == "" {
            super.callWebService(strService: "search?media=music&entity=musicArtist&limit=25", params: nil)
        }else{
            super.callWebService(strService: "search?term=\(word!)&media=music&entity=musicArtist&limit=25", params: nil)
        }
    }
    
    override func processJSONResponse(json: Any) {
        let dicJson = json as! Dictionary<String, Any>
        
        switch identifier {
        case "artists":
            artists = [Artist]()
            let arr = dicJson["results"] as! [Dictionary<String, Any>]
            for artist in arr {
                let art = Artist().initWithDic(dic: artist)
                artists.append(art)
            }
            if self.delegate != nil {
                self.delegate?.handleResult(isOk: true, service: self.identifier, error: nil)
            }
            break
        default:
            break
        }
    }
}
