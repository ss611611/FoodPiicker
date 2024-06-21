//
//  Unit.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/6/21.
//

import SwiftUI

enum Unit: String, CaseIterable, Identifiable, View {
    case gram = "g", pound = "lb"
    
    var id: Self { self }
    
    var body: some View {
        Text(rawValue)
    }
}
