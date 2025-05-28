//
//  HTTPView.swift
//  Kursach
//
//  Created by Георгий Борисов on 27.05.2025.
//

import SwiftUI

struct HTTPView: View {
    @StateObject private var viewModel = HTTPViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("HTTP MITM Demo")
                .font(.title)
                .padding()
                        
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
            }
            
           
            ScrollView {
                Text(viewModel.responseText)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .padding()
        }
        .onAppear {
            viewModel.loadImage()
        }
    }
}

#Preview {
    HTTPView()
}
