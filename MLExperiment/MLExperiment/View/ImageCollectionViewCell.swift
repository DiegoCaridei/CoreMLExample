//
//  ImageCollectionViewCell.swift
//  MLExperiment
//
//  Created by Diego Caridei on 11/10/17.
//  Copyright © 2017 Diego Caridei. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imagViewBackGroundCell: UIImageView!
  
  func configureCell(_ backGroundImage:UIImage){
    imagViewBackGroundCell.image = backGroundImage
  }
}
