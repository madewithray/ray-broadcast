//
//  ViewController.swift
//  RayBroadcast
//
//  Created by Sean Ooi on 7/3/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    let reuseIdentifier = "Cell"
    let sectionInset: CGFloat = 16
    
    // Beacon configuration
    let beacons: [[String: AnyObject]] = [
        [
            "uuid": "6efd70cf-cfc1-4298-9db2-62257ac93b61",
            "major": 39,
            "minor": 1512,
            "identifier": "ray1"
        ],
        [
            "uuid": "6efd70cf-cfc1-4298-9db2-62257ac93b61",
            "major": 13891,
            "minor": 3443,
            "identifier": "ray2"
        ],
        [
            "uuid": "6efd70cf-cfc1-4298-9db2-62257ac93b61",
            "major": 34810,
            "minor": 8394,
            "identifier": "ray3"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Beacons"
        collectionView?.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beacons.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let beacon = beacons[indexPath.item]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BeaconCollectionViewCell
        cell.majorValueLabel.text = String(beacon["major"] as? Int ?? 0)
        cell.minorValueLabel.text = String(beacon["minor"] as? Int ?? 0)
        cell.regionValueLabel.text = beacon["identifier"] as? String ?? "No Identifier"
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedObject = beacons[indexPath.item]
        performSegueWithIdentifier("advertise", sender: selectedObject)
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "advertise" {
            let selectedBeacon = sender as! [String: AnyObject]
            let destination = segue.destinationViewController as! AdvertiseViewController
            destination.beacon = selectedBeacon
        }
    }
}
