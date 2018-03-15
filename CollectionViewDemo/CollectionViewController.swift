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
    var cutCopyItem: DataItem?
    
   
    @IBAction func addButtonTapped(_ sender: Any) {
    let item = DataItem(title: "New Item", kind: .Animal, imageName: "default.jpeg")
        let index = allItems[0].count
        allItems[0].append(item)
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.insertItems(at: [indexPath])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.allowsMultipleSelection = true
        self.collectionView?.allowsSelection = true
        
        
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        //added trying to get delete button - wasn't working
        /*UIMenuController.shared.menuItems = [UIMenuItem.init(title: "Delete", action: #selector(UIResponderStandardEditActions.delete(_:)))]
        
        UIMenuController.shared.setMenuVisible(true, animated: true)*/
        
        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Data Source Methods
    
    
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
    
    //trying here to move some cells around; seems like nothing below is getting called.
    // stopped here to try some other things in a new file.
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
    

 
 
    // MARK: UICollectionViewDelegate

 
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }


    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }


    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        if action.description == "copy:"{
            cutCopyItem = allItems[indexPath.section][indexPath.row]
        }
        else if action.description == "cut:"{
            cutCopyItem = allItems[indexPath.section][indexPath.row]
            allItems[indexPath.section].remove(at: indexPath.row)
            collectionView.reloadData()
        }
        else if action.description == "paste:"{
            if (cutCopyItem != nil)
            {
                allItems[indexPath.section].insert(cutCopyItem!, at: indexPath.row)
                collectionView.reloadData()
            }
        }
        else if action.description == "delete:"{
            allItems[indexPath.section].remove(at: indexPath.row)
            collectionView.reloadData()
        }
    }
}
