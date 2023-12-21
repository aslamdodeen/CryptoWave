//
//  XMarkButton.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 19/12/2023.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}
