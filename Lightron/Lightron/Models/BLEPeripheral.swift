//
//  BLEPeripheral.swift
//  Lightron
//
//  Created by Derrick Ding on 3/13/23.
//

import Foundation
import CoreBluetooth

class BLEPeripheral {
    static var connectedPeripheral: CBPeripheral?
    static var connectedService: CBService?
    static var connectedTXChar: CBCharacteristic?
    static var connectedRXChar: CBCharacteristic?
}
