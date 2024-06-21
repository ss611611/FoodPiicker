//
//  ContentView.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/5/21.
//

import SwiftUI

struct FoodPickerScreen: View {
    @State private var selectedFood: Food?
    @State private var shouldShowInfo: Bool = false
    
    let food = Food.examples
        
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 30) {
                    foodImage
                    
                    Text("今天吃什麼？").bold()
                    
                    selectedFoodInfoView
                    
                    Spacer().layoutPriority(1)
                    
                    selectFoodButton
                    
                    cancelButton
                }
                .padding()
                .maxWidth()
                .frame(minHeight: proxy.size.height)
                .font(.title2.bold())
                .mainButtonStyle()
                .animation(.mySpring, value: shouldShowInfo)
                .animation(.myEase, value: selectedFood)
            }.background(.bg2)
        }
    }
}

// MARK: - Subviews
private extension FoodPickerScreen {
    var foodImage: some View {
        Grid {
            if let selectedFood {
                Text(selectedFood.image)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            } else {
                Image("dinner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }.frame(height: 250)
    }
    
    var foodNameView: some View {
        HStack {
            Text(selectedFood!.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.green)
                .id(selectedFood!.name)
                .transition(.delayInsertionOpacity)
            Button {
                shouldShowInfo.toggle()
            } label: {
                SFSymbol.info.foregroundColor(.secondary)
            }.buttonStyle(.plain)
        }
    }
    
    var foodDetailView: some View {
        VStack {
            if shouldShowInfo {
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    GridRow {
                        Text("蛋白質")
                        Text("脂肪")
                        Text("碳水")
                    }.frame(minWidth: 60)
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal, -10)
                    GridRow {
                        Text(selectedFood!.$protein)
                        Text(selectedFood!.$fat)
                        Text(selectedFood!.$carb)
                    }
                }
                .font(.title2)
                .padding(.horizontal)
                .padding()
                .roundedRectBackground()
                .transition(.moveUpWithOpacity)
            }
        }
        .maxWidth()
        .clipped()
    }
    
    @ViewBuilder var selectedFoodInfoView: some View {
        if let selectedFood {
            
            foodNameView
            
            Text("熱量 \(selectedFood.$calorie)").font(.title2)
            
            foodDetailView
            
        }
    }
    
    var selectFoodButton: some View {
        Button {
            selectedFood = food.shuffled().first { $0 != selectedFood }
        } label: {
            Text(selectedFood == .none ? "告訴我！" : "換一個").frame(width: 200)
                .animation(.none, value: selectedFood)
                .transformEffect(.identity)
        }.padding(.bottom, -15)
    }
    
    var cancelButton: some View {
        Button {
            selectedFood = .none
            shouldShowInfo = false
        } label: {
            Text("重置").frame(width: 200)
        }.buttonStyle(BorderedButtonStyle())
    }
}

extension FoodPickerScreen {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

//#Preview {
//    ContentView(selectedFood: .examples.first!)
//    ContentView(selectedFood: .examples.first!).previewDevice(.iPad)
//}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FoodPickerScreen(selectedFood: .examples.first!)
            FoodPickerScreen(selectedFood: .examples.first!).previewDevice(PreviewDevice.iPad)
            FoodPickerScreen(selectedFood: .examples.first!).previewDevice(PreviewDevice.iPhoneSE)
        }
    }
}
