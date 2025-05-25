//
//  FaceIDView.swift
//  Kursach
//
//  Created by Георгий Борисов on 24.05.2025.
//

import SwiftUI


struct FaceIDView: View {
    @StateObject private var viewModel = FaceIDViewModel()

    var body: some View {
        VStack() {
            if viewModel.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: viewModel.authenticate)
    }
}

#Preview {
    FaceIDView()
}
