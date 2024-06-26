//
//  UserDefaultsKey.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/6/21.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case shouldUseDarkMode
        case startTab
        case foodList
        case preferredEnergyUnit
        case preferredWieghtUnit
    }
}
