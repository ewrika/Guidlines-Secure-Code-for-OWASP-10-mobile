import Foundation
import SwiftUI

@MainActor
class KeychainViewModel: ObservableObject {
    private let tokenKey = "auth_token"
    @Published var currentToken: String = "Токен не установлен"
    @Published var statusMessage: String = ""
    
    func saveToken() {
        let demoToken = "apiTokenRandom324fdsfjsdjifjsd"
        
        do {
            try KeychainManager.shared.saveItem(
                demoToken,
                itemClass: .generic,
                key: tokenKey
            )
            currentToken = "Токен сохранён в Keychain!"
            statusMessage = "Используется класс: kSecClassGenericPassword"
        } catch let error as KeychainManager.KeychainError {
            currentToken = "Ошибка сохранения"
            statusMessage = error.localizedDescription
        } catch {
            currentToken = "Неизвестная ошибка"
            statusMessage = error.localizedDescription
        }
    }
    
    func loadToken() {
        do {
            let token: String = try KeychainManager.shared.retrieveItem(
                ofClass: .generic,
                key: tokenKey
            )
            currentToken = "Токен: \(token)"
            statusMessage = "Успешно загружено из Keychain"
        } catch let error as KeychainManager.KeychainError {
            currentToken = "Ошибка загрузки"
            statusMessage = error.localizedDescription
        } catch {
            currentToken = "Неизвестная ошибка"
            statusMessage = error.localizedDescription
        }
    }
    
    func deleteToken() {
        do {
            try KeychainManager.shared.deleteItem(
                ofClass: .generic,
                key: tokenKey
            )
            currentToken = "Токен удалён из Keychain"
            statusMessage = "kSecClassGenericPassword удалён"
        } catch let error as KeychainManager.KeychainError {
            currentToken = "Ошибка удаления"
            statusMessage = error.localizedDescription
        } catch {
            currentToken = "Неизвестная ошибка"
            statusMessage = error.localizedDescription
        }
    }
} 