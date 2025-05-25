import Foundation
import SwiftUI

@MainActor
class UserDefaultsViewModel: ObservableObject {
    private let tokenKey = "auth_token"
    @Published var currentToken: String = "Токен не установлен"
    @Published var filePath: String = "Нажмите кнопку, чтобы узнать путь"
    
    func saveToken() {
        let demoToken = "apiTokenRandom324fdsfjsdjifjsd"
        UserDefaults.standard.set(demoToken, forKey: tokenKey)
        currentToken = "Токен сохранён!"
    }
    
    func loadToken() {
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            currentToken = "Токен: \(token)"
        } else {
            currentToken = "Токен не найден"
        }
    }
    
    func deleteToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        currentToken = "Токен удалён"
    }
    
    func showUserDefaultsPath() {
        let bundleID = Bundle.main.bundleIdentifier ?? "unknown"
        
        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        let libraryPath = paths[0]
        let plistPath = "\(libraryPath)/Preferences/\(bundleID).plist"
        
        filePath = plistPath
        
        print("Путь к UserDefaults файлу:")
        print(plistPath)
        
        #if targetEnvironment(simulator)
        print("\nЧтобы открыть в Finder, выполните в терминале:")
        print("open \(libraryPath)/Preferences")
        #endif
    }
} 