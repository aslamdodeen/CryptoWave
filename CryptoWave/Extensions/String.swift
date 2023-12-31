//
//  String.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 26/12/2023.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
