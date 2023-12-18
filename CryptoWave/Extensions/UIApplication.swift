//
//  UIApplication.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 17/12/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}
