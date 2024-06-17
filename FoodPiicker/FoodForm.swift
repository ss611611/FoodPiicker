//
//  FoodForm.swift
//  FoodPiicker
//
//  Created by Jackie Lu on 2024/6/17.
//

import SwiftUI

private enum MyField: Int {
    case title, image, calories, protein, fat, carb
}

private extension TextField where Label == Text {
    func focused(_ field: FocusState<MyField?>.Binding, equals this: MyField) -> some View {
        submitLabel(this == .carb ? .done : .next)
            .focused(field, equals: this)
            .onSubmit {
                field.wrappedValue = .init(rawValue: this.rawValue + 1)
            }
    }
}

extension FoodListView {
    struct FoodForm: View {
        @Environment(\.dismiss) var dismiss
        @FocusState private var field: MyField?
        @State var food: Food
        var onSubmit: (Food) -> Void
        
        private var isNotValid: Bool {
            food.name.isEmpty || food.image.count > 2
        }
        
        private var inalidMessage: String? {
            if food.name.isEmpty { return "請輸入名稱" }
            if food.image.count > 2 { return "圖示字數過多" }
            return .none
        }

        var body: some View {
            NavigationStack {
                VStack {
                    HStack {
                        Label("編輯食物資訊", systemImage: "pencil")
                            .font(.title.bold())
                            .foregroundColor(.accentColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle.bold())
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                dismiss()
                            }
                    }.padding([.horizontal, .top])
                    
                    Form {
                        LabeledContent("名稱") {
                            TextField("必填", text: $food.name)
                                .focused($field, equals: .title)
                        }
                        
                        LabeledContent("圖示") {
                            TextField("最多輸入２個字元", text: $food.image)
                                .focused($field, equals: .image)
                                
                        }
                        
                        buildNubmerFild(title: "熱量", value: $food.calorie, field: .calories, suffix: "大卡")
                           
                        buildNubmerFild(title: "蛋白質", value: $food.protein, field: .protein)
                        buildNubmerFild(title: "脂肪", value: $food.fat, field: .fat)
                        buildNubmerFild(title: "碳水", value: $food.carb, field: .carb)
                    }
                    
                    Button {
                        dismiss()
                        onSubmit(food)
                        
                    } label: {
                        Text(inalidMessage ?? "儲存")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .mainButtonStyle()
                    .padding()
                    .disabled(isNotValid)
                }
                .background(.groupBg)
                .multilineTextAlignment(.trailing)
                .font(.title3)
                .scrollDismissesKeyboard(.interactively)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(action: goPreviousField) {
                            Image(systemName: "chevron.up")
                        }
                        Button(action: goNextField) {
                            Image(systemName: "chevron.down")
                        }
                    }
            }
            }
        }
        
        func goPreviousField() {
            guard let rawValue = field?.rawValue else { return }
            field = .init(rawValue: rawValue - 1)
        }
        
        func goNextField() {
            guard let rawValue = field?.rawValue else { return }
            field = .init(rawValue: rawValue + 1)
        }
        
        private func buildNubmerFild(title: String, value: Binding<Double>, field: MyField, suffix: String = "g") -> some View {
            LabeledContent(title) {
                HStack {
                    TextField("", value: value, format: .number.precision(.fractionLength(1)))
                        .focused($field, equals: field)
                        .keyboardType(.decimalPad)
                    Text(suffix)
                }
            }
        }
    }
}


#Preview {
    FoodListView.FoodForm(food: Food.examples.first!){ _ in }
}
