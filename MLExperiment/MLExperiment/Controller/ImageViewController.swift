//
//  ViewController.swift
//  MLExperiment
//
//  Created by Diego Caridei on 11/10/17.
//  Copyright © 2017 Diego Caridei. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ImageViewController: UIViewController {
  
  @IBOutlet weak var classificationLabel : UILabel!
  @IBOutlet weak var collectionView      : UICollectionView!
  
  let cellID = "imageCellID"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate   = self
    collectionView.dataSource = self
  }
}

//MARK:-COREML HELPER
extension ImageViewController {
  func makePredictionFor(_ image: UIImage)  {
    guard let model   = try? VNCoreMLModel(for:MobileNet().model) else {return}
    let request = VNCoreMLRequest(model: model, completionHandler: handleResults)
    if let img = image.cgImage {
      let handler = VNImageRequestHandler(cgImage: img, options: [:])
      do {
        try handler.perform([request])
      }catch {debugPrint("ERROR: ",error)}
    }

  }
  
  func handleResults(request: VNRequest, error: Error?){
    guard let results = request.results as? [VNClassificationObservation] else { return }
    let bestResult = results[0]
    let id         = bestResult.identifier.capitalized
    let confidence = String.init(format: "%.2f", bestResult.confidence * 100)
    classificationLabel.text = "\(id), \(confidence)%"
  }
}
//MARK:-UICollectionViewDataSource
extension ImageViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ImageCollectionViewCell
      else {return UICollectionViewCell()}
    cell.configureCell(images[indexPath.row])
    return cell
  }
}

//MARK:-UICollectionViewDelegate
extension ImageViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else {return}
    if let imageSelected = cell.imagViewBackGroundCell.image {
      makePredictionFor(imageSelected)
    }
  }
}
