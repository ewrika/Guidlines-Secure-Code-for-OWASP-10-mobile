//
//  JailBreakViewModel.swift
//  Kursach
//
//  Created by Георгий Борисов on 29.05.2025.
//

import Foundation
import IOSSecuritySuite

class JailBreakViewModel: ObservableObject {
    @Published var isJail: Bool? = nil
    @Published var isDebugged: Bool? = nil
    @Published var isEmulator:Bool? = nil
    @Published var isReverse:Bool? = nil
    @Published var isProxie:Bool? = nil
    @Published var isTampered:Bool? = nil

    func iOSSecuritySuite() {
        isJail = IOSSecuritySuite.amIJailbroken()
        isDebugged = IOSSecuritySuite.amIDebugged()
        isEmulator = IOSSecuritySuite.amIRunInEmulator()
        isReverse = IOSSecuritySuite.amIReverseEngineered()
        isProxie = IOSSecuritySuite.amIProxied()
        let tamperCheck = IOSSecuritySuite.amITampered([.bundleID("testplay.Kursach")])
        isTampered = tamperCheck.result
    }
}
