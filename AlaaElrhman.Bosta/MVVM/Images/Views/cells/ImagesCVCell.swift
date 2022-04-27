//
//  ImagesCVCell.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import UIKit
import Kingfisher

class ImagesCVCell: UICollectionViewCell {

    @IBOutlet weak var imageImgView: UIImageView!
    
    static let cellID = "ImagesCVCell"
    
    var image:ImagesResponseElement?{
        didSet{
            if let url = URL(string: image?.url ?? ""){
                self.imageImgView.kf.indicatorType = .activity
                self.imageImgView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageImgView.layer.masksToBounds = true
    }
}
