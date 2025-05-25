//
//  PinCodeView.swift
//  Kursach
//
//  Created by Георгий Борисов on 25.05.2025.
//

import SwiftUI

struct PinCodeView: View {
    @StateObject private var viewModel = PinCodeViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
                .opacity(0.1)
            
            VStack(spacing: 20) {
                if viewModel.isUnlocked {
                    VStack {
                        Text("Доступ разрешен!")
                            .font(.title)
                            .foregroundColor(.green)
                        
                        Button(action: { viewModel.reset() }) {
                            Text("Выйти")
                                .foregroundColor(.red)
                        }
                        .padding()
                    }
                } else {
                    VStack(spacing: 15) {
                        Text("Введите PIN-код")
                            .font(.title2)
                        
                        PassCodeView(
                            passcode: $viewModel.passcode,
                            countOfDigits: 4,
                            didEnterLastDigit: { passcode in
                                viewModel.checkPasscode(passcode)
                            }
                        )
                        .disabled(viewModel.isBlocked)
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    PinCodeView()
}

