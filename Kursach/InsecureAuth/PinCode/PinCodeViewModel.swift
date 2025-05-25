import Foundation
import SwiftUI

@MainActor
class PinCodeViewModel: ObservableObject {
    @Published var passcode: String = ""
    @Published var isUnlocked: Bool = false
    @Published var isBlocked: Bool = false
    @Published var remainingBlockTime: Int = 0
    @Published var errorMessage: String = ""
    
    private let correctPasscode = "1111"
    private let blockDuration = 5 
    private var blockTimer: Timer?
    private var failedAttempts = 0
    private let maxFailedAttempts = 3
    
    func checkPasscode(_ enteredPasscode: String) {
        guard !isBlocked else { return }
        
        if enteredPasscode == correctPasscode {
            isUnlocked = true
            failedAttempts = 0
            errorMessage = ""
        } else {
            failedAttempts += 1
            errorMessage = "Неверный пароль. Попыток осталось: \(maxFailedAttempts - failedAttempts)"
            
            if failedAttempts >= maxFailedAttempts {
                blockAccess()
            }
        }
    }
    
    private func blockAccess() {
        isBlocked = true
        remainingBlockTime = blockDuration
        errorMessage = "Слишком много попыток. Подождите \(blockDuration) секунд"
        
        blockTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if self.remainingBlockTime > 0 {
                self.remainingBlockTime -= 1
                self.errorMessage = "Слишком много попыток. Подождите \(self.remainingBlockTime) секунд"
            } else {
                self.unblockAccess()
                timer.invalidate()
            }
        }
    }
    
    private func unblockAccess() {
        isBlocked = false
        failedAttempts = 0
        errorMessage = ""
        blockTimer?.invalidate()
        blockTimer = nil
    }
    
    func reset() {
        passcode = ""
        isUnlocked = false
        isBlocked = false
        remainingBlockTime = 0
        errorMessage = ""
        failedAttempts = 0
        blockTimer?.invalidate()
        blockTimer = nil
    }
} 
