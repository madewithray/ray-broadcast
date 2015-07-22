//
//  AdvertiseViewControllerExtension.swift
//  RayBroadcast
//
//  Created by Sean Ooi on 7/3/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

import UIKit
import CoreBluetooth

extension AdvertiseViewController: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        switch peripheral.state {
        case .Unknown:
            peripheralState = "Bluetooth state Unknown"
            
        case .Resetting:
            peripheralState = "Bluetooth Resetting"
            
        case .Unsupported:
            peripheralState = "Bluetooth Unsupported"
            
        case .Unauthorized:
            peripheralState = "Bluetooth Unauthorized"
            
        case .PoweredOn:
            peripheralState = "Bluetooth PoweredOn"
            
        case .PoweredOff:
            peripheralState = "Bluetooth PoweredOff"
        }
    }
}
