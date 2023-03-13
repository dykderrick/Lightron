//
//  ContentView.swift
//  Lightron
//
//  Created by Derrick Ding on 3/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    @ObservedObject var trainingManager: TrainingManager
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            
            Header()
            
            PeripheralInfoView(bluetoothManager: bluetoothManager)
            
            TrainingItemView(trainingItemName: "Cross", trainingManager: trainingManager, bluetoothManager: bluetoothManager, trainingType: .Cross)
            
            TrainingItemView(trainingItemName: "Swing", trainingManager: trainingManager, bluetoothManager: bluetoothManager, trainingType: .Swing)
            
            TrainingItemView(trainingItemName: "Hook", trainingManager: trainingManager, bluetoothManager: bluetoothManager, trainingType: .Hook)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let bluetoothManager = BluetoothManager()
        let trainingManager = TrainingManager()
        
        ContentView(
            bluetoothManager: bluetoothManager,
            trainingManager: trainingManager
        )
    }
}
