//
//  BluetoothManager.swift
//  Lightron
//
//  Created by Derrick Ding on 3/12/23.
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject {
    
    var centralManager = CBCentralManager()
    var bluefruitPeripheral: CBPeripheral?
    var txCharacteristic: CBCharacteristic!
    var rxCharacteristic: CBCharacteristic!
    
    @Published var rssi = NSNumber(integerLiteral: 0)
    @Published var peripheralName = ""
    
    override init() {
        super.init()
        
        self.centralManager.delegate = self
    }
    
    func startScanning() -> Void {
        // Start scanning
        centralManager.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID])
    }
    
    func disconnectFromDevice() -> Void {
        if bluefruitPeripheral != nil {
            centralManager.cancelPeripheralConnection(bluefruitPeripheral!)
        }
    }
    
    // Writes value to be sent to the peripheral
    func writeOutgoingValue(data: String){
        
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        
        if let bluefruitPeripheral = bluefruitPeripheral {
            
            if let txCharacteristic = txCharacteristic {
                
                bluefruitPeripheral.writeValue(
                    valueString!,
                    for: txCharacteristic,
                    type: CBCharacteristicWriteType.withResponse
                )
            }
        }
    }
}

// scan, discover and connect a peripheral.
extension BluetoothManager: CBCentralManagerDelegate {
    // calls this function when its state updates
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("Is Powered Off.")
        case .poweredOn:
            print("Is Powered On.")
            // Scan as soon as the app opens
            startScanning()
        case .unsupported:
            print("Is Unsupported.")
        case .unauthorized:
            print("Is Unauthorized.")
        case .unknown:
            print("Unknown")
        case .resetting:
            print("Resetting")
        @unknown default:
            print("Error")
        }
    }
    
    // assigns peripheral variable, connects to the peripheral and stops the scan when a peripheral is discovered
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        bluefruitPeripheral = peripheral
        
        bluefruitPeripheral!.delegate = self
        
        print("Peripheral Discovered: \(peripheral)")
        print("Peripheral name: \(peripheral.name ?? "unknown")")
        print ("Advertisement Data : \(advertisementData)")
        
        centralManager.connect(bluefruitPeripheral!, options: nil)
        
        self.peripheralName = peripheral.name ?? ""
        
        
//        centralManager.stopScan()
        
    }
    
    // discover a service that the peripheral is holding after the peripheral is connected to the central manager
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        bluefruitPeripheral!.discoverServices([CBUUIDs.BLEService_UUID])
        
        // Will invoke didReadRSSI below
        peripheral.readRSSI()
    }
}

// Provides updates on the use of a peripheral's services
extension BluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        self.rssi = RSSI
    }
    
    // discover characteristics after peripheral's services are discovered
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("*******************************************************")
        
        if ((error) != nil) {
            print("Error discovering services: \(error!.localizedDescription)")
            return
        }
        
        guard let services = peripheral.services else {
            return
        }
        
        // We need to discover the all characteristic
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
        print("Discovered Services: \(services)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            return
        }
        
        print("Found \(characteristics.count) characteristics.")
        
        for characteristic in characteristics {
            
            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Rx)  {
                
                rxCharacteristic = characteristic
                
                peripheral.setNotifyValue(true, for: rxCharacteristic!)
                peripheral.readValue(for: characteristic)
                
                print("RX Characteristic: \(rxCharacteristic.uuid)")
            }
            
            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Tx){
                
                txCharacteristic = characteristic
                
                print("TX Characteristic: \(txCharacteristic.uuid)")
            }
        }
    }
    
    // Invoked once receiving incoming values from a Bluetooth device
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        var characteristicASCIIValue = NSString()

        guard characteristic == rxCharacteristic,

        let characteristicValue = characteristic.value,
        let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }

        characteristicASCIIValue = ASCIIstring

        print("Value Received: \((characteristicASCIIValue as String))")
    }
    
}

extension BluetoothManager: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print("Peripheral Is Powered On.")
        case .unsupported:
            print("Peripheral Is Unsupported.")
        case .unauthorized:
            print("Peripheral Is Unauthorized.")
        case .unknown:
            print("Peripheral Unknown")
        case .resetting:
            print("Peripheral Resetting")
        case .poweredOff:
            print("Peripheral Is Powered Off.")
        @unknown default:
            print("Error")
        }
    }
    
    
}
