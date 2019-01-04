//
//  ConnectBase.swift
//  Prueba
//
//  Created by Francisco Paramo Muñoz on 23/12/17.
//  Copyright © 2017 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit
import Alamofire

protocol ConnectBaseDelegate {
    func startService(service:String)
    func handleResult(isOk:Bool, service:String, error:Any?)
}

class ConnectBase: NSObject {
    var baseUrl = "https://itunes.apple.com/"
    var identifier : String = ""
    var delegate : ConnectBaseDelegate?
    
    let sessionManager = SessionManager()
    
    func cancelAllRequest(){
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({$0.cancel()})
        }
    }
    
    func callWebService(strService : String, params : Dictionary<String,Any>?){
        //let url = baseUrl + strService
        //print("URL: " + url)
        //print("Params:")
        //print(params ?? "vacio")
        
        
        if self.delegate != nil {
            self.delegate?.startService(service: self.identifier)
        }
        
        
        sessionManager.request("\(baseUrl)\(strService)", headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let dicJson = response.result.value as! Dictionary<String, Any>
                    self.processJSONResponse(json: dicJson)
                case .failure(let error):
                    if self.delegate != nil {
                        self.delegate?.handleResult(isOk: false, service: self.identifier, error: error)
                    }
                }
                
        }
    }
    
    func processJSONResponse(json : Any){
        
    }
}

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        self.image = UIImage(named: "no_music")
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}

extension String{
    func URLEncodedString() -> String? {
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return escapedString
    }
    static func queryStringFromParameters(parameters: Dictionary<String,String>) -> String? {
        if (parameters.count == 0)
        {
            return nil
        }
        var queryString : String? = nil
        for (key, value) in parameters {
            if let encodedKey = key.URLEncodedString() {
                if let encodedValue = value.URLEncodedString(){
                    if queryString == nil
                    {
                        queryString = "?"
                    }
                    else
                    {
                        queryString! += "&"
                    }
                    queryString! += encodedKey + "=" + encodedValue
                }
            }
        }
        return queryString
    }
}
