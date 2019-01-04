//
//  ViewController.swift
//  Prueba
//
//  Created by Francisco Paramo Muñoz on 23/12/17.
//  Copyright © 2017 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchText: UITextField!
    var listArtists :[Artist] = [Artist]()
    let connectArtists = ConnectArtists()
    let connectAlbums = ConnectAlbums()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lista"
        // Do any additional setup after loading the view, typically from a nib.
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 140
        tableview.delegate = self
        connectArtists.delegate = self
        connectAlbums.delegate = self
        searchText.delegate = self
        clickSearch(UIButton())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickSearch(_ sender: Any) {
        searchText.resignFirstResponder()
        listArtists = [Artist]()
        tableview.reloadData()
        connectArtists.cancelAllRequest()
        connectArtists.getArtists(word: searchText.text!)
    }
}

extension ViewController : ConnectBaseDelegate {
    func startService(service: String) {
        print("Service: " + service)
    }
    
    func handleResult(isOk: Bool, service: String, error: Any?) {
        if isOk {
            if service == "artists" {
                listArtists = connectArtists.artists
                tableview.reloadData()
                if listArtists.count == 0 {
                    let alert = UIAlertController(title: "", message: "Sin resultados", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                for artist in listArtists {
                    connectAlbums.getAlbums(id: artist.id)
                }
            }
            if service == "albums" {
                let albums = connectAlbums.albums
                if albums.count > 0 {
                    var index = 0
                    for artist in listArtists {
                        if artist.id == albums.first?.id_artist {
                            artist.albums = albums
                            tableview.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableViewRowAnimation.none)
                        }
                        index += 1
                    }
                }
            }
        }
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        clickSearch(UIButton())
        return true
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArtists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ListArtistCell
        let artist = listArtists[indexPath.row]
        let attrTitle = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 22.0)! ]
        let attrDisco = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 18.0)!, NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue ] as [String : Any]
        let attrGenre = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 16.0)! ]
        let attrAlbum = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 12.0)! ]
        let artista = NSAttributedString(string: artist.name, attributes: attrTitle)
        let genero = NSAttributedString(string: artist.genre, attributes: attrGenre)
        let texto = NSMutableAttributedString(string: "")
        texto.append(artista)
        texto.append(NSAttributedString(string: "\n"))
        texto.append(genero)
        if artist.albums.count > 0 {
            var i = 0
            for album in artist.albums {
                if i == 2 {
                    texto.append(NSAttributedString(string: "\n"))
                    texto.append(NSAttributedString(string: "..."))
                    break
                }
                if i == 0 {
                    texto.append(NSAttributedString(string: "\n\n"))
                    let title = NSAttributedString(string: "Discografía", attributes: attrDisco)
                    texto.append(title)
                }
                texto.append(NSAttributedString(string: "\n"))
                let album = NSAttributedString(string: "-\(album.name)", attributes: attrAlbum)
                texto.append(album)
                i = i + 1
            }
        }
        cell.selectionStyle = .none
        cell.Texto.attributedText = texto
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = listArtists[indexPath.row]
        if artist.albums.count == 0 {
            return
        }
        let details = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        details.artist = artist
        navigationController?.pushViewController(details, animated: true)
    }
}


