//
//  JailBreakView.swift
//  Kursach
//
//  Created by Георгий Борисов on 29.05.2025.
//

import SwiftUI

struct JailBreakView: View {
    @StateObject private var viewModel = JailBreakViewModel()
    var body: some View {
        VStack(spacing: 16) {
            Text("Проверить устройство на безопасность")
                .font(.title3)
            
            Button("Тык") {
                viewModel.iOSSecuritySuite()
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            
            if let isJail = viewModel.isJail {
                Text(isJail ? "JailBreak найден!" : "JailBreak не обнаружен ✅")
                    .foregroundColor(isJail ? .red : .green)
                    .bold()
            }
            
            if let isDebugged = viewModel.isDebugged{
                Text(isDebugged ? "Устройство Дебажится!" : "Устройство не Дебажится ✅")
                    .foregroundColor(isDebugged ? .red : .green)
                    .bold()
            }
            
            if let isEmulator = viewModel.isEmulator{
                Text(isEmulator ? "Запущено на Эмуляторе" : "Запущено не на эмуляторе ✅")
                    .foregroundColor(isEmulator ? .red : .green)
                    .bold()
            }
            
            if let isReverse = viewModel.isReverse{
                Text(isReverse ? "Приложение подвеглось Reverse" : "Reverse не было✅")
                    .foregroundColor(isReverse ? .red : .green)
                    .bold()
            }
            
            if let isProxie = viewModel.isProxie{
                Text(isProxie ? "Обнаружен Proxie" : "Proxie не обнаружен ✅")
                    .foregroundColor(isProxie ? .red : .green)
                    .bold()
            }
            
            if let isTampered = viewModel.isTampered{
                Text(isTampered ? "Приложение изменено!" : "Приложение не изменено ✅")
                    .foregroundColor(isTampered ? .red : .green)
                    .bold()
            }
            
        }
        .padding()
    }
}

#Preview {
    JailBreakView()
}
