//
//  GCDView.swift
//  Kursach
//
//  Created by Георгий Борисов on 27.05.2025.
//

import SwiftUI

struct GCDView: View {
    @StateObject private var viewModel = GCDViewModel()
    var body: some View {
        
        VStack(spacing: 30) {
            Text("Общий баланс:\(viewModel.balance)  ₽")
                .font(.title2)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            HStack(spacing: 40) {
                // ATM 1
                VStack(spacing: 15) {
                    Image(systemName: "building.columns")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    Text("ATM 1")
                        .font(.headline)
                    
                    Button(action: {
                        viewModel.withdrawFromATM1()
                    }) {
                        Text("Снять 1000₽")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                
                // ATM 2
                VStack(spacing: 15) {
                    Image(systemName: "building.columns")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    Text("ATM 2")
                        .font(.headline)
                    
                    Button(action: {
                        viewModel.withdrawFromATM2()
                    }) {
                        Text("Снять 1000₽")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
            }
            .padding(.horizontal)
            
            Text("Смотрите консоль для деталей")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    GCDView()
}
