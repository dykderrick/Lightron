//
//  LightronApp.swift
//  Lightron
//
//  Created by Derrick Ding on 3/12/23.
//

import SwiftUI

@main
struct LightronApp: App {
    let bluetoothManager: BluetoothManager
    let trainingManager: TrainingManager
    
    init() {
        bluetoothManager = BluetoothManager()
        trainingManager = TrainingManager()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                bluetoothManager: bluetoothManager,
                trainingManager: trainingManager
            )
        }
    }
}
