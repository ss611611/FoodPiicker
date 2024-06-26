//
//  FoodPiickerTests.swift
//  FoodPiickerTests
//
//  Created by Jackie Lu on 2024/6/22.
//

import XCTest
@testable import FoodPiicker
import SwiftUI

private let store = UserDefaults(suiteName: #file)!

final class SuffixTests: XCTestCase {
    var sut: Suffix<MyWeightUnit> = .init(wrappedValue: .zero, .defaultUnit, store: store)
    @AppStorage(.preferredWieghtUnit, store: store) var preferredUnit: MyWeightUnit
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removePersistentDomain(forName: #file)
    }

    func testJoinNumberAndSuffix() throws {
        sut = .init(wrappedValue: 100.1, .gram)
        sut.unit = .gram
        XCTAssertEqual(sut.description, "100.1 grams")
    }
    
    func testNumberFormatter_preferredPounds() {
        preferredUnit = .pound
        // 不用進位
        sut.wrappedValue = 100
        sut.unit = .gram
        XCTAssertEqual(sut.description, "0.2 pounds")
        
        // 要進位
        sut.wrappedValue = -300
        sut.unit = .gram
        XCTAssertEqual(sut.description, "-0.7 pounds")
        
        // 整數
        sut.wrappedValue = 453.592
        sut.unit = .gram
        XCTAssertEqual(sut.description, "1 pounds")
    }
    
    func testNumberFormatter() throws {
        sut = .init(wrappedValue: 100, .gram)
        XCTAssertEqual(sut.description, "100 grams")
        
        sut = .init(wrappedValue: 100.678, .gram)
        XCTAssertEqual(sut.description, "100.7 grams", "應該要在小數點第一位四捨五入")
        
        sut = .init(wrappedValue: -100.678, .gram)
        XCTAssertEqual(sut.description, "-100.7 grams")
        
        sut = .init(wrappedValue: 100.611, .gram)
        XCTAssertEqual(sut.description, "100.6 grams")
    }
}
