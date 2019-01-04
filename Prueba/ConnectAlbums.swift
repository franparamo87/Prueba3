//
//  ConnectAlbums.swift
//  Prueba
//
//  Created by Francisco Paramo Muñoz on 23/12/17.
//  Copyright © 2017 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class ConnectAlbums: ConnectBase {
    
    var albums = [Album]()
    
    func getAlbums(id : String) {
        identifier = "albums"
        super.callWebService(strService: "lookup?id=\(id)&entity=album", params: nil)
    }
    
    override func processJSONResponse(json: Any) {
        let dicJson = json as! Dictionary<String, Any>
        
        switch identifier {
        case "albums":
            albums = [Album]()
            var arr = dicJson["results"] as! [Dictionary<String, Any>]
            arr.remove(at: 0)
            for album in arr {
                let alb = Album().initWithDic(dic: album)
                albums.append(alb)
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
