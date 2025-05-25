//
//  FaceIDViewModel.swift
//  Kursach
//
//  Created by Георгий Борисов on 24.05.2025.
//

import Foundation
import LocalAuthentication

class FaceIDViewModel: ObservableObject {
    @Published var isUnlocked = false
    @Published var errorMessage: String?
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock to access your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.isUnlocked = true
                        self?.errorMessage = nil
                    } else {
                        let errorMessage = authenticationError?.localizedDescription ?? "Unknown error"
                        print("Authentication failed with error: \(errorMessage)")
                        self?.errorMessage = "Authentication failed"
                    }
                }
            }
        } else {
            let errorMessage = error?.localizedDescription ?? "Biometrics unavailable"
            print("Can't evaluate policy. Error: \(errorMessage)")
            DispatchQueue.main.async {
                self.errorMessage = "Biometrics not available"
            }
        }
    }
}
