//
//  ListAlbumCell.swift
//  Prueba
//
//  Created by Francisco Paramo Muñoz on 23/12/17.
//  Copyright © 2017 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class ListAlbumCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
