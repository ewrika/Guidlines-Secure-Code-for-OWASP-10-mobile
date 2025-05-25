//
//  KeyManager.swift
//  Kursach
//
//  Created by Георгий Борисов on 29.04.2025.
//

import Foundation

final class KeychainManager: Sendable {
    typealias ItemAttributes = [CFString: Any]
    static let shared = KeychainManager()
    private init() {}
}

extension KeychainManager {
    enum ItemClass: RawRepresentable {
        typealias RawValue = CFString
        
        case generic
        case password
        case certificate
        
        init?(rawValue: CFString) {
            switch rawValue {
            case kSecClassGenericPassword:
                self = .generic
            case kSecClassInternetPassword:
                self = .password
            case kSecClassCertificate:
                self = .certificate
            default:
                return nil
            }
        }
        
        var rawValue: CFString {
            switch self {
            case .generic:
                return kSecClassGenericPassword
            case .password:
                return kSecClassInternetPassword
            case .certificate:
                return kSecClassCertificate
            }
        }
    }
}

extension KeychainManager {
    enum KeychainError: Error {
        case invalidData
        case itemNotFound
        case duplicateItem
        case unexpected(OSStatus)

        var localizedDescription: String {
            switch self {
            case .invalidData:
                return "Invalid data"
            case .itemNotFound:
                return "Item not found"
            case .duplicateItem:
                return "Duplicate Item"
            case .unexpected(let oSStatus):
                return "Unexpected error - \(oSStatus)"
            }
        }
    }
}

extension KeychainManager {
    private func convertError(_ error: OSStatus) -> KeychainError {
        switch error {
        case errSecItemNotFound:
            return .itemNotFound
        case errSecDataTooLarge:
            return .invalidData
        case errSecDuplicateItem:
            return .duplicateItem
        default:
            return .unexpected(error)
        }
    }
    
    func saveItem<T: Encodable>(
        _ item: T,
        itemClass: ItemClass,
        key: String,
        attributes: ItemAttributes? = nil
    ) throws {
        // 1
        let itemData = try JSONEncoder().encode(item)

        // 2
        var query: [String: AnyObject] = [
            kSecClass as String: itemClass.rawValue,
            kSecAttrAccount as String: key as AnyObject,
            kSecValueData as String: itemData as AnyObject
        ]

        // 3
        if let itemAttributes = attributes {
            for (key, value) in itemAttributes {
                query[key as String] = value as AnyObject
            }
        }

        // 4
        let result = SecItemAdd(query as CFDictionary, nil)

        // 5
        if result != errSecSuccess {
            throw convertError(result)
        }
    }
    
    func retrieveItem<T: Decodable>(
       ofClass itemClass: ItemClass,
       key: String, attributes:
       ItemAttributes? = nil) throws -> T {

       // 1
       var query: [String: AnyObject] = [
          kSecClass as String: itemClass.rawValue,
          kSecAttrAccount as String: key as AnyObject,
          kSecReturnAttributes as String: true as AnyObject,
          kSecReturnData as String: true as AnyObject
       ]

       // 2
       if let itemAttributes = attributes {
          for(key, value) in itemAttributes {
             query[key as String] = value as AnyObject
          }
       }

       // 3
       var item: CFTypeRef?

       // 4
       let result = SecItemCopyMatching(query as CFDictionary, &item)

       // 5
       if result != errSecSuccess {
          throw convertError(result)
       }

       // 6
       guard
          let keychainItem = item as? [String : Any],
          let data = keychainItem[kSecValueData as String] as? Data
       else {
          throw KeychainError.invalidData
       }

       // 7
       return try JSONDecoder().decode(T.self, from: data)
    }
    func deleteItem(
        ofClass itemClass: ItemClass,
        key: String,
        attributes: ItemAttributes? = nil
    ) throws {
        var query: [String: AnyObject] = [
            kSecClass as String: itemClass.rawValue,
            kSecAttrAccount as String: key as AnyObject
        ]

        if let itemAttributes = attributes {
            for (key, value) in itemAttributes {
                query[key as String] = value as AnyObject
            }
        }

        let result = SecItemDelete(query as CFDictionary)

        if result != errSecSuccess && result != errSecItemNotFound {
            throw convertError(result)
        }
    }
    
}


//let apiToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJnb2Fsc2J1ZGR5IiwiZXhwIjo2NDA5MjIxMTIwMH0.JoDuSMARI2Ihh8fisiUxfQiP8AE_WFz9Hcogkk8QMcQ"
//
//do {
//   let apiTokenAttributes: KeychainManager.ItemAttributes = [
//      kSecAttrLabel: "ApiToken"
//   ]
//
//   try KeychainManager.shared.saveItem(
//      apiToken,
//      itemClass: .generic,
//      key: "ApiToken",
//      attributes: apiTokenAttributes
//   )
//
//   let token: String = try KeychainManager.shared.retrieveItem(
//      ofClass: .generic,
//      key: "ApiToken",
//      attributes: apiTokenAttributes
//   )
//
//} catch let keychainError as KeychainManager.KeychainError {
//   print(keychainError.localizedDescription)
//} catch {
//   print(error)
//}



