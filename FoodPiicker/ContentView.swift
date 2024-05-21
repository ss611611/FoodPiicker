//
//  ContentView.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/5/21.
//

import SwiftUI

struct ContentView: View {
    let food = ["漢堡", "沙拉", "披薩", "義大利麵", "雞腿便當", "刀削麵", "火鍋", "牛肉麵", "關東煮"]
    @State private var selectedFood: String?
    
    var body: some View {
        VStack(spacing: 30) {
            Image("dinner")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
            
            Text("今天吃什麼？").bold()
            
            if selectedFood != .none {
                Text(selectedFood ?? "")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
            }
            
            Button {
                selectedFood = food.shuffled().first { $0 != selectedFood }
            } label: {
                Text(selectedFood == .none ? "告訴我！" : "換一個").frame(width: 200)
            }.padding(.bottom, -15)
            
            Button {
                selectedFood = .none
            } label: {
                Text("重置").frame(width: 200)
            }.buttonStyle(BorderedButtonStyle())
        }
        .padding()
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color(.secondarySystemBackground))
        .buttonStyle(BorderedProminentButtonStyle())
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .animation(.easeInOut, value: selectedFood)
    }
}

#Preview {
    ContentView()
}
