//
//  Unit.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/6/21.
//

import Foundation

enum MyEnergyUnit: String, MyUnitProtocol {
    static var userDefaultsKey: UserDefaults.Key = .preferredEnergyUnit
    
    static var defaultUnit: MyEnergyUnit = .cal
    
    case cal = "大卡"
    
    var dimension: UnitEnergy {
        switch self {
        case .cal: return .calories
        }
    }
}

enum MyWeightUnit: String, MyUnitProtocol {
    case gram = "g", pound = "lb", ounce
    
    var dimension: UnitMass {
        switch self {
        case .gram:
            return .grams
        case .pound:
            return .pounds
        case .ounce:
            return .ounces
        }
    }
    static var userDefaultsKey: UserDefaults.Key = .preferredWieghtUnit
    
    static var defaultUnit: MyWeightUnit = .gram
    
}
