//
//  CircleButtonView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 12/12/2023.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName:String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50,height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25), radius: 5)
            .padding()
    }
}

 #Preview(traits: .sizeThatFitsLayout) {
         CircleButtonView(iconName: "info")
             .colorScheme(.light)
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(iconName: "plus")
        .preferredColorScheme(.dark)
}
    
