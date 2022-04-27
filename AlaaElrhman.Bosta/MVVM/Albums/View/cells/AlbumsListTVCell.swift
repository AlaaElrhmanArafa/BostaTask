//
//  AlbumsListTVCell.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import UIKit

class AlbumsListTVCell: UITableViewCell {
    
    static let cellID = "AlbumsListTVCell"
    
    @IBOutlet weak var lblAlbumName: UILabel!
    
    var album:AlbumsResponseElement?{
        didSet{
            self.lblAlbumName.text = album?.title ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
