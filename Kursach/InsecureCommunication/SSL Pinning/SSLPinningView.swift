//
//  SSLPinningView.swift
//  Kursach
//
//  Created by Георгий Борисов on 28.05.2025.
//

import SwiftUI

struct SSLPinningView: View {
    @StateObject private var viewModel = SSLPinningViewModel()
    
    var body: some View {
        VStack {

            if let image = viewModel.image {
                Image(uiImage:image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
            }
            
            ScrollView {
                Text(viewModel.responseText)
                    .font(.system(.body, design: .monospaced))
                    .padding()
            }
        }.onAppear{
            viewModel.loadImage()
        }
    }
}

#Preview {
    SSLPinningView()
}
