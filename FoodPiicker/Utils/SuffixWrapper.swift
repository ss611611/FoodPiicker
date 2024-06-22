//
//  SuffixWrapper.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/6/14.
//

@propertyWrapper struct Suffix: Equatable {
    var wrappedValue: Double
    private let suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    var projectedValue: String {
        wrappedValue.formatted() + " \(suffix)"
    }
}


extension Suffix: Codable { }
