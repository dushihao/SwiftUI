//
//  ContentView.swift
//  Calculator
//
//  Created by YYKJ on 2020/7/31.
//  Copyright © 2020 YYKJ. All rights reserved.
//

import SwiftUI
import Combine

let scale: CGFloat = UIScreen.main.bounds.width / 414

struct ContentView: View {
    @State private var brain: CalculatorBrain = .left("0")
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(brain.output)
                .font(.system(size:76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            CalculatorButttonPad(brain: $brain)
                .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone SE")
    }
}

struct CalculatorButttonPad: View {
    @Binding var brain: CalculatorBrain
    
    let pad : [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    
    var body: some View {
        VStack(spacing:8) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row, brain: self.$brain)
            }
        }
    }
}

struct CalculatorButtonRow : View {
    let row: [CalculatorButtonItem]
    
    @Binding var brain: CalculatorBrain
    
    var body: some View {
        HStack {
            ForEach (row, id: \.self) { item in
                CalculatorButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName) {
                    self.brain = self.brain.apply(item: item)
                    print("Button:\(item.title)")
                }
            }
        }
    }
}

struct CalculatorButton: View {
//    @Binding var brain: CalculatorBrain
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize * scale))
                .foregroundColor(.white)
                .frame(width: size.width * scale, height: size.height * scale)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width * scale / 2)
        }
    }
}
