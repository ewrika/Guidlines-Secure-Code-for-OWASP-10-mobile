//
//  ContentView.swift
//  Kursach
//
//  Created by Георгий Борисов on 28.04.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(sections, id: \.header) { section in
                    Section(header: Text(section.header)) {
                            ForEach(section.items, id: \.self) { item in
                                NavigationLink(destination: DetailView(title: item)) {
                                    Text(item)
                                }
                            }
                        }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct DetailView: View {
    let title: String
    var body: some View {
        switch title {
        case "UserDefaults":
            UserDefaultsView()
        case "KeyChain":
            KeyChainView()
        case "FaceID":
            FaceIDView()
        case "Pincode":
            PinCodeView()
        case "Race Conditions":
            RaceConditionsView()
        case "Design System":
            DesignSystemView()
        case "NSLock":
            NSLockView()
        case "GCD":
            GCDView()
        case "Detecting Jailbreak":
            JailBreakView()
        case "HTTP":
            HTTPView()
        case "Certificate Pinning":
            SSLPinningView()
        default:
            Text("Детали для \(title)")
        }
    }
}

#Preview {
    ContentView()
}
