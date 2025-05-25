//
//  UserDefaultsView.swift
//  Kursach
//
//  Created by Георгий Борисов on 29.04.2025.
//

import SwiftUI

struct UserDefaultsView: View {
    @StateObject private var viewModel = UserDefaultsViewModel()
    
    var body: some View {
        VStack(spacing:20) {
            Text(viewModel.currentToken)
                .font(.title3)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Button(action: { viewModel.saveToken() }) {
                Text("Сохранить токен")
            }
            .buttonStyle(.borderedProminent)
            
            Button(action: { viewModel.loadToken() }) {
                Text("Загрузить токен")
            }
            .buttonStyle(.bordered)
            
            Button(action: { viewModel.deleteToken() }) {
                Text("Удалить токен")
                    .foregroundColor(.red)
            }
            
            Text(viewModel.filePath)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = viewModel.filePath
                    }) {
                        Label("Копировать", systemImage: "doc.on.doc")
                    }
                }
            
            Button(action: { viewModel.showUserDefaultsPath() }) {
                Text("Показать путь к UserDefaults")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
    }
}

#Preview {
    UserDefaultsView()
}

