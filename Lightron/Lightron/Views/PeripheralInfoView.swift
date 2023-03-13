//
//  PeripheralInfoView.swift
//  Lightron
//
//  Created by Derrick Ding on 3/13/23.
//

import SwiftUI

struct PeripheralInfoView: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Connected Bluetooth: ")
                        .font(.custom("Gotham Rounded Bold", size: 18))
                    Text(bluetoothManager.peripheralName)
                        .font(.custom("Gotham Rounded Book", size: 18))
                }
                
                Spacer()
                    .frame(height: 15)
                
                HStack {
                    Text("RSSI: ")
                        .font(.custom("Gotham Rounded Bold", size: 18))
                    Text(bluetoothManager.rssi.stringValue)
                        .font(.custom("Gotham Rounded Book", size: 18))
                }
            }
            
            Spacer()
        }
    }
}

struct PeripheralInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PeripheralInfoView(bluetoothManager: BluetoothManager())
    }
}
