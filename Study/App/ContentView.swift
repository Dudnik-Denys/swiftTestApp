//
//  ContentView.swift
//  Study
//
//  Created by Денис Дудник on 08.04.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Привет, пользователь! Hello, user!")
//                .font(Font.system(size: 18))
                .font(Font.custom("Montserrat Alternates", size: 18))
            Text("Привет, пользователь! Hello, user!")
                .font(Font.system(size: 18))
        }
        VStack(spacing: 40) {
                  
                  // Без lineSpacing и padding
                  Text("Пример\nтекста\nбез отступов")
                      .background(Color.yellow.opacity(0.3))
                      .border(Color.orange)
                  
                  // С lineSpacing
                  Text("Пример\nтекста\nс lineSpacing")
                      .lineSpacing(15)
                      .background(Color.green.opacity(0.3))
                      .border(Color.green)
                  
                  // С padding
                  Text("Пример текста с padding")
                      .padding(20)
                      .background(Color.blue.opacity(0.3))
                      .border(Color.blue)
                  
                  // С padding и lineSpacing
                  Text("Текст\nс padding\nи lineSpacing")
                      .padding(20)
                      .lineSpacing(15)
                      .background(Color.purple.opacity(0.3))
                      .border(Color.purple)
              }
              .padding()
    }
}
        
#Preview {
    ContentView()
}
