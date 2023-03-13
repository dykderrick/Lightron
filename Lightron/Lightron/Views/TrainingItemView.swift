//
//  TrainingItemView.swift
//  Lightron
//
//  Created by Derrick Ding on 3/13/23.
//

import SwiftUI

struct TrainingItemView: View {
    var trainingItemName: String
    @ObservedObject var trainingManager: TrainingManager
    @ObservedObject var bluetoothManager: BluetoothManager
    var trainingType: TrainingType

    var body: some View {
        Button(action: {
            trainingManager.selectedTrainingType = trainingType
            bluetoothManager.writeOutgoingValue(data: trainingType.rawValue)
        }, label: {
            ZStack {
                HStack(alignment: .center) {
                    Spacer()
                        .frame(width: 30)
                    
                    VStack(alignment: .leading) {
                        Text("BOXING TRAINING")
                            .font(.custom("Gotham Rounded Medium", size: 12))
                            .foregroundColor(Color(hex: "#7B7B7B"))
                        
                        Text(trainingItemName)
                            .font(.custom("Gotham Rounded Bold", size: 26))
                            .foregroundColor(Color(hex: "#252727"))
                    }
                    
                    Spacer()
                }
                .frame(width: 360, height: 132)
                .background(Color(hex: "#E8E8E8"))
                .cornerRadius(15)
                .border(trainingManager.selectedTrainingType == trainingType ? .black : .white, width: 4)
                
                
                HStack {
                    Spacer()
                        .frame(width: 150)
                    
                    Image(trainingItemName)
                        .resizable()
                        .frame(width: 164, height: 155)
                }
            }
        }
        )
    }
}

struct TrainingItemView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingItemView(trainingItemName: "Swing", trainingManager: TrainingManager(), bluetoothManager: BluetoothManager(), trainingType: .Swing)
    }
}
