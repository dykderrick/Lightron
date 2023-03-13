//
//  Header.swift
//  Lightron
//
//  Created by Derrick Ding on 3/13/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            
            VStack(alignment: .leading) {
                // FIGHTING
                Text("FIGHTING ")
                    .font(.custom("Gotham Rounded Medium", size: 12))
                    .foregroundColor(Color(hex: "#7B7B7B"))
                
                // Choose a training for today
                Text("Choose a training")
                    .font(.custom("Gotham Rounded Bold", size: 26))
                    .foregroundColor(.black)
                
                Text("for today 🔥")
                    .font(.custom("Gotham Rounded Bold", size: 26))
                    .foregroundColor(.black)

            }
            .frame(width: 248, height: 82)
            
            Spacer()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
