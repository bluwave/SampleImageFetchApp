//
//  SearchImageCollectionViewCell.swift
//  SampleA
//
//  Created by Garrett Richards on 12/16/16.
//  Copyright © 2016 Acme. All rights reserved.
//

import UIKit
import SDWebImage

class SearchImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var searchImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupImage(image: SearchAPIImage) {
        searchImage?.contentMode = .scaleAspectFill
        print("image: url: \(image.flickrURL())")
        searchImage?.sd_setImage(with: image.flickrURL())
    }

}
