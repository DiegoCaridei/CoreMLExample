//
//  GridFlowLayout.swift
//  MLExperiment
//
//  Created by Diego Caridei on 11/10/17.
//  Copyright © 2017 Diego Caridei. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
  
  override init() {
    super.init()
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }
  
  func setup() {
    minimumLineSpacing      = 1.0
    minimumInteritemSpacing = 1.0
    scrollDirection         = .vertical
  }
  
  override var itemSize: CGSize{
    set {}
    get {
      let numberOfColumns : CGFloat = 3
      var itemWidth = CGFloat()
      if let collectionViewWidth = self.collectionView?.frame.width {
         itemWidth = (collectionViewWidth - (numberOfColumns - 1)) / numberOfColumns
      }
      return CGSize (width: itemWidth, height: itemWidth)
    }
  }
}
