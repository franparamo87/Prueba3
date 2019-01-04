//
//  DetailsViewController.swift
//  Prueba
//
//  Created by Francisco Paramo Muñoz on 23/12/17.
//  Copyright © 2017 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    var artist : Artist?
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title=artist?.name
        let nib = UINib(nibName: "ListAlbumCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "albumCell")
        tableview.dataSource=self
        tableview.rowHeight = 80
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (artist?.albums.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! ListAlbumCell
        let album = artist?.albums[indexPath.row]
        cell.title.text = album?.name
        cell.year.text = album?.year
        if album?.imageUrl != "" {
            cell.icon.loadImageUsingCache(withUrl: (album?.imageUrl)!)
        }
        return cell
    }
}
