//
//  BeaconCollectionViewCell.swift
//  RayBroadcast
//
//  Created by Sean Ooi on 7/3/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

import UIKit

class BeaconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var beaconImageView: UIImageView!
    
    @IBOutlet weak private var majorLabel: UILabel!
    @IBOutlet weak private var minorLabel: UILabel!
    @IBOutlet weak private var regionLabel: UILabel!
    
    @IBOutlet weak var majorValueLabel: UILabel!
    @IBOutlet weak var minorValueLabel: UILabel!
    @IBOutlet weak var regionValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
        beaconImageView.contentMode = .ScaleAspectFit
        
        majorLabel.text = "Major:"
        majorLabel.font = UIFont.boldSystemFontOfSize(16)
        minorLabel.text = "Minor:"
        minorLabel.font = UIFont.boldSystemFontOfSize(16)
        regionLabel.text = "Region:"
        regionLabel.font = UIFont.boldSystemFontOfSize(16)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        beaconImageView.image = UIImage(named: "Beacon")
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.6
        layer.cornerRadius = 4
        clipsToBounds = false
    }
    
}
