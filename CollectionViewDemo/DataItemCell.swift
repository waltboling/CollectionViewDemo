//
//  DataItemCell.swift
//  CollectionViewDemo
//
//  Created by Jon Boling on 3/13/18.
//  Copyright © 2018 Walt Boling. All rights reserved.
//

import UIKit

class DataItemCell: UICollectionViewCell {
    @IBOutlet private weak var dataItemImageView: UIImageView!
    
    var dataItem: DataItem? {
        didSet {
            if let dataItem = dataItem {
                dataItemImageView.image = UIImage(named: dataItem.imageName)
            }
        }
    }
    
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = 3.0
            self.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.clear.cgColor
        }
    }
    
}
