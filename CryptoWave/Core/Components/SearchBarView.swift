//
//  SearchBarView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 17/12/2023.
//

import SwiftUI

struct SearchBarView: View {
  
  @Binding  var searchText:String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search by name or symbol...",text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                  Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x:10)
                    .foregroundColor(Color.theme.accent)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                  ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
           RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.theme.background)
            .shadow(
                color: Color.theme.accent.opacity(0.15),
                radius: 5)
        )
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
}
#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}
