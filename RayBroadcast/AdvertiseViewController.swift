//
//  AdvertiseViewController.swift
//  RayBroadcast
//
//  Created by Sean Ooi on 7/3/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class AdvertiseViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var majorValueLabel: UILabel!
    @IBOutlet weak var minorValueLabel: UILabel!
    @IBOutlet weak var regionValueLabel: UILabel!
    
    @IBOutlet weak var dotImageView: UIImageView!
    
    var beacon: [String: AnyObject]?
    var pulseEffect: LFTPulseAnimation! = nil
    var peripheralManager: CBPeripheralManager! = nil
    var peripheralState = "Unknown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Advertise"
        descriptionLabel.text = "Advertising beacon data:"
        
        majorLabel.text = "Major:"
        majorLabel.font = UIFont.boldSystemFontOfSize(16)
        minorLabel.text = "Minor:"
        minorLabel.font = UIFont.boldSystemFontOfSize(16)
        regionLabel.text = "Region:"
        regionLabel.font = UIFont.boldSystemFontOfSize(16)
        
        if let beacon = beacon {
            majorValueLabel.text = String(beacon["major"] as? Int ?? 0)
            minorValueLabel.text = String(beacon["minor"] as? Int ?? 0)
            regionValueLabel.text = beacon["identifier"] as? String ?? "No Identifier"
        }
        
        dotImageView.contentMode = .ScaleAspectFit
        dotImageView.image = UIImage(named: "Dot")
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        advertise()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        peripheralManager.stopAdvertising()
    }
    
    deinit {
        peripheralManager = nil
        
        if pulseEffect != nil {
            pulseEffect.removeFromSuperlayer()
            pulseEffect = nil
        }
        
        println("deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func advertise() {
        if peripheralManager.state == .PoweredOn {
            if peripheralManager.isAdvertising {
                peripheralManager.stopAdvertising()
                
                if pulseEffect != nil {
                    pulseEffect.removeFromSuperlayer()
                    pulseEffect = nil
                }
            }
            else {
                if let
                    beacon = beacon,
                    uuid = beacon["uuid"] as? String,
                    major = beacon["major"] as? Int,
                    minor = beacon["minor"] as? Int,
                    identifier = beacon["identifier"] as? String
                {
                    
                    let beaconRegion = CLBeaconRegion(
                        proximityUUID: NSUUID(UUIDString: uuid),
                        major: UInt16(major),
                        minor: UInt16(minor),
                        identifier: identifier)
                    
                    let manufacturerData = identifier.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                    
                    var beaconData = beaconRegion.peripheralDataWithMeasuredPower(1) as [NSObject : AnyObject]
                    beaconData[CBAdvertisementDataLocalNameKey] = "Ray Beacon"
                    beaconData[CBAdvertisementDataTxPowerLevelKey] = -12
                    beaconData[CBAdvertisementDataManufacturerDataKey] = manufacturerData
                    beaconData[CBAdvertisementDataServiceUUIDsKey] = [CBUUID(NSUUID: NSUUID(UUIDString: uuid))]
                    
                    peripheralManager.startAdvertising(beaconData)
                    
                    if pulseEffect == nil {
                        pulseEffect = LFTPulseAnimation(repeatCount: Float.infinity, radius: 100, position: dotImageView.center)
                        view.layer.insertSublayer(pulseEffect, below: dotImageView.layer)
                    }
                }
            }
        }
        else {
            let alertController = UIAlertController(title: "Bluetooth Error", message: peripheralState, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {[unowned self] (action) -> Void in
                if let navigationController = self.navigationController {
                    navigationController.popViewControllerAnimated(true)
                }
            })
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }

}
