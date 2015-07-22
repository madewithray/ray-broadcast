//
//  ViewControllerExtension.swift
//  RayBroadcast
//
//  Created by Sean Ooi on 7/2/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        /*
        * 2 cells per row
        * Cell padding of `sectionInset` (left, middle, right)
        */
        let width = (collectionView.frame.width - (sectionInset * 2))
        let height = max(132, width / 3)
        
        return CGSize(width: width, height: height)
    }
    
}