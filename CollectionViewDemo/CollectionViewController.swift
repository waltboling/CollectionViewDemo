//
//  CollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Jon Boling on 3/13/18.
//  Copyright © 2018 Walt Boling. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    var plantDataItems = [DataItem]()
    var animalDataItems = [DataItem]()
    var allItems = [[DataItem]]()
   
    @IBAction func addButtonTapped(_ sender: Any) {
    let item = DataItem(title: "New Item", kind: .Animal, imageName: "default.jpeg")
        let index = allItems[0].count
        allItems[0].append(item)
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.insertItems(at: [indexPath])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.allowsSelection = true
        
        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        for i in 1...12 {
            if i > 9 {
                plantDataItems.append(DataItem(title: "Title #\(i)", kind: Kind.Plant, imageName: "img\(i).jpg"))
            } else {
                plantDataItems.append(DataItem(title: "Title #0\(i)", kind: Kind.Plant, imageName: "img0\(i).jpg"))
            }
        }
        
        for i in 1...12 {
            if i > 9 {
                animalDataItems.append(DataItem(title: "Another Title #\(i)", kind: Kind.Animal, imageName: "anim\(i).jpg"))
            } else {
                animalDataItems.append(DataItem(title: "Another Title #0\(i)", kind: Kind.Animal, imageName: "anim0\(i).jpg"))
            }
        }
        
        allItems.append(plantDataItems)
        allItems.append(animalDataItems)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItems[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DataItemCell
        let dataItem = allItems[indexPath.section][indexPath.item]
        cell.dataItem = dataItem
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! DataItemHeader
        var title = ""
        if let kind = Kind(rawValue: indexPath.section) {
            title = kind.description()
        }
        sectionHeader.title = title
        
        return sectionHeader
    }
    
    //moving items
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
            return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = allItems[sourceIndexPath.section][sourceIndexPath.row]
        
        allItems[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        if sourceIndexPath.section == destinationIndexPath.section {
            allItems[sourceIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
        } else {
            allItems[destinationIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
        }
    }
    
    //deleting items
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let questionController = UIAlertController(title: "Delete Cell?", message: nil, preferredStyle: .alert)
        questionController.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            (action:UIAlertAction) -> Void in
            self.allItems[indexPath.section].remove(at: indexPath.row)
            self.collectionView!.deleteItems(at: [indexPath])
            self.collectionView!.reloadData()
        }))
        
        questionController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(questionController, animated: true, completion: nil)
    }
}
