//
//  ShapeStyleView.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/6/15.
//

import SwiftUI

struct ShapeStyleView: View {
    var body: some View {
        VStack {
            Circle().fill(.teal)
            Circle().fill(.teal.gradient)
            Circle().fill(.yellow)
            Circle().fill(.image(.init("dinner"), scale: 0.2))
            Text("Hello").font(.system(size: 100).bold()).foregroundStyle(.linearGradient(colors: [.pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                .background {
                    Color.bg2
                        .scaleEffect(x: 1.5, y: 1.3)
                        .blur(radius: 20)
                }
        }
    }
}


struct ShapeStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeStyleView()
    }
}
