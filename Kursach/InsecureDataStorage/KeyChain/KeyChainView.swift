//
//  KeyChainView.swift
//  Kursach
//
//  Created by Георгий Борисов on 29.04.2025.
//

import SwiftUI

struct KeyChainView: View {
    @StateObject private var viewModel = KeychainViewModel()
    
    var body: some View {
        VStack(spacing:20) {
            Text(viewModel.currentToken)
                .font(.title3)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Text(viewModel.statusMessage)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Button(action: { viewModel.saveToken() }) {
                Text("Сохранить токен в Keychain")
            }
            .buttonStyle(.borderedProminent)
            
            Button(action: { viewModel.loadToken() }) {
                Text("Загрузить токен из Keychain")
            }
            .buttonStyle(.bordered)
            
            Button(action: { viewModel.deleteToken() }) {
                Text("Удалить токен из Keychain")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    KeyChainView()
}
