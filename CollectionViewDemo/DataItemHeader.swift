//
//  DataItemHeaderCollectionReusableView.swift
//  CollectionViewDemo
//
//  Created by Jon Boling on 3/13/18.
//  Copyright © 2018 Walt Boling. All rights reserved.
//

import UIKit

class DataItemHeader: UICollectionReusableView {
    @IBOutlet private weak var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
        
}
