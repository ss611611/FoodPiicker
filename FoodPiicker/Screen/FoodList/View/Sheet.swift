//
//  Sheet.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/6/19.
//

import SwiftUI

extension FoodListScreen {
    enum Sheet {
        case newFood((Food) -> Void)
        case editFood(Binding<Food>)
        case foodDetail(Food)
    }
}

extension FoodListScreen.Sheet: View {
    var body: some View {
        switch self {
        case .newFood(let onSubmit):
            FoodListScreen.FoodForm(food: .new, onSubmit: onSubmit)
        case .editFood(let binding):
            FoodListScreen.FoodForm(food: binding.wrappedValue) { binding.wrappedValue = $0 }
        case .foodDetail(let food):
            FoodListScreen.FoodDetailSheet(food: food)
        }
    }
}


extension FoodListScreen.Sheet: Identifiable {
    var id: UUID {
        switch self {
        case .newFood:
            return UUID()
        case .editFood(let binding):
            return binding.wrappedValue.id
        case .foodDetail(let food):
            return food.id
        }
    }
}

